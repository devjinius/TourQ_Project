<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

function changTab(pageName) {
		
	var menuAll = $("[prop=menu]");
	
	menuAll.removeClass("active");
	
	$("#"+pageName).addClass("active");
}

$(document).ready(function(){	

	var pageName = "<c:out value="${param.pageName}"/>";
	
	changTab(pageName);
});
</script>
    <div id="wrapper">
        <section class="section lb page-title little-pad">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="section-big-title clearfix">
                            <div class="pull-left">
                                <h3>나의 주문내역</h3>
                                <p>내가 그동안 주문한 내역을 보여줍니다.</p>
                                
                            </div>

                            <div class="pull-right hidden-xs">
                                <ul class="breadcrumb">
                                    <li><a href="javascript:void(0)">Home</a></li>
                                    <li><a href="javascript:void(0)">My Page</a></li>
                                    <li class="active">My Order List</li>
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
                            <nav class="portfolio-filter wow fadeIn text-center" data-wow-duration="1s" data-wow-delay="0.4s">
                                <ul>
                                    <li>
                                    	<a prop="menu" id="myinfo" class="btn btn-dark" href="#"
                                    		onclick="javascript:nav.pageSubmitFn({pageName: 'myInfo', frmName: 'frm', url: 'myInfo.do'})">내정보</a>
                                    </li>
                                    <li>
                                   		<a prop="menu" id="myOrderList" class="btn btn-dark" href="#"
                                   			onclick="javascript:nav.pageSubmitFn({pageName: 'myOrderList', frmName: 'frm', url: 'myOrderList.do'})">나의 주문내역</a>
                                    </li>
                                    <li>
                                    	<a prop="menu" id="myQuestion" class="btn btn-dark" href="#"
                                    		onclick="javascript:nav.pageSubmitFn({pageName: 'myQuestion', frmName: 'frm', url: 'myQuestion.do'})">나의 문의내역</a>
                                    </li>
                                    <li>
                                    	<a prop="menu" id="myFavoritList" class="btn btn-dark" href="#"
                                    		onclick="javascript:nav.pageSubmitFn({pageName: 'myFavoritList', frmName: 'frm', url: 'myFavoritList.do'})">관심코스</a>
                                    </li>
                                    <li>
                                    	<a prop="menu" id="myPoint" class="btn btn-dark" href="#"
                                    		onclick="javascript:nav.pageSubmitFn({pageName: 'myPoint', frmName: 'frm', url: 'myPoint.do'})">보유 포인트</a>
                                    </li>
                                </ul>
                            </nav>

                    		<div class="col-md-12">
		                        <div class="shortcode-wrap col-md-10">
		                        
	                                <!-- Recent Posts -->
	                                <div class="recentposts recent">
	                                    <ul class="list-unstyled myOrderList-wrapper">
	                                    	<c:forEach var="getMyOrder" items="${getMyOrder}">
		                                        <li>
		                                            <a href="#">
						                                <dl class="myOrderList-contents">
						                                	<dt class="myOrderList-img" style="background:url('images/uploads/course/<c:out value="${getMyOrder.courseNumber}"/>_1.jpg');">
						                                	</dt>
						                                	<dd>
						                                		<div class="text">
					                                                <h6>주문번호 : <span><c:out value="${getMyOrder.orNumber}" /></span></h6>
					                                                <h4><c:out value="${getMyOrder.courseTitle}" /></h4>
				                                                </div>
				                                                <div class="myOrderList-date"> <!-- 취소시 order-cancel 클래스 추가 -->
			                                                		<h6 class="text">주문일 : <c:out value="${getMyOrder.orDate}" /></h6>
			                                                		<button class="btn btn-default btn-xs align-center" type="button">예약 취소</button>
		                                                		</div>
						                                	</dd>
						                                </dl>
		                                            </a>
		                                        </li>
	                                    	</c:forEach>
	                                    </ul>
	                                </div>
		                        
		                        </div><!-- end wrap -->
                   			</div><!-- end col -->
                    
                        </div><!-- end grid -->
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end section -->
    </div>
    <!-- end wrapper -->