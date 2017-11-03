<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
		
	var mappingValue = {
			
		type : function() {
			
			<c:forEach items="${markerType}" var="markerType">
				
				var type = '${markerType}';
				$("#type").append("<option value=\'"+type.split("=")[0]+"\'>"+type.split("=")[1]+"</option>");
				
			</c:forEach>
		}
	}
	$(document).ready(function(){	

		initMap();
		
		mappingValue.type();
	});
</script>

<div class="mainbar">

<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">마커 추가하기
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right">
				<div class="bread-crumb">
				  <a href="#" onclick="left.adminSubmitFn('adminMain', 'adminMain.do', 'frmAdmin')"><i class="fa fa-home"></i> 메인</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current" onclick="left.adminSubmitFn('adminMarker', 'adminMarker.do', 'frmAdmin')">마커 조회</a>
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">마커 생성</a>
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
				<table class="table table-bordered table-row">
					<thead>
				  		<form name="createMarkerForm" id="createMarkerForm" method="post" enctype="multipart/form-data">
							<input type="hidden" name="courseNumber" id="courseNumber" value="<c:out value="${param.courseNumber}"/>">
							<tr>
								<th>마커이름</th>
								<td colspan="2" class="ip-text"><input class="form-control" type="text" name="title" id="title" value="" placeholder="이름을 입력해주세요"></td>
							</tr>
							<tr>
								<th>대표사진</th>
								<td colspan="2" class="ip-text"><input class="form-control" type="file" id="fileUp" name="fileUp"></td>
							</tr>
							<tr>
								<th>종류</th>
								<td colspan="2">
									<select name="type" id="type" class="form-control">
									</select>
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="2">
									<textarea class="textarea-box" name="contents" id="contents" rows="6"></textarea>
								</td>
							</tr>
							<tr>
								<th>마커정보</th>
								<td class="ip-text"><input class="form-control" type="text" id="lat" name="lat" placeholder="위도" readonly="readonly"></td>
								<td class="ip-text"><input class="form-control" type="text" id="lon" name="lon" placeholder="경도" readonly="readonly"></td>
							</tr>
							<tr>
								<td colspan="3">
									<input id="pac-input" class="controls" type="text" placeholder="Enter a location">
									<button id="pac-submit" class="controls btn btn-xs btn-default">마커수정</button>
									<div id="map"></div>
								</td>
							</tr>
						</form>
					</thead>
				</table>
			</div>
		</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
		<div class="col-md-12 widget-foot">
			<div class="content-c-btn">
				<button class="btn btn-default ma-right5" type="button" onclick="javascript:left.adminSubmitFn('insertMarker', 'insertMarker.do', 'createMarkerForm')"><i class="fa fa-check"></i> 저장하기</button>
			</div>
		</div>
	</div><!--/ Matter ends -->
</div>

<script>
    
// 구글 지도 시작메서드입니다.
function initMap() {
  	
	// 왼쪽위에 띄울 검색창과 저장하기 버튼 생성
	var input = document.getElementById('pac-input');
	var submit = document.getElementById('pac-submit');
	$("#pac-submit").css({"margin-left": 10});
	
	// input을 autocomlete로 만든다.
	var autocomplete = new google.maps.places.Autocomplete(input);
	
	var infowindow = new google.maps.InfoWindow();
	
	var map = new google.maps.Map(document.getElementById('map'), {
      	
	  center: {lat: 37.554876, lng: 126.918142},
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
		position: new google.maps.LatLng(37.554876,126.918142) 
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
		  map.setZoom(17);
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
		 $("#lat").val(infoWindowLocation.lat());
		 $("#lon").val(infoWindowLocation.lng());
		});
	});

}
</script>	