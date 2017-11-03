<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
	var nav = {
		pageSubmitFn : function(options) {
			
			var settings = {
					
				pageName: "main1",
				frmName: "frm",
				url: "main.do"
			};
			
			settings = $.extend({}, settings, options);
			
			$("#pageName").val(settings.pageName);
			
			$("#" + settings.frmName).attr("action", settings.url);
			
			$("#" + settings.frmName).submit();
		},

		// 추천코스 클릭시 #pageNameRec에 값 부여한 뒤 submit
		pageSubmitRecFn : function(pageName, frmName, select) {

			if (select == "recommend") {

				$("#pageNameRec").val("recommend");
				nav.pageSubmitFn({pageName: pageName, frmName: frmName, url: "main.do"});
			} else if (select == "busRecommend") {

				$("#pageNameRec").val("busRecommend");
				nav.pageSubmitFn({pageName: pageName, frmName: frmName, url: "main.do"});
			}

		},
		
		mainMenuCallFn : function() {
			
			ajaxCall.ajaxMainMenuFn({url: "menuList.do", FCGubun: "F"});
		}
	};
	
	var ajaxCall = {
			
			// ajax를 이용해서 depth가 1인 메뉴를 가져온다.
			ajaxMainMenuFn : function(option) {
				
				var that = this;
				
				var settings = {
					
					url: "menuList.do",
					FCGubun: "F",
					menuId: ""
				};
				
				settings = $.extend({}, settings, option);
				
				$.ajax({
					
					type: "POST",
					url: settings.url,
					data: {"menuId": settings.menuId},
					async: false,
					success: function(result) {
						
						var jsonRes = JSON.parse(result);
						
						$.each(jsonRes, function(i, item) {
							
							// depth가 1인 것 중 하위메뉴가 있다면 if문을 탄다.
							if(item.collapseYn == 'Y'){
								
								var strMenu = "";
								var strSubMenu = "";
								
								// 1depth인 현재li의 하위li(2depth)를 가져와 strSubMenu에 스트링으로 저장한다.
								strSubMenu = that.ajaxSubMenuFn({url: "menuList.do",FCGubun: "C", menuId: item.menuId});
								
								// 가져온 strSubMenu는 1depth li하위의 ul안으로 넣어준다.
								strMenu += "<li class=\"dropdown has-submenu\">" + 
                                				"<a href=\"bootstrap-elements.html\" data-target=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\">" + 
													item.menuNm +
                                				"<b class=\"fa fa-angle-down\"></b></a>" +
                               					"<ul class=\"dropdown-menu\">" +
                               						strSubMenu +
                                				"</ul>" +
                            				"</li>";
					                      
								$("#menuTargetLeft").append(strMenu);
								
 							// depth가 1이고 하위메뉴가 없으면 else
							} else {

								var strMenu = "";

								strMenu += "<li>" +
 												"<a href=\"#\" onclick=\"javascript:nav.pageSubmitFn({pageName: \'menu" + item.menuId + "\', frmName: \'frm\', url: \'" + item.menuUrl + "\'})\">" + 
													item.menuNm +  
 												"</a>" +
											"</li>";
											
								// 세션에 값이 없을때(미 로그인)
								if("<c:out value="${sessionScope.memberSession.memberId}"/>" == "") {
									
									// 로그아웃과 admin, mypage는 출력하지 않는다.
									if(item.menuNm != "Logout" && item.menuNm !="ADMIN" && item.menuNm != "마이페이지"){
										
										that.appendFn(item.directions, strMenu);
									}
									
								// 세션에 값은 있는데(기 로그인)
								} else {
									
									
 									// 일반 사용자라면
									if("<c:out value="${sessionScope.memberSession.adminYn}"/>" == "N"){
										
 										//admin과 로그인은 출력하지 않는다.
										if(item.menuNm != "ADMIN" && item.menuNm != "Login" && item.menuNm != "회원가입"){
											
											that.appendFn(item.directions, strMenu);
										}
 									
 									// 어드민 사용자라면 로그인빼고 다 출력한다.
									} else {
										
										if(item.menuNm != "Login" && item.menuNm != "회원가입" && item.menuNm != "마이페이지"){
											
											that.appendFn(item.directions, strMenu);
										}
									}
								}
 							}
						});
					}
				})
			},
			
			// 부모의 id가 같은 2depth li를 가져오는 함수 
			ajaxSubMenuFn: function(option) {
				
				// 가져온 li를 저장할 변수 생성.
				var subMenuStr = "";
				
				var settings = {
						
						url: "menuList.do",
						FCGubun: "C",
						menuId: ""
					};
					
				settings = $.extend({}, settings, option);
					
				$.ajax({
					
					type: "POST",
					url: settings.url,
					data: {"menuId": settings.menuId},
					async: false,
					success: function(result) {
						
						var jsonRes = JSON.parse(result);
						
						$.each(jsonRes, function(i, item) {
							
							if(item.menuNm == "추천코스") {
								
								subMenuStr += "<li>" +
													"<a href=\"#\" onclick=\"javascript:nav.pageSubmitRecFn(\'main\', \'frm\', \'recommend\')\">" + 
														item.menuNm
													"</a>" + 
												"</li>";
							} else {
								
								subMenuStr += "<li>" +
													"<a href=\"#\" onclick=\"javascript:nav.pageSubmitFn({pageName: \'menu" + item.menuId + "\', frmName: \'frm\', url: \'" + item.menuUrl + "\'})\">" + 
														item.menuNm
													"</a>" + 
												"</li>";
							}
						});
					}
				});
				
				return subMenuStr;
			},
			
			appendFn : function(directions ,strMenu){
				
				if(directions == "left"){
					
					$("#menuTargetLeft").append(strMenu);
				} else {
					$("#menuTargetRight").append(strMenu);
				}
			} 
	}

	$(document).ready(function() {

		nav.mainMenuCallFn();
		
	});
