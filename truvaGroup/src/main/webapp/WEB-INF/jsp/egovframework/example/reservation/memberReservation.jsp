<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript">
/******************************************
 * 예약모달창
 ******************************************/
var modal = {
		
	reservation : function(){
		var $modal = $(".bus-seat-modal"),
			$modalContents = $(".bus-seat-modal .modal-dialog"),
			$seatArea = $(".bus-seat-area"),
			$modalHeader = $(".prod-modal"),
			modalWidth = "";

		$modal.toggleClass("hidden");
		
		if (!($modal.hasClass("hidden"))) {

			modalWidth = $modalContents.width();
			
			$modalContents.css({
				"margin-left" : -modalWidth/2,
				"left" : "50%"});

		} else {
			$seatArea.children().remove();
			$seatArea.parent().removeClass();
			$modalHeader.children("h4").text("");
			$modalHeader.children("h5").text("");
		}
	}
}

// 좌석을 선택하면 인원수에 체크한 만큼 선택이 된다. 인원수 이상으로 선택되지 않으며 이미 선택한 좌석을 다시 클릭할경우 선택이 해제된다.
var reservationBus = {
		
	seatArr			: new Set(),
		
	busSeatSelectFn : function(target) {
		
		var $target = $(target),
			seatNum = $target.parent().attr("id");
		
		if(this.seatArr.has(seatNum)) {

			this.seatArr.delete(seatNum);
			
			$target.parent().removeClass("seat-select");
		} else {
			
			if (this.seatArr.size < $("#resCount").val()) {
				
				if (!$target.parent().hasClass("seat-soldout")) {

					this.seatArr.add(seatNum);
					
					$target.parent().addClass("seat-select");
				}
			} else {
				
				alert("예약인원보다 많은 좌석을 선택할 수 없습니다.");
			}
		}
	},
	
	saveSelectSeat : function() {
		
		if (this.seatArr.size == 0) {
			
			alert("선택한 좌석이 없어 저장할 수 없습니다.");
			
			return;
		}
		
		if (confirm("선택한 좌석을 저장하시겠습니까?") == false) {
			
			return;
		}
		
		if (this.seatArr.size < $("#resCount").val()) {
			
			alert("예약인원보다 선택한 인원수가 적습니다.");
			
			return;
		}

		$("#resSeat").val([...reservationBus.seatArr]);
		$(".seat-info").css({"display":"block"});
		$(".select-seat").text([...reservationBus.seatArr]);

		modal.reservation();
	}
}

/******************************************
 * 인풋 포커스 아웃되면 값 체크 
 ******************************************/
var reservation = {
	
	/* 주문자와 예약자가 동일할경우 */
	sameVal : function(eTarget){
		
		var resName = $("#resName"),
			resPhone = $("#resPhone"),
			resEmail = $("#resEmail");
		
		/* 체크박스가 선택되면 주문자의 정보를 예약자에 넣고, 체크를 해제할경우 넣었던 값을 초기화 한다. */
		if ($(eTarget).prop("checked")) {

			resName.val($("#orderName").val()).removeClass("valCheck");
			resPhone.val($("#orderPhone").val()).removeClass("valCheck");
			resEmail.val($("#orderEmail").val()).removeClass("valCheck");
		} else {

			resName.val("");
			resPhone.val("");
			resEmail.val("");
		}
	},
	
	/* 인풋 빈값 체크 */
	valCheck : function(){
		
		var that = this;
		
		$("#reservationFrm input[order=info]").blur(function(){
			
			var target = $(this),
				getId = target.attr("id"),
				text = "";
			
			/* 인풋이 포커스 아웃이 되었을때 값이 없으면 붉은색 글씨로 해당 인풋에 값을 입력하라고 표시한다. */
			if (CommonJsUtil.isEmpty(target.val())) {

				if (target.hasClass("valCheck")){
					
					return false;
				}
				var text = target.attr("placeholder");
				
				target.attr("placeholder", text+"을 입력하세요");
				target.addClass("valCheck");
			} else {
				
				if (getId == "orderName" || getId == "resName") {
					
					text = CommonJsUtil.isKor(target.val()) ? "" : "한글";
				} else if (getId == "orderPhone" || getId == "resPhone"){

					text = CommonJsUtil.isNumeric(target.val()) ? "" : "숫자";

					if (text == "") {
						
						var phoneVal = CommonJsUtil.phonRes(target.val());
						
						target.val(phoneVal);
					}
					
				} else if (getId == "resEmall" || getId == "orderEmail"){
					
					text = CommonJsUtil.isMail(target.val()) ? "" : "정확한 이메일양식";
				}
				
				/* 인풋에 값이 있을경우 공백을 지우고, 값이 없을경우 경고창을 띄운다. */
				if (text != "") {
					
					alert(text +"만 입력 가능합니다.");
					
					target.val("");
				} else {

					CommonJsUtil.trim(target);
				}
				
				$(this).removeClass("valCheck");
			}
		});
	},
	
	/* 공백 지우기 */
	valTrim : function(target){
		
		var targetVal = CommonJsUtil.trim(target.val());
		
		target.val(targetVal);
	}
};

