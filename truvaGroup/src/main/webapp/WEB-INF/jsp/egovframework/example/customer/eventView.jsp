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
										<h4>참여되었습니다.</h4>
										<form class="contact-form search-top">
											<div class="row">
												<div class="col-md-12">
														
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
                <div class="row">
                    <div class="col-md-8">
                        <div class="content">
                                <div class="custom-tab">
                                    <ul class="nav nav-tabs">
                                        <li class="active"><a data-toggle="tab" href="#menu1"><i class="fa fa-location-arrow"></i> 이벤트정보 </a></li>
                                        <li><a data-toggle="tab" href="#menu3"><i class="fa fa-thumbs-up"></i> 리뷰</a></li>
                                    </ul>
                                    <div class="entry">
                                        <img src="images/uploads/cruise_01.jpg"  alt="" class="img-responsive">
                                        <div class="magnifier">
                                            <div class="magni-desc">
                                                <div class="rating">
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                    <i class="fa fa-star"></i>
                                                </div>
                                                <!-- end rating -->
                                            </div>
                                        </div>
                                        <!-- end magnifier -->
                                    </div>
                                    <div class="tab-content">
                                        <div id="menu1" class="tab-pane fade in active">
                                            <div class="hotel-informations clearfix">
	                                            <div class="detail">
	                                               		<p> 내용 </p>
	                                               		<p> .</p>
	                                                                         
													    <input type="button" class="btn btn-primary" value="참여하기" onclick="javascript:void(0)"  
													     data-toggle="modal" data-target=".list-view-modal" align="right">
	                                             
	                                                	<br>
	    	                                            <h4>협찬 기업</h4>
	    	                                            <h4>기업1</h4>
														<p> ~~~</p>
	    	                                            <h4>기업2</h4>
														<p> ~~~</p>
	    	                                            <h4>기업3</h4>
														<p> ~~~</p>
	    	                                            <h4>기업4</h4>
														<p> ~~~</p>
	    	                                            <h4>기업5</h4>
														<p> ~~~</p>
												
														
		                                        </div>    
                                            </div>
			                             	
                                        </div>
                                        
                                        <div id="menu3" class="tab-pane fade">
                                            <div class="car-details-box clearfix">
                                                <h3 class="car-single-title">
                                                    <i class="flaticon-avatar"></i> Reviews (2)
                                                </h3>

                                                <div class="comments-list">
                                                    <div class="media">
                                                        <p class="pull-right"><small>4 days ago</small></p>
                                                        <a class="media-left" href="#">
                                                            <img src="images/uploads/people_12.jpg" alt="" class="img-circle">
                                                        </a>
                                                        <div class="media-body">
                                                            <h4 class="media-heading user_name">Matt Damon 님</h4>

                                                            <h5>Great attraction!</h5>

                                                            <p>I love this course. Very organized and efficient and even reasonable price. If I hadn`t used this course, I couldn`t have fully felt attraction of seoul. Thank You. Highly recommend.</p>

                                                            <div class="comment-review clearfix">
                                                                <div class="row">
                                                                    <div class="col-md-12 review-wrap">
                                                                        <div class="form-group clearfix">
                                                                            <div class="pull-left">
                                                                                <label>코스 만족도</label>
                                                                            </div>
                                                                            <div class="pull-right">
                                                                                <div class="rating">
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star-o"></i></a>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-12 review-wrap">
                                                                        <div class="form-group clearfix">
                                                                            <div class="pull-left">
                                                                                <label>해설사 만족도</label>
                                                                            </div>
                                                                            <div class="pull-right">
                                                                                <div class="rating">
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-12 review-wrap">
                                                                        <div class="form-group clearfix">
                                                                            <div class="pull-left">
                                                                                <label>사이트 만족도</label>
                                                                            </div>
                                                                            <div class="pull-right">
                                                                                <div class="rating">
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-12 review-wrap">
                                                                        <div class="form-group clearfix">
                                                                            <div class="pull-left">
                                                                                <label>전체 평점</label>
                                                                            </div>
                                                                            <div class="pull-right">
                                                                                <div class="rating">
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star-o"></i></a>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- end comment-review -->
                                                        </div>
                                                    </div>

                                                    <div class="media">
                                                        <p class="pull-right"><small>7 days ago</small></p>
                                                        <a class="media-left" href="#">
                                                            <img src="images/uploads/people_11.jpg" alt="" class="img-circle">
                                                        </a>
                                                        <div class="media-body">

                                                            <h4 class="media-heading user_name">강진성 님</h4>

                                                            <h5>알차고 좋았습니다!</h5>

                                                            <p>여름이라 덥긴 했지만 훌륭한 해설과 알찬 코스덕에 재밌는 여행 했습니다. 서울을 다시 여행하게 된다면 다른 코스도 경험해 보고 싶네요^^ 추천드립니다.</p>

                                                            <div class="comment-review clearfix">
                                                                <div class="row">
                                                                    <div class="col-md-12 review-wrap">
                                                                        <div class="form-group clearfix">
                                                                            <div class="pull-left">
                                                                                <label>코스 만족도</label>
                                                                            </div>
                                                                            <div class="pull-right">
                                                                                <div class="rating">
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star-o"></i></a>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-12 review-wrap">
                                                                        <div class="form-group clearfix">
                                                                            <div class="pull-left">
                                                                                <label>해설사 만족도</label>
                                                                            </div>
                                                                            <div class="pull-right">
                                                                                <div class="rating">
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star-o"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star-o"></i></a>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-12 review-wrap">
                                                                        <div class="form-group clearfix">
                                                                            <div class="pull-left">
                                                                                <label>이벤트 만족도</label>
                                                                            </div>
                                                                            <div class="pull-right">
                                                                                <div class="rating">
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-md-12 review-wrap">
                                                                        <div class="form-group clearfix">
                                                                            <div class="pull-left">
                                                                                <label>전체 평점</label>
                                                                            </div>
                                                                            <div class="pull-right">
                                                                                <div class="rating">
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star"></i></a>
                                                                                    <a href="#" class="active"><i class="fa fa-star-o"></i></a>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <!-- end comment-review -->
                                                        </div>
                                                    </div>
                                                </div>

                                                <ul class="pagination">
						                            <li class="disabled"><a href="javascript:void(0)">&laquo;</a></li>
						                            <li class="active"><a href="javascript:void(0)">1</a></li>
						                            <li><a href="javascript:void(0)">2</a></li>
						                            <li><a href="javascript:void(0)">3</a></li>
						                            <li><a href="javascript:void(0)">...</a></li>
						                            <li><a href="javascript:void(0)">&raquo;</a></li>
						                        </ul>

                                            </div>
                                            <!-- end content -->
                                        </div>
                                    </div>
                                </div><!-- end custom-tab -->

                            </div>
                        </div><!-- end grid -->
                    </div><!-- end col -->

                    
                </div><!-- end row -->
                
                
            </div><!-- end container -->
        </section><!-- end section -->
    	
    	