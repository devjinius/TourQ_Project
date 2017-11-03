<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

    <script type="text/javascript">
    
    <c:forEach items="${markerList}" var="markerList" varStatus="status">
	var courseNumber = '<c:out value="${markerList.courseNumber}"/>';
	</c:forEach>
        $(document).ready(function() {
			
        	// 마커 이미지의 개수만큼 for문을 돈다.
        	for(var i=0; i < $(".mapimg").length; i++){
        		
        		// 화면의 마커 img태그를 돌면서 저장되어있는 사진을 하나씩 가져와 넣는다.
	        	$(".mapimg").eq(i).attr('src', 'images/markerImage/'+courseNumber+'_'+ (i+1) +'.jpg');
        	}
        	
		});
    </script>
                                        <div id="menu02" class="tab-pane fade">
                                            <div class="list-desc clearfix">
	                                            <div class="detail">                                            	
													<h3>코스 내 주요 관광 명소</h3>
													<c:forEach items="${markerList}" var="markerList" varStatus="status">
														<!-- markerType이 0과 6(출발지와 도착지)가 아닌 경유지인경우 출력! -->
														<c:if test="${markerList.markerType != 0 and markerList.markerType != 6}">
			                                                <div class="hotel-nini-title">
			                                                    <h4><c:out value="${markerList.markerName}"></c:out></h4>
			                                                </div>
			                                                <div class="row">
					                                            <div class="col-md-5 col-sm-5">
					                                               <div class="list-item">
				                                                       <p><img src="" alt="" class="img-responsive mapimg"></p>
					                                               </div>
					                                            </div>
			                                                	<p><c:out value="${markerList.markerContents}"></c:out></p>
					                                        </div>
														</c:if>
			                                        </c:forEach>

                                                </div>
                                            </div>
                                        </div>