<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

function myCourse(courseNm) {

	$("#courseNumber").val(courseNm);
		
    nav.pageSubmitFn({pageName: 'seoulro', frmName: 'myCourseFrm', url: 'seoulro.do'});
}
</script>

<form id="myCourseFrm" name="myCourseFrm">
	<input type="hidden" name="courseNumber" id="courseNumber" /> 
</form>

    <div id="wrapper">
        <section class="section lb page-title little-pad">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="section-big-title clearfix">
                            <div class="pull-left">
                                <h3>마이페이지</h3>
                                <p>주문내역 및 내 정보를 확인하세요.</p>
                            </div>

                            <div class="pull-right hidden-xs">
                                <ul class="breadcrumb">
                                    <li><a href="javascript:void(0)">Home</a></li>
                                    <li><a href="javascript:void(0)">My Page</a></li>
                                    <li class="active">My Page</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

		<section class="section">
		    <div class="container">
		        <div class="row text-center">
		            <div class="col-md-3 wow fadeIn">
		                <div class="stat-wrap" onclick="javascript:nav.pageSubmitFn({pageName: 'myInfo', frmName: 'frm', url: 'myInfo.do'})">
		                    <i class="flaticon-avatar"></i>
		                    <p class="stat_count"><c:out value="${getInfo.pointTotalmile}" /></p>
		                    <small>내정보 보기</small>
		                </div><!-- end stat-wrap -->
		            </div><!-- end col -->
		            <div class="col-md-3 wow fadeIn">
		                <div class="stat-wrap" onclick="javascript:nav.pageSubmitFn({pageName: 'myOrderList', frmName: 'frm', url: 'myOrderList.do'})">
		                    <i class="flaticon-shopping-basket"></i>
		                    <p class="stat_count"><c:out value="${getInfo.totalOrderCount}" /></p>
		                    <small>내 주문내역 보기</small>
		                </div><!-- end stat-wrap -->
		            </div><!-- end col -->
		            <div class="col-md-3 wow fadeIn">
		                <div class="stat-wrap" onclick="javascript:nav.pageSubmitFn({pageName: 'myQuestion', frmName: 'frm', url: 'myQuestion.do'})">
		                    <i class="flaticon-headphones"></i>
		                    <p class="stat_count"><c:out value="${getInfo.totalAskCount}" /></p>
		                    <small>나의 문의내역</small>
		                </div><!-- end stat-wrap -->
		            </div><!-- end col -->
		            <div class="col-md-3 wow fadeIn" onclick="javascript:nav.pageSubmitFn({pageName: 'myFavoritList', frmName: 'frm', url: 'myFavoritList.do'})">
		                <div class="stat-wrap">
		                    <i class="flaticon-smiling-emoticon-square-face"></i>
		                    <p class="stat_count"><c:out value="${getInfo.totalLikeCount}" /></p>
		                    <small>관심 코스</small>
		                </div><!-- end stat-wrap -->
		            </div><!-- end col -->
		        </div><!-- end row -->
		    </div><!-- end container -->
		</section><!-- end section -->

       <section class="section">
            <div class="container">
                <div class="row sitemap">
                
                   <div class="col-md-6">
					  <h4 class="myPage-mini-title col-sm-12">- 최근에 작성한 문의글 
					  	<a href="#" class="myPage-more" onclick="javascript:nav.pageSubmitFn({pageName: 'myQuestion', frmName: 'frm', url: 'myQuestion.do'})">More 
					  		<i class="fa fa-angle-right"></i>
					  	</a>
					  </h4>
					  
                      <div class="testimonials">
                        <div class="active item myPage-question col-sm-12">
                          <blockquote class="col-sm-12">
                          	<p>
	                          	<c:choose>
	                          		<c:when test="${getInfo.askContent != '0'}">
	                          			<c:out value="${getInfo.askContent}" />
	                          		</c:when>
	                          		<c:otherwise>
	                          			작성된 문의글이 없습니다.
	                          		</c:otherwise>
	                          	</c:choose>
                         	</p>
                          </blockquote>
                		</div>
                        <div class="active item myPage-question">
                          <div class="carousel-info col-sm-2">
                            <img alt="" src="http://keenthemes.com/assets/bootsnipp/img1-small.jpg" class="pull-left">
                            <div class="pull-left">
                              <span class="testimonials-name text-center">관리자</span>
                            </div>
                          </div>
	                        <div class="active item col-sm-10">
	                          <blockquote><p>
	                          	<c:choose>
	                          		<c:when test="${getInfo.askAnswerYn == Y}">
	                          			<c:out value="${getInfo.answerContent}" />
	                          		</c:when>
	                          		<c:otherwise>
	                          			작성된 답변이 없습니다.
	                          		</c:otherwise>
	                          	</c:choose>
	                          </p></blockquote>
	                        </div>
                		</div>
                  	</div>
                  </div><!-- end col -->
					  
		            <div class="container col-md-6">
				 		<h4 class="myPage-mini-title">- 최근에 조회한 투어 코스</h4>
		                <div class="row">
					 		<c:choose>
					 			<c:when test="${myCourseList != '0'}">
					 				<c:forEach items="${myCourseList}" var="myCourseList" varStatus="status">
					                    <div class="col-sm-6 wow fadeIn" data-wow-duration="1s" data-wow-delay="0.2s"
					                    	 onclick="myCourse('<c:out value='${myCourseList.courseNumber}' />')">
				                            <img src="images/uploads/course/<c:out value="${myCourseList.courseNumber}"/>_1.jpg"
				                            	alt="<c:out value='${myCourseList.courseTitle}' />" class="img-responsive">
					                        <div class="box text-center my-course-list">   
					                            <h4><c:out value='${myCourseList.courseTitle}' /></h4>
					                            <span><c:out value='${myCourseList.courseSubtitle}' /></span>
					                        </div><!-- end box -->
					                    </div><!-- end col -->
					 				</c:forEach>
					 			</c:when>
					 			<c:otherwise>
					 			 	<div class="col-sm-6 wow fadeIn" data-wow-duration="1s" data-wow-delay="0.2s">
					                        <div class="box text-center my-course-list">
					                            <span>최근에 조회한 리스트가 없습니다.</span>
					                        </div><!-- end box -->
					                </div><!-- end col -->
					 			</c:otherwise>
					 		</c:choose>
		                </div><!-- end row -->
		            </div><!-- end container -->
			            
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end section -->

		
    </div><!-- end wrapper -->