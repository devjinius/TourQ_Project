<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
var submitNumber = {

		submit : function(number) {
	           
	           $("#number").val(number);
	           
	           left.adminSubmitFn('adminEventDetail','adminEventDetail.do','frmNumber');
	    }
}	

	$(document).ready(function(){	

		var pageName = "<c:out value="${param.pageName}"/>";
		
		$("[prop=menu]").removeClass("active");
		
		$("#"+pageName).addClass("active");
		
		$("tr").click(function(){
	    	
			$("#number").val($(this).children().eq(1).html());  	

		});
		
		
		jqgridTable.init();
		jqgridTable.goSearch();
		
	});
	   

	var CommonJsUtil = 
	{
	    isEmpty : function(val) {
	        if (null == val || null === val || "" == val || val == undefined || typeof(val) == undefined || "undefined" == val || "NaN" == val) {
	            return true;
	        } else {
	            return false;
	        }
	    },
	    
	    isNumeric : function(val) {
	    	if (!/^[0-9]/.test(val)) {		
	            return false;
	        } else {
	            return true;
	        }
	    }
	}

	/******************************************
	 * jqgrid 
	 ******************************************/
	var jqgridTable = 
	{
		
		init : function() {
			
			var cnames = ['번호','제목','내용','시작일','종료일','할인율','코스번호'];
			
		    $("#jqGrid").jqGrid({
		    	
		        url: "adminJqEvent.do",
		        datatype: "local",
		        colNames: cnames,
		        colModel:[
		   	   		   {name:'seq',       index:'seq',      width:55,    key:true,    align:"center"},	
			           {name:'eventTitle',        index:'eventTitle',      width:100,             align:"center"},
			           {name:'eventContent',     index:'eventContent',     width:100},
			           {name:'eventSdate',        index:'eventSdate',         width:100},
			           {name:'eventEdate',        index:'eventEdate',         width:100},
			           {name:'eventDiscount',     index:'eventDiscount',       width:100},
			           {name:'courseNumber',      index:'courseNumber', 		width:100}
		        	  
				],
		        height			: 480,
		        rowNum			: 10,
		        rowList			: [10,20,30],
		        pager			: '#jqGridPager',
		        cellEdit		: true,					//
		        cellsubmit		: "clientArray",		//수정된 사항을 바로 보내지 않고 가지고 있음	//이게 없으면 셀 수정시 url로 바로 감,		
		        multiselect		: true,					//체크박스
		        rownumbers		: true,
		        viewrecords : true, 
		        
		        
	        	onCellSelect : function(rowId, colId, val, e) { // e의 의미는?					//onCellSelect는 jqgrid에서 만듬	//콜백함수(파라메터로 함수를 넣으면)
	                
					//console.log(rowId, colId, val, e);	        			
	        		submitNumber.submit($("#jqGrid").getCell(rowId, "seq"));
	        	
	        		var seq = $("#jqGrid").getCell(rowId, "seq");
	                
		       		console.log($("#jqGrid").setGridParam('colModel'));
	        		
	           //     if(colId == 3) {											//2 -> 3으로 늘린건 체크박스 컬럼 추가되서
	                    if(CommonJsUtil.isEmpty(seq)) {							//조회한 데이터(줄)가 빈값이면 
	                        $("#jqGrid").setColProp('seq',  {editable:true});
	                        $("#jqGrid").setColProp('eventTitle',     {editable:true});
	                        $("#jqGrid").setColProp('eventContent', {editable:true});
	                        $("#jqGrid").setColProp('eventSdate',    {editable:true});
	                        $("#jqGrid").setColProp('eventEdate',   {editable:true});
	                        $("#jqGrid").setColProp('eventDiscount',{editable:true});
	                        $("#jqGrid").setColProp('courseNumber', {editable:true});
	                    } else {
	                        $("#jqGrid").setColProp('seq',  {editable:false});
	                        $("#jqGrid").setColProp('eventTitle',     {editable:false});
	                        $("#jqGrid").setColProp('eventContent', {editable:false});
	                        $("#jqGrid").setColProp('eventSdate',    {editable:false});
	                        $("#jqGrid").setColProp('eventEdate',   {editable:false});
	                        $("#jqGrid").setColProp('eventDiscount',{editable:false});
	                        $("#jqGrid").setColProp('courseNumber', {editable:false});
	                    }
	               // }
	                
	            }
	            
	   
		        
		    });
		},
		
		
		goSearch : function () {

			var jsonObj = {};
			
		 	if ($("#selectId").val() != "C") {
				jsonObj.serviceImplYn = $("#selectId").val();
			}
			
			$("#jqGrid").setGridParam({
				
		        datatype : "json",
		        postData : {"param" : JSON.stringify(jsonObj)},
		        loadComplete: function (data){
		        	
		        	$.each(data, function (i, item) { 

						if (i == "rows") {	
							if (item < 1) {							
								alert("데이터가 없습니다.");
							}
						}
		        	});
		        }
		    }).trigger("reloadGrid");
		},
		

		
		saveData : function() {
			
			//저장 전 validation 체크
			if(!this.gridValid()){
				
				return false;
			}
			
			$("#jqGrid").editCell(0, 0, false);
			
			var param1 = this.selectData('save'),
			 	that = this;
			
			$.ajax({
				
				type		:	"post",
				url			:	"saveJqEvent.do",
				data		:	{"param1": param1},
				async		:	false,
				beforeSend	: 	function(xhr){

				},
				success		:	function(result){
					
					if(result == "SUCCESS"){
						
						alert("성공적으로 저장하였습니다.");
						
						that.goSearch();
					}
				},
				
				error		: 	function() {
					
					alert("error");
				}
				
			});

		},
		
		deleteData : function() {
			
			if(!this.gridValid()){
				
				return false;
			}
			
			$("jqGrid").editCell(0, 0, false);
			
			var param1 = this.selectData('del'),
		        that = this;
			
			$.ajax({
				
				type		:	"post",
				url			:	"saveJqEvent.do",
				data		:	{"param1": param1},
				async		:	false,
				beforeSend	: 	function(xhr){

				},
				success		:	function(result){
					
					if(result == "SUCCESS"){
						
						alert("성공적으로 삭제하였습니다.");
						
						that.goSearch();
					}
					//this.goSearch();
				},
				
				error		: 	function() {
					
					alert("error");
				}
				
			});

		},
		
		gridValid : function() {
		    
	        var $jqGrid = $("#jqGrid"),
	        	trObj = $("#jqGrid").find("tr"),
	        	i = 0;

	        for (i = 0; i < trObj.length; i++) {

	            var $this = $(trObj[i]);

	            if ($this.hasClass("edited")) {

	                var rowId = $this.prop("id");
	              //  var phone = $("#jqGrid").getCell(rowId, "phone");
	                
	 //               alert(phone);
	                
	               /*  if (!CommonJsUtil.isNumeric(phone)) {

	                    alert(rowId + "째 행 전화번호는 숫자만 입력가능합니다.");

	                    return false;

	                    break;
	                } */
	            }
	        }
	        /* for (i = 0; i < trObj.length; i++) {

	            var $this = $(trObj[i]);
				var rowId = $this.prop("id"),
					phone = "";
				
	            if($this.hasClass("selected-row")) {								
	            	var value = $("#" + rowId + " td input[name=phone]").val();		//해당 인풋박스의 벨류를 넣음
	            	
	            	if(value){														
	            		phone = value;								//인풋박스가 있는 상황에서 저장누르면 여기
	            	}else {
	            		phone = $jqGrid.getCell(rowId, "phone");			
	            	}
	            	
					if(!CommonJsUtil.isNumeric(phone)) {
		        		
						alert(rowId + "째 열 전호하번호는 숫자만 입력가능함");
						
						return false;
		        	}
	          
		        } else if($this.hasClass("edited")) { 
		        	phone = $jqGrid.getCell(rowId, "phone");				
		        	
		        	if(!CommonJsUtil.isNumeric(phone)) {
		        		
						alert(rowId + "째 열 전호하번호는 숫자만 입력가능함");
						
						return false;
		        	}
		        }
	            
	            

	            
	        } */
	        
	        

	        return true;
	    },
	    
		selectData : function(gubun){
	 		
	    	var $jqGrid = $("#jqGrid"),
	    		gubunText = gubun =='save' ? '저장' : '삭제',
	    		iCnt = 0 ,
	    		jsonArra1 = new Array(),
	    		$columns = $("#jqGrid").getGridParam("colModel");
	    	
	   			
	    	var checkData = $("#jqGrid").getGridParam("selarrrow");

	    	
	    	if(checkData.length == 0){
				
	    		alert(gubunText + "할 데이터를 선택하여 주십시오.");
	    		
	    		return;
	    	}
	    	if(confirm("선택한 데이터를" +gubunText +" 하시겠습니까?") == false) {
	    		
	    		return false;
	    	}
	    	
	    	var iCnt = 0;
	    	var jsonArray1 = new Array();
	    	
	    	for(var i = 0; i <checkData.length; i++) {			//checkData - 체크된 로우
	    		
	    		var jsonObj = {},
	    			seq = $jqGrid.getCell(checkData[i],"seq"),
	    			editType ="";
	    		
	    		/* if(gubun =='del') {
	    			var data = $jqGrid.getCell(checkData[i], "gender");
	    			
	    			if(data =="2") {
	    				alert("여성 데이터는 삭제 할수 없습니다. 다시 선택해 주시기 바랍니다");
	    				
	    				return;
	    			}
	    			
	    		} */
	    		
	    	
	    	
	    		if(!CommonJsUtil.isEmpty(seq)){
	    			editType = "D";
	    		} else {
	    			editType = "I";
	    		}
	    		
	    		jsonObj.editType = editType;
	    		
	    		$($columns).each(function(j) {
	    				
	    			jsonObj[$columns[j].name] = $jqGrid.getCell(checkData[i], $columns[j].name);  //j 컬럼인덱스  //젠더가 select박스인  채로 저장 누르면 안들어감
	    			
	    			//jsonObj[$columns[j].gender] = $jqGrid.getCell(checkData[i], $columns[j].gender); 
	    			//jsonObj[$columns[j].phone] = $jqGrid.getCell(checkData[i], $columns[j].phone); 
	    		});
	    		
	   
	    	 	jsonObj.seq = seq;								//280라인 대체
	    		//alert(checkData[i]); 
	    		
	            jsonObj.eventTitle   =   $("#jqGrid").getCell(checkData[i], "eventTitle");
	            jsonObj.eventContent =   $("#jqGrid").getCell(checkData[i], "eventContent");
	            jsonObj.eventSdte    =   $("#jqGrid").getCell(checkData[i], "eventSdate");
	            jsonObj.eventEdate   =   $("#jqGrid").getCell(checkData[i], "eventEdate");
	            jsonObj.eventDiscount=   $("#jqGrid").getCell(checkData[i], "eventDiscount");
	            jsonObj.courseNumber =   $("#jqGrid").getCell(checkData[i], "courseNumber");

	    		
	    		
	    		jsonArray1[iCnt] = jsonObj;
	    		//jsonArray1 = push(jsonObj);
	    		console.log(jsonObj); 
	    		iCnt++;
	    		
	    	}
	    	
	    	var param1 = JSON.stringify(jsonArray1);			//param1 이  무슨형태인지  확인해보자
	    	
	    	return param1;
	    }
	}

	/******************************************
	 * 그리드 관련 메소드
	 ******************************************/
	var gridFunc = 
		
	{
		addRow : function() {
			
			var totCnt = $("#jqGrid").getGridParam("records");

			var addData = {"seq":"" , "eventTitle":"", "eventCount":"", "eventSdate":"", "boardOrder":"" ,"boardDate" :""};
			
				$("#jqGrid").addRowData(totCnt+1, addData);
				$("#jqGrid").setColProp('eventTitle',  {editable:true});
				$("#jqGrid").setColProp('eventContent',{editable:true});
				$("#jqGrid").setColProp('eventSdate', {editable:true}); 
				$("#jqGrid").setColProp('eventEdate', {editable:true}); 
				$("#jqGrid").setColProp('eventDiscount', {editable:true});  
				$("#jqGrid").setColProp('courseNumber', {editable:true});  
			
		},
		
		rowBtn : function(cellvalue, options, rowObject) {
			
			/* if(rowObject.seq == ""){
				
				return '<a href="javascript:gridFunc.delRow('+options.rowId+');">행삭제</a>';			//클릭하면 gridFunction.delRow로 감 해당 로우의 아이디를 가져감
			} else {
				
				return "";
			} */  //이 주석이랑 아래 라인이랑 같음 (아래는 삼항연산자 사용)
			
			return(!CommonJsUtil.isEmpty(rowObject.seq))? "" : "<a href='javascript:gridFunc.delRow("+options.rowId+");'>행삭제</a>;"
			
		},

		
	    delRow : function(rowid) {
	    	
	    	if(rowid != "") {
	    		
	    		$("#jqGrid").delRowdata(rowid);
	    	}
	    },
	    
	    clearGrid : function() {
	    	
	    	$("#jqGrid").clearGridData();
	    }


	}


