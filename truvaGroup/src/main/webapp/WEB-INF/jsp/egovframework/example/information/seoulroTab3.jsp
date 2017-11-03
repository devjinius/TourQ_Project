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
pageContext.setAttribute("br", "<br>");
%> 
 
<script type="text/javascript">


function fnGoPaging (page) {
	
	$("#page").val(page);
	$("#courseNumber").val("<c:out value="${param.courseNumber}"/>");
	nav.pageSubmitFn({pageName: 'seoulro', frmName: 'seoulroFrm', url: 'seoulro.do'});
};
    
function rank(){
	var reviewNumber = "";
    <c:forEach items="${reviewList}" var="reviewList">
    	
    reviewNumber = "<c:out value="${reviewList.reviewNumber}"/>";
    	
    	$(".rating" + reviewNumber).raty({	
		
			score: "<c:out value="${reviewList.reviewRank}"/>",
			readOnly: true
		});
    	$(".rating" + reviewNumber).children('img').css("margin", "0");
    </c:forEach>
}
$(document).ready(function() {
	
	rank();
	
	//리뷰 페이징을 통해 들어왔다면
	if("<c:out value="${param.page}" />" != "") {
		
		//li 클래스 active로 하이라이트 처리	
		$(".nav-tabs").children().each(function() {
			
			$(this).removeClass("active");
			$(this).children('a').attr("aria-expanded", "false");
			
			if($(this).attr("id") == "reviewTab"){
				
		    	$(this).addClass("active");
				$(this).children('a').attr("aria-expanded", "true");
			}
		})
		
		//contents 부분을 다 지운 뒤 메뉴3(review)을 보이게한다.
		$("[id*='menu0'] ").removeClass("active in");
		$("#menu03").addClass("active in");
	}
});
</script>

<form name="seoulroFrm" id="seoulroFrm">
<input type="hidden" name="courseNumber" id="courseNumber">
<input type="hidden" name="page" id="page">
</form>
                                        <div id="menu03" class="tab-pane fade">                                        	
                                            <div class="car-details-box clearfix">
                                                <span class="car-single-title">
                                                    <i class="flaticon-avatar"></i> Reviews (${resMap.totalCnt})<br>
                                                </span>
                                                <span>
													총점 : ${resMap.totRank} / 5
                                                </span>

                                                <div class="comments-list">
                                                
                                                	<c:forEach items="${reviewList}" var="reviewList">
                                                		<!-- jstl로 변환처리 -->
														<c:set var="cmt" value="${fn:replace(reviewList.reviewContents,crcn,br)}" />
														<c:set var="cmt" value="${fn:replace(cmt,cr,br)}" />
														<c:set var="cmt" value="${fn:replace(cmt,cn,br)}" />
                                                	
	                                                    <div class="media">
	                                                        <p class="pull-right"><small>${reviewList.reviewDate}</small></p>
	                                                        <div class="media-body">
	                                                            <h4 class="media-heading user_name">${reviewList.memberName} 님</h4>
	
	                                                            <h5>${reviewList.reviewTitle}</h5>
																<br>
	                                                            <p>${cmt}</p>
	
	                                                            <div class="comment-review clearfix">
	                                                                <div class="row">
	                                                                    <div class="col-md-12 review-wrap">
	                                                                            <div class="pull-left">
	                                                                                <label>평점</label>
	                                                                            </div>
	                                                                            <div class="pull-right">
	                                                                                <div class="rating${reviewList.reviewNumber}">
	                                                                                </div>
	                                                                            </div>
	                                                                    </div>
	                                                                </div>
	                                                            </div>
	                                                        </div>
	                                                    </div>
                                                    </c:forEach>

<!--                                                     <div class="media"> -->
<!--                                                         <p class="pull-right"><small>7 days ago</small></p> -->
<!--                                                         <a class="media-left"> -->
<!--                                                             <img src="images/uploads/peoplePic_2.jpg" alt="" class="img-circle"> -->
<!--                                                         </a> -->
<!--                                                         <div class="media-body"> -->

<!--                                                             <h4 class="media-heading user_name">luss 님</h4> -->

<!--                                                             <h5>알차고 좋았습니다!</h5> -->

<!--                                                             <p>여름이라 덥긴 했지만 훌륭한 해설과 알찬 코스덕에 재밌는 여행 했습니다. 서울을 다시 여행하게 된다면 다른 코스도 경험해 보고 싶네요^^ 추천드립니다.</p> -->

<!--                                                             <div class="comment-review clearfix"> -->
<!--                                                                 <div class="row"> -->
<!--                                                                     <div class="col-md-12 review-wrap"> -->
<!--                                                                         <div class="form-group clearfix"> -->
<!--                                                                             <div class="pull-left"> -->
<!--                                                                                 <label>전체 평점</label> -->
<!--                                                                             </div> -->
<!--                                                                             <div class="pull-right"> -->
<!--                                                                                 <div class="rating"> -->
<!--                                                                                     <a href="#" class="active"><i class="fa fa-star"></i></a> -->
<!--                                                                                     <a href="#" class="active"><i class="fa fa-star"></i></a> -->
<!--                                                                                     <a href="#" class="active"><i class="fa fa-star"></i></a> -->
<!--                                                                                     <a href="#" class="active"><i class="fa fa-star"></i></a> -->
<!--                                                                                     <a href="#" class="active"><i class="fa fa-star-o"></i></a> -->
<!--                                                                                 </div> -->
<!--                                                                             </div> -->
<!--                                                                         </div> -->
<!--                                                                     </div> -->
<!--                                                                 </div> -->
<!--                                                             </div> -->
<!--                                                         </div> -->
<!--                                                     </div> -->
                                                </div>

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
                                            </div>
                                        </div>
                                        
