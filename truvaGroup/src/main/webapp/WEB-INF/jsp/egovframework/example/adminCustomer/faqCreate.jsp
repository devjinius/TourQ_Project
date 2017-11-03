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
			<h2 class="pull-left">FAQ 생성</h2>
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


	<!-- Matter -->
	<div class="matter">
		<div class="container" style="height:60%;">
			<div class="table-responsive">
				<table class="table table-bordered table-row">
				  <thead>
					<tr>
						<th>번호</th>
						<td class="ip-text" colspan="2">1</td>
					</tr>
					<tr>
						<th>질문</th>
						<td class="ip-text" colspan="2"><input type="text" name="question" id="question"></td>
					</tr>
					<tr>
						<th>답변</th>
						<td class="ip-text" colspan="2"><textarea name="answer" id="answer" rows="5" cols="100"></textarea>
					</tr>
					
					<tr>
						<th>등록일</th>
						<td class="ip-text" class="ip-text"><input value=<%out.print(today);%>></td>
					</tr>
					<tr>
						<th>분류</th>
						<td class="ip-text" class="ip-text"><input value="분류"></td>
					</tr>
					
				  </thead>
				</table>
			</div>
		</div>
		<div class="col-md-12 widget-foot">
			<div class="content-c-btn">
				<button class="btn btn-green" type="button" data-target=".admin-modal"
            		onclick="javascript:left.adminSubmitFn('','frmAdmin')"><i class="fa fa-pencil"></i> 저장</button>
				<button class="btn btn-red" type="button" data-target=".admin-modal"
            		onclick="javascript:left.adminSubmitFn('','frmAdmin')"><i class="fa fa-close"></i> 뒤로가기</button>
			</div>
		</div>
	</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
</div>

