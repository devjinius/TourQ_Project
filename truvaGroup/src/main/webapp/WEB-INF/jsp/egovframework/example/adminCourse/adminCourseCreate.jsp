<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- MultiSelect -->
<script type="text/javascript">
		
	$(document).ready(function(){	

		$('#startTime').selectize({
		    maxItems: 20
		});
	});
</script>

<div class="mainbar">
<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">Course 생성</h2>
			<!-- Breadcrumb -->
			<div class="pull-right">
				<div class="bread-crumb">
				  <a href="#" onclick="left.adminSubmitFn('adminMain', 'adminMain.do', 'frmAdmin')"><i class="fa fa-home"></i> 메인</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current" onclick="left.adminSubmitFn('adminCourse', 'adminCourse.do', 'frmAdmin')">코스 관리</a>
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">코스 생성</a>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="clearfix"></div>
	</div>
	
	<!-- Matter -->
	<div class="matter nonsurch">
		<div class="container full-page-btn" style="overflow-y: auto;">
			<div class="table-responsive">
				<form id="frmCourse" name="frmCourse" enctype="multipart/form-data"  method="POST">
				<table class="table table-bordered table-row">
				  <thead>
				  	<tr>
						<th>코스번호</th>
						<td class="ip-text" colspan="4"><input class="form-control" type="text" name="courseNumber" id="courseNumber" value="" disabled="disabled"></td>
					</tr>
					<tr>
						<th>도보/버스</th>
						<td colspan="4" class="select-box">
							<select class="selectpicker form-control" data-size="8" data-live-search="false" id="status" name="status">
	                             <option value="도보">도보</option>
	                             <option value="버스">버스</option>
	                        </select>	
						</td>
					</tr>
					<tr>
						<th>제목</th>
						<td class="ip-text" colspan="4"><input class="form-control" type="text" name="title" id="title" value="" placeholder="30byte 이내" required="required"></td>
					</tr>
					<tr>
						<th>부제목</th>
						<td class="ip-text" colspan="4"><input class="form-control" type="text" name="subtitle" id="subtitle" placeholder="80byte 이내" required="required"></td>
					</tr>
					<tr>
						<th>내용</th>
						<td colspan="4">
							<textarea class="textarea-box" name="contents" id="contents" rows="3" placeholder="500byte 이내" required="required"></textarea>
						</td>
					</tr>
					<tr>
						<th>코스세부내역</th>
						<td class="ip-text" colspan="4"><input class="form-control" type="text" name="detail" id="detail" value="" placeholder="150byte 이내" required="required"></td>
					</tr>
					<tr>
						<th>소요시간</th>
						<td class="ip-text" colspan="4"><input class="form-control" type="text" name="time" id="time" value="" required="required"></td>
					</tr>
					<tr>
						<th>가격</th>
						<td class="ip-text" colspan="4"><input class="form-control" type="text" name="price" id="price" value="" required="required"></td>
					</tr>
					<tr>
						<th>출발시간</th>
						<td colspan="4">
					        <select multiple="multiple" style="width: 80%" name="startTime" id="startTime" required="required">
					        	<option value="00"> 00:00</option>	
					            <option value="01"> 01:00</option>
					            <option value="02"> 02:00</option>
					            <option value="03"> 03:00</option>
					            <option value="04"> 04:00</option>
					            <option value="05"> 05:00</option>
					            <option value="06"> 06:00</option>
					            <option value="07"> 07:00</option>
					            <option value="08"> 08:00</option>
					            <option value="09"> 09:00</option>
					            <option value="10"> 10:00</option>
					            <option value="11"> 11:00</option>
					            <option value="12"> 12:00</option>
					            <option value="13"> 13:00</option>
					            <option value="14"> 14:00</option>
					            <option value="15"> 15:00</option>
					            <option value="16"> 16:00</option>
					            <option value="17"> 17:00</option>
					            <option value="18"> 18:00</option>
					            <option value="19"> 19:00</option>
					            <option value="20"> 20:00</option>
					            <option value="21"> 21:00</option>
					            <option value="22"> 22:00</option>
					            <option value="23"> 23:00</option>
					            <option value="24"> 24:00</option>
				        	</select>
						</td>
					</tr>
					<tr>
						<th>버스</th>
						<td colspan="4" class="select-box">
							<select name="bus" id="bus" class="selectpicker form-control" data-size="8" data-live-search="false" id="bus" name="bus" required="required">
								<option data-tokens="해당없음">해당없음</option>
  								<c:forEach items="${busList}" var="busList">
									<option value="${busList.busNo}">${busList.busName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>테마</th>
						<td colspan="4"  class="select-box">
							<select name="theme" id="theme" class="selectpicker form-control" data-size="8" data-live-search="false" required="required">
     							<optgroup label="도보">
                                    <c:forEach items="${themeList}" var="themeList">
                       		       		<c:if test="${themeList.themeType == '도보'}">
			 								<option value="<c:out value="${themeList.themeNumber}"/>"><c:out value="${themeList.themeName}"/></option>
                                		</c:if>
									</c:forEach>
    							</optgroup>
    							<optgroup label="버스">
                                    <c:forEach items="${themeList}" var="themeList">
	    								<c:if test="${themeList.themeType == '버스'}">
			 								<option value="<c:out value="${themeList.themeNumber}"/>"><c:out value="${themeList.themeName}"/></option>
        		                        </c:if>
									</c:forEach>
								</optgroup>
							</select>
						</td>
					</tr>
					<tr>
						<th>만남장소</th>
						<td class="ip-text" colspan="4"><input class="form-control" type="text" name="place" id="place" value="" required="required"></td>
					</tr>
					<tr>
						<th>대표사진</th>
						<td class="ip-text" colspan="4"><input type="file" id="fileUp0" name="fileUp0"></td>
					</tr>
					<tr>
						<th rowspan="2">세부 사진</th>
						<td class="ip-text"><input class="form-control" type="text" placeholder="세부사진_1"></td>
						<td><input type="file" id="fileUp1" name="fileUp1"></td>
						<td class="ip-text"><input class="form-control" type="text" placeholder="세부사진_2"></td>
						<td><input type="file" id="fileUp2" name="fileUp2"></td>
					</tr>
					<tr>
						<td class="ip-text"><input class="form-control" type="text" placeholder="세부사진_3"></td>
						<td><input type="file" id="fileUp3" name="fileUp3"></td>
						<td class="ip-text"><input class="form-control" type="text" placeholder="세부사진_4"></td>
						<td><input type="file" id="fileUp4" name="fileUp4"></td>
					</tr>
					</form>
				  </thead>
				</table>
			</div>
		</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
		
		<div class="col-md-12 widget-foot">
			<div class="content-c-btn">
				<button class="btn btn-default" type="button" onclick="javascript:left.adminSubmitFn('course','courseIUD.do','frmCourse')"><i class="fa fa-close"></i> 코스생성</button>
			</div>
		</div>
	</div><!--/ Matter ends -->
</div>