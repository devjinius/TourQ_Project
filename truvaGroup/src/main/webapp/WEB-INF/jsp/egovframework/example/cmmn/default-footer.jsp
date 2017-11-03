<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
var ajaxFooter = {
		
	ajaxStory : function() {
	
		$.ajax({
			
			type	: "POST",
			url		: "footerStory.do",
			async	: false,
			success	: function(result){

				var jsonRes = JSON.parse(result);
				
				var storyMap = jsonRes[0];
				var reviewMap = jsonRes[1];
				
				var resDate = storyMap.storyDate.split(" ");

				resDate = resDate[0] + resDate[1] + resDate[2];

				var str = "<li>" + 
			                "<a href=\"#\" onclick=\"javascript:nav.pageSubmitFn({pageName:'storyPosting', url:'storyPosting.do', frmName: 'footerFrm'})\"><img src=\"images/uploads/blog/story_"+storyMap.storyNumber+".jpg\" class=\"img-responsive alignleft\"></a>" + 
	            			    "<h3><a href=\"#\" onclick=\"javascript:nav.pageSubmitFn({pageName:'storyPosting', url:'storyPosting.do', frmName: 'footerFrm'})\">"+ storyMap.storyTitle + "</a></h3>" + 
				                "<p>" + storyMap.storySubtitle + "</p>" + 
            			    "<small>" + resDate + "</small>" + 
		                  "</li>";
				
		        $("#storyNumber").val(storyMap.storyNumber);
				
 				$("#footerStory").append(str);
 				
 				resDate = reviewMap.reviewDate.split(" ");

				resDate = resDate[0] + resDate[1] + resDate[2];
				
				str = "<li>" + 
		                "<a href=\"#\" onclick=\"javascript:nav.pageSubmitFn({pageName:'storyPosting', url:'review.do'})\"><img src=\"images/review/"+ reviewMap.reviewNumber +".jpg\" class=\"img-responsive alignleft\"></a>" + 
		    			    "<h3><a href=\"#\" onclick=\"javascript:nav.pageSubmitFn({pageName:'review', url:'review.do'})\">"+ reviewMap.reviewTitle + "</a></h3>" + 
			                "<p>" + reviewMap.reviewContents + "</p>" + 
					    "<small>" + resDate + "</small>" + 
		              "</li>";
		              
 				$("#footerReview").append(str);
			}
			
		});
	},
	
	hot : function() {
		
		$("#pageNameRec").val("hot");
		
		nav.pageSubmitFn({pageName : 'main', url : 'main.do', frm : 'frm'});
	}
}

$(document).ready(function() {

	ajaxFooter.ajaxStory();
	//위로가기 아이콘 클릭 시 맨 위로 이동
	$("#top").click(function(){
		$("body").animate({scrollTop: 0}, 500);
	});
});
</script>
<form name="footerFrm" id="footerFrm">
	<input type="hidden" name="storyNumber" id="storyNumber">
</form>
        <footer class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <div class="widget clearfix">
                            <div class="widget-title">
                                <h4>TourQ Story</h4>
                                <hr>
                            </div>

                            <ul class="blog-posts" id="footerStory" name="footerStory">
<!--                               <li> -->
<!--                                 <a href="#" onclick="javascript:nav.pageSubmitFn('storyPosting', 'frm')"><img src="images/uploads/blog_small_01.jpg" alt="" class="img-responsive alignleft"></a> -->
<!--                                 <h3><a href="#" onclick="javascript:nav.pageSubmitFn('storyPosting', 'frm')">느림의 미학, 서촌</a></h3> -->
<!--                                 <p>서울의 도심에서, 한 걸음 떨어져 서울의 어제와 오늘을 볼 수 있는 그 곳.[…]</p> -->
<!--                                 <small>Sep 11, 2017</small> -->
<!--                                 </li> -->
                            </ul><!-- end blog-posts -->
                        </div><!-- end widget -->
                    </div><!-- end col -->

                    <div class="col-md-4">
                        <div class="widget clearfix">
                            <div class="widget-title">
                                <h4>TourQ Review</h4>
                                <hr>
                            </div>

                            <ul class="blog-posts" id="footerReview" name="footerReview">
<!--                                  <li> -->
<!-- 	                                <a href="http://blog.naver.com/tbus/221017340193"><img src="images/uploads/blog_small_02.jpg" alt="" class="img-responsive alignleft"></a> -->
<!-- 	                                <h3><a href="http://blog.naver.com/tbus/221017340193">Bus 를 타고 서울을 누비다</a></h3> -->
<!-- 	                                <p>버스 투어를 이용하여 서울 관광을 즐겨보았습니다. […]</p> -->
<!-- 	                                <small>Sep 15, 2016</small> -->
<!--                                 </li> -->
                            </ul><!-- end blog-posts -->
                        </div><!-- end widget -->
                    </div><!-- end col -->

                    <div class="col-md-4">
                        <div class="widget clearfix">
                            <div class="widget-title">
                                <h4>한큐에 자바</h4>
                                <hr>
                            </div>

                            <p>"절대 포기하면 안된다." 연봉이 높은 사람이 성공하는게 아니다. 프리 먼저 하는 사람이 성공하는거다~! 실력이 좋고 준비를 잘해도 이 바닥은 용기가 없으면 안된다. 최고가 되고 싶으면 "한큐"를 찾아라!!</p>

                            <ul class="social-links list-inline">
                                <li class="icon facebook"><a href="https://ko-kr.facebook.com/" target="_blank"><i class="fa fa-facebook"></i></a></li>
                                <li class="icon twitter"><a href="https://twitter.com/?lang=ko" target="_blank"><i class="fa fa-twitter"></i></a></li>
                                <li class="icon instagram"><a href="https://www.instagram.com/?hl=ko" target="_blank"><i class="fa fa-instagram"></i></a></li>
                                <li class="icon youtube"><a href="https://www.youtube.com/red?dclid=CMTk1qrXzNYCFcoavAodsMwFtQ" target="_blank"><i class="fa fa-youtube"></i></a></li>
                            </ul><!-- end social -->
                        </div><!-- end widget -->
                    </div><!-- end col -->
                </div><!-- end row -->

            </div><!-- end container -->
        </footer>

        <div class="copyrights">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <p>&copy; HanQ Tour INC. All rights reserved 2017. Designed by: <a href="#">TourQ MOS Team</a></p>
                    </div><!-- end col -->

                    <div class="col-md-6 text-right hidden-xs">
                        <ul class="list-inline">
                            <li><a href="#" onclick="javascript:nav.pageSubmitFn({'pageName' : 'main', url : 'main.do'})">Home</a></li>
                            <li><a href="#" onclick="javascript:ajaxFooter.hot()">Hot Tour</a></li>
                            <li class="dmtop" id="top" name="top"><a href="#"><i class="fa fa-angle-up"></i></a></li>
                        </ul>
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </div><!-- end copyrights -->
    <!-- end wrapper -->