</script>
<form id="frmNumber" name="frmNumber">
	<input type="hidden" id="number" name="number" /> 
</form>


<!-- onclick="javascript:left.adminSubmitFn('adminEvent', 'adminEvent.do','frmAdmin')" -->
<div class="mainbar">
<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">이벤트 관리
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
			<div class="widget-content">
				<div class="padd">
					
					<div class="col-lg-12">
						
						<span class="input-title">기간설정</span>
					    <div class="pull-left col-md-5 btn-select-box">
							
						    <div class="input-append date dtpicker col-md-4">
						    	<div class="add-on">
									<input data-toggle="datepicker" class="form-control" type="text" placeholder="이벤트 기간" name="eventStart">
									<i class="fa fa-calendar" data-date-icon="fa fa-calendar" data-time-icon="fa fa-clock-o"></i>
						    	</div>
						    </div>
						    
							<span class="dtpicker-next">~</span>
							
						    <div class="input-append date dtpicker col-md-4">
						    	<div class="add-on">
									<input data-toggle="datepicker" class="form-control" type="text" placeholder="이벤트 기간" name="eventEnd">
									<i class="fa fa-calendar" data-date-icon="fa fa-calendar" data-time-icon="fa fa-clock-o"></i>
						    	</div>
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
			<div class="widget-content" style="display: none;"> <!--  " -->
				<div class="padd">
					<div class="col-lg-12">
					    <div class="pull-left select-box col-md-2">
							<select name="theme" id="theme" class="form-control select-btn" >
     							<optgroup label="이벤트">
  									<option value="진행">진행중인 이벤트</option>
									<option value="종료">종료된 이벤트</option>
								
     							</optgroup>
     						
							</select>
					    </div>
						<div class="clearfix"></div><!-- 플롯해제 -->
					</div><!-- END ROW -->

					<div class="col-lg-12">
						<div class="form-group col-md-3">
							<span class="input-title">상세검색</span>
						    <div class="pull-left select-box col-md-4 set-surch btn-select-box">
								<div class="pull-left set-surch-select col-md-3">
									<a class="form-control select-btn">검색항목</a>
							    	<ul class="select-list" style="display: none;">
							    		<li>
							    			<a class="select-option">이벤트명</a>
							    		</li>
							    		<li>
							    			<a class="select-option">기간</a>
							    		</li>
							    	</ul>
								</div>
								<div class="pull-left set-surch-inp col-md-7">
								  <input type="text" class="form-control" id="telephone">
								</div>
								<div class="pull-left">
									<button class="btn btn-default btn-navy" type="button">검색</button>
								</div>
								
						    </div>
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
				<button class="btn btn-xs btn-info pull-left" type="button" href="#" onclick="javascript:jqgridTable.goSearch();"><i class="fa fa-search"></i> 조회</button>
				<button class="btn btn-xs btn-red pull-left" type="button" href="#" onclick="javascript:jqgridTable.deleteData();"><i class="fa fa-trash-o"></i> 삭제</button>
				<button class="btn btn-xs btn-navy pull-left" type="button" href="#" onclick="javascript:jqgridTable.saveData();"><i class="fa fa-pencil"></i> 저장</button>
				<button class="btn btn-xs btn-green pull-left" type="button" href="#" onclick="javascript:gridFunc.addRow();"><i class="fa fa-plus"></i> 추가</button>
				<button class="btn btn-xs btn-yellow pull-left" href="#" onclick="javascript:gridFunc.clearGrid();"><i class="fa fa-unlock"></i> 초기화</button>
