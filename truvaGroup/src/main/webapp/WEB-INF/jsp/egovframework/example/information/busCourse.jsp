<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <script src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=75506322-1518-31a1-92d2-4ea1768fab15"></script>
    <script type="text/javascript">
		
        var map;
    	var markerLayer = new Tmap.Layer.Markers( "MarkerLayer" ); // 마커레이어 객체 생성
        
        function init(){
    		
        	var cLonLat = new Tmap.LonLat(14135893.887852,4518348.1852606);  //초기 중심점 좌표. EPSG3857 좌표계 형식으로 선언. 
            var zoom = 14;  // zoom level입니다.  0~19 레벨있음.
            var mapW = '100%';  // 지도의 가로 크기 입니다.
            var mapH = '100%';  // 지도의 세로 크기 입니다.
            
            map = new Tmap.Map({div:'map_div', width:mapW, height:mapH, animation:true}); 
            					// div : 지도가 생성될 div의 id값과 같은 값을 옵션으로 정의, animation은 뭐하는 앤지 알아볼 필요 있음
            map.setCenter(cLonLat,zoom); // 지도 초기 값 설정
        	map.addLayer(markerLayer); // map객체에 마커 등록
        	
        	// 코스 리스트에서 출발지 좌표값을 받아 json으로 생성
        	var markerLonlat = {
   				"marker1" : {"lon": 14134405.455675, "lat": 4516747.1878169},
   				"marker2" : {"lon": 14134391.123732, "lat": 4517115.0410154},
   				"marker3" : {"lon": 14134833.0253, "lat": 4517447.064357},
   				"marker4" : {"lon": 14135186.546556, "lat": 4518736.9392091},
   				"marker5" : {"lon": 14137040.144492, "lat": 4518655.7248665},
   				"marker6" : {"lon": 14135950.916839, "lat": 4519773.6164051},
           	}
            
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
           	
        	//marker 생성 후 모두 보이게 zoom 변경
           	markerLayer.events.register("loadend", markerLayer, showRoute);//point의 아이콘 삭제
        }
    	
		function showRoute(event){ 
        	
            map.zoomToExtent(this.getDataExtent())
        }
    	

		function addMarker2(lonlat, iconRef){	 
        	
        	// icon생성
        	var icon = addIcon2(iconRef);
           	
            var marker = new Tmap.Marker(lonlat, icon); // 마커 생성
            markerLayer.addMarker(marker); // 레이어에 마커 추가
        }
		function addIcon2(iconRef){
        	
        	//icon 생성
        	var size = new Tmap.Size(30, 44);
        	var offset = new Tmap.Pixel(-(size.w/2), -(size.h/2)); // icon이 지도에 표시될 상대적 위치, 사이즈의 가운데에 위치시켜라.
        	
        	//아래에서 아이콘 그림 수정 가능
           	var icon = new Tmap.Icon(iconRef, size, offset);
        	
        	return icon;
        }
        
        function addMarker(lonlat){	 
        	
        	// icon생성
        	var icon = addIcon();
           	
            var marker = new Tmap.Marker(lonlat, icon); // 마커 생성
            markerLayer.addMarker(marker); // 레이어에 마커 추가
        }
        
        function addIcon(){
        	
        	//icon 생성
        	var size = new Tmap.Size(30, 44);
        	var offset = new Tmap.Pixel(-(size.w/2), -(size.h/2)); // icon이 지도에 표시될 상대적 위치, 사이즈의 가운데에 위치시켜라.
        	
        	//아래에서 아이콘 그림 수정 가능
           	var icon = new Tmap.Icon('https://developers.skplanetx.com/upload/tmap/marker/pin_b_m_a.png', size, offset);
        	
        	return icon;
        }
        
        // 위시리스트 기능, 하트 클릭하면 변함
    	function changeHeart(id){
			
			$("#"+id).toggleClass('fa-heart fa-heart-o');
		}
        
        function shoppingCart(id){
        	
        	nav.pageSubmitFn('memberReservationBus', 'frm');
        }
        
        $(document).ready(function() {
        	
        	init(); // 초기 지도를 세팅하고 클릭하면 마커 추가
		});
    </script>
    
        <section class="section lb page-title little-pad">
            <div class="container">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2" style="margin-left: 0px; padding-left: 0px">
                        <div class="section-big-title clearfix">                        
                            <h3>버스 여행</h3>
                            <p>조금 더 편하게 서울을 즐기세요</p>
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
                                <div class="col-sm-3">
	                                <div class="form-group"> 
	                                    <input type="text" name="productName" id="productName" placeholder="코스이름" class="form-control customform" style="height: 40px;">
	                                </div>
                                </div>

                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <select class="selectpicker form-control" data-size="8" data-live-search="false" title="테마">
                                            <option data-tokens="도심·고궁 투어">도심·고궁 투어</option>
                                            <option data-tokens="서울파노라마코스">파노라마코스</option>
                                            <option data-tokens="야간코스">야간코스</option>
                                            <option data-tokens="시티투어">시티투어</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <select class="selectpicker form-control" data-size="8" data-live-search="false" title="가격">
                                            <option data-tokens="5만원  미만">5만원 미만</option>
                                            <option data-tokens="5~10만원">5~10만원</option>
                                            <option data-tokens="10~15만원">10~15만원</option>
                                            <option data-tokens="15만원 이상">15만원 이상</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-sm-3">
                                    <a href="#" class="btn btn-primary btn-block">SEARCH</a>
                                </div>
                            </div>
                        </div><!-- end search-top -->

                        <div class="shop-top row clearfix">
                            <div class="col-md-6 col-sm-6 hidden-xs">
                                <p><strong>170 Results</strong></p>
                            </div>

                            <div class="col-md-6 col-sm-6 text-right">
                                <p><a href="#">Reset all</a> 코스 보기</p>
                            </div>
                        </div><!-- end shop-top -->

                        <div class="list-wrapper clearfix">
                            <div class="row">
                                <div class="col-md-6 col-sm-6 first">
                                    <div class="list-item">
                                        <a href="#" onclick="nav.pageSubmitFn({pageName: 'seoulro', frmName: 'frm', url: 'seoulro.do'})" title="">
	                                        <div class="entry">
	                                            <div class="ribbon"><span>POPULAR</span></div>
	                                            <img src="images/uploads/seoulro_1.jpg" alt="" class="img-responsive">
	                                            <div class="magnifier">
	                                                <div class="magni-desc">
	                                                <div class="rating">
	                                                    <small>24 (Reviews)</small>
	                                                    <i class="fa fa-star"></i>
	                                                    <i class="fa fa-star"></i>
	                                                    <i class="fa fa-star"></i>
	                                                    <i class="fa fa-star"></i>
	                                                    <i class="fa fa-star"></i>
	                                                </div><!-- end rating -->
	                                                </div>
	                                            </div><!-- end magnifier -->
	                                        </div><!-- end entry -->
                                        </a>

                                        <div class="list-desc clearfix">
                                            <h4><a href="#" title="" onclick="nav.pageSubmitFn({pageName: 'seoulro', frmName: 'frm', url: 'seoulro.do'})">한양에서 서울로</a></h4>
                                            <ul class="list-inline">
                                                <li class="small">성곽도시 한양에서 천만도시 서울까지 600년 시간 여행</li>
                                            </ul>

                                            <ul class="list-bottom list-inline">
                                                <li><sub>10%</sub> Discounts</li>
                                                <li>
                                                    <sup class="old-price">60,000&#8361;</sup>
                                                    <sup class="new-price">54,000&#8361;</sup>
                                                </li>
                                                <a class="courseicon hearticon"><i id="heart1" class="fa fa-heart-o" onclick="javascript:changeHeart('heart1')"></i></a>
                                                <a class="courseicon carticon"><i id="cart1"class="fa fa-shopping-cart" onclick="javascript:shoppingCart('cart1')"></i></a>                                                
                                            </ul><!-- end list-bottom -->
                                            
                                        </div><!-- end list-desc -->
                                    </div><!-- end list-item -->
                                </div><!-- end col -->

                                <div class="col-md-6 col-sm-6 last">
                                    <div class="list-item">
                                        <a href="#" onclick="nav.pageSubmitFn({pageName: 'seoulro', frmName: 'frm', url: 'seoulro.do'})" title="">
                                        <div class="entry">
                                            <div class="ribbon"><span>POPULAR</span></div>
                                            <img src="images/uploads/bukchon_1.jpg" alt="" class="img-responsive">
                                            <div class="magnifier">
                                                <div class="magni-desc">
                                                <div class="rating">
                                                    <small>12 (Reviews)</small>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                </div><!-- end rating -->
                                                </div>
                                            </div><!-- end magnifier -->
                                        </div><!-- end entry -->
                                        </a>

                                        <div class="list-desc clearfix">
                                            <h4><a href="#" onclick="nav.pageSubmitFn({pageName: 'seoulro', frmName: 'frm', url: 'seoulro.do'})" title="">서울로 건축기행</a></h4>
                                            <ul class="list-inline">
                                                <li class="small">개화기 이후 서울의 근·현대 역사와 함께 떠나는 여행</a></li>
                                            </ul>

                                            <ul class="list-bottom list-inline">
                                                <li><sub>20%</sub> Discounts</li>
                                                <li>
                                                    <sup class="old-price">50,000&#8361;</sup>
                                                    <sup class="new-price">40,000&#8361;</sup>
                                                </li>
                                                <a class="courseicon hearticon"><i id="heart2" class="fa fa-heart-o" onclick="javascript:changeHeart('heart2')"></i></a>
                                                <a class="courseicon carticon"><i id="cart2" class="fa fa-shopping-cart" onclick="javascript:shoppingCart('cart2')"></i></a>                                                
                                            </ul><!-- end list-bottom -->
                                        </div><!-- end list-desc -->
                                    </div><!-- end list-item -->
                                </div><!-- end col -->

                                <div class="col-md-6 col-sm-6 first">
                                    <div class="list-item">
                                        <a href="#" onclick="nav.pageSubmitFn({pageName: 'seoulro', frmName: 'frm', url: 'seoulro.do'})" title="">
                                        <div class="entry">
                                            <img src="images/uploads/hanriver_1.jpg" alt="" class="img-responsive">
                                            <div class="magnifier">
                                                <div class="magni-desc">
                                                <div class="rating">
                                                    <small>24 (Reviews)</small>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                </div><!-- end rating -->
                                                </div>
                                            </div><!-- end magnifier -->
                                        </div><!-- end entry -->
                                        </a>

                                        <div class="list-desc clearfix">
                                            <h4><a href="#" onclick="nav.pageSubmitFn({pageName: 'seoulro', frmName: 'frm', url: 'seoulro.do'})" title="">서울로 야행</a></h4>
                                            <ul class="list-inline">
                                                <li class="small">서울의 야경과 함께 떠나는 서울역 역사 이야기</li>
                                            </ul>

                                            <ul class="list-bottom list-inline">
                                                <li><sub>15%</sub> Discounts</li>
                                                <li>
                                                    <sup class="old-price">50,000&#8361;</sup>
                                                    <sup class="new-price">35,000&#8361;</sup>
                                                </li>
                                                <a class="courseicon hearticon"><i id="heart3" class="fa fa-heart-o" onclick="javascript:changeHeart('heart3')"></i></a>
                                                <a class="courseicon carticon"><i id="cart3"class="fa fa-shopping-cart" onclick="javascript:shoppingCart('cart3')"></i></a>                                                
                                            </ul><!-- end list-bottom -->
                                        </div><!-- end list-desc -->
                                    </div><!-- end list-item -->
                                </div><!-- end col -->

                                <div class="col-md-6 col-sm-6 last">
                                    <div class="list-item">
                                        <a href="#" onclick="nnav.pageSubmitFn({pageName: 'seoulro', frmName: 'frm', url: 'seoulro.do'}))" title="">
                                        <div class="entry">
                                            <img src="images/uploads/cheonggyecheon_1.jpg" alt="" class="img-responsive">
                                            <div class="magnifier">
                                                <div class="magni-desc">
                                                <div class="rating">
                                                    <small>24 (Reviews)</small>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                </div><!-- end rating -->
                                                </div>
                                            </div><!-- end magnifier -->
                                        </div><!-- end entry -->
                                        </a>

                                        <div class="list-desc clearfix">
                                            <h4><a href="#" onclick="nav.pageSubmitFn({pageName: 'seoulro', frmName: 'frm', url: 'seoulro.do'})" title="">청계천1</a></h4>
                                            <ul class="list-inline">
                                                <li class="small">맑은 공기와 깨끗한 물이 어우러진 도심속 휴식 공간</li>
                                            </ul>

                                            <ul class="list-bottom list-inline">
                                                <li><sub>25%</sub> Discounts</li>
                                                <li>
                                                    <sup class="old-price">80,000&#8361;</sup>
                                                    <sup class="new-price">60,000&#8361;</sup>
                                                </li>
                                                <a class="courseicon hearticon"><i id="heart4" class="fa fa-heart-o" onclick="javascript:changeHeart('heart4')"></i></a>
                                                <a class="courseicon carticon"><i id="cart4" class="fa fa-shopping-cart" onclick="javascript:shoppingCart('cart4')"></i></a>
                                            </ul><!-- end list-bottom -->
                                        </div><!-- end list-desc -->
                                    </div><!-- end list-item -->
                                </div><!-- end col --> 

                                <div class="col-md-6 col-sm-6 first">
                                    <div class="list-item">
                                        <a href="#" onclick="nav.pageSubmitFn({pageName: 'seoulro', frmName: 'frm', url: 'seoulro.do'})" title="">
                                        <div class="entry">
                                            <img src="images/uploads/cheonggyecheon_2.jpg" alt="" class="img-responsive">
                                            <div class="magnifier">
                                                <div class="magni-desc">
                                                <div class="rating">
                                                    <small>12 (Reviews)</small>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                </div><!-- end rating -->
                                                </div>
                                            </div><!-- end magnifier -->
                                        </div><!-- end entry -->
                                        </a>

                                        <div class="list-desc clearfix">
                                            <h4><a href="#" onclick="nav.pageSubmitFn({pageName: 'seoulro', frmName: 'frm', url: 'seoulro.do'})" title="">청계천2</a></h4>
                                            <ul class="list-inline">
                                                <li class="small">맑은 공기와 깨끗한 물이 어우러진 도심속 휴식 공간</li>
                                            </ul>

                                            <ul class="list-bottom list-inline">
                                                <li>
                                                    <sup class="new-price">60,000&#8361;</sup>
                                                </li>
                                            <a class="courseicon hearticon"><i id="heart5" class="fa fa-heart-o" onclick="javascript:changeHeart('heart5')"></i></a>
                                            <a class="courseicon carticon"><i id="cart5" class="fa fa-shopping-cart" onclick="javascript:shoppingCart('cart5')"></i></a>
                                            </ul><!-- end list-bottom -->
                                        </div><!-- end list-desc -->
                                    </div><!-- end list-item -->
                                </div><!-- end col -->

                                <div class="col-md-6 col-sm-6 last">
                                    <div class="list-item">
                                        <a href="#" onclick="nav.pageSubmitFn({pageName: 'seoulro', frmName: 'frm', url: 'seoulro.do'})" title="">
                                        <div class="entry">
                                            <img src="images/uploads/bukchon_2.jpg" alt="" class="img-responsive">
                                            <div class="magnifier">
                                                <div class="magni-desc">
                                                <div class="rating">
                                                    <small>24 (Reviews)</small>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                </div><!-- end rating -->
                                                </div>
                                            </div><!-- end magnifier -->
                                        </div><!-- end entry -->
                                        </a>

                                        <div class="list-desc clearfix">
                                            <h4><a href="#" onclick="nav.pageSubmitFn({pageName: 'seoulro', frmName: 'frm', url: 'seoulro.do'})" title="">북촌 한옥마을</a></h4>
                                            <ul class="list-inline">
                                                <li class="small">서울의 한옥들과 한국 고유의 문화를 체험하고 알릴 수 있는코스입니다.</li>
                                            </ul>

                                            <ul class="list-bottom list-inline">
                                                <li>
                                                    <sup class="new-price">40,000&#8361;</sup>
                                                </li>
                                                <a class="courseicon hearticon"><i id="heart6" class="fa fa-heart-o" onclick="javascript:changeHeart('heart6')"></i></a>
                                                <a class="courseicon carticon"><i id="cart6" class="fa fa-shopping-cart" onclick="javascript:shoppingCart('cart6')"></i></a>
                                            </ul><!-- end list-bottom -->
                                        </div><!-- end list-desc -->
                                    </div><!-- end list-item -->
                                </div><!-- end col -->
                            </div><!-- end row -->
                        </div><!-- end list-wrapper -->

                        <ul class="pagination">
                            <li class="disabled"><a href="javascript:void(0)">&laquo;</a></li>
                            <li class="active"><a href="javascript:void(0)">1</a></li>
                            <li><a href="javascript:void(0)">2</a></li>
                            <li><a href="javascript:void(0)">3</a></li>
                            <li><a href="javascript:void(0)">...</a></li>
                            <li><a href="javascript:void(0)">&raquo;</a></li>
                        </ul>
                    </div><!-- end col -->

                    <div class="col-md-6 col-sm-12 nopad fixmymap">
                        <div class="similar_map_wrap_container">
        					<div id="map_div"></div>
       					</div>
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end section -->
    </div><!-- end wrapper -->
