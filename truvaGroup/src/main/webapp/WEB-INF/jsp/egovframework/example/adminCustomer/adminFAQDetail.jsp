<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">


function faqSubmit() {
	
	var title = $("#faqTitle").val();
		content = $("#faqContents").val();
		faqType = $("#faqType").val();

	if(title.length == 0 || content.length == 0 || faqType.length == 0){
		
		alert("필요한 데이터를 모두 입력하셔야 합니다!!");
		
		return;
	}
	var param = {
	
		title : title,
		content : content,
		gubun : "U",
		faqNumber : "<c:out value="${faqDetail.faqNumber}"/>",
		faqType : faqType
	}
	
	$.ajax({
		
		type	: "POST",
		url		: "faqIU.do",
		data 	: {"param" : JSON.stringify(param)},
		async	: false,
		success	: function(result){
			
			alert("성공적으로 수정되었습니다.");
			
			left.adminSubmitFn('adminFaq','adminFaq.do','frmAdmin');
		}
	});
	
};

$(document).ready(function(){	
	
	$("#faqType").val("${faqDetail.faqType}");
});
</script>

<div class="mainbar">
	<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">FAQ 상세보기</h2>
			<!-- Breadcrumb -->
			<div class="pull-right">
				<div class="bread-crumb">
				  <a href="#" onclick="left.adminSubmitFn('adminMain', 'adminMain.do', 'frmAdmin')"><i class="fa fa-home"></i> 메인</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current" onclick="left.adminSubmitFn('adminFaq', 'adminFaq.do', 'frmAdmin')">FAQ</a>
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">FAQ 상세보기</a>
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
							<td class="ip-text" colspan="2"><input class="form-control" type="text" name="faqNumber" id="faqNumber" value="${faqDetail.faqNumber}" disabled="disabled"></td>
						</tr>
						<tr>
							<th>제목</th>
							<td class="ip-text" colspan="2"><input class="form-control" type="text" name="faqTitle" id="faqTitle"  value="${faqDetail.faqTitle}"></td>
						</tr>
						<tr>
							<th>타입</th>
							<td colspan="2">
								<select class="selectpicker form-control" data-size="8" data-live-search="false" id="faqType" name="faqType">
			                            <option value="join" selected="selected">회원가입</option>
			                            <option value="reservation">예약 및 결제</option>
			                            <option value="cancel">취소 및 환불</option>
			                            <option value="travel">여행</option>
			                            <option value="event">이벤트</option>
			                            <option value="other">기타 문의사항</option>
		                        </select>
							</td>
						</tr>
						<tr>
							<th>등록일</th>
							<td>${faqDetail.faqDate}</td>
						</tr>
						<tr>
							<th>내용</th>
							<td class="ip-text">
								<textarea id="faqContents" name="faqContents" class="textarea-box" style="height: 385px;">${faqDetail.faqContents}</textarea>
							</td>
						</tr>
				</thead>
				</table>
			</div>
		</div>
		<div class="col-md-12 widget-foot">
			<div class="content-c-btn">
				<button class="btn btn-default" type="button" value="" onclick="javascript:faqSubmit()">저장하기</button>
				<button class="btn btn-default" onclick="javascript:left.adminSubmitFn('adminFaq','adminFaq.do','frmAdmin')">뒤로가기</button>
			</div>
		</div>
	</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
	
</div>
