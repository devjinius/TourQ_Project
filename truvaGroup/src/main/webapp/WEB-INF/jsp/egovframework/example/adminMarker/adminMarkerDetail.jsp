<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">

	var submitMarker = {
    	
	   	submitDetail : function(markerNumber) {
	   		
	   		$("#markerNumber").val(markerNumber);
	   		
	   		$("#courseNumber").val("<c:out value="${param.courseNumber}"/>");
	   		
		    left.adminSubmitFn('adminMarkerMap','adminMarkerMap.do','frmMarker');
	   	},
		submitCreate : function(courseNumber) {
	   		
			// 마커가 7개면 개수가 최대이므로 추가하지 못하게 한다. 
			if($("tbody tr").length==7){

				alert("마커의 개수가 최대입니다. 기존의 마커를 삭제하고 추가해주세요");
				
				return;
			}
			
	   		$("#courseNumber").val(courseNumber);
	   		
		    left.adminSubmitFn('adminMarkerCreate','adminMarkerCreate.do','frmMarker');
	   	},
	   	
	   	deleteMarker : function() {
	   		
	   		if($("#checkbox:checked").length == 0){
	   			
	   			alert("체크박스를 선택해주세요.");
	   			return;
	   		}
	   		
	   		if(confirm("정말로 선택하신 마커를 삭제하시겠습니까?")){
	   			
			    left.adminSubmitFn('adminMarkerCreate','adminMarkerDelete.do','checkFrm');
	   		}
	   	}
	}
	
	$(document).ready(function(){	
		
	});
</script>

<form name="frmMarker" id="frmMarker">
	<input type="hidden" value="" name="markerNumber" id="markerNumber">
	<input type="hidden" value="" name="courseNumber" id="courseNumber">
</form>
<div class="mainbar">

	<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">Marker 수정하기
			  <!-- page meta -->
			  <span class="page-meta">한양에서 서울로</span>
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right">
				<div class="bread-crumb">
				  <a href="#" onclick="left.adminSubmitFn('adminMain', 'adminMain.do', 'frmAdmin')"><i class="fa fa-home"></i> 메인</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current" onclick="left.adminSubmitFn('adminMarker', 'adminMarker.do', 'frmAdmin')">마커 관리</a>
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">마커 수정</a>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="clearfix"></div>
	</div><!--/ Page heading ends -->
	<!-- Matter -->
	<div class="matter nonsurch">
		
		<div class="col-md-12 widget-top">
			<div class="pull-right">
				<button class="btn btn-xs btn-green pull-left" type="button" onclick="javascript:submitMarker.submitCreate('<c:out value="${param.courseNumber}"/>')">
					<i class="fa fa-plus"></i> 추가
				</button>
				<button class="btn btn-xs btn-red pull-left"  onclick="javascript:submitMarker.deleteMarker()">
					<i class="fa fa-trash-o"></i> 삭제
				</button>
			</div>
			<div class="clearfix"></div>
		</div>
		
		<div class="container full-page">
			<!-- half-table -->
			<div class="widget-content medias">
				<div class="table-responsive">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th></th>
								<th>마커번호</th>
								<th>마커이름</th>
								<th>내용</th>
								<th>종류</th>
							</tr>
						</thead>
						<tbody>
						<form name="checkFrm" id="checkFrm">
							<input type="hidden" name="courseNum" id="courseNum" value="<c:out value="${param.courseNumber}"/>">
							<c:forEach items="${markerList}" var="markerList" varStatus="status">
								<tr>
									<th><input type='checkbox' class="checkbox" name="checkbox" id="checkbox" value="<c:out value="${markerList.markerNumber}"/>"/></th>
									<td><c:out value="${markerList.markerNumber}"/></td>
									<td><c:out value="${markerList.markerName}"/></td>
									<td><button class="btn btn-xs btn-default" type="button" onclick="javascript:submitMarker.submitDetail('<c:out value="${markerList.markerNumber}"/>')">상세보기</button></td>
									<td><c:out value="${markerList.markerType}"/></td>
								</tr>
							</c:forEach>
						</form>
						</tbody>
					</table>
				</div> 
			</div><!-- half-table -->

		</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
	</div><!--/ Matter ends -->
</div><!--/ Mainbar ends -->