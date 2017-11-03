<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles"  prefix="tiles"%>
<!doctype html>
	<head>
		<tiles:insertAttribute name="header"/>
	</head>
	
	<body>
		<tiles:insertAttribute name="nav"/>
	    <tiles:insertAttribute name="content"/>
	    <tiles:insertAttribute name="footer"/>
	    
	    <script src="js/bootstrap.js"></script>
	    <script src="js/owl.carousel.min.js"></script>
	    <script src="js/parallax.js"></script>
	    <script src="js/animate.js"></script>
	    <script src="js/custom.js"></script>
	    <!-- FOR SINGLE LISTING PAGES -->
	    <script src="js/bootstrap-select.js"></script>
	    <script src="js/bootstrap-datetimepicker.min.js"></script>
	    <script src="js/price-ranger.js"></script>
	    <!-- SLIDER REV -->
	    <script src="js/rs-plugin/js/jquery.themepunch.tools.min.js"></script>
	    <script src="js/rs-plugin/js/jquery.themepunch.revolution.min.js"></script>
	    <!-- PORTFOLIO 갤러리용 js-->
	    <script src="js/venobox/venobox.min.js"></script> 
	    <script src="js/masonry.js"></script> 
	    <script src="js/gallery_04.js"></script>
	    
	    <script>
	    jQuery(document).ready(function() {
	        jQuery('.tp-banner').show().revolution(
	            {
	            dottedOverlay:"none",
	            delay:16000,
	            startwidth:1170,
	            startheight:760,
	            hideThumbs:200,     
	            thumbWidth:100,
	            thumbHeight:50,
	            thumbAmount:5,  
	            navigationType:"none",
	            navigationArrows:"solo",
	            navigationStyle:"preview2",  
	            touchenabled:"on",
	            onHoverStop:"on",
	            swipe_velocity: 0.7,
	            swipe_min_touches: 1,
	            swipe_max_touches: 1,
	            drag_block_vertical: false,          
	            parallax:"mouse",
	            parallaxBgFreeze:"on",
	            parallaxLevels:[10,7,4,3,2,5,4,3,2,1],
	            parallaxDisableOnMobile:"off",           
	            keyboardNavigation:"off",   
	            navigationHAlign:"center",
	            navigationVAlign:"bottom",
	            navigationHOffset:0,
	            navigationVOffset:20,
	            soloArrowLeftHalign:"left",
	            soloArrowLeftValign:"center",
	            soloArrowLeftHOffset:20,
	            soloArrowLeftVOffset:0,
	            soloArrowRightHalign:"right",
	            soloArrowRightValign:"center",
	            soloArrowRightHOffset:20,
	            soloArrowRightVOffset:0,  
	            shadow:0,
	            fullWidth:"on",
	            fullScreen:"off",
	            spinner:"spinner4",  
	            stopLoop:"off",
	            stopAfterLoops:-1,
	            stopAtSlide:-1,
	            shuffle:"off",  
	            autoHeight:"off",           
	            forceFullWidth:"off",                         
	            hideThumbsOnMobile:"off",
	            hideNavDelayOnMobile:1500,            
	            hideBulletsOnMobile:"off",
	            hideArrowsOnMobile:"off",
	            hideThumbsUnderResolution:0,
	            hideSliderAtLimit:0,
	            hideCaptionAtLimit:0,
	            hideAllCaptionAtLilmit:0,
	            startWithSlide:0,
	            fullScreenOffsetContainer: ""  
	            }); 
	        });
	    
	    //페이지가 메인이면 nav가 투명해지게 한다.
	    if ($("#main").length) {
			$("#transNav").addClass("transparent-header");
		}
	    </script>
	</body>
</html>