<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
	var map;
	var markerLayer = new Tmap.Layer.Markers( "MarkerLayer" ); // 마커레이어 객체 생성
	//pr_3857 인스탄스 생성.
	pr_3857 = new Tmap.Projection("EPSG:3857");
	 
	//pr_4326 인스탄스 생성.
	pr_4326 = new Tmap.Projection("EPSG:4326");
	 
	function get3857LonLat(coordX, coordY){
	    return new Tmap.LonLat(coordX, coordY).transform(pr_4326, pr_3857);
	}
	
    function init(){
		
    	var cLonLat = new Tmap.LonLat(14135893.887852,4518348.1852606);  //초기 중심점 좌표. EPSG3857 좌표계 형식으로 선언. 
        var zoom = 14;  // zoom level입니다.  0~19 레벨있음.
        var mapW = '100%';  // 지도의 가로 크기 입니다.
        var mapH = '100%';  // 지도의 세로 크기 입니다.
        
        map = new Tmap.Map({div:'map_div', width:mapW, height:mapH, animation:true}); 
        					// div : 지도가 생성될 div의 id값과 같은 값을 옵션으로 정의, animation은 뭐하는 앤지 알아볼 필요 있음
        map.setCenter(cLonLat,zoom); // 지도 초기 값 설정
    	map.addLayer(markerLayer); // map객체에 마커 등록
    	
    	
    	var markerLonlat = {};
    	var markerTmap = 0.1;
    	<c:forEach items="${markerList}" var="markerList" varStatus="status">
    	
    		markerTmap = get3857LonLat(<c:out value="${markerList.markerLon}"/>, <c:out value="${markerList.markerLat}"/>);

    		markerLonlat.marker<c:out value="${status.count}"/> = 
    		{
					"lon": markerTmap.lon,
					"lat": markerTmap.lat
    		}
		</c:forEach>
    	// 코스 리스트에서 출발지 좌표값을 받아 json으로 생성
//     	var markerLonlat = {
//				"marker1" : {"lon": 14134405.455675, "lat": 4516747.1878169},
//				"marker2" : {"lon": 14134391.123732, "lat": 4517115.0410154},
//				"marker3" : {"lon": 14134833.0253, "lat": 4517447.064357},
//				"marker4" : {"lon": 14135186.546556, "lat": 4518736.9392091},
//				"marker5" : {"lon": 14137040.144492, "lat": 4518655.7248665},
//				"marker6" : {"lon": 14135950.916839, "lat": 4519773.6164051},
//        	}
        
    	// Lonlat 인스턴스 넣을 배열 생성
       	var markerLonlatArr = Array();
        
    	// for문을 이용해서 좌표를 가지고 인스턴스 생성후 배열에 저장
       	$.each(markerLonlat, function(key, value){ 
       		markerLonlatArr.push(new Tmap.LonLat(value.lon,value.lat));
       	});
       	
    	// 차례대로 마커 생성
       	for(var i=0; i<markerLonlatArr.length; i++){
       		addMarker2(markerLonlatArr[i], "images/map/marker/marker_"+(i+1)+".png");
       	}
       	
    	//마커에 맞추어 가장 보기좋은 zoom으로 변경
       	map.zoomToExtent(markerLayer.getDataExtent());
    	
    }

	function addMarker2(lonlat, iconRef){	 
    	
    	// icon생성
    	var icon = addIcon2(iconRef);
       	
        var marker = new Tmap.Marker(lonlat, icon); // 마커 생성
        markerLayer.addMarker(marker); // 레이어에 마커 추가
    }
	function addIcon2(iconRef){
    	
    	var size = new Tmap.Size(30, 44);
    	var offset = new Tmap.Pixel(-(size.w/2), -(size.h/2)); // icon이 지도에 표시될 상대적 위치, 사이즈의 가운데에 위치시켜라.
    	
       	var icon = new Tmap.Icon(iconRef, size, offset);
    	
    	return icon;
    }
    
    function addMarker(lonlat){	 
    	
    	// icon생성
    	var icon = addIcon();
       	
        var marker = new Tmap.Marker(lonlat, icon); // 마커 생성
        markerLayer.addMarker(marker); // 레이어에 마커 추가
    }
    
   </script>