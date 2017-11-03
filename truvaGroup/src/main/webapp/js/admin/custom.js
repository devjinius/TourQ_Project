/* Navigation */

$(document).ready(function(){

  $(window).resize(function()
  {
    if($(window).width() >= 765){
      $(".sidebar .sidebar-inner").slideDown(350);
    }
    else{
      $(".sidebar .sidebar-inner").slideUp(350); 
    }
  });

});

$(document).ready(function(){
  $(".sidebar-dropdown a").on('click',function(e){
      e.preventDefault();

      if(!$(this).hasClass("dropy")) {
        // hide any open menus and remove all other classes
        $(".sidebar .sidebar-inner").slideUp(350);
        $(".sidebar-dropdown a").removeClass("dropy");
        
        // open our new menu and add the dropy class
        $(".sidebar .sidebar-inner").slideDown(350);
        $(this).addClass("dropy");
      }
      
      else if($(this).hasClass("dropy")) {
        $(this).removeClass("dropy");
        $(".sidebar .sidebar-inner").slideUp(350);
      }
  });

});

// 셀렉트창 js
$(document).ready(function(){
  $(".select-box a").on('click',function(e){
      e.preventDefault();

      if(!$(this).hasClass("dropy")) {
        // hide any open menus and remove all other classes
        
        // open our new menu and add the dropy class
        $(this).parent().children($("li")).slideDown(300);
        $(this).toggleClass("dropy");
        
        $(".select-option").click(function(){
        	
        	var selectContent, selectContent
        	
        	selectContent = $(this).parent().parent().parent();
        	selectText = $(this).text();
        	
        	selectContent.children(".select-btn").text(selectText).toggleClass("dropy");
        	selectContent.children(".select-list").slideUp(300);
        	
        	
        	console.log(selectContent);
        });
      }
      
      else if($(this).hasClass("dropy")) {
        $(this).toggleClass("dropy");
        $(".select-list").slideUp(300);
      }
  });

  $(".select-list li").on('click',function() {
        $(this).toggleClass("dropy");
        $(".select-list").slideUp(300);
      });

  /* Widget close */

  $('.wclose').click(function(e){
    e.preventDefault();
    var $wbox = $(this).parent().parent().parent();
    $wbox.hide(100);
  });

  // 수정중
  $('.wminimize').click(function(e){

  	e.preventDefault();
  	
	var $wcontentHeight, $wcontentAutoHeight, $wcontent, $wcontainer
	$wcontentHeight = $('.page-head .widget-content').height();
	$wcontentAutoHeight = $(".mainbar .matter").height();
	$wcontentAutoHeightCh = $(".mainbar .matter > .container").height();
  	$wcontent = $(this).parent().parent().next('.widget-content');
  	$wcontainer = $(this).parent().parent().parent().next('.matter');
  	  	
  	if($wcontent.is(':visible')) 
  	{
  	  $wcontent.slideUp(500);
      $wcontainer.animate({
    	  "height": $wcontentAutoHeight+$wcontentHeight
      }, 500);
      $wcontainer.children('.container').css("height", $wcontentAutoHeightCh+$wcontentHeight);
  	}
  	else 
  	{
      $wcontent.slideDown(500);
  	  $wcontainer.css("height", "");
  	  $wcontainer.children('.container').css("height", "");
  	}
  });   
});

$('.modal').appendTo($('body'));