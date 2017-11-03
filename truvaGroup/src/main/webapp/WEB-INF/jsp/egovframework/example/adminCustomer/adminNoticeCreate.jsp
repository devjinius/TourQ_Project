<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="ckeditor/ckeditor.js"></script>

<script type="text/javascript">
var ckedit = {
		
	init : function() {
		CKEDITOR.replace("ckeditor",{
			height : '365px'  // 입력창의 높이
		});
	}
};

function noticeSubmit() {
	
	var title = $("#noticeTitle").val();
		content = CKEDITOR.instances.ckeditor.getData();
		
	if(title.length == 0 || content.length == 0){
		
		alert("필요한 데이터를 모두 입력하셔야 합니다!!");
		
		return;
	}
	
	var param = {
	
		title : title,
		content : content,
		gubun : "I"
	}
	
	$.ajax({
		
		type	: "POST",
		url		: "noticeIU.do",
		data 	: {"param" : JSON.stringify(param)},
		async	: false,
		success	: function(result){
			
			if(result == "SUCCESS"){
				
				alert("성공적으로 생성되었습니다.");
				
				left.adminSubmitFn('adminNotice','adminNotice.do','frmAdmin');
			} else if(result == "FAIL") {
				
				alert("에러가 발생했습니다. ErrorCode : NoticeCreate01");
			}
		}
	});
	
};


$(document).ready(function(){	
	
	ckedit.init();
});
</script>

<div class="mainbar">
	<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">공지사항 생성</h2>
			<!-- Breadcrumb -->
			<div class="pull-right">
				<div class="bread-crumb">
				  <a href="#" onclick="left.adminSubmitFn('adminMain', 'adminMain.do', 'frmAdmin')"><i class="fa fa-home"></i> 메인</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current" onclick="left.adminSubmitFn('adminNotice', 'adminNotice.do', 'frmAdmin')">공지사항</a>
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">공지사항 생성</a>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
	</div><!--/ Page heading ends -->


	
	<!-- Matter -->
	<div class="matter">
		<div class="container full-page-btn" style="overflow-y: auto;">
			<div class="table-responsive">
				<table class="table table-bordered table-row">
				  <thead>
						<tr>
							<th>제목</th>
							<td class="ip-text" colspan="2" height="70px"><input class="form-control" type="text" name="noticeTitle" id="noticeTitle"></td>
						</tr>
						<tr>
							<th>내용</th>
							<td class="ip-text">
								<textarea name="ckeditor" id="ckeditor"></textarea>
							</td>
						</tr>
				</thead>
				</table>
			</div>
		</div>
		<div class="col-md-12 widget-foot">
			<div class="content-c-btn">
				<button class="btn btn-default" type="button" value="" onclick="javascript:noticeSubmit()">저장하기</button>
				<button class="btn btn-default" onclick="javascript:left.adminSubmitFn('adminNotice','adminNotice.do','frmAdmin')">뒤로가기</button>
			</div>
		</div>
	</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
	
</div>

