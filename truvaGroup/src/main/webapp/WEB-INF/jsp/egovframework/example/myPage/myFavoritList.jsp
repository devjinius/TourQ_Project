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

var favoritList = {
	
	delet : function(courseNm) {
		
		if (confirm("리스트를 정말로 삭제하시겠습니까?") == false) {
			return;
		}
		
		$.ajax({
			
			type	: "POST",
			url		: "deletFavoritList.do",
			data	: {"param1" : courseNm},
			async	: false,
			success	: function() {
				alert("d");
			}
		})
	}
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
                             <h3>나의 관심코스</h3>
                             <p>내가 즐겨찾기한 투어상품입니다.</p>
                             
                         </div>

                         <div class="pull-right hidden-xs">
                             <ul class="breadcrumb">
                                 <li><a href="javascript:void(0)">Home</a></li>
                                 <li><a href="javascript:void(0)">My Page</a></li>
                                 <li class="active">My Favorit List</li>
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
                                    		onclick="javascript:nav.pageSubmitFn({pageName: 'myinfo', frmName: 'frm', url: 'myinfo.do'}">내정보</a>
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
                
                			<c:forEach items="${getMyFavorit}" var="getMyFavorit">
			                    <div class="col-md-4">
			                        <div class="shortcode-wrap">
			                            <div class="list-three-item cruise-list">
			                                <div class="list-item">
			                                    <a href="#" title="">
			                                        <div class="entry" onclick="myCourse('<c:out value='${getMyFavorit.courseNumber}' />')">
			                                            <img src="images/uploads/course/<c:out value="${getMyFavorit.courseNumber}" />_1.jpg" alt="" class="img-responsive">
			                                            <div class="magnifier">
			                                                <div class="magni-desc">
			                                                    <div class="rating">
			                                                        <small><c:out value="${getMyFavorit.totCnt}" /> (Reviews)</small>
			                                                        <c:forEach var="i" begin="0" end="5" varStatus="status">
			                                                        	<c:choose>
			                                                        		<c:when test="${getMyFavorit.rank > i}"><i class="fa fa-star"></i></c:when>
			                                                        		<c:otherwise><i class="fa fa-star-o"></i></c:otherwise>
			                                                        	</c:choose>
			                                                        </c:forEach>
			                                                    </div><!-- end rating -->
			                                                </div>
			                                            </div><!-- end magnifier -->
			                                        </div><!-- end entry -->
			                                    </a>
			                                    <div class="list-desc clearfix box-close">
			                                        <h4>
			                                        	<a href="cruise-single.html" title="">
			         		                               <c:out value="${getMyFavorit.courseTitle}" />
			         		                            </a>
			         		                        </h4>
			                                        <ul class="list-inline">
			                                            <li class="small"><c:out value="${getMyFavorit.courseSubtitle}" /></li>
			                                        </ul>
			                                        <div class="box-close-btn">
			                                        	<a href="#" onclick="javascript:favoritList.delet(<c:out value='${getMyFavorit.courseNumber}' />)"></a>
			                                        </div>
			                                    </div><!-- end list-desc -->
			                                </div><!-- end list-item -->
			                            </div><!-- end list-three-item -->
			                        </div>
			                    </div><!-- end col -->
		                    </c:forEach>
                    
                     </div><!-- end grid -->
                 </div><!-- end col -->
             </div><!-- end row -->
         </div><!-- end container -->
     </section><!-- end section -->
 </div><!-- end wrapper -->