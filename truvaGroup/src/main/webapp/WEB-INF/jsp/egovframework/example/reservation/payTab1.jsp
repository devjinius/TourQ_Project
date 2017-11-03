<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- ("temaList", temaList);
		model.addAttribute("payList", payList); -->
<div id="payCard" prop="orderKind" class="tab-pane fade in active">
	<ul class="card-select">
		<c:forEach var="payList" items="${payList}">
			<c:if test="${payList.payType == param.payTab1}">
				<li id="<c:out value='${payList.payNumber}' />">
					<img alt="<c:out value='${payList.payName}' />" src="images/payIcon/<c:out value='${payList.payImg}' />">
					<span class="mask"></span>
				</li>
			</c:if>
		</c:forEach>
	</ul>
	<div class="col-sm-12">
		<div class="col-sm-3 comment-input-area">
			<div class="comment-input">할부개월을 선택하세요</div>
		</div> 
        <div class="col-md-3 search-select">
           <select class="selectpicker col-sm-12" name="cardIns" id="cardIns" data-size="5" data-live-search="false" title="할부개월">
               <option data-tokens="일시불">일시불</option>
               <option data-tokens="2개월">2개월</option>
               <option data-tokens="3개월">3개월</option>
               <option data-tokens="4개월">4개월</option>
               <option data-tokens="5개월">5개월</option>
               <option data-tokens="6개월">6개월</option>
               <option data-tokens="7개월">7개월</option>
               <option data-tokens="8개월">8개월</option>
               <option data-tokens="9개월">9개월</option>
               <option data-tokens="10개월">10개월</option>
               <option data-tokens="11개월">11개월</option>
               <option data-tokens="12개월">12개월</option>
           </select>
        </div>
	</div>
</div>