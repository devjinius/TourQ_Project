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
	var cnames = ['주문번호','예약번호','회원구분','예약자','연락처','E-mail','인원','상품구분','상품명','좌석','예약일','결제정보'];

	 $("#adminReservationTable").jqGrid({
	 
	     url: "jqgridAdminReservationMain.do",
	     datatype: "json",
	     postData: {"param" : ""},
	     colNames: cnames,
	     colModel:[
	   {name:'orNumber',		index:'orNumber',		key:true,		align:"center"},
	   {name:'resNumber',	index:'resNumber',	align:"center"},
	   {name:'orMemberYn',	index:'orMemberYn',	align:"center",	edittype:"select",	formatter:"select",
	 	
	 	  editoptions: {
	 		  
	 		  value	:{"Y":"회원", "N":"비회원"},
	 		  dataEvents :[{
	 			  type	:"change"
	 		  }]
	 	  }
	   },
	   {name:'resName',		index:'resName',	align:"center"},
	   {name:'resPhone',		index:'resPhone',	align:"center"},
	   {name:'resEmail',		index:'resEmail',	align:"center"},
	   {name:'resCount',		index:'resCount',	align:"center"},
	   {name:'resType',		index:'resType',	align:"center",	edittype:"select",	formatter:"select",
	 	
	 	  editoptions: {
	 		  value	:{"B":"버스", "W":"도보"},
	 		  dataEents	:[{
	 			  type	:"change"
	 		  }]
	 	  }
	   },
	   {name:'productNumber',index:'productNumber',	align:"center"},
	   {name:'resSeat',		index:'resSeat',	align:"center"},
	   {name:'resDate',		index:'resDate',	align:"center",		formatter:"date",	formatoptions:{newformat:" Y/m/d "}},
	   {name:'orNumber',		index:'orNumber',	align:"center",	formatter:gridButton.addMore}
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
							+ '<a href="#" onclick="javascript:surchButton.surchGrid('+ i +')">' + i +'</a>'
	      			+'</li>';
			} else {
				pageNum += '<li>'
					+ '<a href="#" onclick="javascript:surchButton.surchGrid('+ i +')">'
						+ i
	      				+'</a>'
	      			+'</li>';
			}
		}
		
		if (totalPage > pageScale) {
			prevPageBtn = '<li><a href="#" onclick="javascript:surchButton.surchGrid(1)"><<</a></li>'
	   					+ '<li><a href="#" onclick="javascript:surchButton.surchGrid('+ prevPage +')"><</a></li>';
			
	   		nextPageBtn = '<li><a href="#" onclick="javascript:surchButton.surchGrid('+ nextPage +')">></a></li>'
	    					+ '<li><a href="#" onclick="javascript:surchButton.surchGrid('+ totalPage +')">>></a></li>';
		} else {
	   		prevPageBtn = '<li><a href="#" onclick="javascript:surchButton.surchGrid(1)"><<</a></li>';
			
	   		nextPageBtn = '<li><a href="#" onclick="javascript:surchButton.surchGrid('+ totalPage +')">>></a></li>';
		}

		pagination.append(prevPageBtn + pageNum + nextPageBtn);
	}
}

/******************************************
 * 버튼 클릭시 이벤트
 ******************************************/
