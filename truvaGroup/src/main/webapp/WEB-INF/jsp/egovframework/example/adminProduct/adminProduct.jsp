<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
/******************************************
 * jqGrid
 ******************************************/
var adminGrid = function(){
	
	var cnames = ['상품번호','구분','상품명','출발일','출발시간','총인원','예약인원'];

    $("#adminProductTable").jqGrid({
    
        url: "jqgridAdminProMain.do",
        datatype: "json",
        colNames: cnames,
		postData: {"param" : ""},
        colModel:[
      {name:'productNumber',	index:'productNumber',		key:true,		align:"center"},
      {name:'courseStatus',		index:'courseStatus',		align:"center",	edittype:"select",	formatter:"select",
    		
    	  editoptions: {
    		  
    		  value		:{"도보":"도보", "버스":"버스"},
    		  dataEvents:[{

    			  type	:"change"
    		  }]
    	  }	
      },
      {name:'courseTitle',		index:'courseTitle',	align:"center"},
      {name:'departureDay',		index:'departureDay',	align:"center"},
      {name:'departureTime',	index:'departureTime',	align:"center"},
      {name:'totalPerson',		index:'totalPerson',	align:"center",		formatter:gridButton.seatMoreBtn},
      {name:'person',			index:'person',			align:"center"}
		],
        height: '513',
        width: '97%',
        rowNum: 14,
        autowidth: true,
        cellEdit: true,
        cellsubmit: "clientArray",
        rownumbers  : false,
        multiselect	: true,
        viewrecords : true,
	    loadonce : true,
    	loadComplete : function(result){
    		
    		paging(result);
	 	}
    }).trigger("reloadGrid");
}

/******************************************
 * 그리드 페이징
 ******************************************/
var paging = function(result) {
	
	/* 페이징처리 */
	var totalPage = result.totalPage,
		prevPage = result.prevPage,
		endPage = result.endPage,
		nextPage = result.nextPage,
		pageScale = result.pageScale,
		i = 0,
		pagination = $("#pagination"),
		pageNum = "",
		prevPageBtn = "",
		nextPageBtn = "";
	
	var setEnd = (totalPage < endPage) ? totalPage : endPage;
		
	pagination.children().remove();
	
	if (pagination.children().length == 0) {
		
		for (i = result.startPage; i < setEnd + 1; i++) {

			if (i == result.page) {
				pageNum += '<li class="active">'
							+ '<a href="#" onclick="javascript:surchButton.surchGrid({page:'+ i +'})">' + i +'</a>'
	      			+'</li>';
			} else {
				pageNum += '<li>'
					+ '<a href="#" onclick="javascript:surchButton.surchGrid({page:'+ i +'})">'
						+ i
	      				+'</a>'
	      			+'</li>';
			}
		}

		if (totalPage > pageScale) {
			prevPageBtn = '<li><a href="#" onclick="javascript:surchButton.surchGrid({page:1})"><<</a></li>'
	   					+ '<li><a href="#" onclick="javascript:surchButton.surchGrid({page:'+ prevPage +'})"><</a></li>';
			
	   		nextPageBtn = '<li><a href="#" onclick="javascript:surchButton.surchGrid({page:'+ nextPage +'})">></a></li>'
	    					+ '<li><a href="#" onclick="javascript:surchButton.surchGrid({page:'+ totalPage +'})">>></a></li>';
		} else {
	   		prevPageBtn = '<li><a href="#" onclick="javascript:surchButton.surchGrid({page:1})"><<</a></li>';
			
	   		nextPageBtn = '<li><a href="#" onclick="javascript:surchButton.surchGrid({page:'+ totalPage +'})">>></a></li>';
		}

		pagination.append(prevPageBtn + pageNum + nextPageBtn);
	}
}

/******************************************
 * 버튼 클릭시 이벤트
 ******************************************/
