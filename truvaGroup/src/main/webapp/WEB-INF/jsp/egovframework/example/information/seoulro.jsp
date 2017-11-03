<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
    <script src="js/bootstrap-select.js"></script>
    <script src="js/bootstrap-datetimepicker.min.js"></script>
    <script src="js/price-ranger.js"></script>
    <script src="js/jquery.flexslider-min.js"></script>
    <script src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=75506322-1518-31a1-92d2-4ea1768fab15"></script>
    <script type="text/javascript">

        var map;
    	var markerLayer = new Tmap.Layer.Markers( "MarkerLayer" ); // 마커레이어 객체 생성
    	var passPointIndex = 1; // 경유지 사진을 위한 인덱스
    	
        var tMap = {
    		
    		map : null,
    			
        	init : function() {
        		var cLonLat = new Tmap.LonLat(14134558.628515,4517068.9592956);  //초기 중심점 좌표. EPSG3857 좌표계 형식으로 선언. 
                var zoom = 15;  // zoom level입니다.  0~19 레벨있음.
                var mapW = '100%';  // 지도의 가로 크기 입니다.
                var mapH = '100%';  // 지도의 세로 크기 입니다.
                
                map = new Tmap.Map({div:'map_div', width:mapW, height:mapH, animation:true}); 
                					// div : 지도가 생성될 div의 id값과 같은 값을 옵션으로 정의, animation은 뭐하는 앤지 알아볼 필요 있음
                map.setCenter(cLonLat,zoom); // 지도 초기 값 설정
            	map.addLayer(markerLayer); // map객체에 마커 등록
        	},
        	
        	addMarker : function(lonlat){
        		
        		// icon생성
            	var icon = this.addIcon();
               	
                var marker = new Tmap.Marker(lonlat, icon); // 마커 생성
                markerLayer.addMarker(marker); // 레이어에 마커 추가
        	},
        	
        	addIcon : function() {
        		
        		//icon 생성
            	var size = new Tmap.Size(30, 44);
            	var offset = new Tmap.Pixel(-(size.w/2), -(size.h/2)); // icon이 지도에 표시될 상대적 위치, 사이즈의 가운데에 위치시켜라.
            	
            	//아래에서 아이콘 그림 수정 가능
               	var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_a.png', size, offset);
            	
            	return icon;
        	},
        	
        	drawDirections : function() {
        		
        		var startX = "",
        			startY = "",
        			endX = "",
        			endY = "",
        			passArray = new Array();
        		
        		
        	 	<c:forEach items="${markerList}" var="markerList" varStatus="status">
         			var tmapLonlat = this.get3857LonLat('<c:out value="${markerList.markerLon}"/>', '<c:out value="${markerList.markerLat}"/>');
         			if('<c:out value="${markerList.markerType}"/>' == 0){

         				startX = tmapLonlat.lon;
         				startY = tmapLonlat.lat;
         			} else if ('<c:out value="${markerList.markerType}"/>' == 6) {
         				
         				endX = tmapLonlat.lon;
         				endY = tmapLonlat.lat;
         			} else {
         				
         				passArray.push(tmapLonlat.lon +","+ tmapLonlat.lat);
         			}
        		</c:forEach>
    			
    			var passList= passArray.join("_");	
            	var route = new Tmap.Format.KML({extractStyles:true, extractAttributes:true}) 
     			var urlStr =  "https://apis.skplanetx.com/tmap/routes/pedestrian?version=1&sort=custom&format=xml";
    				urlStr += "&startName='"+encodeURIComponent("출발지")+"'&endName='"+encodeURIComponent("도착지")+"'";
    				urlStr += "&startX="+startX+"&startY="+startY+"&endX="+endX+"&endY="+endY;
    				urlStr += "&passList="+passList;
    				urlStr += "&appKey=75506322-1518-31a1-92d2-4ea1768fab15";
    				
    			var prtcl = new Tmap.Protocol.HTTP({ 
                   url: urlStr,
                   format:route
                }); 
                            
                var routeLayer = new Tmap.Layer.Vector("route", {protocol:prtcl, strategies:[new Tmap.Strategy.Fixed()]});
                
                routeLayer.events.register("featuresadded", routeLayer, showRoute);//지도가 로딩되면 전체가 보이게 zoom
                routeLayer.events.register("beforefeatureadded", routeLayer, onBeforeFeatureAdded);//point의 아이콘 삭제 및 경유지 아이콘 수정

                map.addLayers([routeLayer]);
                
        	},
        	
            
          	//pr_3857 인스탄스 생성.
    		pr_3857 : new Tmap.Projection("EPSG:3857"),
    		 
    		//pr_4326 인스탄스 생성.
    		pr_4326 : new Tmap.Projection("EPSG:4326"),
    		 
    		get3857LonLat : function (coordX, coordY){
    		    return new Tmap.LonLat(coordX, coordY).transform(this.pr_4326, this.pr_3857);
    		}
    	}

        //지도 관련 이벤트
        function showRoute(event){ 
        	 
            map.zoomToExtent(this.getDataExtent())
        }
        
        function onBeforeFeatureAdded(e){
        	
        	if(e.feature.attributes.styleUrl=="#pointStyle"){
        		
        		e.feature.style.externalGraphic = "";
        	}  else if(e.feature.attributes.styleUrl=="#passPointStyle"){
        		
        		e.feature.style.externalGraphic = "images/map/marker/passPoint.png";
        		passPointIndex++;
        	}
        	
        };
        
        // 마이페이지 최근 본 상품 리스트
