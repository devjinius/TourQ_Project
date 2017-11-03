<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>

var login = {
		
	loginData : {},
	
	ajaxFn : function() {
		
		this.loginData = {
			
			"memberId" : $("#memberId").val(),
			
			"memberPw" : $("#memberPw").val()
		};

		$.ajax({
			
			type: "POST",
			url: "loginOk.do",
			data: this.loginData,
			async: false,
			success: function(result) {
				
				if(result == "SUCCESS"){
					
					alert("안녕하세요. 로그인 되셨습니다.");
					
					nav.pageSubmitFn({pageName: 'memberReservation', frmName: 'frm', url: 'memberReservation.do'});
				} else if (result == "FAIL"){
					
					alert("ID와 비밀번호를 확인해주세요.");
					
					$("#memberId").val("");
					
					$("#memberPw").val("");
				}
			},
		    fail: function(){

				alert("ID와 비밀번호를 확인해주세요");
		    }
		});
	}
}
</script>

  <section class="section">
      <div class="container">
          <div class="row">
              <div class="col-lg-12">
                  <div class="content">
                      <div class="blog-wrapper">
                          <div class="blog-item">
                              <div class="row register-form normal-register">
                                  <div class="col-md-6 col-register">
                                      <h4>회원 로그인</h4>
	                                  <div class="col-sm-8 col-register">
	                                      <form role="form" method="post" class="l-form">
	                                          <div class="form-group">
	                                              <label class="sr-only" for="l-form-username">memberId</label>
	                                              <input type="text" name="l-form-username" placeholder="Username" class="l-form-username form-control" id="memberId">
	                                          </div>
	                                          <div class="form-group">
	                                              <label class="sr-only" for="l-form-password">memberPw</label>
	                                              <input type="password" name="l-form-password" placeholder="Password" class="l-form-password form-control" id="memberPw">
	                                          </div>
	                                      </form>
	                                  </div>
	                                  <div class="col-sm-4 col-register">
	                                      <form role="form" method="post" class="l-form">
	                                          <button type="submit" class="btn btn-primary btn-login" onclick="javascript:login.ajaxFn()">Login</button>
	                                      </form>
	                                  </div>
	                                  <div class="col-sm-12 col-register">
                                          <p>비밀번호를 잃어버리셨나요?<button type="submit" class="btn findPassword">비밀번호 찾기</button></p>
	                                  </div>
                                  </div>

                                  <div class="col-md-6 col-register">
                                      <h4>아직 회원이 아니신가요?</h4>
	                                  <div class="col-sm-12 col-register">
	                                      <form role="form" method="post" class="l-form">
	                                          <div class="form-group loginCheck-text">
	                                              <p>회원가입 하시고 적립금 혜택을 받아가세요!
	                                                  <button type="button" class="btn btn-primary btn-loginCheck btn-xs" onclick="javascript:nav.pageSubmitFn({pageName: 'memberJoin', frmName: 'frm', url: 'memberJoin.do'})">회원가입 하러가기</button>
	                                              </p>
	                                              <p>회원가입을 원하지 않으세요?
	                                                  <button type="button" class="btn btn-primary btn-loginCheck" onclick="javascript:nav.pageSubmitFn({pageName: 'reservationAgree', frmName: 'frm', url: 'reservationAgree.do'})">비회원 예약하러가기</button>
	                                              </p>
	                                          </div>
	                                      </form>
	                                  </div>
                                  </div>
                              </div>
                          </div><!-- end blog-item -->
                      </div>
                  </div><!-- end grid -->
              </div><!-- end col -->
          </div><!-- end row -->
      </div><!-- end container -->
  </section><!-- end section -->