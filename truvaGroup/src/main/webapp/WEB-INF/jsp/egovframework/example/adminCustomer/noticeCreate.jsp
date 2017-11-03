<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*, java.text.*"  %>
<%
 java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
 String today = formatter.format(new java.util.Date());
%>


<!-- ckEditor -->
<script src="//cdn.ckeditor.com/4.7.1/standard/ckeditor.js"></script>
<script type="text/javascript">
		
	$(document).ready(function(){	

		var pageName = "<c:out value="${param.pageName}"/>";
		
		$("[prop=menu]").removeClass("active");
		
		$("#"+pageName).addClass("active");
		
	});

	
    $(function(){
         
        CKEDITOR.replace( 'ckeditor', {//해당 이름으로 된 textarea에 에디터를 적용
            width:'100%',
            height:'400px',
            filebrowserImageUploadUrl: '/imageUpload' //여기 경로로 파일을 전달하여 업로드 시킨다
        });
         
         
        CKEDITOR.on('dialogDefinition', function( ev ){
            var dialogName = ev.data.name;
            var dialogDefinition = ev.data.definition;
          
            switch (dialogName) {
                case 'image': //Image Properties dialog
                    //dialogDefinition.removeContents('info');
                    dialogDefinition.removeContents('Link');
                    dialogDefinition.removeContents('advanced');
                    break;
            }
        });
         
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
				  <a href="index.html"><i class="fa fa-home"></i> 대메뉴</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">소메뉴</a>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
	</div><!--/ Page heading ends -->


	<form method="post" enctype="multipart/form-data">

	<!-- Matter -->
	<div class="matter">
		<div class="container">
			<div class="table-responsive">
				<table class="table table-bordered table-row">
				  <thead>
					<tr>
						<th>번호</th>
						<td  colspan="2"><input class="form-control" type="text" name="boardTitle" id="boardTitle"></td>
					</tr>
					<tr>
						<th>분류</th>
						<td  colspan="2"><input class="form-control" type="text" name="boardClass" value="01" id="boardClass" readonly></td>
					</tr>
					<tr>
						<th>제목</th>
						<td colspan="2"><input class="form-control" type="text" name="boardTitle" id="title"></td>
					</tr>
					
					<tr>
						<th>등록일</th>
						<td class="ip-text"><input class="form-control" name="boardDate" value=<%out.print(today);%>></td>
					</tr>
					<tr>
						<th style="height: 600px;">내용</th>
						<td  colspan="2" style="padding-bottom: 20px; padding-top: 20px;">
						<textarea name="ckeditor" id="ckeditor"></textarea>
							<script type="text/javascript">
								CKEDITOR.replace("ckeditor",{
									height : '600px',  // 입력창의 높이
			   						filebrowserBrowseUrl: '/browser/browse.php',
			    					filebrowserUploadUrl: '/uploader/upload.do'
			    	//				filebrowserUploadUrl: '${pageContext.request.contextPath}/file/ckeditorImageUpload.do'	
								});
								CKEDITOR.instances.ckeditor.setData("<p>임시 내용</p>");
							</script>
						</td>
					</tr>
				  </thead>
				</table>
			</div>
			<div class="text-center margin-top-bottom">
				<button class="item-btn" type="submit" value="">저장하기</button>
				<button class="item-btn" onclick="javascript:left.adminSubmitFn('','frmAdmin')">뒤로가기</button>
			</div>
		</div>
	</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
	
	</form>
</div>

