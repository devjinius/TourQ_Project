<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
     
     
  /*   CKEDITOR.on('dialogDefinition', function( ev ){
        var dialogName = ev.data.name;
        var dialogDefinition = ev.data.definition;
      
        switch (dialogName) {
            case 'image': //Image Properties dialog
                //dialogDefinition.removeContents('info');
                dialogDefinition.removeContents('Link');
                dialogDefinition.removeContents('advanced');
                break;
        }
    }); */
     
});
		
$(document).ready(function(){	

	var pageName = "<c:out value="${param.pageName}"/>";
	
	$("[prop=menu]").removeClass("active");
	
	$("#"+pageName).addClass("active");
	
});

function randomString() {
	var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
	var string_length = 10;
	var randomstring = '';
	for (var i=0; i<string_length; i++) {
		var rnum = Math.floor(Math.random() * chars.length);
		randomstring += chars.substring(rnum,rnum+1);
	}
	alert("쿠폰이 생성되었습니다.");
	$('#couponNumber').val(randomstring);
	return randomstring;
}


</script>



<div class="mainbar">
	<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">쿠폰 생성</h2>
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
		<div class="container">
			<div class="table-responsive">
				<table class="table table-bordered table-row">
				  <thead>
					<tr>
						<th>발행번호</th>
						<td class="ip-text" colspan="2"><input type="text" name="couponNumber" id="couponNumber" value=""></td>
						<td class="ip-text"><button onclick="randomString()">번호생성</button></td>
					</tr>
					<tr>
						<th>쿠폰이름(종류)</th>
						<td class="ip-text"><input type="text" name="title" id="title" value="제목"></td>
						<th>분류코드</th>
						<td class="ip-text"><input type="text" name="classcode" id="classcode" value="분류코드"></td>
					</tr>
					<tr>
						<th>할인율</th>
						<td class="ip-text" colspan="3"><input type="text" name="discount" id="discount" value="할인율"></td>
					</tr>
					
					<tr>
						<th>발행일</th>
						<td class="ip-text"><input type="date" name="sdate" id="edate" value="2017-07-26"></td>
						<th>만료일</th>
						<td class="ip-text"><input type="date" name="edate" id="edate" value="2017-07-26"></td>
					</tr>
					<tr>
						<th style="height:80px;">내용 </th>
						<td colspan="3" style="padding-bottom: 20px; padding-top: 20px;" class="ip-text">
							<div class="wrap">
								<textarea name="content" id="content" cols="130" rows="10"></textarea>
							</div>
						</td>
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

