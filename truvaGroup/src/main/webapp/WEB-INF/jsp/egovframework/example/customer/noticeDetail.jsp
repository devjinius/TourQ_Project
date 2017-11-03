<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
pageContext.setAttribute("cr", "\r");
pageContext.setAttribute("cn", "\n");
pageContext.setAttribute("crcn", "\r\n");
pageContext.setAttribute("br", "");
%> 
 
<!-- jstl로 변환처리 -->
<c:set var="cmt" value="${fn:replace(noticeDetail.boardContent,crcn,br)}" />
<c:set var="cmt" value="${fn:replace(cmt,cr,br)}" />
<c:set var="cmt" value="${fn:replace(cmt,cn,br)}" />
<script type="text/javascript">
$(document).ready(function(){	
	
});
</script>

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
				<h5><b class="post-title"><c:out value="${noticeDetail.boardTitle}"/></b><b class="post-info">작성일 : <c:out value="${noticeDetail.boardDate}"/> <b>|</b> 조회수 : <c:out value="${noticeDetail.count}"/></b></h5>                 
				<hr>
				<c:out value="${cmt}"  escapeXml="false" />
         </div><!-- end container -->
     </section><!-- end section -->
</div>
