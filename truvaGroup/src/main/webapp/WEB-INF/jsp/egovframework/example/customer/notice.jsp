<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

var noticeSubmit = function (boardNumber) {
	
	$("#boardNumber").val(boardNumber);
	
	nav.pageSubmitFn({"pageName" : "noticeDetail", "url" : "noticeDetail.do", "frmName" : "frmNotice"});
};

var fnGoPage = function (page) {
	
	$("#page").val(page);
		
	nav.pageSubmitFn({"pageName" : "notice", "url" : "notice.do", "frmName" : "frmNoticePage"});
}


$(document).ready(function(){	
	
});
</script>

<form id="frmNotice" name="frmNotice">
	<input type="hidden" id="boardNumber" name="boardNumber" /> 
</form>

 <div id="wrapper">
     <section class="section lb page-title little-pad">
         <div class="container">
             <div class="row">
                 <div class="col-md-12">
                     <div class="section-big-title clearfix">
                         <div class="pull-left">
                             <h3>공지사항</h3>
                             <p>TourQ의 소식을 전해드립니다.</p>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
     </section>
     <section class="section">
		<div class="container">
            <div class="col-md-12">
                <div class="content col-md-10 align-center">
	                <table class="cmmn-table notice-table">
	                  <thead>
	                    <tr>
	                      <td>No.</td>
	                      <td>제목</td>
	                      <td>작성일</td>
	                      <td>조회수</td>
	                    </tr>
	                  </thead>
	                  <tbody>
	                  	<c:forEach items="${noticeList}" var="noticeList">
	            			<tr>
		                  		<td><c:out value="${noticeList.seq}"/></td>
		                  		<td><a href="#" onclick="javascript:noticeSubmit(<c:out value="${noticeList.boardNumber}"/>)"><c:out value="${noticeList.boardTitle}"/></a></td>
		                  		<td><c:out value="${noticeList.boardDate}"/></td>
		                  		<td><c:out value="${noticeList.count}"/></td>
	                  		</tr>
	                 	</c:forEach>
	                  </tbody>
	                </table>
            	</div><!-- end col -->
            </div><!-- end row -->
        </div><!-- end container -->
        <div class="container">
			<div class="pagination-foot" style="text-align: center; margin-top: 50px;">
				<ul class="pagination">
					<c:if test="${resMap.pageGroup != 1}">
						<li><a href="javascript:fnGoPage(1)">처음</a></li>
					</c:if>
			
					<c:if test="${resMap.pageGroup > 1}">
						<li><a href="javascript:fnGoPage(<c:out value='${resMap.prePage}'/>)">Prev</a></li>
					</c:if>
					
					<c:forEach var="i" begin="${resMap.startPage}" 
						end="${resMap.endPage > resMap.totalPage ? resMap.totalPage : resMap.endPage}">
					
					<c:choose>
						<c:when test="${resMap.page eq i}">
							<li class="active">
								<a href="javascript:fnGoPage(${i});">${i}</a>
							</li>
							</c:when>
						<c:otherwise>
							<li>
								<a href="javascript:fnGoPage(${i});">${i}</a>
							</li>
						</c:otherwise>
					</c:choose>
					
					</c:forEach>
					
					<c:if test="${resMap.nextPage <= resMap.totalPage}">
						<li><a href="javascript:fnGoPage(<c:out value='${resMap.nextPage}'/>)">Next</a></li>
					</c:if>
					
					<c:if test="${resMap.nextPage <= resMap.totalPage}">
						<li><a href="javascript:fnGoPage(<c:out value='${resMap.totalPage}'/>)">맨뒤</a></li>
					</c:if>
				</ul>                      
				<div class="clearfix"></div> 
			</div>
		</div>
     </section><!-- end section -->
    <form name="frmNoticePage" id="frmNoticePage">
		<input type="hidden" value="" name="page" id="page">\
	</form>
</div>
