<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
$(document).ready(function() {
	
	jqgridTable.init();
});
/*어드민 모달창*/
var modalPoint = {
		
		paramArray : new Array(),
		adminReservation : function(paramArray){

			this.paramArray = paramArray;
			
			var modalHeight = "",
				$adminModal = $(".admin-modal"),
				$adminModalBg = $(".admin-modal-bg");
			
			$adminModal.toggleClass("hidden");
			$adminModalBg.toggleClass("hidden");
			
			// 모달 중앙정렬
			if (!($adminModal.hasClass("hidden"))) {
				
				modalHeight = $(".admin-m-content").height();
				
				$(".admin-m-content").css("margin-top",(-modalHeight/2));
			} else {

				/* 모달창 초기화 */
				$adminModal.find("input").val("");
			}
		},
		
		addPointRow : function () {
			
			$(".admin-modal input").each(function() {
				
				if($(this).val() == "") {
					
					alert("값을 입력해주세요");
					
					return;
				}
			});
			
			var paramJson = {
				
				"array" : this.paramArray,
				"title" : $("#title").val(),
				"point" : $("#point").val()
			}
			
			console.log(paramJson);
			
			$.ajax({
				
	 			type		:	"post",
	 			url			:	"addRowPoint.do",
	 			data		:	{"param": JSON.stringify(paramJson)},
	 			async		:	false,
	 			success		:	function(result){
					
	 				if(result == "SUCCESS"){
						
	 					alert("성공적으로 포인트를 부여하였습니다.");
						
	 					modalPoint.adminReservation();
	 					
	 					that.goSearch();
	 				}
	 			}
				
	 		});
		}
}
/******************************************
 * jqgrid 
 ******************************************/
var jqgridTable = 
{
	init : function() {
		
		var cnames = ['회원번호','아이디', '이름', 'E-Mail','휴대폰','회원등급','가입일'];
		
	    $("#jqGrid").jqGrid({
	    	
	        url: "adminMemberGrid.do",
	        datatype: "local",
	        colNames: cnames,
	        colModel:[
	   	   		{name:'seq',		index:'seq', 		width:55,	key:true,	align:"center"},
	   	   		{name:'memberId',		index:'memberId', 		width:100, 				align:"center"},
	   	   		{name:'memberName',		index:'memberName', 		width:100, 				align:"center"},
	   	   		{name:'memberMail',		index:'memberMail', 		width:100, align:"center"},
	   	   		{name:'memberHp',	index:'memberHp', 	width:100, align:"center"},
	   	   		{name:'adminType',		index:'adminType', 		width:100, align:"center"},
	   	   		{name:'memberDate',		index:'memberDate',     width:100, align:"center"}
			],
	        height			: 400,
	        rowNum			: 10,
	        rowList			: [10,20,30],
	        pager			: '#jqGridPager',
	        cellsubmit 		: "clientArray", 
	        viewrecords 	: true,
	        multiselect	: true
	    });
	},
	
	goSearch : function () {

		var jsonObj = {};
		
		jsonObj.searchId = $("#searchId").val();
		
		$("#jqGrid").setGridParam({
			
	        datatype : "json",
	        postData : {"param" : JSON.stringify(jsonObj)},
	        loadComplete: function (data){
	        	
	        	$.each(data, function (i, item) { 

					if (i == "rows") {	
						if (item < 1) {							
							alert("데이터가 없습니다.");
						}
					}
	        	});
	        }
	    }).trigger("reloadGrid");
	},
	
	goPoint : function() {
		
		var that = this;
			checkData = $("#jqGrid").getGridParam("selarrrow");
		
		if (checkData.length == 0){
			
			alert("데이터를 선택해주세요");
			
			return;
		}
		
		var paramArray = new Array();
		
		for (i in checkData) {
			
			var seq = $("#jqGrid").getCell(checkData[i], "seq");
			
			paramArray.push(seq);
		}

		modalPoint.adminReservation(paramArray);
	}
}

/******************************************
 * 그리드 관련 메소드
 ******************************************/
var gridFunc = 
{			
	delRow : function(rowId) {
		
		if (rowId != '') {
			
			$("#jqGrid").delRowData(rowId);
		}
	},
	
	clearGrid : function() {
		
		$("#jqGrid").clearGridData();
	}
	
}
</script>

<div class="mainbar">

<div class="admin-modal hidden">
   		<div class="admin-m-content">
   			
   			<h4 class="admin-m-title">상품 생성하기</h4>
			<div class="table-responsive non-scroll">
			<form id="newProdFrm"	name="newProdFrm">
				<table class="table table-bordered table-row">
				  <thead>
					<tr>
					  <th>제목</th>
					  <td class="ip-text">
						  <input  type="text" id="title" name="title">
					  </td>
					</tr>
					<tr class="ip-text">
					  <th>마일리지</th>
					  <td>
						  <input type="number" id="point" name="point">
					  </td>
					</tr>
				  </thead>
				</table>
			</form>
			</div>
			<div class="widget-c-btn">
				<button class="btn btn-green" type="button" data-target=".admin-modal"
            		onclick="javascript:modalPoint.addPointRow()"><i class="fa fa-pencil"></i> 추가</button>
				<button class="btn btn-red" type="button" data-target=".admin-modal"
            		onclick="javascript:modalPoint.adminReservation()"><i class="fa fa-close"></i> 닫기</button>
			</div>
   		</div>
   	<div class="admin-modal-bg hidden" onclick="javascript:modalPoint.adminReservation()"></div>
   	</div>
   	
   	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">회원 정보
			  <!-- page meta -->
			  <span class="page-meta">가입된 회원의 정보를 조회 할 수 있습니다.</span>
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right">
				<div class="bread-crumb">
				  <a href="#" onclick="left.adminSubmitFn('adminMain', 'adminMain.do', 'frmAdmin')"><i class="fa fa-home"></i> 메인</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">회원정보</a>
				</div>
				<button class="btn btn-default wminimize" type="button"><i class="fa fa-plus"></i> 검색창 보기</button>
			</div>
			<div class="clearfix"></div>
		</div>
		<!-- Breadcrumb -->
			<div class="widget-content">
				<div class="padd">
					
					<div class="col-lg-12">
						
						<span class="input-title">ID </span>
						    <div class="pull-left col-md-4 set-surch btn-select-box">
								<div class="pull-left set-surch-inp col-md-7">
								  <input type="text" class="form-control" id="searchId" name="searchId">
								</div>
								<div class="pull-left">
									<button class="btn btn-default btn-navy" type="button" onclick="javascript:jqgridTable.goSearch()">검색</button>
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
				<button class="btn btn-xs btn-navy pull-left" type="button"  onclick="window.print()"><i class="fa fa-print"></i> PRINT</button>
			</div>
			<div class="pull-right">
				<button class="btn btn-xs btn-green pull-left" type="button" onclick="javascript:jqgridTable.goSearch()">
					<i class="fa fa-search"></i> 조회</button>
				<button class="btn btn-xs btn-green pull-left" type="button" onclick="javascript:jqgridTable.goPoint()">
					<i class="fa fa-plus"></i> 포인트</button>
			</div>
			<div class="clearfix"></div>
		</div>
		
		<div class="container">
			<table class="table input-table table-bordered" id="jqGrid">
			</table>
	   		<div id="jqGridPager"></div>
		</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
	</div><!--/ Matter ends -->
</div><!--/ Mainbar ends -->