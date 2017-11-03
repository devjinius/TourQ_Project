<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=75506322-1518-31a1-92d2-4ea1768fab15"></script>
<script type="text/javascript">
	function changeHeart(id) {

		$("#" + id).toggleClass('fa-heart fa-heart-o');
	}

	var map;
	var markerLayer = new Tmap.Layer.Markers("MarkerLayer"); // 마커레이어 객체 생성

	function init() {

		var defaultCenter = new Tmap.LonLat(126.918142, 37.554876);
		defaultCenter.transform("EPSG:4326","EPSG:3857");
		var cLonLat = new Tmap.LonLat(14128464.168699, 4516740.0218454); //초기 중심점 좌표. EPSG3857 좌표계 형식으로 선언. 
		var zoom = 19; // zoom level입니다.  0~19 레벨있음.
		var mapW = '631.667px'; // 지도의 가로 크기 입니다.
		var mapH = '500px'; // 지도의 세로 크기 입니다.

		map = new Tmap.Map({
			div : 'map_div',
			width : mapW,
			height : mapH,
			animation : true
		});
		// div : 지도가 생성될 div의 id값과 같은 값을 옵션으로 정의, animation은 뭐하는 앤지 알아볼 필요 있음
		map.setCenter(defaultCenter, zoom); // 지도 초기 값 설정
		map.addLayer(markerLayer); // map객체에 마커 등록

		addMarker(cLonLat);
		map.events.register("click", map, onClickMap); // 지도를 클릭하면 onClickMap이 실행되며 마커 추가
	}

	function onClickMap(e) {

		var lonlat = map.getLonLatFromViewPortPx(e.xy); // 클릭한 지점의 픽셀값을 좌표값으로 변환 

		addMarker(lonlat);
	}

	function addMarker(lonlat) {

		// icon생성
		var icon = addIcon();

		var marker = new Tmap.Marker(lonlat, icon); // 마커 생성
		markerLayer.addMarker(marker); // 레이어에 마커 추가
	}

	function addIcon() {

		//icon 생성
		var size = new Tmap.Size(30, 44);
		var offset = new Tmap.Pixel(-(size.w / 2), -(size.h / 2)); // icon이 지도에 표시될 상대적 위치, 사이즈의 가운데에 위치시켜라.

		//아래에서 아이콘 그림 수정 가능
		var icon = new Tmap.Icon(
				'https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_a.png',
				size, offset);

		return icon;
	}

	$(document).ready(function() {

		init(); // 초기 지도를 세팅하고 클릭하면 마커 추가

		// 삭제하기 버튼을 누르면 제일 최근에 추가한 마커를 삭제함 
		$("#deleteButton").click(function() {

			var eraseIndex = map.layers[1].markers.length - 1; // 마커 객체에 접근해 가장 최근의 마커에 접근하기 위한 index 값

			// marker에 접근하는 위치는 아래와 같다. markers는 배열로 이루어져 있다.
			markerLayer.markers[eraseIndex].destroy();

			// destory()를 이용하면 마커 안에 값들이 null로 변해 마커가 화면에서 사라진다. 하지만  배열에서 없어지진 않는다. 내부 값만 null이 된다. 배열에서 없애줘야 한다.

			// 따라서 아래와 같이 splice를 이용해서 없애준다.
			markerLayer.markers.splice(eraseIndex, 1);

			// 그냥 splice로만 지우면 화면에서 지워지지 않는데 그 이유는 모르겠다; 추후 알아보자

			/* 2017-07-12 마커에 접근하는 방법을 수정했다. 현재 코드는 신버전, 아래코드는 구버전
			map.layers[1].markers[eraseIndex].destroy(); 
			map.layers[1].markers.splice(eraseIndex, 1); */

		});
	});
</script>
<section class="section lb page-title little-pad">
	<div class="container">
		<div class="row">
			<div class="col-md-8 col-md-offset-2"
				style="margin-left: 0px; padding-left: 0px">
				<div class="section-big-title clearfix">
					<h3>테스트 페이지입니다.</h3>
					<p>어드민에선 이렇게!</p>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="section bb nopad">
            <div class="container-fluid">
                <div class="row">
                    <div class="content half-map-style col-md-6 col-sm-12">
                        <div class="croise-top search-top clearfix">
                            <div class="row">
                   				<div class="form-group">
									코스를 추가 해 봅시다
									<!-- <input type="text" name="productName" id="productName"
									placeholder="코스이름" class="form-control customform"
									style="height: 40px;"> -->
								</div>
                            </div>
                        </div><!-- end search-top -->

                        <div class="shop-top row clearfix">
           					<div class="col-md-6 col-sm-6 hidden-xs">
								<p>
									<strong>코스 추가</strong>
								</p>
							</div>
                        </div><!-- end shop-top -->

                        <div class="list-wrapper clearfix">
                            <div class="col-custom-1">
								<table class="table">
									<thead>
										<tr>
											<th>번호</th>
											<th>위치명</th>
											<th>간단설명</th>
											<th>위도/경도</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>1</td>
											<td>한큐에 자바-홍대점</td>
											<td>여기가 그곳입니다.</td>
											<td>hi</td>
										</tr>
										<tr>
											<td>2</td>
											<td>홍대입구역 1번출구</td>
											<td>지하철 역입니다</td>
											<td>hi</td>
										</tr>
										<tr>
											<td>3</td>
											<td>홍대 놀이터</td>
											<td>이제 홍대 어린이공원</td>
											<td>hi</td>
										</tr>
										<tr>
											<td>4</td>
											<td>홍익대학교</td>
											<td>미대 짱짱</td>
											<td>hi</td>
										</tr>
									</tbody>
								</table>
                            <button id = "deleteButton">삭제하기</button>
                            </div><!-- end row -->
                        </div><!-- end list-wrapper -->
                    </div><!-- end col -->

                    <div class="col-md-6 col-sm-12 nopad fixmymap">
                        <div class="similar_map_wrap_container">
        					<div id="map_div"></div>
       					</div>
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
