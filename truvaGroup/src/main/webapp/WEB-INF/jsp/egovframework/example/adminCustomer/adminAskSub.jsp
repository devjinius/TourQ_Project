<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(document).ready(function() {
	
	jqgridTable.init();
	
	jqgridTable.goSearch();
});

var jqgridTable = 
{
	
	init : function() {
		
		var cnames = ['번호', '회원아이디', '제목' , '답변여부', '등록일', '버튼'];

	    $("#jqGrid").jqGrid({
	    	
	        url: "adminJqAsk.do",
	        datatype: "local",
	        colNames: cnames,
	        colModel:[
	   	   		   {name:'seq',       		index:'seq',       	width:55, key:true,    align:"center"},	
		           {name:'memberId',      	index:'memberId', width:100, align:"center"},
		           {name:'askTitle',      	index:'askTitle',      width:100, align:"center"},
		           {name:'askAnswerYn',     index:'askAnswerYn',  width:100, align:"center"},
		           {name:'askDate',     	index:'askDate',  width:100, align:"center"},
		           {name:'btn', 			index:'btn', 		width:100, formatter:gridFunc.rowBtn, align:"center"}
			],
	        height			: 450,
	        rowNum			: 10,
	        rowList			: [10,20,30],
	        pager			: '#jqGridPager',
	        cellsubmit: "clientArray",		//수정된 사항을 바로 보내지 않고 가지고 있음	//이게 없으면 셀 수정시 url로 바로 감,		
	        viewrecords : true,
	        loadonce : true
	    });
	},
	
	
	goSearch : function (option) {

		var settings = {
				
			searchSelect: "",
			searchText: "",
			memberNumber: "<c:out value="${param.memberNumber}"/>"
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
	}
}

/******************************************
 * 그리드 관련 메소드
 ******************************************/
var gridFunc = 
	
{
	rowBtn : function(cellvalue, options, rowObject) {

		if (rowObject.askAnswerYn == "Y") {
			
			return "<button class=\"btn btn-xs btn-default\" type=\"button\" onclick=\"javascript:gridFunc.detailFn("+ rowObject.seq + ", 'Y', "+ rowObject.memberNumber +")\">상세보기</button>";
		} else if (rowObject.askAnswerYn == "N") {
			
			return "<button class=\"btn btn-xs btn-default\" type=\"button\" onclick=\"javascript:gridFunc.detailFn("+ rowObject.seq + ", 'N', "+ rowObject.memberNumber +")\">상세보기</button>";
		}
	},

    detailFn : function(number, yn, memberNumber) {
        
    	$("#askNumber").val(number);
    	$("#memberNumber").val(memberNumber);
        
    	if(yn == "Y"){
    		
	    	left.adminSubmitFn('adminAskY','adminAskY.do','frmNumber');
    	} else {
    		
	    	left.adminSubmitFn('adminAskN','adminAskN.do','frmNumber');
    	}
    }
}
</script>

		<h4>이 회원의 문의 내역</h4>
		  <table id="jqGrid"></table>
          <div id="jqGridPager"></div>
