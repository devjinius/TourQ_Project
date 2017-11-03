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
<c:set var="cmt" value="${fn:replace(answerInfo.answerContent,crcn,br)}" />
<c:set var="cmt" value="${fn:replace(cmt,cr,br)}" />
<c:set var="cmt" value="${fn:replace(cmt,cn,br)}" />

<script src="ckeditor/ckeditor.js"></script>

<script type="text/javascript">
var ckedit = {
		
	init : function() {
		CKEDITOR.replace("ckeditor",{
			height : '200px'  // 입력창의 높이
		});
		
 		CKEDITOR.instances.ckeditor.setData("<c:out value="${cmt}"  escapeXml='false' />");
	}
};

function answerSubmit() {

	var title = $("#askTitle").val();
		content = CKEDITOR.instances.ckeditor.getData();
		
	if(title.length == 0 || content.length == 0){
		
		alert("필요한 데이터를 모두 입력하셔야 합니다!!");
		
		return;
	}
	
	var param = {
	
		title : title,
		content : content,
		gubun : "U",
		askNumber : "<c:out value="${param.askNumber}"/>"
	}
	
	$.ajax({
		
		type	: "POST",
		url		: "answerIU.do",
		data 	: {"param" : JSON.stringify(param)},
		async	: false,
		success	: function(result){
			
			if(result.split(" ")[0] == "SUCCESS"){
				
				alert("성공적으로 수정되었습니다.");

				$("#answerDate").html(result.split(" ")[1]);
			}
		}
	});
	
};

var askFn = {
		
	createAsk : function() {
		
		$("#first-display").css("display", "none");
		
		$(".hide-div").css("display", "block");
	},
	
	cancelAsk : function() {
		
		$("#first-display").css("display", "block");
		
		$(".hide-div").css("display", "none");
	}
}


$(document).ready(function(){	
	
	ckedit.init();
});
</script>

<form id="frmNumber" name="frmNumber">
	<input type="hidden" id="askNumber" name="askNumber" value="<c:out value="${param.askNumber}"/>" /> 
	<input type="hidden" id="memberNumber" name="memberNumber" value="<c:out value="${param.memberNumber}"/>" /> 
</form>

<div class="mainbar">
	<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">1대1문의 상세보기</h2>
			<!-- Breadcrumb -->
			<div class="pull-right">
				<div class="bread-crumb">
				  <a href="#" onclick="left.adminSubmitFn('adminMain', 'adminMain.do', 'frmAdmin')"><i class="fa fa-home"></i> 메인</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">1대1문의 상세보기</a>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
	</div><!--/ Page heading ends -->


	
	<!-- Matter -->
	<div class="matter">
		<div class="container full-page-btn" style="overflow-y: auto;">
			<h4>회원 정보</h4>
			<div class="table-responsive table-margin-bottom">
				<table class="table table-bordered">
					<thead>
						<tr>
						  	<th>회원번호</th>
							<th>ID</th>
							<th>이름</th>
							<th>MAIL</th>
							<th>전화번호</th>
							<th>등록일</th>
						</tr>
					</thead>
					<tbody>
						<tr>
						  	<td>${memberInfo.memberNumber}</td>
							<td>${memberInfo.memberId}</td>
							<td>${memberInfo.memberName}</td>
							<td>${memberInfo.memberMail}</td>
							<td>${memberInfo.memberHp}</td>
							<td>${memberInfo.memberRegdate}</td>
						</tr>
					</tbody>
				</table>
			</div> 
			<hr>
			<h4>문의 내용</h4>
			<div class="table-responsive table-margin-bottom">
				<table class="table table-bordered table-row">
				  <thead>
					  	<tr>
							<th>번호</th>
							<td>${askInfo.askNumber}</td>
						</tr>
						<tr>
							<th>제목</th>
							<td>${askInfo.askTitle}</td>
						</tr>
						<tr>
							<th>등록일</th>
							<td>${askInfo.askDate}</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								${askInfo.askContent}
							</td>
						</tr>
				</thead>
				</table>
			</div>
				
			<h4>답변</h4>
				<div class="table-responsive table-margin-bottom">
					<table class="table table-bordered table-row">
					    <thead>
					    	<tr>
								<th>답변번호</th>
								<td>${answerInfo.answerNumber}</td>
							</tr>
							<tr>
								<th>제목</th>
								<td class="ip-text"><input class="form-control" type="text" name="askTitle" id="askTitle" value="${answerInfo.answerTitle}"></td>
							</tr>
							<tr>
								<th>답변일</th>
								<td id="answerDate">${answerInfo.answerDate}</td>
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
				<div class="pull-right table-margin-bottom" style="margin-top: 15px">
					<button class="btn btn-default" type="button" value="" onclick="javascript:answerSubmit()">저장하기</button>
					<button class="btn btn-default" onclick="javascript:left.adminSubmitFn('adminAsk','adminAsk.do','frmAdmin')">뒤로가기</button>
				</div>
				<div class="clearfix"></div> 
			<hr>
			<jsp:include page="/WEB-INF/jsp/egovframework/example/adminCustomer/adminAskSub.jsp">
				<jsp:param value="${param.askNumber}" name="asNumber"/>
			</jsp:include>
		</div>
		
		<div class="col-md-12 widget-foot">
		</div>
	</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
</div>

