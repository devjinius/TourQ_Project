<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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

function idDupFn() {
	
	
	var memberId = $("#memberId").val();
	
	if(memberId == ""){
		
		alert("ID를 입력해 주세요.");
		
		$("#memberId").focus();
		
		return;
	}
	
	$.ajax({
		
		type: "POST",
		url: "validateDup.do",
		data: {"memberId": memberId},
		async: false,
		success: function(result) {
			
			if(result == "DUPLICATE"){
				
				alert("중복되는 값이 있습니다. ID를 변경해주세요!");
				
				$("#memberId").val("");
				
				$("#memberId").focus("");
			} else {
				
				alert("중복되는 값이 없습니다. 계속 진행해주세요.");
				
				$("#idDup").val("OK");
				
				$("#memberPw").focus();
			}
		}
	});
}

function register() {
	
	
	if($("#idDup").val() != "OK"){
		
		alert("id 중복 체크를 해주세요.");
		
		return;
	} else {
		
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
}

$(document).ready(function(){	

	$("[id*='memberHp']").numeric("positiveInteger");

});
</script>
<style>
.pd-bt-20 {
	padding-bottom: 20px;
}
</style>

<section class="section lb page-title little-pad">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="section-big-title clearfix">
					<div class="pull-left">
						<h3>회원가입</h3>
						<p>회원가입을 이용하시면 다양한 혜택을 받을 수 있습니다.</p>
					</div>

					<div class="pull-right hidden-xs">
						<ul class="breadcrumb">
							<li><a href="javascript:nav.pageSubmitFn({url:'main.do'})">Home</a></li>
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
					<div class="blog-wrapper">
							<div class="row contact-form search-top">
								<form onsubmit="return false;" name="registerForm" id="registerForm" method="post">
								<input type="hidden" name="idDup" id="idDup" value="N">
								<input type="hidden" name="pwDup" id="pwDup" value="N">
								<div class="col-md-7">
										<div class="col-md-12">
											<div class="form-group">
												<div class="col-sm-12">
													<div class="col-sm-12 join-title">아이디</div>
												</div>
												<div class="col-sm-6">
													<input type="text" class="form-control" id="memberId" name="memberId" placeholder="ID를 입력해 주세요" title="아이디">
												</div>
												<div class="col-sm-1">
													<button class="btn btn-primary"  onclick="javascript:idDupFn()">중복검사</button>
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
														placeholder="이름을 입력해주세요"  title="이름">
												</div>
											</div>
										</div>

										<div class="col-md-12">
											<div class="form-group">
												<div class="col-sm-12">
													<div class="col-sm-12 join-title">이메일</div>
													<input type="text" class="form-control" name="memberMail" id="memberMail"
														placeholder="E-mail 주소 입력"  title="이메일">
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
														name="memberHpf" id="memberHpf" placeholder="010" title="전화번호">
												</div>
												<div class="col-sm-4">
													<input type="text" class="form-control col-sm-4" name="memberHpm" id="memberHpm"
														placeholder="1234" title="전화번호2">
												</div>
												<div class="col-sm-4">
													<input type="text" class="form-control col-sm-4" name="memberHpl" id="memberHpl"
														placeholder="5678" title="전화번호3">
												</div>
											</div>
										</div>
									</div>
										<div class="col-md-5 join-btn-area">
											<div class="col-md-4 align-right">
												<button class="btn btn-primary col-md-12" onclick="javascript:register()">가입하기</button>
											</div>
											<div class="col-md-4 align-right">
												<button class="btn btn-primary col-md-12" onclick="javascript:nav.pageSubmitFn({url:'main.do'})">취소</button>
											</div>
										</div>
								</form>
							</div>
							<!-- end col -->
						</div>
				</div>
			<!-- end grid -->
			</div>
		<!-- end col -->
		</div>
	<!-- end row -->
	</div>
	<!-- end container -->
</section>
<!-- end section -->