var gridButton = {
	
	seatMoreBtn : function(cellvalue, options, rowObject) {
		
		if (rowObject.courseStatus == "버스") {
			
			return cellvalue + '  <button class="btn btn-xs btn-default" type="button" data-target=".admin-showSeat"'
			+'onclick="javascript:gridButton.showSeat(\''+ rowObject.productNumber +'\')">잔여좌석</button>'
		} else {

			return cellvalue;
		}
	},
	
	/* 상품추가 버튼 */
	addProd : function(){
		
		var $newProdFrm = $("#newProdFrm"),
			$productGubun = $("#productGubun"),
			$productName = $("#productName"),
			checkFrm = $newProdFrm.find("select, input[type!=hidden]");
		
		for (var i = 0; i < checkFrm.length; i++) {
			
			if (checkFrm.eq(i).val() == "") {

				alert("미입력된 값이 있습니다.");
				
				exit = true;
				
				return false;
			}
		}
		
		if (confirm("입력된 내용을 저장하시겠습니까?") == false) {
			
			return false;
		}
		
		var selectGubun = $("#selectGubun").val(),
			selectName = $("#selectName").val().split("] ").pop(),
			courseGubun = $("#selectName").children("option:selected").attr("gubun");
			
		$productGubun.val(selectGubun);
		$productName.val(selectName);
		
		var newProdFrm = $("#newProdFrm").serializeObject();
		
		// 아작스 통신
		var result = this.prodAjaxFn({"param1" : JSON.stringify(newProdFrm), "gubun" : "I", "select" : courseGubun}, "Y");

		if (result == "SUCCESS") {
			
			modal.adminReservation('admin-modal');
			
			alert("저장이 완료되었습니다.");
		}
	},

	delProd : function() {
		
		var grid = $("#adminProductTable"),
			selectRow = grid.getGridParam("selarrrow");
		
		var result = this.prodAjaxFn({"param1" : selectRow.join(","), "gubun" : "D"}, "Y");
		
		
		if (result == "SUCCESS") {
			
			alert("삭제가 완료되었습니다.");
		}
		$("#adminProductTable").trigger("reloadGrid");
	},
	
	showSeat : function(podNm) {
		
		var page = $("#pagination").children(".active").text();
		
		var result = this.prodAjaxFn({"param1" : podNm, "url" : "prodShowSeat.do", "page" : page}, "N");
		
		var seatArr = new Array,
			resSeatArr = new Array,
		 	parsArr = new Array,
			makeSeat = "",
			i = 0;
		
		/* 받아온 좌석 정보를 json Array로 파싱 */
		parsArr = JSON.parse(result);
	  	seatArr = JSON.parse(parsArr.seat);
		
		for (i = 0; i < seatArr.length; i++) {

			makeSeat += '<div class="bus-seat bus-seat-admin" new="busSeat" style="left:'
						+ seatArr[i].seatLeft +'px; top:'+ seatArr[i].seatTop +'px; position: absolute;"'
						+ 'id="'+ seatArr[i].seatNum +'">'
					+ '<div class="bus-seat-mask">'
						+ '<span class="seatId">'+ seatArr[i].seatNum +'</span>'
					+ '</div>'
				+ '</div>';
		}
		
		$("#showSeatArea").append(makeSeat);
		
		/* 이미 예약된 좌석을 예약완료 처리 */
		if (parsArr.resSeat != null) {

		  	resSeatArr = parsArr.resSeat.split(",");
			
			for ( var i in resSeatArr) {
				
				$("#"+resSeatArr[i]).addClass("seat-soldout");
			}
		}

		modal.adminReservation('admin-showSeat');
	},
	
	/* 아작스 통신 관련 Fn */
	prodAjaxFn : function(option, reload){
		
		var settings = {
			
			url		: "adminNewProduct.do",
			param1	: "",
			page	: 1,
			gubun	: "",
			select	: "",
		};
		
		var jsonRes = {};
		
		settings = $.extend({}, settings, option);
		
		$.ajax({
			
			type	: "POST",
			url		: settings.url,
			data	: {"param1" : settings.param1, "page" : settings.page, "gubun" : settings.gubun, "select" : settings.select},
			async	: false,
			success	: function(result){
				
				if (result == "SUCCESS") {
					
					alert("성공하였습니다.");
				}

				jsonRes = result;
			},
			complete : function() {
				
				if (reload == "Y") {
					$.jgrid.gridUnload("#adminProductTable"); 
					adminGrid(settings.page);
				}
			}
		});
		
		return jsonRes;
	}
}

