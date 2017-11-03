<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        
 <div id="wrapper">
    <section class="section lb page-title little-pad">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="section-big-title clearfix">
                        <div class="pull-left">
                            <h3>회원가입 완료</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
     </section>
        <section class="section">
            <div class="container">
                <div class="row">
                    <div class="col-md-9 align-center">
                        <div class="blog-item">
                        	<h2 class="reservationComplet-title">축하드립니다.</h2>
                            <h3 class="reservationComplet-title"><c:out value="${loginVO.memberId}"/>님 회원가입이 완료되었습니다</h3>
                            <h5 class="reservationComplet-title">회원가입 기념으로 포인트 5000점이 추가되었습니다.</h5>
                            <div class="reservationComplet-btn">
                            	<a href="#" class="btn btn-primary" onclick="javascript:nav.pageSubmitFn({url:'main.do'})">메인으로 가기</a>
                            </div>
                        </div><!-- end blog-item -->
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end section -->
    </div>
    <!-- end wrapper -->