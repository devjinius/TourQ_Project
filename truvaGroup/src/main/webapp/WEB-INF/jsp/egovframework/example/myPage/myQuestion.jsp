<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<script type="text/javascript">

function changTab(pageName) {
		
	var menuAll = $("[prop=menu]");
	
	menuAll.removeClass("active");
	
	$("#"+pageName).addClass("active");
}

var showMore = {
		
	modal : null,
	
	textArea : null,
	
	titleArea : null,
	
	anserArea : null,
	
	anserTitle : null,
	
	anserDate : null,
	
	contentsDate : null,
	
	modalContents : function() {
		
		this.modal = $(".myQuestion-contents-modal");
		
		this.textArea = $(".modal-contents-text");
		
		this.titleArea = $(".modal-contents-title");
		
		this.anserArea = $(".modal-anser-text");
		
		this.anserTitle = $(".modal-anser-title");
		
		this.anserDate = $(".anser-date");
		
		this.contentsDate = $(".contents-date");
	},
	
	modalAjax : function(option){
		
		var that = this;
		$.ajax({
			
			type	: "POST",
			url		: "myQuestionMore.do",
			async	: false,
			data	: {"param1" : option},
			success : function(result) {
				
				var jsonRes = JSON.parse(result);
				
				that.titleArea.text(jsonRes.askTitle);
				that.textArea.text(jsonRes.askContent);
				that.contentsDate.text(jsonRes.askDate);
				
				if (jsonRes.answerContent == null) {
					that.anserTitle.text("등록된 답변이 없습니다.");
				} else {

					that.anserTitle.text(jsonRes.answerTitle);
					that.anserDate.text(jsonRes.answerDate);
					that.anserArea.append(jsonRes.answerContent);
				}
			}
		});
	},
	
	showModal : function(number){
		
		this.modal.toggleClass("hidden");
		
		this.modalAjax(number);
	},
	
	hideModal : function() {

		this.modal.toggleClass("hidden");
		
		this.titleArea.text("");
		this.textArea.text("");
		this.anserArea.text("");
		this.anserTitle.text("");
		this.anserDate.text("");
		this.contentsDate.text("");
	}
}

function pageing(getVal) {
	
	var $page = $("#page");
	
	$page.val(getVal);
	
	nav.pageSubmitFn({pageName: "myQuestion", frmName: "myqPageFrm", url: "myQuestion.do"});
}

$(document).ready(function(){	

	var pageName = "<c:out value="${param.pageName}"/>";
	
	changTab(pageName);
	showMore.modalContents();
	
});
</script>

<form id="myqPageFrm"	name="myqPageFrm">
	<input type="hidden" id="page" name="page" />
</form>

<section class="white-modal myQuestion-contents-modal hidden">
	<div class="modal-box col-lg-6">
        	<div class="modal-close clear">
        		<span>나의 문의내역</span>
        		<a href="#" class="modal-close-btn" onclick="javascript:showMore.hideModal()"></a>
        	</div>
        <form class="contact-form search-top">
			<div class="col-lg-12 modal-contents">
	           <div class="form-control myQuestion-title">
	         	  <span class="modal-contents-title"></span>
	         	  <span class="contents-date align-right"></span>
	           </div>
	           <div class="form-group">
	          	 <div class="form-control modal-contents-text"></div>
	           </div>
	           <div class="form-control myQuestion-title">
	         	  <span class="modal-anser-title"></span>
	         	  <span class="anser-date align-right"></span>
	           </div>
	           <div class="form-group">
	          	 <div class="form-control modal-anser-text"></div>
	           </div>
			</div>
		</form>
	</div>
