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
	var cnames = ['버스번호','종류','버스명','총 좌석수','좌석보기'];

	 $("#adminSeatTable").jqGrid({
	 
	     url: "adminSeatGrid.do",
	     datatype: "json",
	     postData: {"param" : ""},
	     colNames: cnames,
	     colModel:[
	   {name:'busNo',			index:'busNo',		key:true,		align:"center"},
	   {name:'busType',			index:'busType',		align:"center"},
	   {name:'busName',			index:'busName',		align:"center"},
	   {name:'busSitcount',		index:'busSitcount',	align:"center"},
	   {name:'busNo',			index:'busNo',			align:"center",		formatter:seatBtn.addMoreBtn}
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
							+ '<a href="#" onclick="javascript:surchButton.surchGrid('+ i +')">' + i +'</a>'
	      			+'</li>';
			} else {
				pageNum += '<li>'
					+ '<a href="#" onclick="javascript:surchButton.surchGrid('+ i +')">'
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
var seatBtn = {
	
	addMoreBtn : function(cellvalue) {

		return '<button class="btn btn-xs btn-default" type="button" data-target=".admin-showSeat"'
					+'onclick="javascript:seatBtn.showSeat(\''+ cellvalue +'\')">좌석보기</button>'
	},
	
	showSeat : function(busId) {
		
		$.ajax({
			
			type	: "POST",
			url		: "getSeatData.do",
			async	: false,
			data	: {"param" : busId},
			success : function(result) {

				var jsonPas = JSON.parse(result),
					seatArr = new Array,
					makeSeat = "",
					$busName = $(".admin-showSeat .bus-name");
				
				seatArr = JSON.parse(jsonPas.seat);
				
				for ( var i in seatArr) {
					
					makeSeat += '<div class="bus-seat bus-seat-admin" new="busSeat" style="left:'
								+ seatArr[i].seatLeft +'px; top:'+ seatArr[i].seatTop +'px; position: absolute;"'
								+ 'id="'+ seatArr[i].seatNum +'">'
					+ '<div class="bus-seat-mask">'
						+ '<span class="seatId">'+ seatArr[i].seatNum +'</span>'
					+ '</div>'
				+ '</div>';
				}
				
				var $showSeatArea = $("#showSeatArea");
				
				$showSeatArea.append(makeSeat);
				
				$busName.html(jsonPas.busName +" 좌석 배치도");
				
				modal.adminReservation('admin-showSeat');
			},
			complete : function() {

				$.jgrid.gridUnload("#adminSeatTable"); 
				adminGrid();
			}
		});
	}
}
/******************************************
 * 상단 서치바 이벤트
 ******************************************/
var surchButton = {
	
	surchGrid	: function(pageNm){
		
		$("#adminSeatTable").setGridParam({
			
			datatype	: "json",
			page		: pageNm,
			mtype		: "POST",
			loadComplete: function(result){
				if (result.rows.length == 0) {

					alert("검색에 해당하는 결과가 없습니다. ");
				}
				
	    		paging(result);
			}
		}).trigger("reloadGrid");
	}
}

$(document).ready(function(){
	
	adminGrid();
});
</script>

<div class="mainbar">

   	<div class="admin-modal hidden">
   		<div class="admin-m-content">
   			
   			<h4 class="admin-m-title">버스 생성하기</h4>
			<div class="table-responsive">
				<table class="table table-bordered table-row">
				  <thead>
					<tr>
					  <th>버스타입</th>
					  <td class="select-box col-lg-4">
                         <select class="selectpicker form-control" id="selectBus" name="selectBus" data-size="8" data-live-search="false" title="버스종류">
                             <option data-tokens="1층">1층</option>
                             <option data-tokens="2층">2층</option>
                         </select>
					  </td>
					  <th>총 좌석수</th>
					  <td class="ip-text">
					  	<input type="number" name="totalSeat" id="totalSeat" min="0" readonly="readonly">
					  </td>
					</tr>
					<tr>
					  <th>버스명</th>
					  <td class="ip-text" colspan="3">
						  <input type="text" class="" id="busName" name="busName">
					  </td>
					</tr>
				  </thead>
				</table>
				<table class="table table-bordered">
				  <thead>
					<tr>
					  <th>좌석 생성</th>
					  <th>좌석 배치</th>
					</tr>
				  </thead>
					<tbody>
						<tr>
						  <th class="text-center"> 
						  	<div class="creatBtn">
							  	<input type="number" name="newSeat" id="newSeat" min="0" placeholder="0" />
								<button class="btn btn-default seat-btn" onclick="javascript:adminBus.btnClick(this)">
										<div class="bus-seat seat-soldout">
											<div class="bus-seat-mask"></div>
										</div>
										<span>좌석 추가</span>
								</button>
							</div>
							<div class="editBtn">
								<button class="btn btn-default seat-btn" onclick="javascript:adminBus.addRowSeat()">
										<span>추가</span>
								</button>
								<button class="btn btn-default seat-btn" onclick="javascript:adminBus.delRow()">
										<span>열 삭제</span>
								</button>
							</div>
						  </th>
						  <th> 
					  		<div class="admin-bus bus1" id="adminSeatArea">
					  		</div>
						  </th>
						</tr>                                                        
					</tbody>
				</table>
			</div>
			<div class="widget-c-btn">
				<button class="btn btn-yellow" type="button" data-target=".admin-modal"
            		onclick="javascript:add.busData()"><i class="fa fa-pencil"></i> 추가하기</button>
			</div>
   		</div>
   		<div class="admin-modal-bg hidden" onclick="javascript:modal.adminReservation('admin-modal')"></div>
   	</div>
   	
   	<div class="admin-showSeat hidden">
   		<div class="admin-m-content">
   			
   			<h4 class="admin-m-title bus-name"></h4>
			<div class="table-responsive">
				<table class="table table-bordered">
				  <thead>
					<tr>
					  <th>좌석 배치도</th>
					</tr>
				  </thead>
					<tbody>
						<tr>
						  <th> 
					  		<div class="admin-bus bus1">
					  			<div class="admin-bus" id="showSeatArea"></div>
					  		</div>
						  </th>
						</tr>                                                        
					</tbody>
				</table>
			</div>
			<div class="widget-c-btn">
				<button class="btn btn-red" type="button" data-target=".admin-modal"
            		onclick="javascript:modal.adminReservation('admin-showSeat')"><i class="fa fa-pencil"></i> 닫기</button>
			</div>
   		</div>
   		<div class="admin-modal-bg hidden" onclick="javascript:modal.adminReservation('admin-showSeat')"></div>
   	</div>
   
	<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">버스관리
			  <!-- page meta -->
			  <span class="page-meta">버스 좌석 및 종류 관리입니다.</span>
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right widget-head-right">
				<div class="bread-crumb">
				  <a href="index.html"><i class="fa fa-home"></i> 코스관리</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">버스관리</a>
				</div>
				<button class="btn btn-default wminimize" type="button"><i class="fa fa-plus"></i> 검색창 보기</button>
			</div>
			<div class="clearfix"></div>
		</div>
		<!-- Breadcrumb -->
			<div class="widget-content">
				<div class="padd">
					
					<div class="col-lg-12">
					
						<span class="input-title">버스타입</span>
					    <div class="pull-left col-md-3 btn-select-box">
					    	<div class="select-surch col-md-9">
	                         <select class="selectpicker form-control" data-size="8" data-live-search="false" title="버스종류">
	                             <option data-tokens="1층">1층</option>
	                             <option data-tokens="2층">2층</option>
	                         </select>
					    	</div>
							<div class="pull-left">
								<button class="btn btn-default btn-navy" type="button">검색</button>
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
	
		<div class="col-md-12 widget-top pull-left">
			<div class="pull-right">
				<button class="btn btn-xs btn-green pull-left" type="button" onclick="javascript:modal.adminReservation('admin-modal')">
					<i class="fa fa-pencil"></i> 버스 생성</button>
			</div>
			<div class="clearfix"></div>
		</div>
		
		<div class="container">
			<table id="adminSeatTable" class="table input-table table-bordered"></table>
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