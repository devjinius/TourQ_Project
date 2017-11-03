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
		
		var cnames = ['번호','제목','타입','등록일', '버튼'];

	    $("#jqGrid").jqGrid({
	    	
	        url: "adminJqFaq.do",
	        datatype: "local",
	        colNames: cnames,
	        colModel:[
	   	   		   {name:'faqNumber',       index:'faqNumber',      width:55, key:true,    align:"center"},	
		           {name:'faqTitle',      	index:'faqTitle', 		width:100, align:"center"},
		           {name:'faqType',      	index:'faqType',      	width:100, align:"center"},
		           {name:'faqDate',     	index:'faqDate',  		width:100, align:"center"},
		           {name:'btn', 			index:'btn', 			width:100, formatter:gridFunc.rowBtn, align:"center"}
			],
	        height			: 450,
	        rowNum			: 10,
	        rowList			: [10,20,30],
	        pager			: '#jqGridPager',
	        cellsubmit: "clientArray",		//수정된 사항을 바로 보내지 않고 가지고 있음	//이게 없으면 셀 수정시 url로 바로 감,		
	        viewrecords : true,
		    multiselect	: true
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
	
	deleteData : function() {
		
		var that = this;
			checkData = $("#jqGrid").getGridParam("selarrrow");
		
		if (checkData.length == 0){
			
			alert("데이터를 선택해주세요");
			
			return;
		}

		if (confirm("선택한 " + checkData.length + "개 데이터들을 삭제하시겠습니까?") == false) {
			
			return;
		}
		
		var paramArray = new Array();
		
		for (i in checkData) {
			
			var faqNumber = $("#jqGrid").getCell(checkData[i], "faqNumber");
			
			paramArray.push(faqNumber);
		}
		
		console.log(paramArray);
		
		$.ajax({
			
			type		:	"post",
			url			:	"deleteFaq.do",
			data		:	{"param": JSON.stringify(paramArray)},
			async		:	false,
			success		:	function(result){
				
				if(result == "SUCCESS"){
					
					alert("성공적으로 삭제하였습니다.");
					
					that.goSearch();
				} else {
					
					alert("문제가 발생했습니다. ErrorCode : Faq-1");
				}
			},
			
			error		: 	function() {
				
				alert("error");
			}
			
		});

	}
}

/******************************************
 * 그리드 관련 메소드
 ******************************************/
var gridFunc = 
	
{
	rowBtn : function(cellvalue, options, rowObject) {

		return '<button class="btn btn-xs btn-default" type="button" onclick="javascript:gridFunc.detailFn(\''+ rowObject.faqNumber +'\')">상세보기</button>';
	},

    detailFn : function(number) {
        
    	$("#faqNumber").val(number);
       
    	left.adminSubmitFn('adminFaqDetail','adminFaqDetail.do','frmNumber');
    }
}


</script>
<form id="frmNumber" name="frmNumber">
	<input type="hidden" id="faqNumber" name="faqNumber" /> 
</form>


<div class="mainbar">
<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">FAQ 관리
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right widget-head-right">
				<div class="bread-crumb">
				  <a href="#" onclick="left.adminSubmitFn('adminMain', 'adminMain.do', 'frmAdmin')"><i class="fa fa-home"></i> 메인</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">FAQ</a>
				</div>
				<button class="btn btn-default wminimize" type="button"><i class="fa fa-plus"></i> 검색창 보기</button>
			</div>
			<div class="clearfix"></div>
		</div>
		<!-- Breadcrumb -->
		<div class="widget-content">
			<div class="padd">
				<div class="col-lg-12">
					<span class="input-title">분류</span>
				    <div class="pull-left col-md-4 set-surch btn-select-box">
						<div class="pull-left set-surch-select admin-select col-md-3">
                               <select class="selectpicker form-control" data-size="8" data-live-search="false" title="검색항목" id="searchSelect">
                                   <option value="제목">제목</option>
                                   <option value="내용">내용</option>
                                   <option value="제내">제목 + 내용</option>
                                   <option value="타입">타입</option>
                               </select>
						</div>
						<div class="pull-left set-surch-inp col-md-7">
						  <input type="text" class="form-control" id="searchText">
						</div>
						<div class="pull-left">
							<button class="btn btn-default btn-navy" type="button" onclick="javascript:jqgridTable.goSearchBar()">검색</button>
						</div>
			   		</div>
				</div>
				<div class="clearfix"></div>
			</div>
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
				<button class="btn btn-xs btn-green pull-left" type="button" onclick="javascript:left.adminSubmitFn('adminFaqCreate','adminFaqCreate.do','frmAdmin')">
					<i class="fa fa-plus"></i> 추가
				</button>
				<button class="btn btn-xs btn-red pull-left" type="button" onclick="javascript:jqgridTable.deleteData();">
				<i class="fa fa-trash-o"></i> 삭제
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