var prodList = {

   	cookieArr : new Array(),
   		
   	myProdList : function(courseNm) {
   		
   		// 상품을 선택하지 않았을경우 가지고있는 쿠키의 값을 배열에 담는다.
   		if ($.cookie("prodCookie") != null) {

	  		this.cookieArr = $.cookie("prodCookie").split(",");
		}

  		console.log(this.cookieArr);
   		
   		if (this.cookieArr.length < 2) {

   			this.cookieArr.push(courseNm);
   		} else {
   			
   			this.cookieArr.shift();
   			this.cookieArr.push(courseNm);
   		}
   	
   		console.log(this.cookieArr);
   		
   		this.setMyProdList(this.cookieArr);
   	},
   	
   	setMyProdList : function(courseArr) {
   		
   		var str = "";
   		
   		for ( var i in courseArr) {
   			if (str != "") {
   				str += ","
   			}
   			
   			str += courseArr[i];
   		}
   		
   		$.cookie("prodCookie", courseArr, {expires : 7});
   	}
}

        $(document).ready(function() {
        	
        	$('.flexslider').flexslider({
                animation: "slide",
                controlNav: "thumbnails"
            });
        	
        	tMap.init(); // 초기 지도를 세팅하고 클릭하면 마커 추가
        	
        	tMap.drawDirections();
        	
        	prodList.myProdList(<c:out value="${param.courseNumber}"/>);
        	
        	// 예약하기 버튼을 누르면 예약 사이트로 이동
        	$("#goReservation").click(function() {
        		
        		$("#pageNameInform").val("memberReservationWalk");
        		
        		nav.pageSubmitFn({pageName: 'memberReservationWalk', frmName: 'frmInform', url: 'memberReservationWalk.do'});
        	})

		});
        
    </script>
    
        <section class="section lb page-title little-pad">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="section-big-title clearfix">
                            <div class="pull-left">
    							<c:forEach items="${courseList}" var="courseList" varStatus="status">
                                	<h2><c:out value="${courseList.courseTitle}"/></h2> 
                                	<p><c:out value="${courseList.courseSubtitle}"/></p>
								</c:forEach>
                            </div>
                            <div class="pull-right hidden-xs">
                                <ul class="breadcrumb">
                                    <li><a href="#" onclick="javascript:nav.pageSubmitFn({pageName: 'main', frmName: 'frm', url: 'main.do'})">Home</a></li>
                                    <li><a href="#" onclick="javascript:nav.pageSubmitFn({pageName: 'localCourse', frmName: 'frm', url: 'localCourse.do'})">코스안내</a></li>
                                    <li class="active"><a href="#">세부정보</a></li>
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
                    <div class="col-md-8">
                        <div class="content">
                            <div class="list-wrapper clearfix">
                                <div class="row wow fadeIn mb30">
                                    <div class="col-md-12">
                                        <div class="list-three-item cruise-list">
                                            <div class="list-item">
                                                <!-- Place somewhere in the <body> of your page -->
                                                <div class="flexslider">
                                                	<ul class="slides">
                                                  		<c:forEach items="${courseList}" var="courseList" varStatus="status">
		                                                    <li data-thumb="images/uploads/course/<c:out value="${courseList.courseNumber}"/>-1.jpg">
		                                                      <img src="images/uploads/course/<c:out value="${courseList.courseNumber}"/>-1.jpg">
		                                                    </li>
		                                                    <li data-thumb="images/uploads/course/<c:out value="${courseList.courseNumber}"/>-2.jpg">
		                                                      <img src="images/uploads/course/<c:out value="${courseList.courseNumber}"/>-2.jpg">
		                                                    </li>
		                                                    <li data-thumb="images/uploads/course/<c:out value="${courseList.courseNumber}"/>-3.jpg">
		                                                      <img src="images/uploads/course/<c:out value="${courseList.courseNumber}"/>-3.jpg">
		                                                    </li>
		                                                    <li data-thumb="images/uploads/course/<c:out value="${courseList.courseNumber}"/>-4.jpg">
		                                                      <img src="images/uploads/course/<c:out value="${courseList.courseNumber}"/>-4.jpg">
		                                                    </li>
                                                  		</c:forEach>
                                                	</ul>
                                                </div>
                                            </div><!-- end list-item -->
                                        </div><!-- end list-three-item -->
                                    </div><!-- end col -->
                                </div><!-- end row -->

                                <div class="custom-tab">
                                    <ul class="nav nav-tabs">
                                        <li class="active"><a data-toggle="tab" href="#menu01"><i class="fa fa-location-arrow"></i> 코스소개</a></li>
                                        <li><a data-toggle="tab" href="#menu02"><i class="fa fa-info"></i> 세부정보</a></li>
                                        <li id="reviewTab"><a data-toggle="tab" href="#menu03"><i class="fa fa-thumbs-up"></i> 리뷰</a></li>
                                    </ul>

                                    <div class="tab-content">
	                                    <jsp:include page="/WEB-INF/jsp/egovframework/example/information/seoulroTab1.jsp"></jsp:include>
	                                    <jsp:include page="/WEB-INF/jsp/egovframework/example/information/seoulroTab2.jsp"></jsp:include>
	                                    <jsp:include page="/WEB-INF/jsp/egovframework/example/information/seoulroTab3.jsp"></jsp:include>
                                    </div>	
                                </div><!-- end custom-tab -->
							</div>
                        </div><!-- end grid -->
                    </div><!-- end col -->

                    <div class="col-md-4">
                        <div class="sidebar restaurant-sidebar croise-sidebar">
                            <div class="widget clearfix">
                                <div class="hotel_mini_map similar_map_wrap_container mini-map widget clearfix">
        							<div id="map_div"></div>
                                </div>
                            </div>

                            <hr class="custom">
                            
                            <div class="widget clearfix">
                                <div class="widget-title">
                                    <h4>CALL US TODAY</h4>
                                    <hr>
                                </div>
									
                                <div class="callusbox">
                                    <div class="detail"><p>페이지에 방문해주셔서 감사합니다. 더 나은 서울 도보 관광을 위해 도움이 필요하시다면 여기로 연락해 주십시오.</p></div>
                                    <h4><i class="flaticon-telephone"></i> +88 02 123 4567</h4>
                                </div><!-- end callusbox -->
                            </div>

                            <hr class="custom">

                            <div class="widget clearfix">
                                <a href="#"><img src="images/banner_02.png" alt="" class="img-responsive"></a>
                            </div>
                        </div><!-- end sidebar -->
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end section -->