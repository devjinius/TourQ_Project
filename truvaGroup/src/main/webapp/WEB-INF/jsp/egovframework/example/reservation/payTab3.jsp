<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<div id="payPhone" prop="orderKind" class="tab-pane fade">
		<div class="col-md-12">
			<div class="col-sm-6 form-group">
				<input type="text" class="form-control col-sm-8" name="payPhoneNumber" id="payPhoneNumber" placeholder="결제할 핸드폰번호를 입력하세요.">
			</div>
			<div class="col-sm-12 comment-input-area">
				<h5 class="pd-top-10">휴대폰 간편결제 안내 </h5>
				<p>
					- 휴대폰 결제한도는 최대 30만원입니다.<br/>
					- 단, 개인별 한도는 통신사별 회원등급에 따라 적용됩니다.
				</p>
			</div>
		</div>
	</div>