</script>

<form id="frm" name="frm">
	<input type="hidden" id="pageName" name="pageName" /> 
	<input type="hidden" id="pageNameRec" name="pageNameRec" />
</form>

<!-- LOADER -->
<div id="preloader">
	<img class="preloader" src="images/loader.gif" alt="">
</div>
<!-- end loader -->
<!-- END LOADER -->

<div class="modal askModal fade ask-write-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog col-lg-12">
		<div class="modal-content">
			<div class="clearfix">
				<div class="custom-tab border-none reviewModalBox">
					<div class="tab-content">
						<div id="menu3" class="tab-pane fade active in">
							<div class="clearfix">
								<div class="comments-list">
									<div class="media review-more-img">
										<h4>1:1 문의하기</h4>
										<form class="contact-form search-top">
											<div class="row">
												<div class="col-md-12">
													<div class="form-group">
				                                        <!-- <select class="selectpicker form-control" name="theme" id="theme" data-size="8" data-live-search="false" title="분야"> -->
				                                        <select class="selectpicker form-control" name="theme" id="theme" data-size="8" data-live-search="false" title="분야">
				                                            <option data-tokens="전체보기">전체보기</option>
				                                            <option data-tokens="예약 및 결제">예약 및 결제</option>
				                                            <option data-tokens="취소 및 환불">취소 및 환불</option>
				                                            <option data-tokens="도보관광 및 버스투어">도보관광 및 버스투어</option>
				                                            <option data-tokens="이벤트">이벤트</option>
				                                            <option data-tokens="기타 문의사항">기타 문의사항</option>
				                                        </select>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-12">
													<div class="form-group">
														<input type="text" class="form-control" name="phone" placeholder="제목을 입력하세요">
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-md-12">
													<textarea placeholder="문의할 내용을 입력하세요" class="form-control"></textarea>
													<button class="btn btn-primary" type="submit" onclick="javascript:alert('전송')">문의 보내기</button>
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
	<div id="wrapper">
		<div class="" id="transNav" ><!-- 페이지가 main이면 투명한 nav적용 -->
	        <header class="header">
	            <div class="container">
	                <nav class="navbar navbar-default">
	                    <div class="container-fluid">
	                        <div class="navbar-collapse collapse navbar-responsive-collapse">
	                            <ul class="nav navbar-nav" id="menuTargetLeft">
	                            </ul>
	                            <ul class="nav navbar-nav navbar-right" id="menuTargetRight">
	                    		</ul>
	                        </div>
	                    </div>
	                </nav>
	            </div><!-- end container -->
	        </header><!-- end header -->
        </div><!-- end transNav -->
    </div><!-- end wrapper -->