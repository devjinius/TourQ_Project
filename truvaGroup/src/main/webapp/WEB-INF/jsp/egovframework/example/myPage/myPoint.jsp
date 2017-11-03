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

function pageing(page) {
	
	var $page = $("#page");
	
	$page.val(page);
	
	nav.pageSubmitFn({pageName: 'myPoint', frmName: 'mypPageFrm', url: 'myPoint.do'});
}

$(document).ready(function(){	

	var pageName = "<c:out value="${param.pageName}"/>";
	
	changTab(pageName);
});
</script>

<form id="mypPageFrm"	name="mypPageFrm">
	<input type="hidden" id="page" name="page" />
</form>

    <div id="wrapper">
        <section class="section lb page-title little-pad">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="section-big-title clearfix">
                            <div class="pull-left">
                                <h3>나의 포인트</h3>
                                <p>그동안 포인트 사용내역을 보여줍니다.</p>
                                
                            </div>

                            <div class="pull-right hidden-xs">
                                <ul class="breadcrumb">
                                    <li><a href="javascript:void(0)">Home</a></li>
                                    <li><a href="javascript:void(0)">My Page</a></li>
                                    <li class="active">My Point</li>
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
		                              <table class="table cmmn-table myPoint-table">
		                       	 		<thead>
		                       	 			<tr>
		                       	 				<td>날짜</td>
		                       	 				<td>내용</td>
		                       	 				<td>발생한 포인트</td>
		                       	 				<td>소멸 및 사용포인트</td>
		                       	 				<td>잔여포인트</td>
		                       	 			</tr>
		                       	 		</thead>
		                       	 		<tbody>
		   									<c:forEach items="${getMyPoint}" var="getMyPoint" varStatus="status">
		                        	 			<tr>
		                        	 				<td><c:out value="${getMyPoint.pointDate}"/></td>
		                        	 				<td><c:out value="${getMyPoint.pointTitle}"/></td>
		                        	 				<c:choose>
		                        	 					<c:when test="${getMyPoint.gubun == '+'}">
		                        	 						<td><c:out value="${getMyPoint.pointMile}"/> 원</td>
		                        	 						<td></td>
		                        	 					</c:when>
		                        	 					<c:otherwise>
		                        	 						<td></td>
		                        	 						<td><c:out value="${getMyPoint.pointMile}"/> 원</td>
		                        	 					</c:otherwise>
		                        	 				</c:choose>
		                        	 				<td><c:out value="${getMyPoint.pointTotalmile}"/> 원</td>
		                        	 			</tr>
		   									</c:forEach>
		                       	 		</tbody>
		                       	 	</table>
		                       	 	
									<div class="text-center pd-top-20">
				                        <ul class="pagination">
				                        	<c:if test="${resMap.pageGroup > 1}">
				                            	<li><a href="javascript:pageing(<c:out value='${resMap.nextPage}' />)">&laquo;</a></li>
				                        	</c:if>
				                            <c:forEach var="i" begin="${resMap.startPage}"
				                            	end="${resMap.endPage > resMap.totalPage ? resMap.totalPage : resMap.endPage}">
				                            	<c:choose>
				                            		<c:when test="${resMap.page eq i}">
				                          				<li class="active"><a href="javascript:pageing(${i})">${i}</a></li>
				                            		</c:when>
				                            		<c:otherwise>
				                        			    <li><a href="javascript:pageing(${i})">${i}</a></li>
				                            		</c:otherwise>
				                            	</c:choose>
				                            </c:forEach>
				                            <c:if test="${resMap.nextPage < resMap.totalPage}">
				                            	<li><a href="javascript:pageing(<c:out value='${resMap.nextPage}' />)">&raquo;</a></li>
				                            </c:if>
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