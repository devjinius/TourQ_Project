<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script>
$(document).ready(function () {
	   
	   (function($) {
	       var $container = $('#accordion'),
	       colWidth = function() {
	           var w = $container.width(),
	               columnNum = 1,
	               columnWidth = 50;
	           if (w > 1200) {
	               columnNum = 1;
	           } else if (w > 900) {
	               columnNum = 1;
	           } else if (w > 600) {
	               columnNum = 1;
	           } else if (w > 300) {
	               columnNum = 1;
	           }
	           columnWidth = Math.floor(w / columnNum);
	           $container.find('.panel').each(function() {
	        	   var $item = $(this),
                   multiplier_w = $item.attr('class').match(/item-w(\d)/),
                   multiplier_h = $item.attr('class').match(/item-h(\d)/),
                   width = multiplier_w ? columnWidth * multiplier_w[1] - 0 : columnWidth - 5,
                   //height = multiplier_h ? columnWidth * multiplier_h[1] * 1 - 5 : columnWidth * 0.5 - 5;
	               $item.css({
	                   width: width,
	                   //height: height
	               });
	           });
	           return columnWidth;
	       }

	   function refreshWaypoints() {
	       setTimeout(function() {}, 3000);
	   }
	   $('nav.portfolio-filter ul a').on('click', function() {
	       var selector = $(this).attr('data-filter');
	       $container.isotope({
	           filter: selector
	       }, refreshWaypoints());
	       $('nav.portfolio-filter ul a').removeClass('active');
	       $(this).addClass('active');
	       return false;
	   });

	   function setPortfolio() {
	       setColumns();
	       $container.isotope('reLayout');
	   }
	   $container.imagesLoaded(function() {
	       $container.isotope();
	   });
	   isotope = function() {
	       $container.isotope({
	           resizable: true,
	           itemSelector: '.panel',
	           layoutMode: 'masonry',
	           gutter: 10,
	           masonry: {
	               columnWidth: colWidth(),
	               gutterWidth: 0
	           }
	       });
	   };
	   isotope();
	   $(window).smartresize(isotope);
	   }(jQuery));
});

</script>
 <div id="wrapper">
     <section class="section lb page-title little-pad">
         <div class="container">
             <div class="row">
                 <div class="col-md-12">
                     <div class="section-big-title clearfix">
                         <div class="pull-left">
                             <h3>F A Q</h3>
                             <p>자주 묻는 질문입니다.</p>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
     </section>
     <section class="section">
         <div class="container">
             <div class="col">
                 <div class="col-md-11 align-center">
                     <div class="content">
                     
                         <!-- data-filter 의 cat1 값으로 tab 조절 --> 
                         <nav class="portfolio-filter wow fadeIn text-center align-center" data-wow-duration="1s" data-wow-delay="0.4s">
                             <ul>
                                 <li><a class="btn btn-dark" href="#" data-toggle="tooltip" data-placement="top"  title="${totCnt.totCnt}" data-filter="*">전체보기</a></li>
                             	<c:forEach items="${faqTypeCnt}" var="faqTypeCnt">
                                 <li><a class="btn btn-dark" href="#" data-toggle="tooltip" data-placement="top"  title="${faqTypeCnt.cnt}" data-filter=".${faqTypeCnt.faqType}">${faqTypeCnt.faqType}</a></li>
                             	</c:forEach>
                             </ul>
                         </nav>
                         <div class="row align-center">
                             <div class="shortcode-wrap">
                                 <div class="custom-toggle">
                                     <div class="panel-group" id="accordion">
                                 	     <c:forEach items="${faqList}" var="faqList" varStatus="status">
                                         <div class="panel panel-default ${faqList.faqType}">
                                             <div class="panel-heading">
                                       	      <a data-toggle="collapse" data-parent="#accordion" href="#collapse<c:out value="${status.count}"/>"> 
                                                 <h4 class="panel-title"><strong>Q : </strong><c:out value="${faqList.faqTitle}"/></h4>
                                           		</a>
                                             </div>
                                             <div id="collapse<c:out value="${status.count}"/>" class="panel-collapse collapse">
                                                 <div class="panel-body"><strong>A : </strong>${faqList.faqContents}</div>
                                             </div>
                                         </div>
                                         </c:forEach>
                                     </div>
                                 </div>
                             </div>
                          </div>
                          </div>
                     </div><!-- end grid -->
                 </div><!-- end col -->
             </div><!-- end row -->
         </div><!-- end container -->
     </section><!-- end section -->
</div>