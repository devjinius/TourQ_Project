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
	});
</script>

<div class="mainbar">
<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">쿠폰 현황
			  <!-- page meta -->
			  <span class="page-meta">부제</span>
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right">
				<div class="bread-crumb">
				  <a href="index.html"><i class="fa fa-home"></i> 대메뉴</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">소메뉴</a>
				</div>
				<button class="btn btn-default wminimize" type="button">Default</button>
			</div>
			<div class="clearfix"></div>
		</div>
		<!-- Breadcrumb -->
			<div class="widget-content" style="display: none;"> <!--  " -->
				<div class="padd">
					<div class="col-lg-12">
					    <div class="pull-left select-box col-md-2">
							<select name="theme" id="theme" class="form-control select-btn" >
     							<optgroup label="이벤트">
  									<option value="진행">쿠폰ID</option>
									<option value="종료">회원ID</option>
								
     							</optgroup>
     						
							</select>
					    </div>
						<div class="clearfix"></div><!-- 플롯해제 -->
					</div><!-- END ROW -->

					<div class="col-lg-12">
						<div class="form-group col-md-3">
							<span class="input-title">글 제목</span>
							<div class="pull-left">
								<input type="text" class="form-control" id="eventTitle" name="eventTitle">
							    <button class="btn btn-navy">검색</button>
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
				<button class="btn btn-xs btn-info pull-left"><i class="fa fa-pencil"></i>추가하기</button>
				<button class="btn btn-xs btn-yellow pull-left">수정하기</button>
				<button class="btn btn-xs btn-red pull-left"><i class="fa fa-remove"></i>삭제하기</button>
				<button class="btn btn-xs btn-green pull-left" type="button"><i class="fa fa-save"></i> 저장하기</button>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="container">
			<div class="widget-content medias">
				<div class="table-responsive">
					<table class="table table-bordered ">
						<thead>
							<tr>
								<th></th>
								<th>쿠폰이름</th>
								<th>분류코드</th>
								<th>할인율</th>
								<th>발행일</th>
								<th>만료일</th>
								<th>총수량</th>
								<th>사용수량</th>
								<th>잔여수량</th>
							  	
							</tr>
						</thead>
						<tbody>
							<tr>
								<th><input type='checkbox' class="checkbox" name="checkbox_1" id="checkbox_1"/></th>
								<td>후기입력발행쿠폰</td>
								<td>10</td>
								<td>10%</td>
								<td>2017-07-20</td>
								<td>2017-07-25</td>
								<td>100개</td>
								<td>13개</td>
								<td>총수량-사용수량(수식사용)</td>
							</tr>
							<tr>
								<th><input type='checkbox' class="checkbox" name="checkbox_1" id="checkbox_1"/></th>
								<td>출석이벤트쿠폰</td>
								<td>20</td>
								<td>10%</td>
								<td>2017-07-20</td>
								<td>2017-07-25</td>
								<td>100개</td>
								<td>13개</td>
								<td>총수량-사용수량</td>
							</tr><tr>
								<th><input type='checkbox' class="checkbox" name="checkbox_1" id="checkbox_1"/></th>
								<td>추첨쿠폰</td>
								<td>30</td>
								<td>10%</td>
								<td>2017-07-20</td>
								<td>2017-07-25</td>
								<td>100개</td>
								<td>23개</td>
								<td>총수량-사용수량</td>
							</tr>
							
						</tbody>
					</table>
				</div> 
			</div>

<!-- 세로테이블
						<div class="table-responsive">
							<table class="table table-bordered table-row">
							  <thead>
								<tr>
								  <th>dddd</th>
								  <td>
									  <button class="btn btn-xs btn-default">상세보기</button>
								  </td>
								</tr>
								<tr>
								  <th>dddd</th>
								  <td>dddddd</td>
								</tr>
								<tr>
								  <th>dddd</th>
								  <td>dddddd</td>
								</tr>
								<tr>
								  <th>dddd</th>
								  <td>dddddd</td>
								</tr>
								<tr>
								  <th>dddd</th>
								  <td>dddddd</td>
								</tr>
								<tr>
								  <th>dddd</th>
								  <td>dddddd</td>
								</tr>
							  </thead>
							</table>
						</div> -->

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