<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- 상단에 선언 -->
<%
pageContext.setAttribute("cr", "\r");
pageContext.setAttribute("cn", "\n");
pageContext.setAttribute("crcn", "\r\n");
pageContext.setAttribute("br", "");
%> 
 
<!-- jstl로 변환처리 -->
<c:set var="cmt" value="${fn:replace(storyList[0].storyContents,crcn,br)}" />
<c:set var="cmt" value="${fn:replace(cmt,cr,br)}" />
<c:set var="cmt" value="${fn:replace(cmt,cn,br)}" />

<script type="text/javascript">

//하트를 클릭하면 아이콘 클래스가 변하고 db 업데이트
function changeHeart(storyNumber){
	
	var memberNumber = "<c:out value="${sessionScope.memberSession.memberNumber}"/>";
	// 세션에 회원이 없으면 얼럿 띄우고 로그인 페이지로 이동
	if(memberNumber==""){
		
		alert("회원만 이용할 수 있습니다");
		nav.pageSubmitFn({pageName: "login", url: "memberLogin.do"});

		// 그렇지 않고 세션값이 있으면
	} else {
		
    	var $heartid = $("#heart");
    		gubun = "";
    	
    	// 하트가 비어있다면 칠해주고 하트가 칠해져있다면 비어있게 한다.
    	if($heartid.hasClass('fa-heart-o')) {
    		
    		$heartid.removeClass();
    		
    		$heartid.addClass("fa fa-heart");
    		
    		gubun = "I";
    	} else {
			
    		$heartid.removeClass();
    		
    		$heartid.addClass("fa fa-heart-o");
    		
    		gubun = "D";
    	}
    	
    	// gubun을 넘겨서 U면 insert, N이면 delete 한다.
    	$.ajax({
			
			type: "POST",
			url: "storyLikeID.do",
			data: {
				"gubun" : gubun,
				"storyNumber" : storyNumber
				},
			async: false
		});
	}
}

$(document).ready(function () {
	
	$(".blog-meta img").each(function() {
		$(this).attr("style", "height:400px; width:700px");
	});
});   
   
</script>
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
                                    <li><a href="#" onclick="javascript:nav.pageSubmitFn({pageName: 'main', frmName: 'frm', url: 'main.do'})">Home</a></li>
                                    <li><a href="#" onclick="javascript:nav.pageSubmitFn({pageName: 'story', frmName: 'frm', url: 'story.do'})">Story</a></li>
                                    <li><a href="#">Posting</a></li>
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
                                <div class="blog-item">
                                
									<c:forEach items="${storyList}" var="storyList" varStatus="status">
                                    <div class="post-media">
                                        <img src="images/uploads/blog/story_<c:out value="${storyList.storyNumber}"/>.jpg" alt="" class="img-responsive">
                                    </div><!-- end media -->
                                    <div class="blog-meta">
                                        <ul class="list-inline">
                                            <ul class="list-inline">
                                            <li><a href="#"><i class="fa fa-clock-o"></i> <c:out value="${storyList.storyDate}"/></a></li>
                                            <li><a href="#"><i class="fa fa-user"></i> 진성 매니저</a></li>
                                            <li><a href="#"><i class="fa fa-eye"></i> <c:out value="${storyList.storyCount}"/></a></li>
                                            <li><a href="#"><i class="fa fa-heart"></i> <c:out value="${storyList.storyLike}"/></a></li>
                                            </ul>
                                        </ul><!-- end inline -->
                                        
                                        <h4><c:out value="${storyList.storyTitle}"/></h4>
                                        
                                        <p><c:out value="${storyList.storySubTitle}"/></p>

                                        <c:out value="${cmt}"  escapeXml="false" />
                                        <div class="blog-heart">
                                        	<i id="heart" 
                                        	<c:if test="${storyList.like eq 'Y'}">
                                           		class="fa fa-heart"
                                           	</c:if>
                                           	<c:if test="${storyList.like eq 'N'}">
                                           		class="fa fa-heart-o"
                                          	</c:if>
	                                         onclick="javascript:changeHeart(<c:out value="${storyList.storyNumber}"/>)"></i>
                                        </div>
									</c:forEach>
                                    </div><!-- end blog-meta -->
                                </div><!-- end blog-item -->

                                <!-- author box -->
                                <div class="blog-item">
                                    <div class="authorbox">
                                        <img src="images/uploads/peoplePic_2.jpg" alt="" class="img-circle alignleft">
                                        <h4>작가 블레어 씨</h4>
                                        <p>여행을 좋아하고 즐기며 산다.<br> 아침먹고 점심먹고 저녁먹고 밥 잘먹으며 산다.<br> 인생뭐있나</p>
                                        <a href="#"><i class="fa fa-twitter"></i></a> <small>-</small>
                                        <a href="#"><i class="fa fa-facebook"></i></a> <small>-</small>
                                        <a href="#"><i class="fa fa-instagram"></i></a>
                                    </div><!-- end authorbox -->
                                </div>
                            </div><!-- end blog-wrapper -->
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