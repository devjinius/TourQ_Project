<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
var main = {
		
	submitCourse : function(courseNumber) {
		
		$("#courseNumber").val(courseNumber);
		
		nav.pageSubmitFn({pageName: 'seoulro', frmName: 'mainFrm', url: 'seoulro.do'});
	},
	
	rank : function() {
		
		var courseNumber = "";
	    <c:forEach items="${recList}" var="recList">
	    	
	    courseNumber = "<c:out value="${recList.courseNumber}"/>";
	    	
	    	$(".rating" + courseNumber).raty({	
			
				score: "<c:out value="${recList.rank}"/>",
				readOnly: true
			});
	    	$(".rating" + courseNumber).children('img').css("margin", "0");
	    	$(".rating" + courseNumber).children('img').css("width", "14");
	    	$(".rating" + courseNumber).children('img').css("height", "14");
	    </c:forEach>
	},
	
	recommend : function () {
		
		if ("<c:out value="${param.pageNameRec}"/>" == "recommend") {
			
// 			var offset = $("#recommendation").offset();
			var offset = 760;
	        $('html, body').animate({scrollTop : offset}, 1000);
		} else if ("<c:out value="${param.pageNameRec}"/>" == "hot") {
			
			var offset = 2115.25;
	        $('html, body').animate({scrollTop : offset}, 1000);
		}
	} 
}

// 하트를 클릭하면 아이콘 클래스가 변하고 db가 업데이트
function changeHeart(id, courseNumber){
	
	var memberNumber = "<c:out value="${sessionScope.memberSession.memberNumber}"/>";
	// 세션에 회원이 없으면 얼럿 띄우고 로그인 페이지로 이동
	if(memberNumber==""){
		
		alert("회원만 이용할 수 있습니다");
		nav.pageSubmitFn({pageName: "login", url: "memberLogin.do"});

		// 그렇지 않고 세션값이 있으면
	} else {
		
    	var $heartid = $("#heart"+id);
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
			url: "mainLikeID.do",
			data: {
				"gubun" : gubun,
				"courseNumber" : courseNumber
				},
			async: false
		});
	}z
}

