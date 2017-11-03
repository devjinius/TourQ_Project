<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
	
	var left = 
	{
		adminSubmitFn	: function(adminPageName, url, frmadmin) {
			
			$("#adminPageName").val(adminPageName);
			$("#"+frmadmin).attr("action", url);
			$("#"+frmadmin).submit();
		},
		adminMenuFn		: function(){
			
			ajaxMenu.ajaxMenuList({url : "adminMenuList.do", menuId : ""});
		}
	}
	
	var ajaxMenu = {
			
		ajaxMenuList	: function(option){
			
			var that = this;
			
			var setting = {
				
				url		: "adminMenuList.do",
				menuId	: ""
			}
			setting = $.extend({}, setting, option);
			
			$.ajax({
				
				type	: "POST",
				url		: setting.url,
				async	: false,
				data	: {"menuId" : setting.menuId},
				success	: function(result){
					
					var jsonRes = JSON.parse(result);
					
					$.each(jsonRes, function(i, item){
						
						if (item.collapseYn == "Y") {
							
							var subMenu = that.ajaxSubMenuList({url : item.menuUrl, menuId : item.menuId});
							
							var mainMenu = 
							'<li class="has_submenu highLight">'
								+'<a href="#">'
									+'<i class="fa '+ item.menuClass +'"></i>'
									+ item.menuNm
									+'<span class="pull-right"><i class="fa fa-angle-down"></i></span>'
								+'</a>'
								+'<ul>'
									+ subMenu
								+'</ul>'
							+'</li>'
								
							$("#navi").append(mainMenu);
						} else {
							
							var mainMenu =
							'<li class="highLight">'
								+'<a href="#" id="menu'+ item.menuId +'" onclick="javascript:left.adminSubmitFn(\'menu'+ item.menuId +'\',\''+ item.menuUrl +'\',\'frmAdmin\')">'
									+'<i class="fa '+ item.menuClass +'"></i>'
									+item.menuNm
								+'</a>'
							+'</li>'
							
							$("#navi").append(mainMenu);
						}
					})
				}
			});
		},
		ajaxSubMenuList	: function(option){
			
			var subMenu = "";
					
			var setting = {
				
				url		: "adminMenuList.do",
				menuId	: ""
			}
			setting = $.extend({}, setting, option);
			
			$.ajax({
				
				type	: "POST",
				url		: setting.url,
				async	: false,
				data	: {"menuId" : setting.menuId},
				success	: function(result){
					
					var jsonRes = JSON.parse(result);
					
					$.each(jsonRes, function(i, item){
						
						subMenu +=
								'<li>'
									+'<a href="#" id="menu'+ item.menuId +'" onclick="javascript:left.adminSubmitFn(\'menu'+ item.menuId +'\',\''+ item.menuUrl +'\',\'frmAdmin\')">'
										+ item.menuNm
									+'</a>'
								+'</li>'
					});
				}
			});
			return subMenu;
		}
	}

	/* 메뉴클릭시 슬라이드 */
	var menuSlide = {
		
		menuListTarget : null,
		
		getTarget : function() {
			
			this.menuListTarget = $("#navi > li");
		},
		
		menuToggle : function() {
			
			var listTarget = $("#navi > li");
			
			listTarget.click(function() {
				
				var eTarget = $(this);

				listTarget.removeClass("current");

				listTarget.find(".pull-right i").removeClass("fa-angle-up").addClass("fa-angle-down");
				
				eTarget.addClass("current");
				
				if (!(eTarget.hasClass("open"))) {

					eTarget.find(".pull-right i").removeClass("fa-angle-up").addClass("fa-angle-down");
				} else{

					eTarget.find(".pull-right i").removeClass("fa-angle-down").addClass("fa-angle-up");
				}
			});
		},
		
		slideToggle : function() {
			
			var that = this;

			$(this.menuListTarget).children("a").click(function(e){
				
				e.preventDefault();
				
				var subMenu = $(this).next("ul"),
					target	= $(this).parent("li");
				
				if (target.hasClass("open")) {
					
					subMenu.slideUp(350);
					target.removeClass("open");
				} else {
					
					that.menuListTarget.children("ul").slideUp(350);
					that.menuListTarget.removeClass("open");
					
					subMenu.slideDown(350);
					target.addClass("open");
				}
			});
		},
		
		menuLight : function(menuName) {

			this.menuListTarget.removeClass("current");
			
			if (menuName == "adminMain") {
				
				$(this.menuListTarget).first().addClass("current");
			} else {
				
				$("#"+menuName).parents(".highLight").addClass("current");
			}
		}
	}
	
	$(document).ready(function(){	
		left.adminMenuFn();
		menuSlide.menuToggle();
		menuSlide.getTarget();
		menuSlide.slideToggle();
		menuSlide.menuLight("<c:out value="${param.adminPageName}" />");
		
		//$("#navi > li").first().addClass("current");
	});
</script>

<form id="frmAdmin" name="frmAdmin">
	<input type="hidden" id="adminPageName"  	name="adminPageName" />
</form>

<div class="sidebar">
	<div class="sidebar-dropdown"><a href="#">Navigation</a></div>
	<div class="sidebar-inner">
		<!-- Search form -->
		<div class="sidebar-widget">
			<h1 class="main-logo" onclick="javascript:left.adminSubmitFn('adminMain','adminMain.do','frmAdmin')"></h1>
		</div>
		<!--- Sidebar navigation -->
		<!-- If the main navigation has sub navigation, then add the class "has_submenu" to "li" of main navigation. -->
		<ul class="navi" id="navi">
			<!-- Use the class nred, ngreen, nblue, nlightblue, nviolet or norange to add background color. You need to use this in <li> tag. -->
		</ul>
		<!--/ Sidebar navigation -->
		<h2 class="go-to-main" onclick="javascript:left.adminSubmitFn('main','main.do','frmAdmin')">
			<i class="fa fa-sign-in"> </i> 메인 사이트로 이동
		</h2>

	</div>
</div>
<!-- Sidebar ends -->