<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

var story = {
		
	submitFn : function(storyNumber) {
		
		$("#storyNumber").val(storyNumber);
		
		nav.pageSubmitFn({pageName: 'storyPosting', frmName: 'storyForm', url: 'storyPosting.do'});
	}
}

function fnGoPaging (page) {
	
	$("#page").val(page);
	
	nav.pageSubmitFn({pageName: 'storyForm', frmName: 'storyForm', url: 'story.do'});
}

</script>

<form name="storyForm" id="storyForm">
	<input type="hidden" name="storyNumber" id="storyNumber">
	<input type="hidden" name="page" id="page">
</form>
        <section class="section lb page-title little-pad">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="section-big-title clearfix">
                            <div class="pull-left">
                                <h3>여행을 쓰다</h3>
                                <p>여행 전문가가 다녀본 서울</p>
                            </div>

                            <div class="pull-right hidden-xs">
                                <ul class="breadcrumb">
                                    <li><a href="javascript:nav.pageSubmitFn({pageName: 'main', frmName: 'frm', url: 'main.do'})">Home</a></li>
                                    <li><a href="#">Story</a></li>
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
                    <div class="col-md-8">
                        <div class="content">
                            <div class="blog-wrapper">
                            	<c:forEach items="${storyList}" var="storyList" varStatus="status">
                                <div class="blog-item">
                                    <div class="post-media">
                                        <a href="#" onclick="javascript:story.submitFn('<c:out value="${storyList.storyNumber}"/>')">
                                        	<img src="images/uploads/blog/story_<c:out value="${storyList.storyNumber}"/>.jpg" alt="" class="img-responsive img-custom-1">
                                        </a>
                                    </div><!-- end media -->
                                    <div class="blog-meta">
                                        <ul class="list-inline">
                                            <li><a href="#"><i class="fa fa-clock-o"></i> <c:out value="${storyList.storyDate}"/></a></li>
                                            <li><a href="#"><i class="fa fa-user"></i> 진성 매니저</a></li>
                                            <li><a href="#"><i class="fa fa-eye"></i> <c:out value="${storyList.storyCount}"/></a></li>
                                            <li><a href="#"><i class="fa fa-heart"></i> <c:out value="${storyList.storyLike}"/></a></li>
                                        </ul><!-- end inline -->
                                        <h4><a href="#" onclick="javascript:story.submitFn('<c:out value="${storyList.storyNumber}"/>')"><c:out value="${storyList.storyTitle}"/></a></h4>
                                        <p><c:out value="${storyList.storySubtitle}"/></p>
                                        <a href="#" class="btn btn-primary" onclick="javascript:story.submitFn('<c:out value="${storyList.storyNumber}"/>')">Read more</a>
                                    </div><!-- end blog-meta -->
                                </div><!-- end blog-item -->
                                </c:forEach>

                            </div><!-- end blog-wrapper -->

                            <div class="clearfix"></div>
                            
                            <ul class="pagination">
                            
	           				<c:if test="${resMap.pageGroup != 1}">
	                            <li><a href="javascript:fnGoPaging(1)">처음</a></li>
	               			</c:if>
	               			
	           				<c:if test="${resMap.pageGroup > 1}">
	                            <li><a href="javascript:fnGoPaging(<c:out value='${resMap.prePage}'/>)">&laquo;</a></li>
	               			</c:if>
	               			
	               			<c:forEach var="i" begin="${resMap.startPage}" 
	               						end="${resMap.endPage > resMap.totalPage ? resMap.totalPage : resMap.endPage}">
	               					
	               				<c:choose>
	               					<c:when test="${resMap.page eq i}">
	               						<li class="active">
	               							<a href="javascript:fnGoPaging(${i});">${i}</a>
	               						</li>
	               					</c:when>
	               					<c:otherwise>
	               						<li>
	               							<a href="javascript:fnGoPaging(${i});">${i}</a>
	               						</li>
	               					</c:otherwise>
	               				</c:choose>
	               			
	               			</c:forEach>
	               			
	               			<c:if test="${resMap.nextPage <= resMap.totalPage}">
	                           <li><a href="javascript:fnGoPaging(<c:out value='${resMap.nextPage}'/>)">»</a></li>
	                        </c:if>
	                        
	                        <c:if test="${resMap.nextPage <= resMap.totalPage}">
		                        <li><a href="javascript:fnGoPaging(<c:out value='${resMap.totalPage}'/>)">맨뒤</a></li>
	                        </c:if>
                        </ul>
                        </div><!-- end grid -->
                    </div><!-- end col -->
                    <div class="col-md-4">
                        <div class="sidebar restaurant-sidebar croise-sidebar">
                            <div class="widget clearfix">
                                <div class="widget-title">
                                    <h4>CALL US TODAY</h4>
                                    <hr>
                                </div>

                                <div class="callusbox">
                                    <p>페이지에 방문해주셔서 감사합니다. 더 나은 서울 도보 관광을 위해 도움이 필요하시다면 여기로 연락해 주십시오.</p>
                                    <h4><i class="flaticon-telephone"></i> +88 02 123 4567</h4>
                                </div><!-- end callusbox -->
                            </div><!-- end widget -->

                            <hr class="custom">

                            <div class="widget clearfix">
                                <a href="#"><img src="images/banner_02.png" alt="" class="img-responsive"></a>
                            </div><!-- end widget -->

                            <hr class="custom">

                                </div>
                            </div><!-- end widget -->
                        </div><!-- end sidebar -->
                    </div><!-- end col -->    
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end section -->