var gridButton = {

	/* 수정버튼 */
	goEdit	: function(){
		
		var checkId = $("#adminReservationTable").getGridParam("selarrrow"),
			colName = $("#adminReservationTable").getGridParam("colModel");
		
		if (checkId.length != 0) {

			var gridTable = $("#adminReservationTable"),
				i = 0,
				j = 0;
			
			/* 테이블의 셀을 선택했을때 그 셀이 체크박스로 선택된 셀이면 수정가능하게 한다. */
			gridTable.setGridParam({
				
				onCellSelect : function(rowId, colId, val){

					for (i = 4; i < colName.length-1; i++) {

						gridTable.setColProp(colName[i].name, {editable:false}); 
					}
					
					for (i = 0; i < checkId.length; i++) {
						
						if (rowId == checkId[i]) {
							
							for (j = 4; j < colName.length-1; j++) {

								gridTable.setColProp(colName[j].name, {editable:true}); 
							}
						}
					}
				}
			});
		} else {
			
			alert("수정할 데이터를 선택하세요.");
		}
	},
	
	/* 저장버튼 */
	goSave	: function(){
		
		var checkId = $("#adminReservationTable").getGridParam("selarrrow"),
			colName = $("#adminReservationTable").getGridParam("colModel"),
			gridTable = $("#adminReservationTable"),
			that = this;

		gridTable.editCell(0,0, false);
				
		if (checkId.length == 0) {
			
			alert("저장할 데이터를 선택하세요.");
		} else {
			
			var i = 0,
				j = 0,
				gubun = "";
		
			gridTable.editCell(0,0, false);
			
			/* 선택한 줄에 수정된 데이터가 있는지 없는지 체크한다.*/
			for (i = 0; i < checkId.length; i++) {
				
				var selectTarget = $("#adminReservationTable").children().children("#"+ checkId[i]);
				
				for (j = 4; j < selectTarget.children().length - 1; j++) {
					
					if (selectTarget.children().eq(j).hasClass("dirty-cell")) {
						
						gubun = "Y"
						break;
					}
				}
				
				if (gubun == "Y") {
	
					break;
				}
			}
			
			if (gubun == "Y") {
				
				if (confirm("선택한 데이터를 저장하시겠습니까?") == false) {
					
					return false;
				}
				
				var jsonArr = new Array(),
					cnt = 0,
					i = 0;
				
				for (i = 0; i < checkId.length; i++) {

					var jsonObj = {};
					
					$(colName).each(function(j){
						
						if (j != 0) {

							jsonObj[colName[j].name] = gridTable.getCell(checkId[i], colName[j].name);
						}
					});
					
					jsonArr[cnt] = jsonObj;
					cnt ++
				}
				
				var result = that.gridAjaxFn({param1 : JSON.stringify(jsonArr), url : "jqgridAdminReservationChange.do", gubun : "S"});
				
				if (result == "SUCCESS") {
					
					alert("수정완료 되었습니다.");
				} else {
					
					alert("수정중 에러가 발생하였습니다.");
				}
				
				gridTable.trigger("reloadGrid");
				
			} else {

				alert("선택된 줄중 수정된 데이터가 없어 저장할 수 없습니다.");
			}
		}
	},
	
	/* 주문상세보기 버튼 */
	addMore	: function(cellvalue){
		
		return '<button class="btn btn-xs btn-default" type="button" data-target=".admin-modal"'
					+'onclick="javascript:gridButton.moreBtn(\''+ cellvalue +'\')">상세보기</button>'
	},
	
	/* 결제취소 버튼 */
	orderCancel : function(){

		var orNumber = $("#orNumber").val(),
			orPayment = $("#orPayment"),
			cancelCheck = "";
		
		cancelCheck = confirm("정말로 결제를 취소하시겠습니까?") ? "Y" : "N";
		
		if (cancelCheck == "Y") {

			var result = this.gridAjaxFn({param1 : orNumber, url : "jqgridAdminReservationChange.do", gubun : "C"});
			
			if (result = "SUCCESS") {
				
				orPayment.val("결제취소");
				orPayment.next().hide();
				alert("결제가 취소되었습니다.");
			} else {
				
				alert("결제상태 변경도중 에러가 발생하였습니다.");
			}
		}
	},
	
	/* 그리드에서 데이터를 가져올 때 사용하는 공통 ajax 받은 데이터를 파싱항 리턴함 */
	gridAjaxFn : function(option){
		
		var settings = {
				
			param1	: "",
			gubun	: "",
			url		: "jqgridAdminReservationMore.do"
		};
		
		settings = $.extend({}, settings, option);

		var jsonRes = {};
		
		$.ajax({
			
			type	: "POST",
			url		: settings.url,
			async	: false,
			data	: {"param1": settings.param1, "gubun" : settings.gubun},
			success	: function(rulset){
				
				jsonRes = JSON.parse(rulset);
			},
			complete : function() {

				$.jgrid.gridUnload("#adminReservationTable"); 
				adminGrid();
			}
		});
		
		return jsonRes;
	},
	
	/* 주문상세보기 버튼을 눌렀을때  아작스를 이용해서 json 데이터를 가져옴 */
	moreBtn : function(orNum){
		
		var result = this.gridAjaxFn({param1 : orNum, url : "jqgridAdminReservationMore.do"});
		
		var orNumber = $("#orNumber"),
			orMemberYn = $("#orMemberYn"),
			orName = $("#orName"),
			orPhone = $("#orPhone"),
			orEmail = $("#orEmail"),
			couponNumber = $("#couponNumber"),
			orDiscont = $("#orDiscont"),
			orUsePoint = $("#orUsePoint"),
			totalDiscont = $("#totalDiscont"),
			orKind = $("#orKind"),
			orPrice = $("#orPrice"),
			orPayment = $("#orPayment"),
			orDate = $("#orDate");

			orNumber.val(result.orNumber);
			orMemberYn.val((result.orMemberYn == "Y" ? "회원" : "비회원"));
			orName.val(result.orName);
			orPhone.val(result.orPhone);
			orEmail.val(result.orEmail);
			couponNumber.val((result.couponPubNumber == null ? "미사용" : result.couponPubNumber));
			orDiscont.val(result.orDiscont + " 원");
			orUsePoint.val((result.orUsePoint != null ? result.orUsePoint : 0) + " 원");
			totalDiscont.val(((result.orUsePoint != null ? result.orUsePoint : 0) + result.orDiscont) + " 원");
			orKind.val((result.orKind == "payCard" ? "카드결제" : (result.orKind == "payBank" ? "무통장 입금" : "핸드폰 결제")));
			orPrice.val(result.orPrice + " 원");
			orPayment.val((result.orPayment == "wait" ? "입금대기중" : 
						(result.orPayment == "payCompleted" ? "결제완료" : 
							(result.orPayment == "cancel" ? "결제취소" : "이용완료"))))
			orDate.val(result.orDate);
			
			modal.adminReservation('admin-modal');
		
		/* 이용 완료가되면 결제취소버튼이 안보이도록 */
		if (orPayment.val() == "이용완료") {
			
			orPayment.next().hide();
		} else {
			
			orPayment.next().show();
		}
	}
}

 /******************************************
  * 상단 서치바 이벤트
  ******************************************/