/******************************************
 * 서버로 데이터 보내기
 ******************************************/
var reservationFn = {
	
	/* 예약하기 버튼틀릭시 예약자 및 결제자 정보가 없을경우 데이터를 입력하세요라는 알림창이 뜨고, 전체 정보가 기입되어있을경우 데이터를 저장한다. */
	goRes : function(){
		
		var resData = $("#reservationFrm input[order=info]"),
			kindTarget = $("div[prop=orderKind]"),
			orderKind = "",
			kindInfo = "",
			pageContinue = "N";
		
		
		if (resData.hasClass("valCheck")) {
			
			alert("데이터를 입력하세요");
		} else if (resData.val() == ""){
			
			alert("미입력 데이터가 있습니다.");
		} else {
	
			/* 결제종류 저장 */
			$(kindTarget).each(function(i){
				
				if (kindTarget.eq(i).hasClass("active")) {
					
					var $this = kindTarget.eq(i),
						orderKindTarget = $("#orderKind"),
						orderKind = $this.attr("id");
					
					if(!($this.children().children("li.active").length == 0)){
						
						kindInfo = $this.children().children("li.active").children("img").attr("alt");
						$(orderKindTarget).val(orderKind);
						pageContinue = "Y"
					} else if (orderKind == "payPhone"){
						
						$(orderKindTarget).val(orderKind);
						pageContinue = "Y"
					} else {

						alert("결제수단을 선택해주세요.");
					}
				}
			});
		}
		
		if (pageContinue == "Y") {
			
			var kindInfoTarget = $("#kindInfo"),
				discount = $("#discount"),
				price = $("#price"),
				discountPrice = $("#discountPrice"),
				finalPrice = $("#finalPrice"),
				usePoint = $("#usePoint");
			
			if (usePoint.val() == "") {
				
				usePoint.val(0);
			}
			
			$(kindInfoTarget).val(kindInfo);
			$(discount).val(discountPrice.text());
			$(price).val(finalPrice.text());
			
			nav.pageSubmitFn({pageName: 'saveReservationInfo', frmName: 'reservationFrm', url: 'saveReservationInfo.do'});
		}
	}
}

/******************************************
 * 쿠폰적용
 ******************************************/
var discountPrice = {
		
	useCoupon : function(){

		if (changePay.finalPrice == null) {
			
			alert("상품을 먼저 선택해주세요.");
			
			return;
		}
		
		var couponVal = $("#couponNumber").val(),
			that = this,
			couponNumber = $("#couponNumber");
		
		if (couponVal != "") {
			
			var result = that.ajaxFn({"url": "getReservationInfo.do", "param": couponVal});
			
			if(result[0].success == "FALL"){
				
				$(couponNumber).val("");
				
				alert("잘못된 쿠폰번호 입니다.");
			} else {
				
				changePay.payCoupon(result[0].couponDiscount);
				
				alert(""+ result[0].couponName +"("+ result[0].couponDiscount +"% 할인)이 적용되었습니다.");
			}
		} else {

			alert("쿠폰번호를 입력하세요.");
		}
	},

	ajaxFn : function(option){
		
		var settings = {
			
			url			: "getReservationInfo.do",
			param		: ""
		}
		
		settings = $.extend({}, settings, option);

		var jsonPas = {};
		
		$.ajax({
			
			type	: "POST",
			url		: settings.url,
			async	: false,
			data	: {"param" : settings.param},
			success	: function(result){
				
				jsonPas = JSON.parse(result);
			}
		});
		
		return jsonPas;
	}
}

/******************************************
 * 결제수단 선택시 변경
 ******************************************/