/******************************************
 * 상단 서치바 이벤트
 ******************************************/
var surchButton = {
	
	surchMore	: function(){
			
			this.surchGrid({"page":1});
	},
	
	surchGrid	: function(options){
		
		var surchSelect = "";
		
		if ($("#productSurchSelect").val() != "") {
			
			surchSelect = $("#productSurchSelect").val();
		} 
		
		var settings = {
			surchSelect	:surchSelect,
			page		:"1"
		}
		settings = $.extend({}, settings, options);

		var getPage = "";
		
		$("#adminProductTable").setGridParam({
			
			datatype	: "json",
			postData	: {"param":settings.surchSelect},
			page		: settings.page,
			mtype		: "POST",
			loadComplete: function(result){
				
				if (result.rows.length == 0) {

					alert("검색에 해당하는 결과가 없습니다. ");
				}
					paging(result);
			}
		}).trigger("reloadGrid");
	},
	
	changeOption : function() {
		
		var productSelectGubun = $("#productSelectGubun").val(),
			listTarget = $("#productSurchSelect").prev().children(".dropdown-menu.inner").children();

		listTarget.removeClass("hidden");
		
		if (productSelectGubun != "All") {

			var gubunTarget = listTarget.children().not("[data-tokens="+productSelectGubun+"]").parent();

			gubunTarget.addClass("hidden");
		}
	}
}

var change = {
		
	timeSet : new Set(),
	
	getTime : function(target) {
		
		var getVal = $(target).val().split("] ").pop(),
			getGubun = $(target).children("option:selected").attr("gubun"),
			gubun = $(target).attr("gubun"),
			$productTime = $("#productTime"),
			$timeSet = this.timeSet,
			$productPeople = $("#productPeople");
		
		$.ajax({
			
			type	: "POST",
			url		: "adminProductGetTime.do",
			async	: false,
			data	: {"param1" : JSON.stringify(getVal), "gubun" : getGubun},
			beforeSend : function() {
				
				/* 기존 로딩된 시간이 있을경우 해당 내용을 초기화한다. */
				$timeSet.clear();
				
				$productTime.val("");
				$productTime.nextAll().remove();
				
				$productPeople.val("");
				$productPeople.removeAttr("readonly");
			},
			success : function(result) {
				
				/* 받은 해당코스의 시간정보를 출발시간에 뿌려준다. */
				var jsonPars = JSON.parse(result),
					i = 0,
					addBtn = "",
					jsonArr = new Array;
				
				jsonArr = JSON.parse(jsonPars.getTimes);
				
				for (i = 0; i < jsonArr.length; i++) {
					addBtn += '<button class="btn btn-default btn-xs none-focus" type="button" onclick="javascript:change.addTime(this)">'
									+ jsonArr[i] +':00</button>';
				} 
				
				$productTime.parent().append(addBtn);
				
				if (getGubun == "버스") {
					
					$productPeople.val(jsonPars.busSitcount);
					$productPeople.attr("readonly", "readonly");
				}
			}
		});
	},
	
	/* 시간이 적힌 버튼을 클릭하면 그 시간을 저장한다.  */
	addTime : function(target){
		
		var selectTime = $(target).text()
			$timeSet = this.timeSet,
			$productTime = $("#productTime");
		
		if ($(target).hasClass("activ")) {
			$timeSet.delete(selectTime);
			
			$(target).removeClass("activ");
		} else {
			$timeSet.add(selectTime);
			
			$(target).addClass("activ");
		}
		
		$productTime.val([...$timeSet]);
	}
}