var surchButton = {
		
	/* 기간검색 */
	surchDate	: function(){
		
		if ($("#resSurchStartDate").val() != "") {
			
			var startDate = $("#startDate"),
				endDate = $("#endDate");
			
			startDate.val($("#resSurchStartDate").val());
			endDate.val($("#resSurchEndDate").val());

			this.surchGrid(1);
		} else {
			
			alert("검색 시작할 기간을 지정하세요.");
		}
	},
	
	/* 상세검색 */
	surchMore	: function(){

		if ($("#resSurchMoreSelect").val() != "") {
			
			var getSurchSelect = $("#resSurchMoreSelect").val(),
				getSurchText = $("#resSurchMoreText").val(),
				surchSelect = $("#surchSelect"),
				surchText = $("#surchText");
			
			surchSelect.val(getSurchSelect);
			surchText.val(getSurchText);
			
			this.surchGrid(1);
		} else {
			
			alert("검색 구분을 지정하세요");
		}
	},
	
	surchGrid	: function(pageNm){
		
		var resFrm = $("#resFrm").serializeObject();
		
		$("#adminReservationTable").setGridParam({
			
			datatype	: "json",
			postData	: {"resFrm" : JSON.stringify(resFrm)},
			page		: pageNm,
			mtype		: "POST",
			loadComplete: function(result){
				if (result.rows.length == 0) {

					alert("검색에 해당하는 결과가 없습니다. ");
				}
	    		paging(result);
			}
		}).trigger("reloadGrid");
	}
}
$(document).ready(function(){
	
	adminGrid();
});
</script>

<form id="resFrm">
	<input type="hidden"	id="surchSelect"	name="surchSelect" />
	<input type="hidden"	id="surchText"		name="surchText" />
	<input type="hidden"	id="startDate"		name="startDate" />
	<input type="hidden"	id="endDate"		name="endDate" />
</form>

