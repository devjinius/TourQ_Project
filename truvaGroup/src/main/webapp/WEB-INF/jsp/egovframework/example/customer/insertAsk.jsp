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
                            <h3>문의 접수 완료</h3>
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
                        	<h2 class="reservationComplet-title">접수 됐습니다!</h2>
                            <h3 class="reservationComplet-title"><c:out value="${sessionScope.memberSession.memberId}"/>님의 귀중하신 의견이 관리자에게 전달되었습니다.</h3>
                            	최대한 빠른 시간안에 회원님의 문의에 답변해드리겠습니다.<br>
                            	문의내용과 답변은 마이페이지에서 확인하실 수 있습니다.
                            <div class="askComplet-btn">
                            	<button class="btn btn-primary" onclick="javascript:nav.pageSubmitFn({url:'main.do'})" type="button">메인으로 가기</button>
                            	<button class="btn btn-primary courseicon" onclick="javascript:nav.pageSubmitFn({url:'myPage.do'})" type="button">마이페이지로 가기</button>
                            </div>
                        </div><!-- end blog-item -->
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end section -->
    </div>
    <!-- end wrapper -->