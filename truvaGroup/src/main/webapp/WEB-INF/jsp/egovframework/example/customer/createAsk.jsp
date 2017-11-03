<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div id="wrapper">
	<section class="section lb page-title little-pad">
	        <div class="container">
	            <div class="row">
	                <div class="col-md-12">
	                    <div class="section-big-title clearfix">
	                        <div class="pull-left">
	                            <h3>1:1 문의 보내기</h3>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </section>
	<section class="section">
	         <div class="container">
	            <div class="row">
	                 <div class="col-md-7 align-center">
	                 <div class="content">
	                         <div class="blog-wrapper">
	                             <div class="blog-item">
									<div class="row">
					                 	 <div class="shortcode-wrap">
					                 	 <h1 class="customtitle">문의사항을 입력해주세요!</h1>
					                 	 <hr class="custom1">
					                     <form class="contact-form search-top" method="post" name="askFrm" id="askFrm">
					                         <div class="col-md-12">
					                             <div class="form-group">
					                             <input type="text" class="form-control" name="title" id="title" placeholder="Title">
					                             </div>
					                         </div>
					
					                         <div class="col-md-12">
					                             <textarea placeholder="Your message" class="form-control" id="contents" name="contents"></textarea>
					                             <button class="btn btn-primary" onclick="nav.pageSubmitFn({pageName: 'insertAsk', url:'insertAsk.do', frmName: 'askFrm'})">Submit</button>
					                         </div>
					                     </form>
					                     </div>
					                </div>
					           	 </div>
					      	</div>
	                 </div>
				</div>
				</div>
	         </div><!-- end container -->
	</section><!-- end section -->
</div>

	