<div class="mainbar">
      
   	<div class="admin-modal hidden">
   		<div class="admin-m-content">
   			
   			<h4 class="admin-m-title">주문 상세보기 _ 윤선희</h4>
			<div class="table-responsive">
				<table class="table table-bordered table-row">
				  <thead>
					<tr>
					  <th>주문번호</th>
					  <td class="ip-text">
						  <input type="text" id="orNumber" name="orNumber"  readOnly="true">
					  </td>
					  <th>회원구분</th>
					  <td class="ip-text">
						  <input type="text" id="orMemberYn" name="orMemberYn"  readOnly="true">
					  </td>
					</tr>
					<tr>
					  <th>결제자</th>
					  <td class="ip-text" colspan="3">
						  <input type="text" id="orName" name="orName"  readOnly="true">
					  </td>
					</tr>
					<tr>
					  <th>결제자 연락처</th>
					  <td class="ip-text" colspan="3">
						  <input type="text" id="orPhone" name="orPhone"  readOnly="true">
					  </td>
					</tr>
					<tr>
					  <th>결제자 E-mail</th>
					  <td class="ip-text" colspan="3">
						  <input type="text" id="orEmail" name="orEmail"  readOnly="true">
					  </td>
					</tr>
					<tr>
					  <th>쿠폰 적용</th>
					  <td class="ip-text">
						  <input type="text" id="couponNumber" name="couponNumber"  readOnly="true">
					  </td>
					  <th>쿠폰 할인금액</th>
					  <td class="ip-text">
						  <input type="text" id="orDiscont" name="orDiscont"  readOnly="true">
					  </td>
					</tr>
					<tr>
					  <th>사용 마일리지</th>
					  <td class="ip-text">
						  <input type="text" id="orUsePoint" name="orUsePoint"  readOnly="true">
					  </td>
					  <th>총 할인금액</th>
					  <td class="ip-text">
						  <input type="text" id="totalDiscont" name="totalDiscont"  readOnly="true">
					  </td>
					</tr>
					<tr>
					  <th>결제방법</th>
					  <td class="ip-text">
						  <input type="text" id="orKind" name="orKind"  readOnly="true">
					  </td>
					  <th>결제금액</th>
					  <td class="ip-text">
						  <input type="text" id="orPrice" name="orPrice"  readOnly="true">
					  </td>
					</tr>
					<tr>
					  <th>결제상태</th>
					  <td class="ip-text ip-btn">
						<input type="text" id="orPayment" name="orPayment"  readOnly="true">
					  	<button class="btn btn-xs btn-red pull-right" type="button" onclick="javascript:gridButton.orderCancel()">결제 취소</button>
					  </td>
					  <th>결제일</th>	
					  <td class="ip-text">
						  <input type="text" id="orDate" name="orDate"  readOnly="true">
					  </td>
					</tr>
				  </thead>
				</table>
			</div>
			<div class="widget-c-btn">
				<button class="btn btn-green" type="button" data-target=".admin-modal"
            		onclick="javascript:modal.adminReservation('admin-modal')"><i class="fa fa-check"></i> 확인</button>
			</div>
   		</div>
   	<div class="admin-modal-bg hidden" onclick="javascript:modal.adminReservation('admin-modal')"></div>
   	</div>

	<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">예약 및 주문관리
			  <!-- page meta -->
			  <span class="page-meta">예약자 및 주문자 관리페이지 입니다.</span>
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right widget-head-right">
				<div class="bread-crumb">
				  <a href="index.html"><i class="fa fa-home"></i> 예약관리</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">예약 및 주문</a>
				</div>
				<button class="btn btn-default wminimize" type="button"><i class="fa fa-plus"></i> 검색창 보기</button>
			</div>
			<div class="clearfix"></div>
		</div>
		<!-- Breadcrumb -->
			<div class="widget-content">
				<div class="padd">
					
					<div class="col-lg-12">
						
						<span class="input-title">기간설정</span>
					    <div class="pull-left col-md-5 btn-select-box">
							
						    <div class="input-append date dtpicker col-md-4">
						    	<div class="add-on">
									<input data-toggle="datepicker" class="form-control" type="text" data-format="yyyy/MM/dd" placeholder="Pick-up time" name="resSurchStartDate" id="resSurchStartDate">
									<i class="fa fa-calendar" data-date-icon="fa fa-calendar" data-time-icon="fa fa-clock-o"></i>
						    	</div>
						    </div>
						    
							<span class="dtpicker-next">~</span>
							
						    <div class="input-append date dtpicker col-md-4">
						    	<div class="add-on">
									<input data-toggle="datepicker" class="form-control" type="text" data-format="yyyy/MM/dd" placeholder="Pick-up time" name="resSurchEndDate" id="resSurchEndDate">
									<i class="fa fa-calendar" data-date-icon="fa fa-calendar" data-time-icon="fa fa-clock-o"></i>
						    	</div>
							</div>
							
							<div class="pull-left">
								<button class="btn btn-default btn-navy" type="button" onclick="javascript:surchButton.surchDate()">검색</button>
							</div>
					    </div>
					    
						<span class="input-title">분류</span>
						    <div class="pull-left col-md-4 set-surch btn-select-box">
						    	<form id="resSurchMoreFrm" name="resSurchMoreFrm">
									<div class="pull-left set-surch-select admin-select col-md-3">
		                                <select class="selectpicker form-control" data-size="8" data-live-search="false" title="검색항목" id="resSurchMoreSelect">
		                                    <option data-tokens="이름">이름</option>
		                                    <option data-tokens="주문번호">주문번호</option>
		                                    <option data-tokens="예약번호">예약번호</option>
		                                </select>
									</div>
									<div class="pull-left set-surch-inp col-md-7">
									  <input type="text" class="form-control" id="resSurchMoreText">
									</div>
								</form>
								<div class="pull-left">
									<button class="btn btn-default btn-navy" type="button" onclick="javascript:surchButton.surchMore()">검색</button>
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
	
		<div class="col-md-12 widget-top pull-left">
			<div class="pull-left">
				<button class="btn btn-xs btn-green pull-left" type="button"><i class="fa fa-save"></i> EXCEL DOWNLODE</button>
				<button class="btn btn-xs btn-navy pull-left" type="button"><i class="fa fa-print"></i> PRINT</button>
			</div>
			<div class="pull-right">
				<button class="btn btn-xs btn-green pull-left" type="button" onclick="javascript:gridButton.goSave()"><i class="fa fa-pencil"></i> 저장</button>
				<button class="btn btn-xs btn-yellow pull-left" type="button" onclick="javascript:gridButton.goEdit()"><i class="fa fa-unlock"></i> 수정</button>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="container">
			<table id="adminReservationTable" class="table input-table table-bordered"></table>
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