<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

var submitMarker = {
   	
   	submit : function(courseNumber) {
   		
   		$("#courseNumber").val(courseNumber);
   		
	    left.adminSubmitFn('adminMarkerDetail','adminMarkerDetail.do','frmMarker');
   	},
   	
	fnGoPaging : function(page) {
	  		
		$("#page").val(page);
		
		left.adminSubmitFn('adminMarker','adminMarker.do','frmSearchCourse');
	}
};
	
$(document).ready(function(){	
	
	$("#searchTheme").val("<c:out value="${courseVo.searchTheme}"/>");
	$("#searchName").val("<c:out value="${courseVo.searchName}"/>");
});
</script>

<form name="frmMarker" id="frmMarker">
	<input type="hidden" value="" name="courseNumber" id="courseNumber">
</form>

<div class="mainbar">
<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">Marker 조회
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right">
				<div class="bread-crumb">
				  <a href="#" onclick="left.adminSubmitFn('adminMain', 'adminMain.do', 'frmAdmin')"><i class="fa fa-home"></i> 메인</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">마커 관리</a>
				</div>
				<button class="btn btn-default wminimize" type="button"><i class="fa fa-plus"></i> 검색창 보기</button>
			</div>
			<div class="clearfix"></div>
		</div>
		
		<form name="frmSearchCourse" id="frmSearchCourse">
		<input type="hidden" value="" name="page" id="page">
		<input type="hidden" name="isSearch" id="isSearch" value="is">
		<!-- Breadcrumb -->
			<div class="widget-content">
				<div class="padd">
					<div class="col-lg-12">
					    <span class="input-title">테마검색</span>
					    <div class="pull-left col-md-3 btn-select-box">
						    	<div class="select-surch col-md-9">
						    	<select class="selectpicker form-control" data-size="8" data-live-search="false" title="테마" id="searchTheme" name="searchTheme">
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
					    
						<span class="input-title">코스이름</span>
					    <div class="pull-left select-box col-md-4 set-surch btn-select-box">
							<div class="pull-left set-surch-inp col-md-7">
							  <input type="text" class="form-control" id="searchName" name="searchName">
							</div>
							<div class="pull-left">
								<button class="btn btn-default btn-navy" type="button" onClick="javascript:submitMarker.fnGoPaging(1)">검색</button>
							</div>
	
							<div class="clearfix"></div><!-- 플롯해제 -->
						</div><!-- END ROW -->
						<div class="clearfix"></div>
					</div><!-- END ROW -->

				<div class="clearfix"></div>
				</div>
			</div>
			</form>
		
		<div class="clearfix"></div>
	</div><!--/ Page heading ends -->

	<!-- Matter -->
	<div class="matter">
		<div class="container">
			<div class="widget-content medias">
				<div class="table-responsive">
					<table class="table table-bordered ">
						<thead>
							<tr>
							  	<th>코스번호</th>
								<th>버스/도보</th>
								<th>제목</th>
								<th>가격</th>
								<th>소요시간</th>
								<th>테마</th>
								<th>인기상품</th>
								<th>추천상품</th>
								<th>등록일</th>
								<th>상세보기</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${courseList}" var="courseList" varStatus="status">
								<tr>
								  	<td><c:out value="${courseList.courseNumber}"/></td>
									<td><c:out value="${courseList.courseStatus}"/></td>
									<td><c:out value="${courseList.courseTitle}"/></td>
									<td><c:out value="${courseList.coursePrice}"/></td>
									<td><c:out value="${courseList.courseTime}"/></td>
									<td><c:out value="${courseList.themeName}"/></td>
									<td><c:out value="${courseList.popular}"/></td>
									<td><c:out value="${courseList.recommand}"/></td>
									<td><c:out value="${courseList.courseDate}"/></td>
									<td><button class="btn btn-xs btn-default" type="button" onclick="submitMarker.submit(<c:out value="${courseList.courseNumber}"/>)">상세보기</button></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div> 
			</div>
		</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
				<div class="col-md-12 widget-foot">
					<div class="pagination-foot">
						<ul class="pagination">
						  	<c:if test="${resMap.pageGroup != 1}">
	                            <li><a href="javascript:submitMarker.fnGoPaging(1)">&lt;&lt;</a></li>
	               			</c:if>
	               			
	           				<c:if test="${resMap.pageGroup > 1}">
	                            <li><a href="javascript:submitMarker.fnGoPaging(<c:out value='${resMap.prePage}'/>)">&lt;</a></li>
	               			</c:if>
	               			
	               			<c:forEach var="i" begin="${resMap.startPage}" 
	               						end="${resMap.endPage > resMap.totalPage ? resMap.totalPage : resMap.endPage}">
	               					
	               				<c:choose>
	               					<c:when test="${resMap.page eq i}">
	               						<li class="active">
	               							<a href="javascript:submitMarker.fnGoPaging(${i});">${i}</a>
	               						</li>
	               					</c:when>
	               					<c:otherwise>
	               						<li>
	               							<a href="javascript:submitMarker.fnGoPaging(${i});">${i}</a>
	               						</li>
	               					</c:otherwise>
	               				</c:choose>
	               			
	               			</c:forEach>
	               			
	               			<c:if test="${resMap.nextPage <= resMap.totalPage}">
	                           <li><a href="javascript:submitMarker.fnGoPaging(<c:out value='${resMap.nextPage}'/>)">&gt;</a></li>
	                        </c:if>
	                        
	                        <c:if test="${resMap.nextPage <= resMap.totalPage}">
		                        <li><a href="javascript:submitMarker.fnGoPaging(<c:out value='${resMap.totalPage}'/>)">&gt;</a></li>
	                        </c:if>
						</ul>                      
						<div class="clearfix"></div> 
					</div>
				</div>
	</div><!--/ Matter ends -->
</div><!--/ Mainbar ends -->