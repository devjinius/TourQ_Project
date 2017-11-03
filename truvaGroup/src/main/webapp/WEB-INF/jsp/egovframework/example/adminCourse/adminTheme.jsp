<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">

	/*어드민 모달창*/
	var thememodal = {
			
		adminModal : function(){
			
			$(".admin-modal").toggleClass("hidden");
			$(".admin-modal-bg").toggleClass("hidden");
			
			$("#modalTitle").val("");
			$("#modalType").val("");
			
			var modalHeight;
			// 모달 중앙정렬
			if (!($(".admin-modal").hasClass("hidden"))) {
				
				modalHeight = $(".admin-m-content").height();
				
				$(".admin-m-content").css("margin-top",(-modalHeight/2));
			}
		},
	
		// ajax를 통해 테마를 추가합니다.
		themeCreate : function() {
			
			var that = this;
			
			// 보낼 데이터를 json으로 만듭니다. 
			var submitData = {
				
				themeTitle : $("#modalTitle").val(),
				themeType : $("#modalType").val() 
			};
			
			// json object string으로 변환한 뒤 데이터를 보냅니다.
			$.ajax({
				type	: "POST",
				url		: "adminThemeCreate.do",
				async	: false,
				data	: {"param" : JSON.stringify(submitData)},
				success	: function(result){
					
					// 성공적일 경우 테마를 추가하고 모달을 초기화 한 뒤 모달을 종료합니다.
					alert("성공적으로 테마가 추가되었습니다.");
					
					that.adminModal();
				}
			});
		}
		
	};
	
	function deleteTheme() {
		
		var leng = $("#checkbox:checked").length;
		
		if(leng == 0){
			
			alert("데이터를 선택해주세요! 데이터를 선택하지 않으면 안됩니다.");
			
			return;
		}
		
   		if(confirm('선택하신 ' + leng + '개의 코스를 정말로 삭제하시겠습니까?')){
   			
   	   		left.adminSubmitFn('adminTheme','adminThemeDelete.do','checkForm');
   		}
	} 

</script>
<div class="mainbar">
     
    <!-- 모달부분시작 -->
   	<div class="admin-modal hidden">
   		<div class="admin-m-content text-center">
   					
   			<h4 class="admin-m-title">테마추가</h4>
				
				<div class="table-responsive map-modal" style="height: inherit;">
				<table class="table table-bordered table-row">
				  <thead>
					<tr>
						<th>테마이름</th>
						<td colspan="2" class="ip-text"><input class="form-control" type="text" name="modalTitle" id="modalTitle" placeholder="이름을 입력해주세요"></td>
					</tr>
					<tr>
						<th>종류</th>
						<td colspan="2">
							<select name="type" class="form-control" name="modalType" id="modalType">
	    						<option value="도보">도보</option>
	    						<option value="버스">버스</option>
							</select>
						</td>
					</tr>
				  </thead>
				</table>
			</div>
   				<div class="margin-top-bottom">
   					<button type="submit" class="btn btn-xs btn-default" onclick="javascript:thememodal.themeCreate()">저장하기</button>
					<button class="btn btn-xs btn-default" onclick="javascript:thememodal.adminModal()">닫기</button>
   				</div>
   		</div>
   	<div class="admin-modal-bg hidden" onclick="javascript:thememodal.adminModal()"></div>
   	</div><!-- 모달 종료 -->
   	
	<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">테마관리
			  <!-- page meta -->
			  <span class="page-meta">상품 테마 추가 및 수정페이지 입니다.</span>
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right">
				<div class="bread-crumb">
				  <a href="#" onclick="left.adminSubmitFn('adminMain', 'adminMain.do', 'frmAdmin')"><i class="fa fa-home"></i> 메인</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">테마 관리</a>
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
				<button class="btn btn-xs btn-green pull-left" type="button" onclick="javascript:thememodal.adminModal()">
					<i class="fa fa-plus"></i> 추가
				</button>
				<button class="btn btn-xs btn-red pull-left" onclick="javascript:deleteTheme()">
					<i class="fa fa-trash-o"></i> 삭제
				</button>
			</div>
			<div class="clearfix"></div>
		</div>
		
		<div class="container full-page-doubleBtn">
			<!-- half-table -->
			<div class="widget-content medias">
				<div class="table-responsive ">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th></th>
								<th>번호</th>
								<th>테마이름</th>
								<th>구분</th>
								<th>코스수</th>
							</tr>
						</thead>
						<tbody>
							<form name="checkForm" id="checkForm">
								<c:forEach items="${themeList}" var="themeList" varStatus="status">
									<tr>
										<th><input type='checkbox' class="checkbox" name="checkbox" id="checkbox" value="<c:out value="${themeList.themeNumber}"/>"/></th>
										<td><c:out value="${themeList.themeNumber}"/></td>
										<td><c:out value="${themeList.themeName}"/></td>
										<td><c:out value="${themeList.themeType}"/></td>
										<td>
										<c:out value="${themeList.themeCount}"/>
										</td> 
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