</section>


    <div id="wrapper">
        <section class="section lb page-title little-pad">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="section-big-title clearfix">
                            <div class="pull-left">
                                <h3>나의 문의내역</h3>
                                <p>내가 그동안 문의한 내역을 보여줍니다.</p>
                            </div>

                            <div class="pull-right hidden-xs">
                                <ul class="breadcrumb">
                                    <li><a href="javascript:void(0)">Home</a></li>
                                    <li><a href="javascript:void(0)">My Page</a></li>
                                    <li class="active">My Question</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="content">
                            <nav class="portfolio-filter wow fadeIn text-center" data-wow-duration="1s" data-wow-delay="0.4s">
                                <ul>
                                    <li>
                                    	<a prop="menu" id="myinfo" class="btn btn-dark" href="#"
                                    		onclick="javascript:nav.pageSubmitFn({pageName: 'myInfo', frmName: 'frm', url: 'myInfo.do'})">내정보</a>
                                    </li>
                                    <li>
                                   		<a prop="menu" id="myOrderList" class="btn btn-dark" href="#"
                                   			onclick="javascript:nav.pageSubmitFn({pageName: 'myOrderList', frmName: 'frm', url: 'myOrderList.do'})">나의 주문내역</a>
                                    </li>
                                    <li>
                                    	<a prop="menu" id="myQuestion" class="btn btn-dark" href="#"
                                    		onclick="javascript:nav.pageSubmitFn({pageName: 'myQuestion', frmName: 'frm', url: 'myQuestion.do'})">나의 문의내역</a>
                                    </li>
                                    <li>
                                    	<a prop="menu" id="myFavoritList" class="btn btn-dark" href="#"
                                    		onclick="javascript:nav.pageSubmitFn({pageName: 'myFavoritList', frmName: 'frm', url: 'myFavoritList.do'})">관심코스</a>
                                    </li>
                                    <li>
                                    	<a prop="menu" id="myPoint" class="btn btn-dark" href="#"
                                    		onclick="javascript:nav.pageSubmitFn({pageName: 'myPoint', frmName: 'frm', url: 'myPoint.do'})">보유 포인트</a>
                                    </li>
                                </ul>
                            </nav>

                    		<div class="col-md-12">
		                        <div class="shortcode-wrap col-md-10">
		                              <table class="table cmmn-table myQuestion-table">
		                       	 		<thead>
		                       	 			<tr>
		                       	 				<td>No.</td>
		                       	 				<td>문의제목</td>
		                       	 				<td>작성일</td>
		                       	 				<td>답변여부</td>
		                       	 			</tr>
		                       	 		</thead>
		                       	 		<tbody>
		   									<c:forEach items="${getMyQuestion}" var="getMyQuestion" varStatus="status">
		                        	 			<tr>
		                        	 				<td><c:out value="${getMyQuestion.seq}"/></td>
		                        	 				<td class="myQuestion-title" onclick="javascript:showMore.showModal(<c:out value='${getMyQuestion.askNumber}'/>)">
		                        	 					<c:out value="${getMyQuestion.askTitle}"/></td>
		                        	 				<td><c:out value="${getMyQuestion.askDate}"/></td>
		                        	 				<td id="answerYn">
		                        	 					<c:choose>
		                        	 						<c:when test="${getMyQuestion.askAnswerYn == 'Y'}">
		                        	 							답변완료
		                        	 						</c:when>
		                        	 						<c:otherwise>
		                        	 							답변 대기중
		                        	 						</c:otherwise>
		                        	 					</c:choose>
		                        	 				</td>
		                        	 			</tr>
		   									</c:forEach>
		                       	 		</tbody>
		                       	 	</table>
		                       	 	
									<div class="text-center pd-top-20">
				                        <ul class="pagination">
				                        	<c:if test="${resMap.pageGroup > 1}">
				                            	<li><a href="javascript:pageing(<c:out value='${resMap.nextPage}' />)">&laquo;</a></li>
				                        	</c:if>
				                            <c:forEach var="i" begin="${resMap.startPage}"
				                            	end="${resMap.endPage > resMap.totalPage ? resMap.totalPage : resMap.endPage}">
				                            	<c:choose>
				                            		<c:when test="${resMap.page eq i}">
				                          				<li class="active"><a href="javascript:pageing(${i})">${i}</a></li>
				                            		</c:when>
				                            		<c:otherwise>
				                        			    <li><a href="javascript:pageing(${i})">${i}</a></li>
				                            		</c:otherwise>
				                            	</c:choose>
				                            </c:forEach>
				                            <c:if test="${resMap.nextPage < resMap.totalPage}">
				                            	<li><a href="javascript:pageing(<c:out value='${resMap.nextPage}' />)">&raquo;</a></li>
				                            </c:if>
				                        </ul>
									</div>
		                        </div><!-- end wrap -->
                   			</div><!-- end col -->
                    
                        </div><!-- end grid -->
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end section -->
    </div>
    <!-- end wrapper -->