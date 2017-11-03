<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>

function passwordValidate() {
	
	if($("#memberPw").val() == ""){
		
		alert("비밀번호의 값이 없습니다.");
	} else if ($("#memberPw").val() == $("#memberPwRe").val()) {
		
		alert("비밀번호가 같습니다.");
		
		$("#memberName").focus();
	} else {
		
		alert("비밀번호가 다릅니다. 확인해주시기 바랍니다.");
		
		$("#memberPw").val("");
		
		$("#memberPwRe").val("");
		
		$("#memberPw").focus();
	}
}

function register() {
	
	var validateOk = true;
	
	$("#registerForm input").each(function(index){
		
		if($(this).attr("title") == '이메일') {
			
			if(!CommonJsUtil.isMail($(this).val())){
				
				alert("이메일 형식이 올바르지 않습니다.");
				
				validateOk = false;
				
				return false;
			}
		}
		if($(this).val() == ""){
						
			alert($(this).attr("title") + "은 필수 입력사항입니다.");
			
			validateOk = false;
			
			$(this).focus();
			
			return false;
		}
	});
	
	if(validateOk){
		
		$("#registerForm").attr("onsubmit", "");
		
		nav.pageSubmitFn({pageName: 'main', frmName: 'registerForm', url: 'register.do'});
	} else {
		
		return;
	}
	
}

$(document).ready(function(){	

	$("[id*='memberHp']").numeric("positiveInteger");

});
</script>

<div id="wrapper">
	<section class="section lb page-title little-pad">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="section-big-title clearfix">
						<div class="pull-left">
							<h3>내정보 수정</h3>
							<p>내 정보를 확인하고 수정해주세요.</p>
						</div>
	
						<div class="pull-right hidden-xs">
							<ul class="breadcrumb">
								<li><a href="javascript:nav.pageSubmitFn('main', 'frm')">Home</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

     <section class="section">
         <div class="container">
             <div class="row">
                 <div class="col-md-12">
                     <div class="content">
                        <div class="row contact-form search-top">
							<form onsubmit="return false;" name="registerForm" id="registerForm" method="post">
							<input type="hidden" name="memberNumber" id="memberNumber" value="<c:out value="${sessionScope.memberSession.memberNumber}" />">
								<div class="col-md-7">
									<div class="col-md-12">
										<div class="form-group">
											<div class="col-sm-12">
												<div class="col-sm-12 join-title">아이디</div>
											</div>
											<div class="col-sm-6">
												<input type="text" class="form-control" id="memberId" name="memberId" value="${sessionScope.memberSession.memberId}"
												title="아이디" readonly="readonly">
											</div>
										</div>
									</div>
									
									<div class="col-md-12">
										<div class="form-group">
											<div class="col-sm-6">
												<div class="col-sm-12 join-title">비밀번호</div>
												<input type="password" class="form-control"
													id="memberPw" name="memberPw" placeholder="비밀번호" title="비밀번호">
											</div>
											<div class="col-sm-6">
												<div class="col-sm-12 join-title">비밀번호 확인</div>
												<input type="password" class="form-control"
													id="memberPwRe" name="memberPwRe"
													placeholder="비밀번호를 재입력 해주세요" onblur="javscript:passwordValidate()">
											</div>
										</div>
									</div>
									
									<div class="col-md-6">
										<div class="form-group">
											<div class="col-sm-12">
												<div class="col-sm-12 join-title">이름</div>
												<input type="text" class="form-control" name="memberName" id="memberName"
													value="${sessionScope.memberSession.memberName}"  title="이름">
											</div>
										</div>
									</div>
	
									<div class="col-md-12">
										<div class="form-group">
											<div class="col-sm-12">
												<div class="col-sm-12 join-title">이메일</div>
												<input type="text" class="form-control" name="memberMail" id="memberMail"
													value="${sessionScope.memberSession.memberMail}" title="이메일">
											</div>
										</div>
									</div>
	
									<div class="col-md-12">
										<div class="form-group">
											<div class="col-sm-12">
												<div class="col-sm-12 join-title">휴대폰 번호</div>
											</div>
											<div class="col-sm-4">
												<input type="text" class="form-control col-sm-4"
													name="memberHpf" id="memberHpf" value="${sessionScope.memberSession.memberHpf}" title="전화번호1">
											</div>
											<div class="col-sm-4">
												<input type="text" class="form-control col-sm-4" name="memberHpm" id="memberHpm"
													value="${sessionScope.memberSession.memberHpm}" title="전화번호2">
											</div>
											<div class="col-sm-4">
												<input type="text" class="form-control col-sm-4" name="memberHpl" id="memberHpl"
													value="${sessionScope.memberSession.memberHpl}" title="전화번호3">
											</div>
										</div>
									</div>
								</div>
							</form>
						</div>
                        <div class="col-md-12 text-center pd-top-30">
							<button class="btn btn-primary" onclick="javascript:register()">수정하기</button>
                        </div>
                    </div>
            	</div>
        	</div><!-- end blog-item -->
	 	</div><!-- end container -->
     </section><!-- end section -->
</div>