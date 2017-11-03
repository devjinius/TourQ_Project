<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">

	$(document).ready(function(){	

		var pageName = "<c:out value="${param.pageName}"/>";
		
		$("[prop=menu]").removeClass("active");
		
		$("#"+pageName).addClass("active");

		// inputWidth.autoWidth();
		inputAutoCol();
	    
	});
</script>

<div class="mainbar">
   
	<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">리뷰관리
			  <!-- page meta -->
			  <span class="page-meta">Something Goes Here</span>
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right widget-head-right">
				<div class="bread-crumb">
				  <a href="index.html"><i class="fa fa-home"></i> 게시판관리</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">리뷰관리</a>
				</div>
				<button class="btn btn-default wminimize" type="button"><i class="fa fa-plus"></i> 검색창 보기</button>
			</div>
			<div class="clearfix"></div>
		</div>
		<!-- Breadcrumb -->
			<div class="widget-content" style="display: none;">
				<div class="padd">
					<div class="col-lg-12 form-group">
					
						<span class="input-title">기간검색</span>
					    <div class="pull-left col-md-5 btn-select-box">
					    	<div class="select-box col-md-5">
								<a class="form-control select-btn">달력넣고싶네</a>
						    	<ul class="select-list" style="display: none;">
						    		<li>
						    			<a class="select-option">선택하세요</a>
					    		</li>
					    		<li>
					    			<a class="select-option">도보</a>
					    		</li>
					    		<li>
					    			<a class="select-option">버스</a>
						    		</li>
						    	</ul>
					    	</div>
					    	<div class="select-box col-md-5">
								<a class="form-control select-btn">달력넣고싶네</a>
						    	<ul class="select-list" style="display: none;">
						    		<li>
						    			<a class="select-option">선택하세요</a>
					    		</li>
					    		<li>
					    			<a class="select-option">도보</a>
					    		</li>
					    		<li>
					    			<a class="select-option">버스</a>
						    		</li>
						    	</ul>
					    	</div>
							<div class="pull-left">
								<button class="btn btn-default btn-navy" type="button">검색</button>
							</div>
					    </div>
					    
						<span class="input-title">상세검색</span>
						    <div class="pull-left col-md-4 set-surch btn-select-box">
								<div class="pull-left set-surch-select admin-select col-md-3">
	                                <select class="selectpicker form-control" data-size="8" data-live-search="false" title="검색항목">
	                                    <option data-tokens="작성자">작성자</option>
	                                    <option data-tokens="별점">별점</option>
	                                    <option data-tokens="투어상품">투어상품</option>
	                                    <option data-tokens="제목">제목</option>
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
	
		<div class="col-md-12 widget-top">
			<div class="widget-r-btn pull-right">
				<button class="btn btn-xs btn-red pull-left"><i class="fa fa-trash-o"></i> 삭제</button>
			</div>
			<div class="clearfix"></div>
		</div>
		
		<div class="container">
			<div class="widget-content medias">
				<div class="table-responsive">
					<table class="table table-bordered ">
						<thead>
							<tr>
							  <th>
								  <input type='checkbox' class="checkbox" value='check1' />
							  </th>
							  <th>작성자</th>
							  <th>별점</th>
							  <th>사진</th>
							  <th>투어상품</th>
							  <th>제목</th>
							  <th>내용</th>
							  <th>작성일</th>
							  <th>마일리지</th>
							</tr>
						</thead>
						<tbody>
							<tr>
							  <th>                  
								  <input type='checkbox' class="checkbox" value='check1' />
							  </th>
							  <td>윤선희</td>
							  <td>4.5</td>
							  <td>사진사진</td>
							  <td>알차다! 서울투어</td>
							  <td>정말 재미있는 투어였습니다!</td>
							  <td>메롱메롱메롱메롱메롱메롱메롱메롱메롱메롱메롱메롱메롱</td>
							  <td>2017-07-10</td>
							  <td class="ip-w-text">
								  <input type="text" id="telephone" value="1000">
							  </td>
							</tr>                                                        
						</tbody>
					</table>
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