var changeSelect = {
	
	/* 카드나 무통장 입금 아이콘 선택시 css 변경 */
	selectPay : function(){
		
		var target2 = $(".card-select").children();
		
		target2.click(function(){
			var select = $(this);
			target2.removeClass("active");
			select.addClass("active");
		});
	},
	
	/* 입금날짜 출력하기 */
	payDate : function(){
		
		var now = new Date(),
			yy = now.getFullYear(),
			mm = now.getMonth()+1,
			dd = now.getDate()+3,
			fullDate = "",
			$bankDate = $("#bankDate");
		
			fullDate = fullDate = yy +"-"+ ((mm < 10) ? "0"+ mm : mm) +"-"+ ((dd < 10) ? "0"+ dd : dd);
		
		$bankDate.text(fullDate);
	},
	
	/* 계좌번호 및 은행명 노출 */
	bankNumber : function(target) {
		
		var bankNum = $(target).children("input").val(),
			bankName = $(target).children("img").attr("alt"),
			textTarget = $(".bank-number");
		
		textTarget.text("["+ bankName +"]" + bankNum);
	},
	
	/* 상품선택시 금액 출력 */
	selectProd : function(target, gubun) {
		
		var $productNumber = $("#productNumber"),
			getId = $(target).attr("id"),
			$prodGubun = $("#prodGubun"),
			$prodList = $("#prodList").children("tbody").children(),
			$finalPrice = $("#finalPrice");
			resCount = $("#resCount").val();
		
		$prodList.removeClass("select");
		$(target).addClass("select");
		
		$productNumber.val(getId);
		$prodGubun.val(gubun);
		$finalPrice.text($(target).children("input").val()*resCount);
		changePay.getFinalPrice();
	}
}

/******************************************
 * 할인시 금액 변경
 ******************************************/
var changePay = {
		
	finalPrice : null,
	
	getFinalPrice : function(){
		this.finalPrice = $("#finalPrice").text();
	},
	
	payCoupon	: function(discount){
		
		if (this.finalPrice == null) {
			
			alert("상품을 먼저 선택해주세요.");
			
			return;
		}
		
		var percent = this.finalPrice/100,
			couponDiscount = percent*discount,
			$discountPrice = $("#discountPrice"),
			$finalPrice = $("#finalPrice"),
			usePoint = ($("#usePoint").val() == "") ? 0 : $("#usePoint").val();
		
		$discountPrice.text(couponDiscount);
		$finalPrice.text(this.finalPrice - usePoint - couponDiscount);
	},
	payPoint	: function(){

		var target = $("#usePoint"),
			that = this;
		
		target.blur(function(){

			if (that.finalPrice == null) {
				
				$(this).val("");
				alert("상품을 먼저 선택해주세요.");
				
				return;
			}
			
			var targetVal = target.val(),
				discountPoit = $("#discountPoit"),
				discountPrice = $("#discountPrice").text(),
				finalPrice = $("#finalPrice"),
				myPoint = $("#myPoint").text()*1;
			

			console.log(that.finalPrice);
			console.log(changePay.finalPrice);
			
			if (myPoint > targetVal) {
				
				discountPoit.text(targetVal);
				
				finalPrice.text(that.finalPrice - targetVal - discountPrice);
			} else {
				
				alert("보유적립금 이상으로 사용할 수 없습니다.");
				target.val("");
			}
		});
	}
}

/******************************************
 * 버스 상품일경우 해당 좌석 정보를 가져와서 뿌린다.
 ******************************************/
