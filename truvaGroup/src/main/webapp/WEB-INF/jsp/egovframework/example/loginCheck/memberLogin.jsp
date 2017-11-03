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
					
					nav.pageSubmitFn({url: 'logingo.do'});
				} else if (result == "FAIL"){
					
					alert("ID와 비밀번호를 확인해주세요.");
					
					$("#memberId").val("");
					
					$("#memberPw").val("");
				}
			},
			
		    beforeSend: function() {
		    	
		    	$("#preloader").on(500).fadeIn();
		        $(".preloader").on(600).fadeIn("slow");
		    },
		    
		    complete: function() {

		    	$("#preloader").on(500).fadeOut();
		        $(".preloader").on(600).fadeOut();
		    },
		    
		    fail: function(){

				alert("ID와 비밀번호를 확인해주세요");
		    }
		});
		
	}
				//var jsonRes = JSON.parse(result);
// 				$.each(jsonRes, function(i, item) {
					
// 					// depth가 1인 것 중 하위메뉴가 있다면 if문을 탄다.
// 					if(item.collapseYn == 'Y'){
						
						
// 					} else {
						
// 				});
}

</script>

<div id="wrapper">
    <section class="section lb page-title little-pad">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="section-big-title clearfix">
                        <div class="pull-left">
                            <h3>회원 로그인</h3>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
  <section class="section">
      <div class="container">
          <div class="row">
              <div class="col-lg-12">
                  <div class="content">
                      <div class="blog-wrapper">
                          <div class="blog-item">
                              <div class="row register-form normal-register">
                                  <div class="col-md-6 col-register align-center">
                                      <form method="post" class="l-form" name="loginForm" id="loginForm" onsubmit="return false;">
                                      <h4>회원 로그인</h4>
	                                  <div class="col-sm-8 col-register">
	                                          <div class="form-group">
	                                              <input type="text" name="memberId" placeholder="ID" class="l-form-username form-control" id="memberId">
	                                          </div>
	                                          <div class="form-group">
	                                              <input type="password" name="memberPW" placeholder="Password" class="l-form-password form-control" id="memberPw">
	                                          </div>
	                                  </div>
	                                  <div class="col-sm-4 col-register">
                                          <button class="btn btn-primary btn-login" onclick="javascript:login.ajaxFn()">Login</button>
	                                  </div>
	                                  <div class="col-sm-12 col-register">
                                          <p>회원가입 하고 적립금을 받아가세요!
                                              <button type="button" class="btn btn-primary btn-loginCheck btn-xs" onclick="javascript:nav.pageSubmitFn({pageName: 'memberJoin', frmName: 'frm', url: 'memberJoin.do'})">회원가입 하러가기</button>
                                          </p>
	                                  </div>
                                      </form>
                                  </div>

                              </div>
                          </div><!-- end blog-item -->
                      </div>
                  </div><!-- end grid -->
              </div><!-- end col -->
          </div><!-- end row -->
      </div><!-- end container -->
  </section><!-- end section -->
 </div>