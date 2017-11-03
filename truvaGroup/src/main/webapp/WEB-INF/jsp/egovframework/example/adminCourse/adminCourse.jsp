<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>

var submitCourse = {
        	
   	submit : function(courseNumber) {
   		
   		$("#courseNumber").val(courseNumber);
   		
	    left.adminSubmitFn('adminCourseDetail','adminCourseDetail.do','frmCourse');
   	},
   	
   	check : function(gubun) {
   		
		$("#gubun").val(gubun);
		
		if($("#checkbox:checked").length == 0){
			
			alert("데이터를 선택해주세요! 데이터를 선택하지 않으면 안됩니다.");
			
			return;
		}
		
   		left.adminSubmitFn('adminCourse','adminCourse.do','checkSubmit');
   	},
   	
   	fnGoPaging : function(page) {
   		
   		$("#page").val(page);
   		
   		left.adminSubmitFn('adminCourse','adminCourse.do','frmSearchCourse');
   	},
   	
   	deleteCourse : function() {
   		
		var leng = $("#checkbox:checked").length;
		
		if(leng == 0){
			
			alert("데이터를 선택해주세요! 데이터를 선택하지 않으면 안됩니다.");
			
			return;
		}
		
   		if(confirm('선택하신 ' + leng + '개의 코스를 정말로 삭제하시겠습니까?')){
   			
   	   		left.adminSubmitFn('adminCourse','adminCourseDelete.do','checkSubmit');
   		}
   	}
}

$(document).ready(function () {
	
	$("#searchTheme").val("<c:out value="${courseVo.searchTheme}"/>");
	$("#searchName").val("<c:out value="${courseVo.searchName}"/>");
	
	if("<c:out value="${notRec}"/>" != "") {
		
		alert("<c:out value="${notRec}"/>");
	}
});
</script>
<form name="frmCourse" id="frmCourse">
	<input type="hidden" value="" name="courseNumber" id="courseNumber">
</form>

<div class="mainbar">
	<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">Course 관리
			  <!-- page meta -->
			  <span class="page-meta">투어상품 관리 및 수정</span>
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right widget-head-right">
				<div class="bread-crumb">
				  <a href="#" onclick="left.adminSubmitFn('adminMain', 'adminMain.do', 'frmAdmin')"><i class="fa fa-home"></i> 메인</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">코스 관리</a>
				</div>
				<button class="btn btn-default wminimize" type="button"><i class="fa fa-plus"></i> 검색창 보기</button>
			</div>
			<div class="clearfix"></div>
		</div>
		
		<form name="frmSearchCourse" id="frmSearchCourse">
		<input type="hidden" name="isSearch" id="isSearch" value="is">
		<!-- Breadcrumb -->
			<div class="widget-content">
				<div class="padd">
					<div class="col-lg-12">
						<input type="hidden" value="" name="page" id="page">
					
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
								<button class="btn btn-default btn-navy" type="button" onClick="javascript:submitCourse.fnGoPaging(1)">검색</button>
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
	
		<div class="col-md-12 widget-top">
			<div class="pull-left">
				<button class="btn btn-xs btn-navy pull-left" type="button"  onclick="window.print()"><i class="fa fa-print"></i> PRINT</button>
			</div>
			<div class="pull-right">
				<button class="btn btn-xs btn-green pull-left" type="button" onclick="javascript:left.adminSubmitFn('adminCourseCreate','adminCourseCreate.do','frmAdmin')">
					<i class="fa fa-plus"></i> 추가
				</button>
				<button class="btn btn-xs btn-red pull-left" onclick="javascript:submitCourse.deleteCourse()">
					<i class="fa fa-trash-o"></i> 삭제
				</button>
				<button class="btn btn-xs btn-yellow pull-left" type="button" onclick="javascript:submitCourse.check('P')">
					<i class="fa fa-comments"></i> 인기
				</button>
				<button class="btn btn-xs btn-yellow pull-left" onclick="javascript:submitCourse.check('R')">
					<i class="fa fa-paperclip"></i> 추천
				</button>
			</div>
			<div class="clearfix"></div>
		</div>
		
		<div class="container">
			<div class="widget-content medias">
				<div class="table-responsive">
					<table class="table table-bordered ">
						<thead>
							<tr>
								<th></th>
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
						<form name = "checkSubmit" id="checkSubmit">
						<input type="hidden" name="gubun" id="gubun">
						<tbody>
							<c:forEach items="${courseList}" var="courseList" varStatus="status">
								<tr>
									<th><input type='checkbox' class="checkbox" name="checkbox" id="checkbox" value="<c:out value="${courseList.courseNumber}"/>"/></th>
								  	<td><c:out value="${courseList.courseNumber}"/></td>
									<td><c:out value="${courseList.courseStatus}"/></td>
									<td><c:out value="${courseList.courseTitle}"/></td>
									<td><c:out value="${courseList.coursePrice}"/></td>
									<td><c:out value="${courseList.courseTime}"/></td>
									<td><c:out value="${courseList.themeName}"/></td>
									<td><c:out value="${courseList.popular}"/></td>
									<td><c:out value="${courseList.recommand}"/></td>
									<td><c:out value="${courseList.courseDate}"/></td>
									<td><button class="btn btn-xs btn-default" type="button" onclick="submitCourse.submit(<c:out value="${courseList.courseNumber}"/>)">상세보기</button></td>
								</tr>
							</c:forEach>
						</tbody>
						</form>
					</table>
				</div> 
			</div>
		</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
				<div class="col-md-12 widget-foot">
					<div class="pagination-foot">
						<ul class="pagination">
							<c:if test="${resMap.pageGroup != 1}">
	                            <li><a href="javascript:submitCourse.fnGoPaging(1)">&lt;&lt;</a></li>
	               			</c:if>
	               			
	           				<c:if test="${resMap.pageGroup > 1}">
	                            <li><a href="javascript:submitCourse.fnGoPaging(<c:out value='${resMap.prePage}'/>)">&lt;</a></li>
	               			</c:if>
	               			
	               			<c:forEach var="i" begin="${resMap.startPage}" 
	               						end="${resMap.endPage > resMap.totalPage ? resMap.totalPage : resMap.endPage}">
	               					
	               				<c:choose>
	               					<c:when test="${resMap.page eq i}">
	               						<li class="active">
	               							<a href="javascript:submitCourse.fnGoPaging(${i});">${i}</a>
	               						</li>
	               					</c:when>
	               					<c:otherwise>
	               						<li>
	               							<a href="javascript:submitCourse.fnGoPaging(${i});">${i}</a>
	               						</li>
	               					</c:otherwise>
	               				</c:choose>
	               			
	               			</c:forEach>
	               			
	               			<c:if test="${resMap.nextPage <= resMap.totalPage}">
	                           <li><a href="javascript:submitCourse.fnGoPaging(<c:out value='${resMap.nextPage}'/>)">&gt;</a></li>
	                        </c:if>
	                        
	                        <c:if test="${resMap.nextPage <= resMap.totalPage}">
		                        <li><a href="javascript:submitCourse.fnGoPaging(<c:out value='${resMap.totalPage}'/>)">&gt;&gt;</a></li>
	                        </c:if>
						</ul>                      
						<div class="clearfix"></div> 
					</div>
				</div>
	</div><!--/ Matter ends -->
</div><!--/ Mainbar ends -->