$(document).ready(function(){	

	adminGrid();
	$("#productStartDay").datetimepicker({
		minDate : 0,
		beforeShow : function() {
			alert("d");
		}
	});
});
</script>
<div class="mainbar">

   	<div class="admin-modal hidden">
   		<div class="admin-m-content">
   			
   			<h4 class="admin-m-title">상품 생성하기</h4>
			<div class="table-responsive non-scroll">
			<form id="newProdFrm"	name="newProdFrm">
				<input type="hidden"	id="productGubun"	name="productGubun">
				<input type="hidden"	id="productName"	name="productName">
				<table class="table table-bordered table-row">
				  <thead>
					<tr>
					  <th>코스</th>
					  <td class="select-box col-lg-12">
                         <select class="selectpicker form-control" data-size="5" data-live-search="false" title="코스명 선택" id="selectName" onchange="change.getTime(this)">
                         	<c:forEach var="getCosList" items="${getCosList}">
                        		<option gubun="<c:out value='${getCosList.courseStatus}' />" data-tokens="<c:out value='${getCosList.courseTitle}' />">
                        		[<c:out value="${getCosList.courseStatus}" />] <c:out value="${getCosList.courseTitle}" />
                        		</option>
                            </c:forEach>
                         </select>
					  </td>
					</tr>
					<tr>
					  <th>출발일</th>
					  <td class="ip-text">
						    <div class="input-append date dtpicker col-md-4 pull-left">
						    	<div class="add-on">
									<input data-toggle="datepicker" class="form-control" type="text" placeholder="Pick-up time"
											name="productStartDay" id="productStartDay">
									<i class="fa fa-calendar" data-date-icon="fa fa-calendar" data-time-icon="fa fa-clock-o"></i>
						    	</div>
						    </div>
						    <span class="col-md-2 pull-left">~ </span>
						    <div class="input-append date dtpicker col-md-4 pull-left">
						    	<div class="add-on">
									<input data-toggle="datepicker" class="form-control" type="text" placeholder="Pick-up time"
											name="productEndDay" id="productEndDay">
									<i class="fa fa-calendar" data-date-icon="fa fa-calendar" data-time-icon="fa fa-clock-o"></i>
						    	</div>
						    </div>
					  </td>
					</tr>
					<tr>
					  <th>출발시간</th>
					  <td>
						  <input type="hidden" id="productTime" name="productTime">
					  </td>
					</tr>
					<tr>
					  <th>총 인원</th>
					  <td class="ip-text">
						  <input type="number" id="productPeople" name="productPeople">
					  </td>
					</tr>
				  </thead>
				</table>
			</form>
			</div>
			<div class="widget-c-btn">
				<button class="btn btn-green" type="button" data-target=".admin-modal"
            		onclick="javascript:gridButton.addProd()"><i class="fa fa-pencil"></i> 추가</button>
				<button class="btn btn-red" type="button" data-target=".admin-modal"
            		onclick="javascript:modal.adminReservation('admin-modal')"><i class="fa fa-close"></i> 닫기</button>
			</div>
   		</div>
   	<div class="admin-modal-bg hidden" onclick="javascript:modal.adminReservation('admin-modal')"></div>
   	</div>
   	
   	<div class="admin-showSeat hidden">
   		<div class="admin-m-content">
   			
   			<h4 class="admin-m-title bus-name"></h4>
			<div class="table-responsive">
				<table class="table table-bordered">
				  <thead>
					<tr>
					  <th>좌석 배치도</th>
					</tr>
				  </thead>
					<tbody>
						<tr>
						  <th> 
					  		<div class="admin-bus bus1">
					  			<div class="admin-bus" id="showSeatArea"></div>
					  		</div>
						  </th>
						</tr>                                                        
					</tbody>
				</table>
			</div>
			<div class="widget-c-btn">
				<button class="btn btn-red" type="button" data-target=".admin-modal"
            		onclick="javascript:modal.adminReservation('admin-showSeat')"><i class="fa fa-pencil"></i> 닫기</button>
			</div>
   		</div>
   		<div class="admin-modal-bg hidden" onclick="javascript:modal.adminReservation('admin-showSeat')"></div>
   	</div>

	<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">상품관리
			  <!-- page meta -->
			  <span class="page-meta">투어상품 관리 및 수정</span>
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right widget-head-right">
				<div class="bread-crumb">
				  <a href="index.html"><i class="fa fa-home"></i> 예약관리</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">상품관리</a>
				</div>
				<button class="btn btn-default wminimize" type="button"><i class="fa fa-plus"></i> 검색창 보기</button>
			</div>
			<div class="clearfix"></div>
		</div>

		<!-- Breadcrumb -->
			<div class="widget-content">
				<div class="padd">
					
					<div class="col-lg-12">
					    
						<span class="input-title">상품구분</span>
					    <div class="pull-left col-md-5 btn-select-box">
					    	<div class="select-surch col-md-3">
	                         <select class="selectpicker form-control" data-size="8" data-live-search="false" title="선택하세요"
	                         	 id="productSelectGubun" onchange="javascript:surchButton.changeOption()">
	                             <option data-tokens="All" value="All">전체보기</option>
	                             <option data-tokens="도보">도보</option>
	                             <option data-tokens="버스">버스</option>
	                         </select>
					    	</div>
					    	<div class="select-surch col-md-7">
	                         <select class="selectpicker form-control" data-size="8" data-live-search="false" id="productSurchSelect" title="선택에 해당하는 코스가 나옵니다">
	                           <option data-tokens="All" value="">전체보기</option>
	                         	<c:forEach items="${getCosList}" var="getCosList" varStatus="status">
	                            	<option data-tokens="<c:out value="${getCosList.courseStatus}" />" value="<c:out value="${getCosList.courseNumber}" />">
	                            	[<c:out value="${getCosList.courseStatus}" />] 
	                            		<c:out value="${getCosList.courseTitle}" /></option>
	                         	</c:forEach>
	                         </select>
					    	</div>
							<div class="pull-left">
								<button class="btn btn-default btn-navy" onclick="javascript:surchButton.surchMore()" type="button">검색</button>
							</div>
					   	</div>
					    
						<div class="clearfix"></div><!-- 플롯해제 -->
					</div><!-- END ROW -->

				<div class="clearfix"></div>
				</div>
			</div>

		<div class="clearfix"></div>
	</div><!--/ Page heading ends -->

	<!-- Matter -->
	<div class="matter">
	
		<div class="col-md-12 widget-top">
			<div class="pull-left">
				<button class="btn btn-xs btn-green pull-left" type="button"><i class="fa fa-save"></i> EXCEL DOWNLODE</button>
				<button class="btn btn-xs btn-navy pull-left" type="button"><i class="fa fa-print"></i> PRINT</button>
			</div>
			<div class="pull-right">
				<button class="btn btn-xs btn-green pull-left" type="button" onclick="javascript:modal.adminReservation('admin-modal')">
					<i class="fa fa-plus"></i> 추가</button>
				<button class="btn btn-xs btn-red pull-left" type="button" onclick="javascript:gridButton.delProd()"><i class="fa fa-unlock"></i> 삭제</button>
			</div>
			<div class="clearfix"></div>
		</div>
		
		<div class="container">
		
			<table id="adminProductTable" class="table input-table table-bordered"></table>
		</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
		<div class="col-md-12 widget-foot">
			<div class="pagination-foot">
				<ul class="pagination" id="pagination">
				</ul>                      
				<div class="clearfix"></div> 
			</div>
		</div>
		
	</div><!--/ Matter ends -->
</div><!--/ Mainbar ends -->