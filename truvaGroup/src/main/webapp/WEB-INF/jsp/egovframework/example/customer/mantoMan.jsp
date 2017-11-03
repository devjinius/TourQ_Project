<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
thead tr th {
	text-align: center;
}
</style>
<script type="text/javascript">

var submitNumber = {
	       
        submit : function(number) {
           
           $("#number").val(number);
           
           submitNumber.submitFn('mantoMan','mantoMan.do','frmNumber');
         
        },
        
		submitFn	: function(adminPageName, url, frmadmin) {
			
			$("#adminPageName").val(adminPageName);
			$("#"+frmadmin).attr("action", url);
			$("#"+frmadmin).submit();
		},
}	

</script>

     <section class="section lb page-title little-pad">
         <div class="container">
             <div class="row">
                 <div class="col-md-12">
                     <div class="section-big-title clearfix">
                         <div class="pull-left">
                             <h3>1:1 문의</h3>
                             <p>안내사항을 안내해 드립니다.</p>
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
                                 <th>번호</th>
                                 <th>제목</th>
                                 <th>내용</th>
                                 <th>작성일</th>
                               </tr>
                             </thead>
                             <tbody>
                             	  <c:forEach items="${MantoManList}" var="MantoManList" varStatus="status">
                           			<tr onclick="javascript:submitNumber.submit('<c:out value="${MantoManList.boardNumber}"/>')">
	                               		<td><c:out value="${MantoManList.boardNumber}"/></td>
	                               		<td><c:out value="${MantoManList.boardTitle}"/></td>
	                               		<td><c:out value="${MantoManList.boardContent}"/></td>
	                               		<td><c:out value="${MantoManList.boardDate}"/></td>
	                               	</tr>
                          		  </c:forEach>
                                
                             </tbody>
                         </table>
                      </div><!-- end wrap -->
                 </div>
                 <br>
                 <br>
                 <div class="row">
                 	 <div class="align-center">
					         <ul class="pagination">
					            <li class="disabled"><a href="javascript:void(0)">&laquo;</a></li>
					            <li class="active"><a href="javascript:void(0)">1</a></li>
					            <li><a href="javascript:void(0)">2</a></li>
					            <li><a href="javascript:void(0)">3</a></li>
					            <li><a href="javascript:void(0)">...</a></li>
					            <li><a href="javascript:void(0)">&raquo;</a></li>
					         </ul>
			         </div>
		         </div>
		         <br>
			     <div class="col-md-12">
			     	 <form class="contact-form search-top">
				  		 <input type="button" class="btn btn-primary" value="처음으로" onclick="" style="margin-right: 350px;"/>
					     <input type="text" class="span2">
					     <button type="submit" class="btn btn-primary">검색</button>
					     <input type="button" class="btn btn-primary" value="글쓰기" onclick="javascript:nav.pageSubmitFn({pageName: 'createAsk', frmName: 'frm', url: 'createAsk.do'})" align="right"><!--정렬 왜 안먹힐까-->
					     
					 </form>
			     </div>
          </div>
     </section><!-- end section -->

	