var bus = {
	
	getBusSeat : function(prodNm, target) {
		
		var result = discountPrice.ajaxFn({"param" : prodNm, "url" : "resMainBusSeat.do"});
		
		var seatArr = JSON.parse(result.seat),
			busSeatArea = $(".bus-seat-area"),
			resSeatArr = [],
			makeSeat = "",
			getTitle = $(target).parent().parent().children(".getTitle").text(),
			getTime = $(target).parent().parent().children(".getTime").text(),
			$modalHeader = $(".prod-modal");

		if (result.resSeat != null) {
			resSeatArr = result.resSeat.split(",");
		}
		
		/* 모달에 들어가는 상품의 타이틀과 시간 */
		$modalHeader.children("h4").text(getTitle + " 관광 버스 좌석표");
		$modalHeader.children("h5").text("출발시간 - " + getTime);

		busSeatArea.parent().addClass("bus1");
		
		for ( var i in seatArr) {
			
			makeSeat += '<div class="bus-seat bus-seat-admin" new="busSeat" style="left:'
				+ seatArr[i].seatLeft +'px; top:'+ seatArr[i].seatTop +'px; position: absolute;"'
				+ 'id="'+ seatArr[i].seatNum +'">'
				+ '<div class="bus-seat-mask" onclick="javascript:reservationBus.busSeatSelectFn(this)">'
					+ '<span class="seatId">'+ seatArr[i].seatNum +'</span>'
				+ '</div>'
			+ '</div>';
		}
		
		busSeatArea.append(makeSeat);	// 좌석들을 추가하고
		
		/* 만약 이미 예약된 좌석이 있다면 해당 좌석을 솔드아웃 처리한다. */
		if (resSeatArr.length != 0) {
			
			for ( var i in resSeatArr) {
				
				$("#"+resSeatArr[i]).addClass("seat-soldout");
			}
		}
		
		modal.reservation();
	}
}

/******************************************
 * 상품리스트를 가져온다.
 ******************************************/
var get = {
		
	prodList : function() {
		
		var reserveDate = $("#reserveDate"),
			options = $("#startTime, #startTema");
		
		if (reserveDate.val() == "") {
			alert("예약일을 지정하세요");
			
			return false;
		}
		
		if (options.val() == "") {
			alert("검색구분을 지정하세요");
			
			return false;
		}
		
		var getOptions = [],
			serchOption = "",
			$finalPrice = $("#finalPrice");
		
		$finalPrice.text("");
		
		$("[data=select]").each(function(i, item) {
			
			getOptions[i] = $(item).attr("id")+"="+$(item).val();
		});
		
		serchOption = getOptions.join(",");
		
		var result = discountPrice.ajaxFn({"url": "getProductList.do", "param": serchOption});
		
		var $prodList = $("#prodList").children("tbody"),
			addList = "";
		
		if (result != "") {
			$.each(result, function(i, item) {
				
				/* 가져온 상품이 버스면 좌석선택 버튼을 노출하고, 도보상품일경우 잔여좌석을 표시한다. */
				if (item.courseStatus == "버스") {
					addList += '<tr id="'+ item.productNumber +'" onclick="changeSelect.selectProd(this, \''+ item.courseStatus +'\')">'
								+ '<input type="hidden" value="'+ item.coursePrice +'">'
								+ '<td>'+ item.departureDay +'</td>'
								+ '<td class="getTime">'+ item.departureTime +'</td>'
								+ '<td>'+ item.courseDetail +'</td>'
								+ '<td class="getTitle">'+ item.courseTitle +'</td>'
								+ '<td><a class="btn btn-xs res-table-btn" type="button" '
								+'onclick="javascript:bus.getBusSeat(\''+ item.productNumber +'\', this)">좌석 선택</button></td>'
							+ '</tr>'
				} else {
					addList += '<tr id="'+ item.productNumber +'" onclick="changeSelect.selectProd(this, \''+ item.courseStatus +'\')">'
								+ '<input type="hidden" value="'+ item.coursePrice +'">'
								+ '<td>'+ item.departureDay +'</td>'
								+ '<td class="getTime">'+ item.departureTime +'</td>'
								+ '<td>'+ item.courseDetail +'</td>'
								+ '<td class="getTitle">'+ item.courseTitle +'</td>'
								+ '<td>'+ item.resPerson +'</td>'
							+ '</tr>'
				}
			});
		} else {
			addList = '<tr>'
						+ '<td colspan="5">검색된 항목이 없습니다.</td>'
					+ '</tr>'
		}

		/* 기존 로드된 리스트가 있다면 지우고 현재 가져온 리스트를 뿌린다. */
		$prodList.children().remove();
		$prodList.append(addList);
	}
}

$(document).ready(function(){	

	reservation.valCheck();
	changeSelect.selectPay();
	changeSelect.payDate();
	changePay.payPoint();
});
</script>