$(document).ready(function() {
	
	main.rank();
	main.recommend();
});
</script>
<form name = "mainFrm" id ="mainFrm">
<input type="hidden" name="courseNumber" id="courseNumber">
</form>
        <section class="slider-section">
           <div class="tp-banner-container">
                <div class="tp-banner">
                    <ul>
                        <li data-transition="fade" data-slotamount="1" data-masterspeed="500" data-thumb="images/uploads/slider_01.jpg"  data-saveperformance="off"  data-title="Next">
                            <img src="images/uploads/slider_02.jpg"  alt="fullslide1"  data-bgposition="center top" data-bgfit="cover" data-bgrepeat="no-repeat">
                            <div class="tp-caption slider_layer_02 text-center lft tp-resizeme"
                                data-x="center"
                                data-y="290" 
                                data-speed="1000"
                                data-start="800"
                                data-easing="Power3.easeInOut"
                                data-splitin="none"
                                data-splitout="none"
                                data-elementdelay="0.1"
                                data-endelementdelay="0.1"
                                data-endspeed="1000"
                                style="z-index: 9; max-width: auto; max-height: auto; white-space: nowrap;">오픈기념 
                            </div>
                            <div class="tp-caption slider_layer_01 text-center lft tp-resizeme"
                                data-x="center"
                                data-y="365" 
                                data-speed="1000"
                                data-start="1200"
                                data-easing="Power3.easeInOut"
                                data-splitin="none"
                                data-splitout="none"
                                data-elementdelay="0.1"
                                data-endelementdelay="0.1"
                                data-endspeed="1000"
                                style="z-index: 9; max-width: auto; max-height: auto; white-space: nowrap;"
                                onclick="javascript:nav.pageSubmitFn('Event', 'frm')">
                               <a href="#"  >여름시즌 25% 대박 세일</a>
                            </div>
                            
                        </li>
                        <li data-transition="fade" data-slotamount="1" data-masterspeed="500" data-thumb="images/uploads/slider_02.jpg"  data-saveperformance="off"  data-title="Next">
                            <img src="images/uploads/slider_03.jpg"  alt="fullslide1"  data-bgposition="center top" data-bgfit="cover" data-bgrepeat="no-repeat">
                            <div class="tp-caption slider_layer_02 text-center lft tp-resizeme"
                                data-x="center"
                                data-y="290" 
                                data-speed="1000"
                                data-start="800"
                                data-easing="Power3.easeInOut"
                                data-splitin="none"
                                data-splitout="none"
                                data-elementdelay="0.1"
                                data-endelementdelay="0.1"
                                data-endspeed="1000"
                                style="z-index: 9; max-width: auto; max-height: auto; white-space: nowrap;">경복궁에 즐기는 데이트
                            </div>
                            <div class="tp-caption slider_layer_01 text-center lft tp-resizeme"
                                data-x="center"
                                data-y="365" 
                                data-speed="1000"
                                data-start="1200"
                                data-easing="Power3.easeInOut"
                                data-splitin="none"
                                data-splitout="none"
                                data-elementdelay="0.1"
                                data-endelementdelay="0.1"
                                data-endspeed="1000"
                                style="z-index: 9; max-width: auto; max-height: auto; white-space: nowrap;">경복궁 이벤트 안내!
                                <a href="#"  onclick="javascript:nav.pageSubmitFn('Event', 'frm')">&nbsp</a>
                            </div>
                           
                        </li>
                        
                        <li data-transition="fade" data-slotamount="1" data-masterspeed="500" data-thumb="images/uploads/slider_03.jpg"  data-saveperformance="off"  data-title="Next">
                            <img src="images/uploads/slider_04.jpg"  alt="fullslide1"  data-bgposition="center top" data-bgfit="cover" data-bgrepeat="no-repeat">
                            <div class="tp-caption slider_layer_02 text-center lft tp-resizeme"
                                data-x="center"
                                data-y="290" 
                                data-speed="1000"
                                data-start="800"
                                data-easing="Power3.easeInOut"
                                data-splitin="none"
                                data-splitout="none"
                                data-elementdelay="0.1"
                                data-endelementdelay="0.1"
                                data-endspeed="1000"
                                style="z-index: 9; max-width: auto; max-height: auto; white-space: nowrap;">아름다운 야경 보러 오세요
                            </div>
                            <div class="tp-caption slider_layer_01 text-center lft tp-resizeme"
                                data-x="center"
                                data-y="365" 
                                data-speed="1000"
                                data-start="1200"
                                data-easing="Power3.easeInOut"
                                data-splitin="none"
                                data-splitout="none"
                                data-elementdelay="0.1"
                                data-endelementdelay="0.1"
                                data-endspeed="1000"
                                style="z-index: 9; max-width: auto; max-height: auto; white-space: nowrap;">청계천 야간투어
                                <a href="#" onclick="javascript:nav.pageSubmitFn('Event', 'frm')">&nbsp</a> 
                            </div>
                           
                        </li>
                        <li data-transition="fade" data-slotamount="1" data-masterspeed="500" data-thumb="images/uploads/slider_04.jpg"  data-saveperformance="off"  data-title="Next">
                            <img src="images/uploads/slider_05.jpg"  alt="fullslide1"  data-bgposition="center top" data-bgfit="cover" data-bgrepeat="no-repeat">
                            <div class="tp-caption slider_layer_02 text-center lft tp-resizeme"
                                data-x="center"
                                data-y="290" 
                                data-speed="1000"
                                data-start="800"
                                data-easing="Power3.easeInOut"
                                data-splitin="none"
                                data-splitout="none"
                                data-elementdelay="0.1"
                                data-endelementdelay="0.1"
                                data-endspeed="1000"
                                style="z-index: 9; max-width: auto; max-height: auto; white-space: nowrap;">남산 놀러 가자
                            </div>
                            <div class="tp-caption slider_layer_01 text-center lft tp-resizeme"
                                data-x="center"
                                data-y="365" 
                                data-speed="1000"
                                data-start="1200"
                                data-easing="Power3.easeInOut"
                                data-splitin="none"
                                data-splitout="none"
                                data-elementdelay="0.1"
                                data-endelementdelay="0.1"
                                data-endspeed="1000"
                                style="z-index: 9; max-width: auto; max-height: auto; white-space: nowrap;">케이블카 이용 무료!!
                                <a href="#" onclick="javascript:nav.pageSubmitFn('Event', 'frm')"></a>
                            </div>
                           
                        </li>
                        <li data-transition="fade" data-slotamount="1" data-masterspeed="500" data-thumb="images/uploads/slider_05.jpg"  data-saveperformance="off"  data-title="Next">
                            <img src="images/uploads/slider_01.jpg"  alt="fullslide1"  data-bgposition="center top" data-bgfit="cover" data-bgrepeat="no-repeat">
                            <div class="tp-caption slider_layer_02 text-center lft tp-resizeme"
                                data-x="center"
                                data-y="290" 
                                data-speed="1000"
                                data-start="800"
                                data-easing="Power3.easeInOut"
                                data-splitin="none"
                                data-splitout="none"
                                data-elementdelay="0.1"
                                data-endelementdelay="0.1"
                                data-endspeed="1000"
                                style="z-index: 9; max-width: auto; max-height: auto; white-space: nowrap;">남한산성에 보는 야경이 그렇게 이쁘다며?!
                            </div>
                            <div class="tp-caption slider_layer_01 text-center lft tp-resizeme"
                                data-x="center"
                                data-y="365" 
                                data-speed="1000"
                                data-start="1200"
                                data-easing="Power3.easeInOut"
                                data-splitin="none"
                                data-splitout="none"
                                data-elementdelay="0.1"
                                data-endelementdelay="0.1"
                                data-endspeed="1000"
                                style="z-index: 9; max-width: auto; max-height: auto; white-space: nowrap;">남한 산성 야간 투어 이벤트
                                <a href="#" onclick="javascript:nav.pageSubmitFn('Event', 'frm')"></a>
                            </div>
                            
                        </li>
                    </ul>
                </div>
            </div>

            <div class="custom-search-wrapper">
                <div class="container">
                   	<form name="searchCourse" id="searchCourse">
                   	<input type="hidden" name="isSearch" id="isSearch" value="is">
                    	<div class="croise-top search-top clearfix">
                        	<div class="row">
                        
                            	<div class="col-sm-3">
                             		<div class="form-group"> 
                                 	<input type="text" name="searchName" id="searchName" placeholder="코스이름" class="form-control customform" style="height: 40px;">
                             		</div>
                            	</div>

                             	<div class="col-sm-3">
                                	<div class="form-group">
                                    	<select class="selectpicker form-control" name="searchTheme" id="searchTheme" data-size="8" data-live-search="false" title="테마">
                                    		<optgroup label="도보">
	                                            <c:forEach items="${themeList}" var="themeList">
   	                                        		<c:if test="${themeList.themeType == '도보'}">
						 								<option value="<c:out value="${themeList.themeNumber}"/>"><c:out value="${themeList.themeName}"/></option>
           	                                		</c:if>
												</c:forEach>
			    							</optgroup>
			    							<optgroup label="버스">
	                                            <c:forEach items="${themeList}" var="themeList">
				    								<c:if test="${themeList.themeType == '버스'}">
						 								<option value="<c:out value="${themeList.themeNumber}"/>"><c:out value="${themeList.themeName}"/></option>
           		                               		</c:if>
												</c:forEach>
											</optgroup>
                                     	</select>
                                 	</div>
                             	</div>

                             	<div class="col-sm-3">
                                	<div class="form-group">
                                    	<select class="selectpicker form-control" id="searchPrice" name="searchPrice" data-size="8" data-live-search="false" title="가격">
                                        	<option value="2">3만원 미만</option>
	                                         <option value="3">3~6만원</option>
	                                         <option value="6">6~10만원</option>
	                                         <option value="10">10만원 이상</option>
	                                    </select>
	                                </div>
	                            </div>

                             	<div class="col-sm-3">
                                	<a href="#" class="btn btn-primary btn-block" onclick="javascript:nav.pageSubmitFn({pageName: 'localCourse', frmName: 'searchCourse', url: 'localCourse.do'});">SEARCH</a>
                             	</div>
                        	</div>
	                    </div><!-- end search-top -->
                    </form>
                </div><!-- end container -->
            </div><!-- end search -->
        </section><!-- end slider-wrapper --> 

        <section class="section" id="recommendation">
            <div class="container">
                <div class="section-big-title text-center">
                    <h2><strong><font color="#f18167">TourQ</font> 추천코스</strong> </h2>
                    <p>TourQ가 제안하는 추천코스 입니다.</p>                    
                </div><!-- end title --> 
                <div class="row">
                    <div class="col-md-12">
                        <div class="content grid-map-style">
                            <div class="list-wrapper clearfix">
                            <c:forEach items="${recList}" var="recList" varStatus="status">
                            <c:if test="${status.count == 4 || status.first}"><div class="row"></c:if>
                            			<div class="col-md-4 wow fadeIn" data-wow-duration="1s" data-wow-delay="0.2s">
                             			<div class="list-three-item cruise-list">
	                                    <div class="list-item">
			                               	 
	                                        <a href="#" onclick="main.submitCourse('<c:out value="${recList.courseNumber}"/>')" title="">
		                                        <div class="entry">
		                                        	<c:if test="${recList.popular == 'Y'}">
		                                            	<div class="ribbon"><span>POPULAR</span></div>
		                                            </c:if>
		                                            <img src="images/uploads/course/<c:out value="${recList.courseNumber}"/>_1.jpg" alt="" class="img-responsive">
		                                            <div class="magnifier">
		                                                <div class="magni-desc">
			                                                    <small>${recList.totCnt} (Reviews)</small>
			                                                <div class="rating${recList.courseNumber}">
			                                                </div><!-- end rating -->
		                                                </div>
		                                            </div><!-- end magnifier -->
		                                        </div><!-- end entry -->
	
	                                        </a>
	
	                                        <div class="list-desc clearfix">
	                                            <h4><a href="#" title="" onclick="main.submitCourse('<c:out value="${recList.courseNumber}"/>')"><c:out value="${recList.courseTitle}"/></a></h4>
	                                            <ul class="list-inline">
	                                                <li class="small"><c:out value="${recList.courseSubtitle}"/></li>
	                                            </ul>
	
	                                            <ul class="list-bottom list-inline">
	                                                <li>
	                                                    <sup class="new-price"><c:out value="${recList.coursePrice}"/>&#8361;</sup>
	                                                </li>
													<a class="courseicon hearticon">
	                                                	<i id="heart${status.count}"
                                                		<c:if test="${recList.wish eq 'Y'}">
	                                                		class="fa fa-heart"
	                                                	</c:if>
	                                                	<c:if test="${recList.wish eq 'N'}">
	                                                		class="fa fa-heart-o"
	                                                	</c:if>
	                                                	onclick="javascript:changeHeart(${status.count}, ${recList.courseNumber})"></i>
                                                	</a>
                                                </ul><!-- end list-bottom -->
	                                            </div>
	                                        </div><!-- end list-desc -->
	                                    </div><!-- end list-item -->
	                                </div><!-- end col -->
                                    
                                    <c:if test="${status.count == 3 || status.last}"></div></c:if>
	                                <c:if test="${status.count==3}"><hr class="invis1"></c:if>
                            </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <div class="parallax section"  style="background-image:url('images/uploads/parallax_04.jpg');">
            <div class="calloutbox">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-10 col-md-offset-1 text-center">
                            <h2>서울을 더 재미있게 <strong>즐겨보세요.</strong> </h2>
                            <p>"혼자서는 재미없잖아요. 전문가와 함께 여럿이서 같이 즐기는 서울여행"</p>
                        </div>
                    </div><!-- end row -->
                </div>
            </div><!-- end messagebox -->
        </div><!-- end section -->

        <section class="section"  id="hotTour">
            <div class="container">
                <div class="section-big-title text-center">
                    <h3><strong><font color="#f18167">TourQ </font>의 HOT 투어!</strong></h3>
                    <p>코스를 고르기 어렵다면 핫한 코스로 갑시다</p>
                </div><!-- end title --> 
                <div class="row">
                
                    <div class="col-md-12">
                        <div class="content grid-map-style">
                            <div class="list-wrapper clearfix">
                                <div class="row">
                                
	                                <c:forEach items="${courseList}" var="courseList" varStatus="status">
		                                
										<div class="col-md-6 col-sm-6 
											<c:if test="${status.first}">
												first
											</c:if>
											<c:if test="${status.last}">
												last
											</c:if>
										">
										
	                                    <div class="list-item">
		                                        <a href="#" onclick="main.submitCourse('<c:out value="${courseList.courseNumber}"/>')" title="">
		                                        
			                                        <div class="entry">
			                                        	<c:if test="${courseList.popular == 'Y'}">
			                                            	<div class="ribbon"><span>POPULAR</span></div>
			                                            </c:if>
			                                            <img src="images/uploads/course/<c:out value="${courseList.courseNumber}"/>_1.jpg" alt="" class="img-responsive">
			                                            <div class="magnifier">
			                                                <div class="magni-desc">
				                                                <div class="rating">
				                                                    <small>24 (Reviews)</small>
				                                                    <i class="fa fa-star"></i>
				                                                    <i class="fa fa-star"></i>
				                                                    <i class="fa fa-star"></i>
				                                                    <i class="fa fa-star"></i>
				                                                    <i class="fa fa-star"></i>
				                                                </div><!-- end rating -->
			                                                </div>
			                                            </div><!-- end magnifier -->
			                                        </div><!-- end entry -->
		
		                                        </a>
		
		                                        <div class="list-desc clearfix">
		                                            <h4><a href="#" title="" onclick="main.submitCourse('<c:out value="${courseList.courseNumber}"/>')"><c:out value="${courseList.courseTitle}"/></a></h4>
		                                            <ul class="list-inline">
		                                                <li class="small"><c:out value="${courseList.courseSubtitle}"/></li>
		                                            </ul>
		
		                                            <ul class="list-bottom list-inline">
		                                                <li>
		                                                    <sup class="new-price"><c:out value="${courseList.coursePrice}"/>&#8361;</sup>
		                                                </li>
		                                            </ul><!-- end list-bottom -->
		                                        </div><!-- end list-desc -->
		                                    </div><!-- end list-item -->
		                                </div><!-- end col -->
	                            	</c:forEach>
                                </div><!-- end row -->
                            </div><!-- end list-wrapper -->
                        </div><!-- end grid -->
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end section -->
        <div id="main"></div><!-- 메뉴 바 투명을 위한 코드 -->
