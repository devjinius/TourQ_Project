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

/******************************************
 * jqgrid 
 ******************************************/
var jqgridTable = 
{
	
	init : function() {
		
		var cnames = ['시리얼번호','이름','쿠폰번호','발행일','할인율', '발행개수', '사용여부'];
		
	    $("#jqGrid").jqGrid({
	    	
	        url: "adminJqCoupon.do",
	        datatype: "local",
	        colNames: cnames,
	        colModel:[
	   	   		   {name:'couponNumber',    index:'couponNumber',       	width:55, key:true,    align:"center"},	
		           {name:'couponName',      index:'couponName', 			width:100, align:"center"},
		           {name:'couponPubNumber', index:'couponPubNumber',      	width:100, align:"center"},
		           {name:'couponDate',     	index:'couponDate',  			width:100, align:"center"},
		           {name:'couponDiscount',  index:'couponDiscount',  		width:100, align:"center"},
		           {name:'couponPubCount',  index:'couponPubCount',  		width:100, align:"center"},
		           {name:'couponYn',     	index:'couponYn',  				width:100, align:"center",
		        	   editable : true, edittype: "select", formatter:"select",
		   	   			editoptions: {
		   	   				
		   	   				value : {"Y":"Y", "N":"N"},
		   	   				dataEvents : [{
		   	   					type: "change"
		   	   					
		   	   				}]
		   	   			}
		           }
			],
	        height			: 450,
	        rowNum			: 10,
	        rowList			: [10,20,30],
	        pager			: '#jqGridPager',
	        cellsubmit: "clientArray",		//수정된 사항을 바로 보내지 않고 가지고 있음	//이게 없으면 셀 수정시 url로 바로 감,		
	        viewrecords : true,
		    multiselect	: true,
	        cellEdit 		: true,
			onCellSelect : function(rowId, colId, val, e) {
	    		
	    		var jqgrid = $("#jqGrid");

	    		var couponNumber = jqgrid.getCell(rowId, 'couponNumber');

	    		if (!CommonJsUtil.isEmpty(couponNumber)) {
    				
    				jqgrid.setColProp("couponNumber", {editable:false}); 
    				jqgrid.setColProp("couponName", {editable:false});
    				jqgrid.setColProp("couponPubNumber", {editable:false});
    				jqgrid.setColProp("couponDate", {editable:false});
    				jqgrid.setColProp("couponDiscount", {editable:false});
    				jqgrid.setColProp("couponPubCount", {editable:false});
    				jqgrid.setColProp("couponYn", {editable:false});
    			} else {

    				jqgrid.setColProp("couponNumber", {editable:false}); 
    				jqgrid.setColProp("couponName", {editable:true});
    				jqgrid.setColProp("couponPubNumber", {editable:false});
    				jqgrid.setColProp("couponDate", {editable:false});
    				jqgrid.setColProp("couponDiscount", {editable:true});
    				jqgrid.setColProp("couponPubCount", {editable:true});
    				jqgrid.setColProp("couponYn", {editable:true});
    			}
	    	}
	    });
	},
	
	
	goSearch : function (option) {

		var settings = {
				
			searchSelect: "",
			searchText: ""
		};
		
		settings = $.extend({}, settings, option);
		
		$("#jqGrid").setGridParam({
			
	        datatype : "json",
	        postData : {"param" : JSON.stringify(settings)},
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
	
	goSearchBar : function () {

		var option = {
			searchSelect : $("#searchSelect").val(),
			searchText : $("#searchText").val()
		};
		
		this.goSearch(option);
	},

	
	saveData : function(){
		
		// 전화번호 유효성 체크
		
		// select인 상태에도 잘 저장이 된다.
		$("#jqGrid").editCell(0, 0, false);
		
		var param1 = this.selectData();
		
		if (param1 == undefined) {
			
			return;
		} else{
			
			this.ajaxFn(param1);
		}
	},
	
	/* 수정버튼 */
	updateData	: function(){
		
		var checkId = $("#jqGrid").getGridParam("selarrrow"),
			colName = $("#jqGrid").getGridParam("colModel"),
			that = this;
		
		if (checkId.length != 0) {

			var gridTable = $("#jqGrid"),
				i = 0,
				j = 0;

			gridTable.editCell(0,0, false);
			
			/* 테이블의 셀을 선택했을때 그 셀이 체크박스로 선택된 셀이면 수정가능하게 한다. */
			gridTable.setGridParam({
				
				onCellSelect : function(rowId, colId, val, e){
					
					gridTable.setColProp("couponName", {editable:true}); 
					gridTable.setColProp("couponPubCount", {editable:true}); 
					gridTable.setColProp("couponDiscount", {editable:true}); 
					gridTable.setColProp("couponYn", {editable:true}); 
				}
			});
		} else {
			
			alert("수정할 데이터를 선택하세요.");
		}
	},
	
	ajaxFn : function (param1) {
		
		var that = this;
		
		$.ajax({
			
			type	: "POST",
			url		: "saveJqCoupon.do",
			data	: {"param1" : param1},
			async	: false,
			success	: function(result){
					
				if(result == "SUCCESS"){
					
					alert("성공적으로 저장하였습니다.");
					
					that.goSearch();
				}
			}
		})
	},
	
	selectData : function() {
				
		var checkData = $("#jqGrid").getGridParam("selarrrow");
		
		if (checkData.length == 0) {
			
			alert("저장할 데이터를 선택하여 주십시오.");
			
			return;
		}
		
		if (confirm("선택한 데이터를 저장하시겠습니까?") == false) {
			
			return false;
		}
		
		var iCnt = 0;
		var jsonArray1 = new Array();
		$coulumns = $("#jqGrid").getGridParam("colModel");
		
		for (var i = 0; i < checkData.length; i++) {
			
			var jsonObj = {};
			
			var couponNumber = $("#jqGrid").getCell(checkData[i], "couponNumber");
			
			var editType = "";
			
			if (!CommonJsUtil.isEmpty(couponNumber)) {
				
				editType = "U";
			} else {	
				
				editType = "I";
			}
			
			var $this = $("#jqGrid");
			
			jsonObj.editType = editType;
			
			jsonObj["couponName"] =  $this.getCell(checkData[i], "couponName");
			jsonObj["couponPubCount"] =  $this.getCell(checkData[i], "couponPubCount");
			jsonObj["couponDiscount"] =  $this.getCell(checkData[i], "couponDiscount");
			jsonObj["couponYn"] =  $this.getCell(checkData[i], "couponYn");
			jsonObj["couponNumber"] =  $this.getCell(checkData[i], "couponNumber");
			
			jsonArray1[iCnt] = jsonObj;
			
			iCnt++;
		}
		
	    return JSON.stringify(jsonArray1);
	}
}

/******************************************
 * 그리드 관련 메소드
 ******************************************/
var gridFunc = 
	
{
	addRow : function(){
 		
 		var totCnt = $("#jqGrid").getGridParam("records");
 		
 		var addData = {"couponNumber":"", "couponName":"", "couponPubNumber":"", "couponDate":"", "couponDiscount":"", "couponPubCount":"", "couponYn":"Y"};
 		
 		$("#jqGrid").addRowData(totCnt+1, addData);
 	},
 	
 	rowBtn : function(cellvalue, options, rowObject) {

		return '<button class="btn btn-xs btn-default" type="button" onclick="javascript:gridFunc.detailFn(\''+ rowObject.seq +'\')">상세보기</button>';
	},

    detailFn : function(number) {
        
    	$("#noticeNumber").val(number);
       
    	left.adminSubmitFn('adminNoticeDetail','adminNoticeDetail.do','frmNumber');
    }
}


</script>

<form id="frmNumber" name="frmNumber">
	<input type="hidden" id="noticeNumber" name="noticeNumber" /> 
</form>

<div class="mainbar">
<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">쿠폰 관리
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right widget-head-right">
				<div class="bread-crumb">
				  <a href="#" onclick="left.adminSubmitFn('adminMain', 'adminMain.do', 'frmAdmin')"><i class="fa fa-home"></i> 메인</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">쿠폰관리</a>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
	</div><!--/ Page heading ends -->

	<!-- Matter -->
	<div class="matter">
		<div class="col-md-12 widget-top">
		
			<div class="pull-left">
				<button class="btn btn-xs btn-navy pull-left" type="button"  onclick="window.print()"><i class="fa fa-print"></i> PRINT</button>
			</div>
			<div class="pull-right">
				<button class="btn btn-xs btn-info pull-left" type="button" onclick="javascript:jqgridTable.goSearch();">
				<i class="fa fa-search"></i> 전체조회
				</button>
				<button class="btn btn-xs btn-green pull-left" type="button" onclick="javascript:gridFunc.addRow()">
					<i class="fa fa-plus"></i> 추가
				</button>
				<button class="btn btn-xs btn-green pull-left" type="button" onclick="javascript:jqgridTable.saveData()">
					<i class="fa fa-pencil"></i> 저장
				</button>
				
				<button class="btn btn-xs btn-yellow pull-left" type="button" onclick="javascript:jqgridTable.updateData();">
				<i class="fa fa-unlock"></i> 수정
				</button>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="container full-page-topBtn">
		  <table id="jqGrid"></table>
          <div id="jqGridPager"></div>
		</div> 
	</div><!--/ Matter ends -->
</div><!--/ Mainbar ends -->