<div class="modal bus-seat-modal hidden">
	<div class="modal-dialog col-lg-12">
		<div class="modal-content">
			<div class="clearfix">
				<div class="custom-tab border-none reviewModalBox">
					<div class="tab-content">
						<div id="menu3123" class="tab-pane fade active in">
							<div class="clearfix">

								<div class="comments-list">
									<div class="media">
										<div class="media-body prod-modal">
											<h4 class="media-heading">동대문 DDP - 청계천 - 남대문 City 관광 버스 좌석표</h4>
											<h5>출발시간 - PM 7:00</h5>
											<div class="clearfix">
												<div>
													<div class="bus-seat-area"></div>
												</div>

	                                             <div class="col-md-12 text-center pd-top-30">
	                                                 <button class="btn btn-primary radius btn-lg" type="button" onclick="reservationBus.saveSelectSeat()">좌석선택 완료</button>
	                                             </div>
												
											</div><!-- end comment-review -->
										</div>
									</div>
								</div><!-- comments-list -->

							</div><!-- end clearfix -->
						</div>
					</div><!-- end custom-tab -->
				</div>
			</div><!-- end grid -->
		</div>
	</div>
	<div class="modal-bg" onclick="javascript:modal.reservation()"></div>
</div>

<div id="wrapper">
    <section class="section lb page-title little-pad">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="section-big-title clearfix">
                        <div class="pull-left">
                            <h3>회원 예약</h3>
                            <p>회원 투어상품 예약 페이지 입니다.</p>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
     </section>
     <section class="section">
         <div class="container">
             <div class="row">
                 <div class="col-md-12">
                     <div class="content">
                         <div class="blog-wrapper">
                             <div class="blog-item reservation-contents">
                                 <div class="row">
                                     <div class="col-md-6">
                                         <div class="question">
                                         <h3><strong>!:</strong>예약 전 안내사항</h3>
                                         <p>주말 및 공휴일, 4월/5월/9월/10월 성수기에는 예약이 조기 마감되오니 이점 유의하셔서 신청해주시기 바랍니다.</p>
                                         <p>수학여행 단체 등 50명 이상의 대형 단체일 경우, 관광일 기준 최소 2주전 예약바랍니다.</p>
                                         <p>버스투어의 경우 예약인원 8인 이상일 경우 출발이 확정되며, 예약인원이 1~7인의 경우 출발이 이루어지지 않을 수 있습니다.</p>
                                         <p>만약, 최소인원이 충족되지 않아 투어가 취소될 경우 취소 수수료는 발생하지 않으며 투어일 1일전 문자와 메일로 안내드립니다.</p>
                                         </div>
                                     </div>
                                     <div class="col-md-6">
                                         <div class="question">
                                         <h3><strong>!:</strong>예약시 주의사항</h3>
                                         <p>해설진행시 발생하는 안전사고에 대해서 도보관광사무국과 서울문화관광해설사는 책임을 지지 않습니다. 유아 및 어린이를 포함한 학생단체는 반드시 인솔자를 동반해 주시기 바랍니다.</p>
                                         <p>환불의 경우 투어 예약일 3일전까지 취소가 가능하며, 투어 예약일로부터 7일 이전에 취소시 10%의 수수료가 부가됩니다.</p>
                                         <p>예약하신 내역은 마이페이지 또는 이메일로 발송되어진 바우처의 예약번호를 입력하시면 확인 및 취소/변경이 가능합니다.</p>
                                         </div>
                                     </div><!-- end col -->
                                 </div>

                                 <hr>

                                 <div class="row">
                                     <div class="col-md-10 col-md-offset-1">
                                         <h3><strong>- </strong> 여행상품 예약</h3>
                                         <form class="contact-form search-top"		id="reservationFrm" name="reservationFrm">
                                       	  <input type="hidden" name="orderKind" 	id="orderKind">
                                       	  <input type="hidden" name="kindInfo"		id="kindInfo">
                                       	  <input type="hidden" name="discount"		id="discount">
                                       	  <input type="hidden" name="price"			id="price">
                                       	  <input type="hidden" name="resSeat" 		id="resSeat"/>
                                       	  <input type="hidden" name="prodGubun" 	id="prodGubun"/>
                                       	  <input type="hidden" order="info" name="productNumber"	id="productNumber">
                               			 	<div class="row">
	                                             <div class="col-md-6">
	                                                 <div class="form-group">
	                                                 <input type="text" class="form-control" order="info" name="orderName" id="orderName" placeholder="이름" value="${sessionScope.memberSession.memberName}">
	                                                 </div>
	                                             </div>
	                                             <div class="col-md-6">
	                                                 <div class="form-group">
	                                                 <input type="text" class="form-control" order="info" name="orderPhone" id="orderPhone" placeholder="핸드폰번호"
	                                                 	 value="${sessionScope.memberSession.memberHpf}-${sessionScope.memberSession.memberHpm}-${sessionScope.memberSession.memberHpl}">
	                                                 </div>
	                                             </div>
	                                             <div class="col-md-12">
	                                                 <div class="form-group">
	                                                 <input type="email" class="form-control" order="info" name="orderEmail" id="orderEmail" placeholder="E-mail" value="${sessionScope.memberSession.memberMail}">
	                                                 </div>
	                                             </div>
	                                             
	                                             <div class="col-md-12">
	                                                <div class="form-group">
	                                                	<div class="reservationCheck">
		                                             		<input type="checkbox" class="checkBox" onclick="javascript:reservation.sameVal(this)"><p>주문자와 예약자가 동일할경우 체크해주세요.</p>
	                                             		</div>
	                                             	</div>
	                                             </div>
	
	                                             <div class="col-md-3">
	                                                 <div class="form-group">
	                                                 <input type="text" class="form-control" order="info" name="resName" id="resName" placeholder="예약자">
	                                                 </div>
	                                             </div>
	                                             <div class="col-md-2">
	                                                 <div class="form-group">
	                                                 <input type="number" class="form-control" order="info" name="resCount" id="resCount" placeholder="예약인원" min="1">
	                                                 </div>
	                                             </div>
	                                             <div class="col-md-7">
	                                                 <div class="form-group">
	                                                 <input type="text" class="form-control" order="info" name="resPhone" id="resPhone" placeholder="예약자 전화번호">
	                                                 </div>
	                                             </div>
	                                             <div class="col-md-12">
	                                                 <div class="form-group">
	                                                 <input type="text" class="form-control" order="info" name="resEmail" id="resEmail" placeholder="예약자 이메일">
	                                                 </div>
	                                             </div>
                                             </div>
                                             
                               			 	 <div class="row pd-top-20">
	                                             <div class="col-md-2">
	                                                <div id="datetimepicker1" class="input-append date time-picker">
	                                                    <input data-format="yyyy/MM/dd" class="form-control add-on" name="reserveDate" data="select" id="reserveDate" type="text" placeholder="예약날짜">
	                                                    <span class="add-on"><i data-time-icon="fa fa-clock-o" data-date-icon="fa fa-calendar"></i></span>
	                                                </div>
                                                </div>
	                                             
	                                             <div class="col-md-3 search-select">
	                                                <select class="selectpicker col-sm-12" name="startTime" id="startTime" data="select" data-size="5" data-live-search="false" title="출발시간">
	                                                    <option data-tokens="All">All</option>
	                                                    <option data-tokens="00:00 ~ 05:00">00:00 ~ 05:00</option>
	                                                    <option data-tokens="05:00 ~ 10:00">05:00 ~ 10:00</option>
	                                                    <option data-tokens="10:00 ~ 13:00">10:00 ~ 13:00</option>
	                                                    <option data-tokens="13:00 ~ 17:00">13:00 ~ 17:00</option>
	                                                    <option data-tokens="17:00 ~ 20:00">17:00 ~ 20:00</option>
	                                                    <option data-tokens="20:00 ~ 24:00">20:00 ~ 24:00</option>
	                                                </select>
	                                             </div>
	                                             
	                                             <div class="col-md-3 search-select">
	                                                <select class="selectpicker col-sm-12" name="startTema" id="startTema" data="select" data-size="5" data-live-search="false" title="테마선택">
	                                                    <option data-tokens="All">All</option>
                       									<c:forEach items="${temaList}" var="temaList" varStatus="status">
	                                              	     	<option data-tokens="<c:out value="${temaList.themeName}"/>"><c:out value="${temaList.themeName}"/></option>
                       									</c:forEach>
	                                                </select>
	                                             </div>
	                                             <div class="col-md-1 padding0">
                                         				 <button class="btn btn-primary" type="button" onclick="javascript:get.prodList()">검색</button>
	                                             </div>
	                                             
	                                             <div class="col-md-12">
	                                                 <div class="form-group">
	                                                	 <div class="form-control form-control-table">
	                                                	 	<table class="reservation-table" id="prodList">
	                                                	 		<thead>
	                                                	 			<tr>
	                                                	 				<td>출발일</td>
	                                                	 				<td>출발시간</td>
	                                                	 				<td>출발지</td>
	                                                	 				<td>관광코스명</td>
	                                                	 				<td>남은 좌석</td>
	                                                	 			</tr>
	                                                	 		</thead>
	                                                	 		<tbody>
	                                                	 			<tr>
	                                                	 				<td colspan="5">검색된 항목이 없습니다.</td>
	                                                	 			</tr>
	                                                	 		</tbody>
	                                                	 	</table>
	                                                	 </div>
	                                                 </div>
	                                             </div>
	
	                                             <div class="col-md-3">
	                                                 <div class="form-group">
	                                                 <input type="text" class="form-control col-md-6" id="couponNumber" name="couponNumber" placeholder="쿠폰 입력">
	                                                 </div>
	                                             </div>
	                                             <div class="col-md-1 padding0">
                                         				 <button class="btn btn-primary" type="button" onclick = "javascript:discountPrice.useCoupon()">적용</button>
	                                             </div>
	                                             
	                                             <div class="col-md-6 comment-input-area align-right">
	                                                 <div class="comment-input col-sm-6">보유 적립금  : <span id="myPoint" name="myPoint"><c:out value="${pointTotalmile}" /></span></div>
	                                                 <div class="form-group col-sm-6">
	                                                 <input type="text" class="form-control" name="usePoint" id="usePoint" placeholder="사용할 적립금">
	                                                 </div>
	                                             </div>
	                                             <div class="clearfix"></div>
												
												<hr class="margin0" />
												
											    <div class="col-md-12">
											    	<div class="align-right col-md-8 price-guide">
			                                             <div class="col-sm-3">
			                                             	<div class="seat-info">
				                                                 <h5>선택 좌석</h5>
				                                                 <div class="select-seat"></div>
			                                             	</div>
			                                             </div>
			                                             <div class="col-sm-5 price-discount discount">
			                                                 <h5>할인 금액</h5>
			                                                 <div>
			                                                 	<span class="title">마일리지 할인금액</span>
			                                                 	<span id="discountPoit" name="discountPoit">0</span>
			                                                 </div>
			                                                 <div>
			                                                 	<span class="title">쿠폰 할인금액</span>
			                                                 	<span id="discountPrice" name="discountPrice">0</span>
			                                                 </div>
			                                             </div>
			                                             <div class="col-sm-4 price">
			                                                 <h5>총 결제액</h5>
			                                                 <div class="final-price" id="finalPrice" name="finalPrice">0</div>
			                                             </div>
											    	</div>
												</div>
												
											</div>
                                             
                               			 	<div class="row pd-top-50">
										    <div class="col-md-12">
										        <div class="shortcode-wrap">
										            <h4 class="reservation-title">결제수단을 지정하세요.</h4>
										            <div class="custom-tab">
										                <ul class="nav nav-tabs">
										                    <li class="active"><a data-toggle="tab" href="#payCard"><i class="fa fa-calendar"></i>카드결제</a></li>
										                    <li><a data-toggle="tab" href="#payBank"><i class="fa fa-info"></i>무통장 입금</a></li>
										                    <li><a data-toggle="tab" href="#payPhone"><i class="fa fa-thumbs-up"></i>핸드폰 결제</a></li>
										                </ul>
										                <div class="tab-content row">
											                <jsp:include page="/WEB-INF/jsp/egovframework/example/reservation/payTab1.jsp">
											                	<jsp:param value="C" name="payTab1"/>
											                </jsp:include>
											                <jsp:include page="/WEB-INF/jsp/egovframework/example/reservation/payTab2.jsp">
											                	<jsp:param value="B" name="payTab2"/>
											                </jsp:include>
											                <jsp:include page="/WEB-INF/jsp/egovframework/example/reservation/payTab3.jsp"></jsp:include>
										                </div>
										      		  </div>
										      		</div>
										        </div>
										   	 </div><!-- end row -->
                                         </form>

                                         <div class="col-md-12 text-center pd-top-30">
                                             <button class="btn btn-primary radius btn-lg" type="button" onclick = "javascript:reservationFn.goRes()">예약하기</button>
                                             <!-- nav.pageSubmitFn('reservationComplete', 'frm') -->
                                         </div>
                                             
                                     </div>
                                 </div>
                             </div><!-- end blog-item -->
                         </div>
                     </div><!-- end grid -->
                 </div><!-- end col -->
             </div><!-- end row -->
         </div><!-- end container -->
     </section><!-- end section -->
</div>