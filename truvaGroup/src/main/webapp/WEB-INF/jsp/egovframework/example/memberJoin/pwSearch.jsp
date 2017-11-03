<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<div id="wrapper">
	<section class="section lb page-title little-pad">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="section-big-title clearfix">
						<div class="pull-left">
							<h3>회원 비밀번호 찾기</h3>
							<p>입력하신 E-mail로 비밀번호가 전송 됩니다.</p>
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
										<h4>비밀번호 찾기</h4>
										<div class="col-sm-8 col-register">
											<form class="contact-form search-top " style="margin-top: 40px;">
												<div class="form-group">
													<label class="sr-only" for="l-form-userid">UserID</label>
													<input type="text" name="l-form-userid"
														placeholder="아이디를 입력하세요."
														class="l-form-username form-control" id="l-form-userid">
												</div>
												<div class="form-group">
													<label class="sr-only" for="l-form-username">UserID</label>
													<input type="text" name="l-form-username"
														placeholder="이름를 입력하세요."
														class="l-form-username form-control" id="l-form-username">
												</div>
												<div class="form-group">
													<label class="sr-only" for="l-form-email">E-mail</label>
													<input type="email" name="l-form-email"
														placeholder="E-mail 주소를 입력하세요."
														class="l-form-email form-control" id="l-form-email">
												</div>
											</form>
										</div>
										<div class="col-sm-4 col-register">
											<form role="form" method="post" class="l-form">
												<button type="submit" class="btn btn-primary btn-login" style="height: 174px; width: 133px;"
												>비번찾기</button>
											</form>
										</div>
									</div>

								</div>
							</div>
							<!-- end blog-item -->
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
</div>