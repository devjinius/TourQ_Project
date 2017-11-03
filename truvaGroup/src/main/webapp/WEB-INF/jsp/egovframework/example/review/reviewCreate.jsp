<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
.fileup {
	height: 200px;
}
</style>
<script type="text/javascript">
function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		
		reader.onload = function (e) {
		        $('#fakeFile').attr('src', e.target.result);
		    }
		
		  reader.readAsDataURL(input.files[0]);
	}
}


var reviewFn = {

	fileInit : function () {
		
		$("#file").click();
	},
	
	submitFn : function() {
		
		var arrSub = [$("#courseInfo").val(),
		$("#rank").val(),
		$("#title").val(),
		$("#contents").val()]
		
		for (i in arrSub){
			
			if(arrSub[i] == ""){
				alert("값을 모두 채워주시기 바랍니다.");
				
				return;
			}
		}
		
		nav.pageSubmitFn({'url': 'reviewI.do', 'frmName': 'reviewCreate'});
	}
}
$(document).ready(function () {

	$("#file").on('change', function(){
	    readURL(this);
	});
	
	$('.rating').raty({
		
		click: function(score) {
			
		    $("#rank").val(score);
		}
	});
})

</script>

    <div id="wrapper">
        <section class="section lb page-title little-pad">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="section-big-title clearfix">
                            <div class="pull-left">
                                <h3>Review.</h3>
                                <p>리뷰를 작성하시면 마일리지를 드립니다.</p>
                            </div>

                            <div class="pull-right hidden-xs">
                                <ul class="breadcrumb">
                                    <li><a href="javascript:nav.pageSubmitFn({url:'main.do', pageName:'main'})">Home</a></li>
                                    <li><a href="javascript:void(0)">review</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="content">

                           <div class="clearfix">
								<h4>투어 후기를 작성해주세요.</h4>
								<form class="contact-form search-top" name="reviewCreate" id="reviewCreate" enctype="multipart/form-data" method="post">
									<div class="row">
										<div class="col-md-12">
											<div class="form-group col-sm-8">
												<select class="form-control" id="courseInfo" name="courseInfo">
													<c:forEach items="${beforeList}" var="beforeList">
														<option value="${beforeList.courseNumber}_${beforeList.themeNumber}_${beforeList.orNumber}">[${beforeList.departureTime}]${beforeList.courseTitle} / ${beforeList.courseSubtitle}</option>
													</c:forEach>
												</select>
											</div>
											<div class="pull-right col-sm-4 review-grade">
												<div class="rating">
												</div>
												<input type="hidden" id="rank" name="rank" />
											</div>
										</div>
									</div>
									<div class="row">

										<div class="col-md-12">
											<div class="form-group">
												<input type="text" class="form-control" name="title" id="title" placeholder="후기의 제목을 입력하세요.">
											</div>
										</div>

										<div class="col-md-3">
											<img id="fakeFile" src="images/uploads/default-upload.jpg"  onclick="reviewFn.fileInit();" style="height: 250px; width: 200px; "/>
											<input type="file" id="file" name="file" style="display: none" /> 
										</div>

										<div class="col-md-9">
											<textarea name="contents" id="contents" placeholder="후기 내용을 입력하세요" class="form-control" style="height: 250px; width: 100%;"></textarea>
										</div>
									</div>
								</form>
									<div class="col-md-3 align-center pd-top-20">
										<button class="btn btn-primary" onclick="javascript:reviewFn.submitFn()">후기 올리기</button>
									</div>
                               
							</div><!-- end clearfix -->
                        </div><!-- end grid -->
                    </div><!-- end col -->
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end section -->
    </div>
    <!-- end wrapper -->