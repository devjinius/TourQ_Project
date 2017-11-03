<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

$(document).ready(function() {

	var cnames = ['아이디','이름','전화번호','주소','기타','성별코드'];

	    $("#jqGrid").jqGrid({
	    
	        url: "jqgridStartMain.do",
	        datatype: "local",
	        colNames: cnames,
	        colModel:[
	      {name:'seq',index:'seq', key:true, align:"center"},
	      {name:'name',index:'name', align:"center"},
	      {name:'phone',index:'phone'},
	      {name:'address',index:'address'},
	      {name:'etcc',index:'etcc'},
	      {name:'gender',index:'gender'}
	],
	        height: 450,
	        width: 1200,
	        rowNum: 10,
	        rowList: [10,20,30],
	        pager: '#jqGridPager',
	        rownumbers  : true,                     
	        ondblClickRow : function(rowId, iRow, iCol, e) {

	if(iCol == 1) {

	          alert(rowId+" 째줄 입니다.");
	          }
	        },
	    
	        viewrecords : true,
	    });
	});

</script>
<div class="mainbar">
      
	<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">예약 및 주문관리
			  <!-- page meta -->
			  <span class="page-meta">예약자 및 주문자 관리페이지 입니다.</span>
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right widget-head-right">
				<div class="bread-crumb">
				  <a href="index.html"><i class="fa fa-home"></i> 예약관리</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">예약 및 주문</a>
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
								<div class="pull-left set-surch-select admin-select col-md-3">
	                                <select class="selectpicker form-control" data-size="8" data-live-search="false" title="검색항목">
	                                    <option data-tokens="코드번호">코드번호</option>
	                                    <option data-tokens="이름">이름</option>
	                                </select>
								</div>
								<div class="pull-left set-surch-inp col-md-7">
								  <input type="text" class="form-control" id="telephone">
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
				<button class="btn btn-xs btn-green pull-left" type="button"><i class="fa fa-pencil"></i> 저장</button>
				<button class="btn btn-xs btn-yellow pull-left"><i class="fa fa-unlock"></i> 수정</button>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="container">
			<div class="widget-content medias">
				<div class="table-responsive">
					<table id="jqGrid" class="table input-table table-bordered"></table>
					<div id="jqGridPager"></div>
				</div> 
			</div>

		</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
				<div class="col-md-12 widget-foot">
					<div class="pagination-foot">
						<ul class="pagination">
						  <li><a href="#">Prev</a></li>
						  <li><a href="#">1</a></li>
						  <li><a href="#">2</a></li>
						  <li><a href="#">3</a></li>
						  <li><a href="#">4</a></li>
						  <li><a href="#">Next</a></li>
						</ul>                      
						<div class="clearfix"></div> 
					</div>
				</div>
	</div><!--/ Matter ends -->
</div><!--/ Mainbar ends -->