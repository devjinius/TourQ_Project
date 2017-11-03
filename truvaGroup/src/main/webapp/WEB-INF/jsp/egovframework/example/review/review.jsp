<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

var reviewFn = {

	writeReview : function () {
		
		if("${sessionScope.memberSession.memberNumber}" != ""){
			
			nav.pageSubmitFn({url:'reviewCreate.do'});		
		} else {
			
			alert("로그인을 해주세요!");
			nav.pageSubmitFn({url: 'memberLogin.do'});
		}
	},
	
	showModal : function(reviewNumber) {
		
		//ajax를 타고 난 뒤 값을 각각 할당하자
		//image까지 테스트해볼것
		$.ajax({
			
			type	: "POST",
			url		: "reviewList.do",
			async	: false,
			data	: {"reviewNumber" : reviewNumber},
			success : function(result) {
				
				var jsonRes = JSON.parse(result);
				
				console.log(jsonRes);
				
				$("#couresName").text(jsonRes.courseTitle + "/" + jsonRes.courseSubtitle);
				$("#memberName").text(jsonRes.memberName);
				$("#reviewContents").text(jsonRes.reviewContents);
				$("#reviewDate").text(jsonRes.reviewDate);
				$("#title").text(jsonRes.reviewTitle);
				$("#reviewImg").attr("src", "images/review/"+reviewNumber+".jpg");
				
				$('.rating').raty({	
					
					score: jsonRes.reviewRank,
					readOnly: true
				});
			}
		});
	}
}
$(document).ready(function () {

})
</script>

<div class="modal reviewModal fade review-more-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog col-lg-12">
		<div class="modal-content">
			<div class="clearfix">
				<div class="custom-tab border-none reviewModalBox">
					<div class="tab-content">
						<div id="menu3" class="tab-pane fade active in">
							<div class="clearfix">

								<div class="comments-list">
									<div class="media review-more-img">
										<p class="pull-right"><small id="reviewDate">4 days ago</small></p>
										<div class="col-md-10 text-center review-wrap-center">
											<img id="reviewImg" src="images/uploads/seoulro_detail_1.jpg" alt="" style="width: 100%;height: 300px">
										</div>
										<div class="col-sm-9 review-wrap-center">
											<div class="pull-right ">
												<div class="rating">
												</div>
											</div>
											<h4 class="media-heading user_name" id="memberName">
												글쓴이
											</h4>
											<h5 id="title">제목을 입력하세요</h5>
											<p id="couresName">코스명이 들어가는 자리입니다.</p>
											<p id="reviewContents">후기내용 입니다아아앙 후기를 두줄이상 적어봅시다 봅시다아아아아아아기내용 입니다아아앙 후기를 두줄이상 적어봅시다 봅시다아아아아아아기내용 입니다아아앙 후기를 두줄이상 적어봅시다 봅시다아아아아아아</p>
										
										</div>
									</div>
								</div><!-- comments-list -->

							</div><!-- end clearfix -->
						</div>
					</div><!-- end custom-tab -->
				</div>
			</div><!-- end grid -->
		</div>
	</div>
</div>
        
    <div id="wrapper">
        <section class="section lb page-title little-pad">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="section-big-title clearfix">
                            <div class="pull-left">
                                <h3>Review.</h3>
                                <p>리뷰를 작성하시면 마일리지를 드립니다.</p>
                            </div>

                            <div class="pull-right hidden-xs">
                                <ul class="breadcrumb">
                                    <li><a href="javascript:nav.pageSubmitFn({url:'main.do', pageName:'main'})">Home</a></li>
                                    <li><a href="javascript:void(0)">review</a></li>
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
                    <div class="clearfix pull-right">
                        <button type="button" class="btn btn-primary" onclick="reviewFn.writeReview()">후기 쓰기</button>
                    </div>
                    <div class="col-md-12">
                        <div class="content">
                            <nav class="portfolio-filter wow fadeIn text-center" data-wow-duration="1s" data-wow-delay="0.4s">
                                <ul>
                                    <li><a class="btn btn-dark active" href="#" data-filter="*">All</a></li>
                                	<c:forEach items="${themeList}" var="themeList">
                                    <li><a class="btn btn-dark" href="#" data-toggle="tooltip" data-placement="top" title="${themeList.themeCount}"  data-filter=".cat${themeList.themeNumber}">${themeList.themeName}</a></li>
                                    </c:forEach>
                                </ul>
                            </nav>

							<div class="clearfix">
                            <div class="blog-wrapper blog-masonry">
                                <div class="portfolio row gallery_items">
	                                <c:forEach items="${reviewList}" var="reviewList">
	                                <!-- 순서대로 cat1 부분을 늘려주세요. 1,2,3,4 -->
	                                    <div class="pitem item-w1 item-h1 cat${reviewList.themeNumber}">
	                                        <div class="blog-item">
	                                            <div class="entry">
	                                                <img src="images/review/${reviewList.reviewNumber}.jpg" alt="" class="img-responsive" style="width: 233; height: 155;">
	                                                <span class="review-tag">
	                                                	<span class="tag-text">${reviewList.reviewTitle}</span>
	                                                	<span class="tag-bg"></span>
	                                                </span>
	                                                <div class="magnifier">
	                                                    <div class="magni-portfolio">
	                                                        <a href="#" data-toggle="modal" data-target=".review-more-modal" onclick="javascript:reviewFn.showModal('<c:out value="${reviewList.reviewNumber}"/>')">
	                                                        <i class="fa fa-plus"></i></a>
	                                                    </div>
	                                                </div><!-- end magnifier -->
	                                            </div>
	                                        </div><!-- end blog-item -->
	                                    </div><!-- end col -->
	                                </c:forEach>
                                </div><!-- end row -->
                                </div>
                            </div><!-- end masonry -->
                        </div><!-- end grid -->
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end section -->
    </div>
    <!-- end wrapper -->