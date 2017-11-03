<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
/******************************************
 * jqGrid
 ******************************************/
var adminGrid = function(){
	var cnames = ['코스번호','구분','코스명','저번주 예약인원','이번주 예약인원','전체 예약인원','리뷰수'];

	 $("#adminReservationTotalTable").jqGrid({
	 
	     url: "adminStatusList.do",
	     datatype: "json",
	     postData: {"param" : ""},
	     colNames: cnames,
	     colModel:[
	   {name:'courseNumber',		index:'courseNumber',		key:true,		align:"center"},
	   {name:'courseStatus',	index:'courseStatus',	align:"center"},
	   {name:'courseTitle',		index:'courseTitle',	align:"center"},
	   {name:'prevWeek',		index:'prevWeek',		align:"center"},
	   {name:'thisWeek',		index:'thisWeek',		align:"center"},
	   {name:'total',			index:'total',			align:"center"},
	   {name:'totalReview',		index:'totalReview',	align:"center"}
			],
	     height: '513',
	     width: '97%',
	     rowNum: 14,
	     autowidth: true,
	     cellEdit: true,
	     cellsubmit: "clientArray",
	     rownumbers  : false,
	     viewrecords : true,
	     loadonce : true,
	     sortname : 'total',
	     loadComplete : function(result){

	    	paging(result);
	 	 }
	 }).trigger("reloadGrid");
}

/******************************************
 * 그리드 페이징
 ******************************************/
var paging = function(result) {

	/* 페이징처리 */
	var totalPage = result.totalPage,
		prevPage = result.prevPage,
		endPage = result.endPage,
		nextPage = result.nextPage,
		pageScale = result.pageScale,
		i = 0,
		pagination = $("#pagination"),
		pageNum = "",
		prevPageBtn = "",
		nextPageBtn = "";
	
	var setEnd = (totalPage < endPage) ? totalPage : endPage;
	
	pagination.children().remove();
	
	if (pagination.children().length == 0) {
		
		for (i = result.startPage; i < setEnd + 1; i++) {

			if (i == result.page) {
				pageNum += '<li class="active">'
							+ '<a href="#" onclick="javascript:surchButton.surchGrid({page:'+ i +'})">' + i +'</a>'
	      			+'</li>';
			} else {
				pageNum += '<li>'
					+ '<a href="#" onclick="javascript:surchButton.surchGrid({page:'+ i +'})">'
						+ i
	      				+'</a>'
	      			+'</li>';
			}
		}
		
		if (totalPage > pageScale) {
			prevPageBtn = '<li><a href="#" onclick="javascript:surchButton.surchGrid({page:1})"><<</a></li>'
	   					+ '<li><a href="#" onclick="javascript:surchButton.surchGrid({page:'+ prevPage +'})"><</a></li>';
			
	   		nextPageBtn = '<li><a href="#" onclick="javascript:surchButton.surchGrid({page:'+ nextPage +'})">></a></li>'
	    					+ '<li><a href="#" onclick="javascript:surchButton.surchGrid({page:'+ totalPage +'})">>></a></li>';
		} else {
	   		prevPageBtn = '<li><a href="#" onclick="javascript:surchButton.surchGrid({page:1})"><<</a></li>';
			
	   		nextPageBtn = '<li><a href="#" onclick="javascript:surchButton.surchGrid({page:'+ totalPage +'})">>></a></li>';
		}

		pagination.append(prevPageBtn + pageNum + nextPageBtn);
	}
}

/******************************************
 * 상단 서치바 이벤트
 ******************************************/
var surchButton = {

	surchMore	: function(){

		if ($("#reTotalSurchSelect").val() != "") {
			
			var surchSelect = $("#reTotalSurchSelect").val();
			
			this.surchGrid({"surchSelect":surchSelect});
		} else {
			
			this.surchGrid();
		}
	},
	
	surchGrid	: function(options){
		
		var settings = {
				
				surchSelect	:"",
				page 		: 1,
			}
			settings = $.extend({}, settings, options);
		
		console.log(settings.surchSelect);
		
		$("#adminReservationTotalTable").setGridParam({
			
			datatype	: "json",
			page		: settings.page,
			postData	: {"param" : settings.surchSelect},
			mtype		: "POST",
			loadComplete: function(result){
				if (result.rows.length == 0) {

					alert("검색에 해당하는 결과가 없습니다. ");
				} else {
					
		    		paging(result);
				}
			}
		}).trigger("reloadGrid");
	}
}

$(document).ready(function(){
	
	adminGrid();
});
</script>

<div class="mainbar">
   
	<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">예약현황
			  <!-- page meta -->
			  <span class="page-meta">예약된 현황을 보여줍니다.</span>
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right widget-head-right">
				<div class="bread-crumb">
				  <a href="index.html"><i class="fa fa-home"></i> 예약관리</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">예약통계</a>
				</div>
				<button class="btn btn-default wminimize" type="button"><i class="fa fa-plus"></i> 검색창 보기</button>
			</div>
			<div class="clearfix"></div>
		</div>
		<!-- Breadcrumb -->
			<div class="widget-content">
				<div class="padd">
					
					<div class="col-lg-12">
						
						<span class="input-title">분류</span>
						    <div class="pull-left col-md-4 set-surch btn-select-box">
								<div class="pull-left select-surch admin-select col-md-7">
	                                <select class="selectpicker form-control" id="reTotalSurchSelect" data-size="8" data-live-search="false" title="구분 선택">
	                                    <option data-tokens="All" value="">전체보기</option>
	                                    <option data-tokens="버스">버스</option>
	                                    <option data-tokens="도보">도보</option>
	                                </select>
								</div>
								<div class="pull-left">
									<button class="btn btn-default btn-navy" onclick="javascript:surchButton.surchMore()" type="button">검색</button>
								</div>
					   		</div>
					    
						<div class="clearfix"></div><!-- 플롯해제 -->
					</div><!-- END ROW -->

				<div class="clearfix"></div>
				</div>
			</div>

		<div class="clearfix"></div>
	</div><!--/ Page heading ends -->

	<!-- Matter -->
	<div class="matter">
		<div class="container">
			<table id="adminReservationTotalTable" class="table input-table table-bordered"></table>
		</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
		<div class="col-md-12 widget-foot">
			<div class="pagination-foot">
				<ul class="pagination" id="pagination">
				</ul>                      
				<div class="clearfix"></div> 
			</div>
		</div>
	</div><!--/ Matter ends -->
</div><!--/ Mainbar ends -->

