<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
   <script src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=75506322-1518-31a1-92d2-4ea1768fab15"></script>
   <jsp:include page="/WEB-INF/jsp/egovframework/example/information/localCourseSub.jsp"></jsp:include>
   <script type="text/javascript">
		
        // 하트를 클릭하면 아이콘 클래스가 변하고 db 업데이트
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
        			url: "courseLikeID.do",
        			data: {
        				"gubun" : gubun,
        				"courseNumber" : courseNumber
        				},
        			async: false
        		});
        	}
		}
        
        var submitCourse = {
        	
        	submit : function(courseNumber) {
        		
        		$("#courseNumber").val(courseNumber);
        		
		        nav.pageSubmitFn({pageName: 'seoulro', frmName: 'frmCourse', url: 'seoulro.do'});
        	}
        }
        
        function fnGoPaging (page) {
        	
        	$("#page").val(page);
        	
        	nav.pageSubmitFn({pageName: 'localCourse', frmName: 'searchCourse', url: 'localCourse.do'});
        }
        
        function rank(){
        	
        	var courseNumber = "";
		    <c:forEach items="${courseList}" var="courseList">
		    	
		    courseNumber = "<c:out value="${courseList.courseNumber}"/>";
		    	
		    	$(".rating" + courseNumber).raty({	
				
					score: "<c:out value="${courseList.rank}"/>",
					readOnly: true
				});
		    	$(".rating" + courseNumber).children('img').css("margin", "0");
		    	$(".rating" + courseNumber).children('img').css("width", "14");
		    	$(".rating" + courseNumber).children('img').css("height", "14");
		    </c:forEach>
        }
        $(document).ready(function() {
        	
        	init(); // 초기 지도를 세팅하고 클릭하면 마커 추가
        	
        	$("#searchName").val("<c:out value="${informationCourseVO.searchName}"/>");
        	$("#searchTheme").val("<c:out value="${informationCourseVO.searchTheme}"/>");
        	$("#searchPrice").val("<c:out value="${informationCourseVO.searchPrice}"/>");
        	
        	rank();
		});
    </script>
        <section class="section lb page-title little-pad">
            <div class="container">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2" style="margin-left: 0px; padding-left: 0px">
                        <div class="section-big-title clearfix">                        
                            <h3>도보 여행</h3>
                            <p>서울을 걸어서 즐기세요</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section bb nopad">
            <div class="container-fluid">
                <div class="row">
                    <div class="content half-map-style col-md-6 col-sm-12">
                        <div class="croise-top search-top clearfix">
                            <div class="row">
                            	<form name="searchCourse" id="searchCourse" method="post">
                          		<input id="page" name="page" type="hidden">
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
                                    <a href="#" class="btn btn-primary btn-block" onclick="javascript:fnGoPaging(1)">SEARCH</a>
                                </div>
                                </form>
                            </div>
                        </div><!-- end search-top -->

                        <div class="shop-top row clearfix">
                            <div class="col-md-6 col-sm-6 hidden-xs">
                                <p><strong><c:out value="${courseListCnt.totalTotCnt}"/> Results</strong></p>
                            </div>

                            <!-- <div class="col-md-6 col-sm-6 text-right">
                                <p><a href="#" onclick="resetInput()">Reset all</a> 코스 보기</p>
                            </div> -->
                        </div><!-- end shop-top -->

						<form id="frmCourse" name="frmCourse">
							<input type="hidden" name="courseNumber" id="courseNumber" /> 
						</form>
                        <div class="list-wrapper clearfix">
                            <div class="row">
                             	<c:forEach items="${courseList}" var="courseList" varStatus="status">
	                             	<!-- 홀수번째면 왼쪽, 짝수번째면 오른쪽으로 가게끔 클래스 설정-->
	                             	<c:choose>
	                             		<c:when test="${(status.count%2).equals(1)}">
	                             			<div class="col-md-6 col-sm-6 first">
	                             		</c:when>
	                             		<c:when test="${(status.count%2).equals(0)}">
	                             			<div class="col-md-6 col-sm-6 last">
	                             		</c:when>
	                             	</c:choose>
	                                    <div class="list-item">
			                               	 
	                                        <a href="#" onclick="submitCourse.submit('<c:out value="${courseList.courseNumber}"/>')" title="">
		                                        <div class="entry">
		                                        	<c:if test="${courseList.popular == 'Y'}">
		                                            	<div class="ribbon"><span>POPULAR</span></div>
		                                            </c:if>
		                                            <img src="images/uploads/course/<c:out value="${courseList.courseNumber}"/>_1.jpg" alt="" class="img-responsive">
		                                            <div class="magnifier">
		                                                <div class="magni-desc">
			                                                    <small>${courseList.totCnt} (Reviews)</small>
			                                                <div class="rating${courseList.courseNumber}">
			                                                </div><!-- end rating -->
		                                                </div>
		                                            </div><!-- end magnifier -->
		                                        </div><!-- end entry -->
	
	                                        </a>
	
	                                        <div class="list-desc clearfix">
	                                            <h4><a href="#" title="" onclick="submitCourse.submit('<c:out value="${courseList.courseNumber}"/>')"><c:out value="${courseList.courseTitle}"/></a></h4>
	                                            <ul class="list-inline">
	                                                <li class="small"><c:out value="${courseList.courseSubtitle}"/></li>
	                                            </ul>
	
	                                            <ul class="list-bottom list-inline">
	                                                <li>
	                                                    <sup class="new-price"><c:out value="${courseList.coursePrice}"/>&#8361;</sup>
	                                                </li>
                                               		<a class="courseicon hearticon">
	                                                	<i id="heart${status.count}"
	                                                	<c:if test="${courseList.wish eq 'Y'}">
	                                                		class="fa fa-heart"
	                                                	</c:if>
	                                                	<c:if test="${courseList.wish eq 'N'}">
	                                                		class="fa fa-heart-o"
	                                                	</c:if>
	                                                	onclick="javascript:changeHeart(${status.count}, ${courseList.courseNumber})"></i>
                                                	</a>
	                                            </ul><!-- end list-bottom -->
	                                            
	                                        </div><!-- end list-desc -->
	                                    </div><!-- end list-item -->
	                                </div><!-- end col -->
                                </c:forEach>

                            </div><!-- end row -->
                        </div><!-- end list-wrapper -->
                        
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
                    </div><!-- end col -->

                    <div class="col-md-6 col-sm-12 nopad fixmymap">
                        <div class="similar_map_wrap_container">
        					<div id="map_div"></div>
       					</div>
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end section -->
    </div>
    <!-- end wrapper -->
