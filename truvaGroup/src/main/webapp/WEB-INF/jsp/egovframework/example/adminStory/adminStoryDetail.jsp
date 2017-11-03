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
<c:set var="cmt" value="${fn:replace(storyCon.storyContents,crcn,br)}" />
<c:set var="cmt" value="${fn:replace(cmt,cr,br)}" />
<c:set var="cmt" value="${fn:replace(cmt,cn,br)}" />
 
<!-- ckEditor -->
<script src="ckeditor/ckeditor.js"></script>
<script type="text/javascript">

var ckedit = {
		
	init : function() {
		CKEDITOR.replace("ckeditor",{
			height : '600px',  // 입력창의 높이
				filebrowserBrowseUrl: '/browser/browse.php',
				filebrowserUploadUrl: '/uploader/upload.php'
		});
		
 		CKEDITOR.instances.ckeditor.setData("<c:out value="${cmt}"  escapeXml='false' />");
	}
}

var submitFn = {
		
		create : function () {
			
			$("#contents").val(CKEDITOR.instances.ckeditor.getData());

			left.adminSubmitFn('adminStory', 'adminStoryIUD.do' ,'story');
		}
	}
$(document).ready(function() {
	
	ckedit.init();
})
</script>

<div class="mainbar">
<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">Story 수정
			  <!-- page meta -->
			  <span class="page-meta">느림의 미학, 서촌</span>
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right">
				<div class="bread-crumb">
				  <a href="#" onclick="left.adminSubmitFn('adminMain', 'adminMain.do', 'frmAdmin')"><i class="fa fa-home"></i> 메인</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current" onclick="left.adminSubmitFn('adminStory', 'adminStory.do', 'frmAdmin')">스토리 조회</a>
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">스토리수정</a>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="clearfix"></div>
	</div>
	<!-- Matter -->
	<div class="matter nonsurch">
		<div class="container full-page-btn" style="overflow-y: auto;">
			<div class="table-responsive">
				<table class="table table-bordered table-row">
				  <thead>
			  		  <form name="story" id="story" method="post">
					  	<input type="hidden" name="contents" id="contents" value="">
						<tr>
							<th>스토리번호</th>
							<td ><input class="form-control" type="text" name="storyNumber" id="storyNumber" readonly="readonly"  value="<c:out value="${storyCon.storyNumber}"/>"></td>
						</tr>
						<tr>
							<th>대표사진</th>
							<td class="ip-text"><input class="form-control" type="file" name="picture1" id="picture1" value="대표사진_1"></td>
						</tr>
						<tr>
							<th>제목</th>
							<td class="ip-text"><input class="form-control" type="text" name="title" id="title" value="<c:out value="${storyCon.storyTitle}"/>"></td>
						</tr>
						<tr>
							<th>부제목</th>
							<td class="ip-text"><input class="form-control" type="text" name="subtitle" id="subtitle" value="<c:out value="${storyCon.storySubtitle}"/>"></td>
						</tr>
						<tr>
							<th style="height: 600px;">내용</th>
							<td style="padding-bottom: 20px; padding-top: 20px;">
							<textarea name="ckeditor" id="ckeditor"></textarea>
							</td>
						</tr>
			  		  </form>
				  </thead>
				</table>
			</div>
		</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
		<div class="col-md-12 widget-foot">
			<div class=" content-l-btn">
				<button class="btn btn-xs btn-default" type="button" data-target=".admin-modal"
	           		onclick=""><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i> 이전글 보기</button>
	           	<span class="slash"></span>
				<button class="btn btn-xs btn-default" type="button" data-target=".admin-modal"
	           		onclick="">다음글 보기 <i class="fa fa-angle-right"></i><i class="fa fa-angle-right"></i></button>
			</div>
			<div class="content-c-btn">
				<button class="btn btn-default ma-right5" type="button" onclick="javascript:submitFn.create()"><i class="fa fa-check"></i> 저장하기</button>
				<button class="btn btn-default" type="button" onclick="javascript:left.adminSubmitFn('adminStory', 'adminStory.do' ,'frmAdmin')"><i class="fa fa-close"></i> 뒤로가기</button>
			</div>
		</div>
	</div><!--/ Matter ends -->
</div>