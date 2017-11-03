<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
var submitStory = {
	
	submitFn: function(courseNumber) {
		
   		$("#storyNumber").val(courseNumber);
   		
	    left.adminSubmitFn('adminStoryDetail','adminStoryDetail.do','storyFrm');
	},
	
   	fnGoPaging : function(page) {
   		
   		$("#page").val(page);
   		
   		left.adminSubmitFn('adminStory','adminStory.do','frmSearchStory');
   	},
   	
	deleteStory : function() {
   		
		var leng = $("#checkbox:checked").length;
		
		if(leng == 0){
			
			alert("데이터를 선택해주세요! 데이터를 선택하지 않으면 안됩니다.");
			
			return;
		}
		
   		if(confirm('선택하신 ' + leng + '개의 코스를 정말로 삭제하시겠습니까?')){
   			
   	   		left.adminSubmitFn('adminStory','adminStoryDelete.do','checkSubmit');
   		}
   	}
}

</script>
<form name="storyFrm" id="storyFrm">
<input type="hidden" name="storyNumber" id="storyNumber">
</form>
<div class="mainbar">
	<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">Story 조회
			  <!-- page meta -->
			  <span class="page-meta">관리자 후기 관리 페이지입니다.</span>
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right widget-head-right">
				<div class="bread-crumb">
				  <a href="#" onclick="left.adminSubmitFn('adminMain', 'adminMain.do', 'frmAdmin')"><i class="fa fa-home"></i> 메인</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">스토리 조회</a>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
		<!-- Breadcrumb -->
			<div class="widget-content">
				<div class="padd">
					
					<div class="col-lg-12">
						<form name="frmSearchStory" id="frmSearchStory">
						<input type="hidden" value="" name="page" id="page">
						</form>
					</div><!-- END ROW -->

				<div class="clearfix"></div>
				</div>
			</div>

		<div class="clearfix"></div>
	</div><!--/ Page heading ends -->
	
	<!-- Matter -->
	<div class="matter">
	
		<div class="col-md-12 widget-top">
			<div class="pull-right">
				<button class="btn btn-xs btn-green pull-left" type="button"
					onclick="javascript:left.adminSubmitFn('adminStoryCreate','adminStoryCreate.do','frmAdmin')"><i class="fa fa-plus"></i> 추가</button>
				<button class="btn btn-xs btn-red pull-left" type="button" onclick="javascript:submitStory.deleteStory()"><i class="fa fa-remove"></i> 삭제</button>
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
								<th>스토리 번호</th>
								<th>제목</th>
								<th>조회수</th>
								<th>Like수</th>
								<th>등록일</th>
								<th>상세보기</th>
							</tr>
						</thead>
							<tbody>
							<form name="checkSubmit" id="checkSubmit">
								<c:forEach items="${storyList}" var="storyList">
									<tr>
										<th><input type='checkbox' class="checkbox" name="checkbox" id="checkbox" value="<c:out value="${storyList.storyNumber}"/>"/></th>
										<td><c:out value="${storyList.storyNumber}"/></td>
										<td><c:out value="${storyList.storyTitle}"/></td>
										<td><c:out value="${storyList.storyCount}"/></td>
										<td><c:out value="${storyList.storyLike}"/></td>
										<td><c:out value="${storyList.storyDate}"/></td>
										<td><button class="btn btn-xs btn-default" type="button" onclick="javascript:submitStory.submitFn(<c:out value="${storyList.storyNumber}"/>)">상세보기</button></td>
									</tr>
								</c:forEach>
							</form>
						</tbody>
					</table>
				</div> 
			</div>
		</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
				<div class="col-md-12 widget-foot">
					<div class="pagination-foot">
						<ul class="pagination">
							<c:if test="${resMap.pageGroup != 1}">
	                            <li><a href="javascript:submitStory.fnGoPaging(1)">&lt;&lt;</a></li>
	               			</c:if>
	               			
	           				<c:if test="${resMap.pageGroup > 1}">
	                            <li><a href="javascript:submitStory.fnGoPaging(<c:out value='${resMap.prePage}'/>)">&lt;</a></li>
	               			</c:if>
	               			
	               			<c:forEach var="i" begin="${resMap.startPage}" 
	               						end="${resMap.endPage > resMap.totalPage ? resMap.totalPage : resMap.endPage}">
	               					
	               				<c:choose>
	               					<c:when test="${resMap.page eq i}">
	               						<li class="active">
	               							<a href="javascript:submitStory.fnGoPaging(${i});">${i}</a>
	               						</li>
	               					</c:when>
	               					<c:otherwise>
	               						<li>
	               							<a href="javascript:submitStory.fnGoPaging(${i});">${i}</a>
	               						</li>
	               					</c:otherwise>
	               				</c:choose>
	               			
	               			</c:forEach>
	               			
	               			<c:if test="${resMap.nextPage <= resMap.totalPage}">
	                           <li><a href="javascript:submitStory.fnGoPaging(<c:out value='${resMap.nextPage}'/>)">&gt;</a></li>
	                        </c:if>
	                        
	                        <c:if test="${resMap.nextPage <= resMap.totalPage}">
		                        <li><a href="javascript:submitStory.fnGoPaging(<c:out value='${resMap.totalPage}'/>)">&gt;&gt;</a></li>
	                        </c:if>
						</ul>                      
						<div class="clearfix"></div> 
					</div>
				</div>
	</div><!--/ Matter ends -->
</div><!--/ Mainbar ends -->