<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

    <script type="text/javascript">
        $(document).ready(function() {
		});
    </script>

                                  		<div id="menu01" class="tab-pane fade in active">
                                            <div class="hotel-informations clearfix">
	                                            <div class="detail">
	                                            	<c:forEach items="${courseList}" var="courseList" varStatus="status">
		                                                <div class="hotel-nini-title">
		                                                    <h3><c:out value="${courseList.courseTitle}"/></h3>
		                                                </div>
		                                               		<p><c:out value="${courseList.courseContents}"/></p>
		                                                                                                
		                                                <div class="hotel-nini-title">
		                                                    <h3>코스안내</h3>
		                                                </div>
		                                                
		    	                                            <h4>코스 세부 내역</h4>
															<p><c:out value="${courseList.courseDetail}"/></p>
																
															<h4>소요시간</h4>
															<p><c:out value="${courseList.courseTime}"/></p>
															
															<h4>출발시간</h4>
															<p><c:out value="${courseList.courseStartTime}"/></p>
															
															<h4>테마</h4>
															<p>테마코스</p>
			
															<h4>만남장소 </h4>
															<p><c:out value="${courseList.coursePlace}"/></p>
															
															<p>※ 관광코스에 포함되어 있지 않는 체험프로그램은 관광 종료 후, 개별적으로 체험 해주시기 바랍니다.</p>
													</c:forEach>
												</div>
                                            </div>
                                        </div>