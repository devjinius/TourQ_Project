<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
	
	<c:forEach items ="${markerList}" var="markerList">
	var markerType = "<c:out value="${markerList.markerType}"/>";
	</c:forEach> 
	$(document).ready(function(){	

		initMap();
		
		$("select").val(markerType);
	});
</script>
<div class="mainbar">
	<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">마커 상세보기</h2>
			<!-- Breadcrumb -->
			<div class="pull-right">
				<div class="bread-crumb">
				  <a href="#" onclick="left.adminSubmitFn('adminMain', 'adminMain.do', 'frmAdmin')"><i class="fa fa-home"></i> 메인</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current" onclick="left.adminSubmitFn('adminMarker', 'adminMarker.do', 'frmAdmin')">마커 조회</a>
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current" onclick="left.adminSubmitFn('adminMarkerDetail', 'adminMarkerDetail.do', 'frmAdmin')">마커 수정</a>
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">마커 상세보기</a>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="clearfix"></div>
	</div>
	<!-- Matter -->
	<div class="matter nonsurch">
		<div class="container full-page-btn">
			<div class="table-responsive">
			<form name="frmMarker" id="frmMarker" method="post" enctype="multipart/form-data">
			<input type="hidden" name="courseNumber" id="courseNumber" value="<c:out value="${param.courseNumber}"/>">
				<table class="table table-bordered table-row">
				  <thead>
				  <c:forEach items="${markerList}" var="markerList" varStatus="status">
				  	<tr>
						<th>마커번호</th>
						<td colspan="2" class="ip-text"><input class="form-control" type="text" name="markerNumber" id="markerNumber" value="<c:out value="${markerList.markerNumber}"/>" readonly="readonly"></td>
					</tr>
					<tr>
						<th>마커이름</th>
						<td colspan="2" class="ip-text"><input class="form-control" type="text" name="title" id="title" value="<c:out value="${markerList.markerName}"/>"></td>
					</tr>
					<tr>
						<th>대표사진</th>
						<td colspan="2" class="ip-text"><input class="form-control" type="file" id="fileUp" name="fileUp"></td>
					</tr>
					<tr>
						<th>종류</th>
						<td colspan="2">
							<select name="type" class="form-control">
	    						<option value="0">출발지</option>
	    						<option value="1">경유지1</option>
	    						<option value="2">경유지2</option>
	    						<option value="3">경유지3</option>
	    						<option value="4">경유지4</option>
	    						<option value="5">경유지5</option>
	    						<option value="6">도착지</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="2">
							<textarea class="textarea-box" name="contents" id="contents" rows="6">
<c:out value="${markerList.markerContents}"/></textarea>
						</td>
					</tr>
					<tr>
						<th>마커정보</th>
						<td class="ip-text"><input class="form-control" type="text" id="lat" name="lat" placeholder="위도" value="<c:out value="${markerList.markerLat}"/>" readonly="readonly"></td>
						<td class="ip-text"><input class="form-control" type="text" id="lon" name="lon" placeholder="경도" value="<c:out value="${markerList.markerLon}"/>"readonly="readonly"></td>
					</tr>
					<tr>
						<td colspan="3">
							<input id="pac-input" class="controls" type="text" placeholder="Enter a location">
							<button id="pac-submit" class="controls btn btn-xs btn-default">마커수정</button>
							<div id="map"></div>
						</td>
					</tr>
					</c:forEach>
				  </thead>
				</table>
			</form>
			</div>
		</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
		<div class="col-md-12 widget-foot">
			<div class="content-c-btn">
				<button class="btn btn-default ma-right5" type="button" onclick="javascript:left.adminSubmitFn('insertMarker','insertMarker.do', 'frmMarker')"><i class="fa fa-check"></i> 저장하기</button>
				<button class="btn btn-default" type="button" onclick="javascript:left.adminSubmitFn('adminMarkerDetail', 'adminMarkerDetail.do','frmMarker')"><i class="fa fa-paperclip"></i> 뒤로가기</button>
			</div>
		</div>
	</div>
</div><!--/ Mainbar ends -->
<script>
// 구글 지도 시작메서드입니다.
function initMap() {
  	
	// 왼쪽위에 띄울 검색창과 저장하기 버튼 생성
	var input = document.getElementById('pac-input');
	var submit = document.getElementById('pac-submit');
	<c:forEach items="${markerList}" var="markerList" varStatus="status">
		var lat = <c:out value="${markerList.markerLat}"/>
		var lon = <c:out value="${markerList.markerLon}"/>
	</c:forEach>
	
	$("#pac-submit").css({"margin-left": 10});
	
	// input을 autocomlete로 만든다.
	var autocomplete = new google.maps.places.Autocomplete(input);
	
	var infowindow = new google.maps.InfoWindow();
	
	
	var map = new google.maps.Map(document.getElementById('map'), {
      
	  	center: {lat: lat, lng: lon},
	  	zoom: 19
	});
	// 검색을 통해 추가하는 마커
	var marker = new google.maps.Marker({
		
		map: map,
		anchorPoint: new google.maps.Point(0, -29)
	});
	
	// 초기 마커
	var marker2 = new google.maps.Marker({
	
		map: map,
		position: new google.maps.LatLng(lat,lon) 
	});	
	
	// 검색창과 저장하기 창 왼쪽에 추가
	map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
	map.controls[google.maps.ControlPosition.TOP_LEFT].push(submit);
	
	
	autocomplete.bindTo('bounds', map);
	
	// 초기마커로 맵에 저장
	marker2.setMap(map);
	
	// autocomplete 기능 실행으로 place가 바뀌면 callback
	autocomplete.addListener('place_changed', function() {
	
	  	infowindow.close();
		marker.setVisible(false);
		var place = autocomplete.getPlace();
		if (!place.geometry) {
			
		  // User entered the name of a Place that was not suggested and
		  // pressed the Enter key, or the Place Details request failed.
		  window.alert("요청하신 '" + place.name + "' 는 없는 곳입니다.");
		  return;
		}
		
		// If the place has a geometry, then present it on a map.
		if (place.geometry.viewport) {
			
		  map.fitBounds(place.geometry.viewport);
		} else {
			
		  map.setCenter(place.geometry.location);
		  map.setZoom(15);
		}
		/* marker.setIcon(({
		    
			url: place.icon,
		  	size: new google.maps.Size(71, 71),
		  	origin: new google.maps.Point(0, 0),
		  	anchor: new google.maps.Point(17, 34),
		  	scaledSize: new google.maps.Size(35, 35)
	  	})); */
	  
		marker.setPosition(place.geometry.location);
		marker.setVisible(true);
	
	    var address = '';
	    if (place.address_components) {
	  	  
			address = [
			  (place.address_components[0] && place.address_components[0].short_name || ''),
			  (place.address_components[1] && place.address_components[1].short_name || ''),
			  (place.address_components[2] && place.address_components[2].short_name || '')
			].join(' ');
	    }
	
	    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
	    infowindow.open(map, marker);
	    
	    var infoWindowLocation = place.geometry.location;
	    
	    $("#pac-submit").click(function() {
		 $("#lat").text(infoWindowLocation.lat());
		 $("#lng").text(infoWindowLocation.lng());
		});
	});

}
</script>	