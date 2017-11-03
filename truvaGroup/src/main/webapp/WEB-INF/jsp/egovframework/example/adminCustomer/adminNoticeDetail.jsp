<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 상단에 선언 -->
<%
pageContext.setAttribute("cr", "\r");
pageContext.setAttribute("cn", "\n");
pageContext.setAttribute("crcn", "\r\n");
pageContext.setAttribute("br", "");
%> 
 
<!-- jstl로 변환처리 -->
<c:set var="cmt" value="${fn:replace(noticeDetail.boardContent,crcn,br)}" />
<c:set var="cmt" value="${fn:replace(cmt,cr,br)}" />
<c:set var="cmt" value="${fn:replace(cmt,cn,br)}" />

<script src="ckeditor/ckeditor.js"></script>

<script type="text/javascript">
var ckedit = {
		
	init : function() {
		CKEDITOR.replace("ckeditor",{
			height : '600px'  // 입력창의 높이
		});
		
 		CKEDITOR.instances.ckeditor.setData("<c:out value="${cmt}"  escapeXml='false' />");
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
		gubun : "U",
		noticeNumber : "<c:out value="${noticeDetail.boardNumber}"/>"
	}
	
	$.ajax({
		
		type	: "POST",
		url		: "noticeIU.do",
		data 	: {"param" : JSON.stringify(param)},
		async	: false,
		success	: function(result){
			
			alert("성공적으로 수정되었습니다.");
			
			left.adminSubmitFn('adminNotice','adminNotice.do','frmAdmin');
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
			<h2 class="pull-left">공지사항 상세보기</h2>
			<!-- Breadcrumb -->
			<div class="pull-right">
				<div class="bread-crumb">
				  <a href="#" onclick="left.adminSubmitFn('adminMain', 'adminMain.do', 'frmAdmin')"><i class="fa fa-home"></i> 메인</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current" onclick="left.adminSubmitFn('adminNotice', 'adminNotice.do', 'frmAdmin')">공지사항</a>
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">공지사항 상세보기</a>
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
							<th>번호</th>
							<td class="ip-text" colspan="2"><input class="form-control" type="text" name="noticeNumber" id="noticeNumber" value="${noticeDetail.boardNumber}" disabled="disabled"></td>
						</tr>
						<tr>
							<th>제목</th>
							<td class="ip-text" colspan="2"><input class="form-control" type="text" name="noticeTitle" id="noticeTitle"  value="${noticeDetail.boardTitle}"></td>
						</tr>
						<tr>
							<th>조회수</th>
							<td colspan="2">${noticeDetail.count}</td>
						</tr>
						<tr>
							<th>등록일</th>
							<td>${noticeDetail.boardDate}</td>
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

