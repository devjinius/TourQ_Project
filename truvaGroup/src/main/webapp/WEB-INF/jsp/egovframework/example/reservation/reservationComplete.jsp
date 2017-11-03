<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

</script>
<form id="frm" name="frm">

</form>
        
 <div id="wrapper">
    <section class="section lb page-title little-pad">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="section-big-title clearfix">
                        <div class="pull-left">
                            <h3>예약완료</h3>
                            <p>예약이 완료되었습니다.</p>
                            
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
                                         <h3 class="reservationComplet-title">예약이 완료되었습니다</h3>
                            <div class="post-media reservationComplet-tag">
                                <span class="tab-text">예약 완료</span>
                                <span class="tab-bg"></span>
                                <img src="images/uploads/course/<c:out value="${resInfo.courseNumber}"/>_1.jpg" class="img-responsive">
                            </div><!-- end media -->
                            <div class="blog-meta">
                                <ul class="list-inline">
                                    <li><a href="#"><i class="fa fa-clock-o"></i><c:out value="${resInfo.orDate}"/></a></li>
                                </ul><!-- end inline -->
                                <h4><c:out value="${resInfo.courseTitle}" /></h4>
                                <div class="reservationComplet-contents">
	                                <p>
	                                	<span>주문번호 : </span><c:out value="${resInfo.orNumber}" />
	                                </p>
	                                <p>
	                                	<span>예약번호 : </span><c:out value="${resInfo.resNumber}" />
	                                </p>
	                                <p>
	                                	<span>예약자 : </span><c:out value="${resInfo.resName}" />
	                                </p>
	                                <p>
	                                	<span>예약인원 : </span><c:out value="${resInfo.resCount}" />
	                                </p>
	                                <p>
	                                	<span>결제방법 : </span>[
	                                	<c:out value="${resInfo.orKind eq 'payCard' ? '카드결제' : resInfo.orKind eq 'payBank' ? '무통장입금' : '핸드폰결제'}" />
	                                	] <c:out value="${resInfo.orKindinfo}" />
	                                </p>
	                                <p>
	                                	<span>금액 : </span><c:out value="${resInfo.orPrice}" />
	                                </p>
                                </div>
                                <div class="reservationComplet-btn">
                                	<a href="#" class="btn btn-primary" onclick="javascript:nav.pageSubmitFn('main', 'frm')">메인으로 가기</a>
                                </div>
                            </div><!-- end blog-meta -->
                        </div><!-- end blog-item -->
                    
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end section -->
    </div>
    <!-- end wrapper -->