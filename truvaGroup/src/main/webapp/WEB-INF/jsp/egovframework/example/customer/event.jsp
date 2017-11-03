<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.list-view {
	position: absolute;
	right: 0;
	top: -3px;
	padding: 0;
	z-index: 10;
}
.list-view > button {
	padding: 2px 5px;
}

.listModal > .modal-dialog {
   position: absolute;
   top: 6%;
   left: 21%;
   right: 21%;
   width: auto;
}
</style>
<div class="modal listModal fade list-view-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog col-lg-12">
		<div class="modal-content">
			<div class="clearfix">
				<div class="custom-tab border-none reviewModalBox">
					<div class="tab-content">
						<div id="menu3" class="tab-pane fade active in">
							<div class="clearfix">
								<div class="comments-list">
									<div class="media review-more-img">
										<h4>당첨자 리스트</h4>
										<form class="contact-form search-top">
											<div class="row">
												<div class="col-md-12">
														당첨자1
														당첨자2
														당첨자3
												</div>
											</div>
										</form>
									</div>
								</div>

							</div><!-- end clearfix -->
						</div>
					</div><!-- end custom-tab -->
				</div>
			</div><!-- end grid -->
		</div>
	</div>
</div>
        
        <section class="section">
            <div class="container">
                <div class="row sitemap">
                    <div class="col-md-4">
                        <div class="shortcode-wrap">
                       	    <h4 class="customtitle">친구추천 이벤트</h4>
                        	<hr class="custom1">
                            <div class="car-wrapper clearfix">
                                <a href="#" onclick="nav.pageSubmitFn('eventView', 'frm')" title="">
                                <div class="post-media entry">
                               		<img src="images/uploads/cruise_01.jpg" alt="" class="img-responsive">
                                  <!--   <div class="car-price"><p>$78900</p></div> -->
                                    <ul class="list-inline">
                                    </ul>
                                </div><!-- end post-media -->
                              	</a>
                              	
                            </div><!-- end clearfix -->
	                        <div class="list-desc clearfix">
	                                  <span class="cruise-span">기간:<strong>17/07/15~17/08/15</strong></span>
	                                  <h4><a href="" title="">친구 추천시 마일리지 증정</a></h4>
	                                  <ul class="list-inline">
	                                      <li class="small">많은 추천을 받은 분에게는 경품이!!</li>
	                                  </ul>
	                        </div><!-- end list-desc -->
                        </div>
                    </div><!-- end col -->

                    <div class="col-md-4">
                        <div class="shortcode-wrap">
                            <h4 class="customtitle">오픈 & 복날 이벤트</h4>
                            <hr class="custom1">
                            <div class="list-item">
                                <a href="#" onclick="nav.pageSubmitFn('eventView', 'frm')" title="">
                                <div class="entry">
                                	<div class="ribbon"><span>POPULAR</span></div>
                                	<img src="images/uploads/cruise_03.jpg" alt="" class="img-responsive">
                                    <div class="magnifier">
                                        <div class="magni-desc">
                                            <div class="rating">
                                                <small>여름 시즌 대박세일</small>
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
	                                        <span class="cruise-span">7 nights, 6 days - from <strong>€1,600</strong></span>
	                                        <h4><a href="cruise-single.html" title="">Spain Boat Tour</a></h4>
	                                        <ul class="list-inline">
	                                            <li class="small">Include Port Taxes</li>
	                                            <li class="small">From: <a href="#">Italy to Spain</a></li>
	                                        </ul>
	                                </div><!-- end list-desc -->
                            </div><!-- end list-item -->
                        </div>
                    </div><!-- end col -->

                    <div class="col-md-4">
                        <div class="shortcode-wrap">
                            <h4 class="customtitle">경복궁 이벤트</h4>
                            <hr class="custom1">
                            <div class="list-three-item cruise-list">
                                <div class="list-item">
                                    	<a href="#" onclick="javascript:nav.pageSubmitFn({pageName: 'eventView', frmName: 'frm', url: 'eventView.do'})" title="">
                                        <div class="entry">
                                            <!-- <div class="ribbon"><span>POPULAR</span></div> -->
                                            <img src="images/uploads/cruise_03.jpg" alt="" class="img-responsive">
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
                                    </a>
                                    <div class="list-desc clearfix">
                                        <span class="cruise-span">7 nights, 6 days - from <strong>€1,600</strong></span>
                                        <h4><a href="cruise-single.html" title="">Spain Boat Tour</a></h4>
                                        <ul class="list-inline">
                                            <li class="small">Include Port Taxes</li>
                                            <li class="small">From: <a href="#">Italy to Spain</a></li>
                                        </ul>
                                    </div><!-- end list-desc -->
                                </div><!-- end list-item -->
                            </div><!-- end list-three-item -->
                        </div>
                    </div><!-- end col -->
                </div><!-- end row -->
                <br>
                <br>
                <br>
                <div class="row">
	                    <div class="align-center">
	                        <ul class="pagination">
	                            <li class="disabled"><a href="javascript:void(0)">&laquo;</a></li>
	                            <li class="active"><a href="javascript:void(0)">1</a></li>
	                            <li><a href="javascript:void(0)">2</a></li>
	                            <li><a href="javascript:void(0)">3</a></li>
	                            <li><a href="javascript:void(0)">...</a></li>
	                            <li><a href="javascript:void(0)">&raquo;</a></li>
	                        </ul>
	                    </div>
                </div>
                
                <br>
                <br>
                <br>
              
                <hr class="custom12">
                <div class="section-big-title text-center">
                    <h2><strong><font color="#f18167">TourQ</font> 종료된 이벤트 </strong> </h2>
                </div><!-- end title --> 
                <div class="row">
                    <div class="col-md-12">
                        <div class="content">
                            

                            <div class="blog-wrapper blog-masonry">
                                <div class="portfolio row gallery_items">
                                    <div class="pitem item-w1 item-h1 cat2">
                                        <div class="blog-item">
                                            <div class="entry">
	                                              <div class="post-media reservationComplet-tag" onclick="javascript:void(0)"  data-toggle="modal" data-target=".list-view-modal">
					                                <span class="tab-bg"></span>
	                                                <img src="images/uploads/cruise_02.jpg" alt="" class="img-responsive">
	                                              </div>
                                                  <div class="magnifier">
                                                    <div class="magni-portfolio">
                                                        <a data-gall="myGallery" class="venobox"><i class="fa fa-plus"></i></a>
                                                    </div>
                                                  </div><!-- end magnifier -->
                                            </div>
                                        </div><!-- end blog-item -->
                                    </div><!-- end col -->

                                    <div class="pitem item-w1 item-h1 cat3">
                                        <div class="blog-item">
                                            <div class="entry">
                                            	 <div class="post-media reservationComplet-tag" onclick="javascript:void(0)"  data-toggle="modal" data-target=".list-view-modal">
					                                <span class="tab-bg"></span>
                                                  	<img src="images/uploads/cruise_03.jpg" alt="" class="img-responsive">
	                                              </div>
                                                  <div class="magnifier">
                                                    <div class="magni-portfolio">
                                                        <a href="images/uploads/cruise_03.jpg" data-gall="myGallery" class="venobox"><i class="fa fa-plus"></i></a>
                                                    </div>
                                                  </div><!-- end magnifier -->
                                            </div>
                                        </div><!-- end blog-item -->
                                    </div><!-- end col -->

                                    <div class="pitem item-w1 item-h1 cat4">
                                        <div class="blog-item">
                                            <div class="entry">
                                            	 <div class="post-media reservationComplet-tag" onclick="javascript:void(0)"  data-toggle="modal" data-target=".list-view-modal">
					                                <span class="tab-bg"></span>
                                                  	<img src="images/uploads/cruise_04.jpg" alt="" class="img-responsive">
	                                              </div>
                                                  <div class="magnifier">
                                                    <div class="magni-portfolio">
                                                        <a href="images/uploads/cruise_04.jpg" data-gall="myGallery" class="venobox"><i class="fa fa-plus"></i></a>
                                                    </div>
                                                  </div><!-- end magnifier -->
                                            </div>
                                        </div><!-- end blog-item -->
                                    </div><!-- end col -->

                                    <div class="pitem item-w1 item-h1 cat1">
                                        <div class="blog-item">
                                            <div class="entry">
                                            	 <div class="post-media reservationComplet-tag" onclick="javascript:void(0)"  data-toggle="modal" data-target=".list-view-modal">
					                                <span class="tab-bg"></span>
	                                                <img src="images/uploads/cruise_05.jpg" alt="" class="img-responsive">
	                                              </div>
                                                  <div class="magnifier">
                                                    <div class="magni-portfolio">
                                                        <a href="images/uploads/cruise_05.jpg" data-gall="myGallery" class="venobox"><i class="fa fa-plus"></i></a>
                                                    </div>
                                                  </div><!-- end magnifier -->
                                            </div>
                                        </div><!-- end blog-item -->
                                    </div><!-- end col -->

                                    <div class="pitem item-w1 item-h1 cat2">
                                        <div class="blog-item">
                                            <div class="entry">
                                             	  <div class="post-media reservationComplet-tag" onclick="javascript:void(0)"  data-toggle="modal" data-target=".list-view-modal">
					                                <span class="tab-bg"></span>
	                                                <img src="images/uploads/cruise_06.jpg" alt="" class="img-responsive">
	                                              </div>
                                                  <div class="magnifier">
                                                    <div class="magni-portfolio">
                                                        <a href="images/uploads/cruise_06.jpg" data-gall="myGallery" class="venobox"><i class="fa fa-plus"></i></a>
                                                    </div>
                                                  </div><!-- end magnifier -->
                                            </div>
                                        </div><!-- end blog-item -->
                                    </div><!-- end col -->
                                    
                                    

                                </div><!-- end row -->
                            </div><!-- end masonry -->
                        </div><!-- end grid -->
                    </div><!-- end col -->
            		<div class="align-center">
                        <ul class="pagination">
                            <li class="disabled"><a href="javascript:void(0)">&laquo;</a></li>
                            <li class="active"><a href="javascript:void(0)">1</a></li>
                            <li><a href="javascript:void(0)">2</a></li>
                            <li><a href="javascript:void(0)">3</a></li>
                            <li><a href="javascript:void(0)">...</a></li>
                            <li><a href="javascript:void(0)">&raquo;</a></li>
                        </ul>
                    </div>
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end section -->
        

    <!-- PORTFOLIO -->
    <script src="js/venobox/venobox.min.js"></script> 
    <script src="js/masonry.js"></script> 
    <script src="js/gallery_03.js"></script>

	