<!-- 				<button class="btn btn-xs btn-green pull-left" type="button" onclick="javascript:left.adminSubmitFn('noticeCreate','frmAdmin')"><i class="fa fa-plus"></i> 추가</button> -->
			</div>
		  	<div class="clearfix"></div>
		</div>
		<div class="container full-page-topBtn">
			<%-- <div class="widget-content medias">
				<div class="table-responsive">
					<table class="table table-bordered ">
						<thead>
							<tr>
								<th></th>
								<th>번호</th>
								<th>제목</th>
								<th>내용</th>
								<th>시작일</th>
								<th>종료일</th>
								<th>할인율</th>
								<th>코스번호</th>
							  	
							</tr>
						</thead>
						<tbody>
								<c:forEach items="${adEventList}" var="adEventList" varStatus="status">
                            		<tr onclick="javascript:submitNumber.submit('<c:out value="${adEventList.seq}"/>')">
                            			<td></td>
	                               		<td><c:out value="${adEventList.seq}"/></td>
	                               		<td><c:out value="${adEventList.eventTitle}"/></td>
	                               		<td><c:out value="${adEventList.eventContent}"/></td>
	                               		<td><c:out value="${adEventList.eventSdate}"/></td>
	                               		<td><c:out value="${adEventList.eventEdate}"/></td>
	                               		<td><c:out value="${adEventList.eventDiscount}"/></td>
	                               		<td><c:out value="${adEventList.courseNumber}"/></td>
	                               	</tr>
                            	</c:forEach>
						</tbody>
					</table>
				</div> 
			</div> --%>
		  <table id="jqGrid"></table>
          <div id="jqGridPager"></div>

		</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
				<!-- <div class="col-md-12 widget-foot">
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
				</div> -->
	</div><!--/ Matter ends -->
</div><!--/ Mainbar ends -->