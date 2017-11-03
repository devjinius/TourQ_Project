<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">

$(document).ready(function(){	

	getGrid();
});

/******************************************
 * jqGrid
 ******************************************/
var getGrid = function(){
	
	var cnames = ['코드','분류','이미지','이름', '계좌번호','노출순서','상태'];

    $("#adminPayTable").jqGrid({
    
        url: "jqgridAdminPayMain.do",
        datatype: "json",
        postData: {"param":""},
        colNames: cnames,
        colModel:[
      {name:'payNumber',	index:'payNumber',		key:true,		align:"center"},
      {name:'payType',		index:'payType',		align:"center",	edittype:"select",	formatter:"select",
    		
    	  editoptions: {
    		  
    		  value		:{"C":"카드", "B":"무통장"},
    		  dataEvents:[{

    			  type	:"change"
    		  }]
    	  }
      },
      {name:'payImg',		index:'payImg',		align:"center" ,		formatter:gridButton.logoImage},
      {name:'payName',		index:'payName',	align:"center"},
      {name:'bankNumber',	index:'bankNumber',	align:"center"},
      {name:'paySortnum',	index:'paySortnum',	align:"center"},
      {name:'payUseyn',		index:'payUseyn',	align:"center",		formatter:gridButton.changeUse}
		],
        height: '513',
        width: '97%',
        rowNum: 14,
        autowidth: true,
        cellEdit: true,
        cellsubmit: "clientArray",
        rownumbers  : false,
        multiselect	: true,
        viewrecords : true,
        loadonce : true,
        onCellSelect : function(rowId, colId, val, e){
        	
        	var payNumber = $("#adminPayTable").getCell(rowId, "payNumber");
        	var colModel = $("#adminPayTable").getGridParam("colModel");
        	var $adminPayTable = $("#adminPayTable");
        	
        	if (payNumber == "") {
				
        		for (var i = 2; i < colModel.length-1; i++) {
					
        			if (i != 3) {
	        			$adminPayTable.setColProp(colModel[i].name, {editable:true});
					}
				}
			} else {
				
				for (var i = 2; i < colModel.length; i++) {
					
					$adminPayTable.setColProp(colModel[i].name, {editable:false});
				}
			}
        },
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
			prevPageBtn = '<li><a href="#" onclick="javascript:surchButton.surchGrid(1)"><<</a></li>'
	   					+ '<li><a href="#" onclick="javascript:surchButton.surchGrid('+ prevPage +')"><</a></li>';
			
	   		nextPageBtn = '<li><a href="#" onclick="javascript:surchButton.surchGrid('+ nextPage +')">></a></li>'
	    					+ '<li><a href="#" onclick="javascript:surchButton.surchGrid('+ totalPage +')">>></a></li>';
		} else {
	   		prevPageBtn = '<li><a href="#" onclick="javascript:surchButton.surchGrid(1)"><<</a></li>';
			
	   		nextPageBtn = '<li><a href="#" onclick="javascript:surchButton.surchGrid('+ totalPage +')">>></a></li>';
		}

		pagination.append(prevPageBtn + pageNum + nextPageBtn);
	}
}

var gridButton = {
	
	/* 상태 변경 버튼 */
	changeUse	: function(cellvalue, options, rowObject){
		
		if (cellvalue == "Y") {
			
			return '<button class="btn btn-xs btn-red" type="button"'
			+'onclick="javascript:gridButton.changeUseYn(\''+ rowObject.payNumber +'\', \''+ cellvalue +'\')">노출중</button>'
		} else {
			
			return '<button class="btn btn-xs btn-default" type="button"'
			+'onclick="javascript:gridButton.changeUseYn(\''+ rowObject.payNumber +'\', \''+ cellvalue +'\')">비노출</button>'
		}
	},
	
	/* 노출여부 변경버튼 */
	changeUseYn	: function(getRowNum, useYn){
		
		var changeYn = {"payNumber" : getRowNum, "payUseyn" : ""},
			param = {};
		
		changeYn.payUseyn = useYn == "N" ? "Y" : "N";
		
		param = JSON.stringify(changeYn);
		
		this.saveFn({"url" : "jqgridAdminPayUpdate.do", "data" : {"updateData" : param}, "gubun" : true});
	},
	
	/* 행추가 */
	addRow		: function(){
		
		var totCnt = $("#adminPayTable").getGridParam("records");

		var addData = {"payNumber":"", "payNumber":"", "payType":"", "payImg":"", "payName":"", "paySortnum":"", "payUseyn":"2"}
		
		$("#adminPayTable").addRowData(totCnt+1, addData);
	},

	/* 수정버튼 */
	goEdit	: function(){
		
		var checkId = $("#adminPayTable").getGridParam("selarrrow"),
			colName = $("#adminPayTable").getGridParam("colModel"),
			that = this;
		
		if (checkId.length != 0) {

			var gridTable = $("#adminPayTable"),
				i = 0,
				j = 0;

			gridTable.editCell(0,0, false);
			
			/* 테이블의 셀을 선택했을때 그 셀이 체크박스로 선택된 셀이면 수정가능하게 한다. */
			gridTable.setGridParam({
				
				onCellSelect : function(rowId, colId, val, e){
					
					for (i = 2; i < colName.length-1; i++) {

						gridTable.setColProp(colName[i].name, {editable:false}); 
					}
					
					for (i = 0; i < checkId.length; i++) {
						
						if (rowId == checkId[i]) {
							
							for (j = 2; j < colName.length-1; j++) {
								
								if (colId == 3 && colName[j].name == "payImg"){

									gridTable.setColProp(colName[j].name, {editable:false, formmatter : that.addFileBtn(checkId[i], colId)}); 
								} else {

									gridTable.setColProp(colName[j].name, {editable:true}); 
								}
							}
						}
					}
				}
			});
		} else {
			
			alert("수정할 데이터를 선택하세요.");
		}
	},
	
	/* 선택한 데이터 저장 */
	saveData	: function(){

		$("#adminPayTable").editCell(0,0, false);
		
		var param1 = this.selectData("save");
		
		this.saveFn({"url" : "jqgridAdminPaySave.do", "data" : {"param1" : param1}, "gubun" : true});
		
		$.jgrid.gridUnload("#adminPayTable"); 
		getGrid();
	},
	
	addFileBtn : function(targetId, colNum){
		
		var gridTr = $("#adminPayTable").children().children("#"+ targetId),
			target = gridTr.children().eq(colNum);
		
		$(target).append('<span class="fileMask">파일 첨부'
						+ '<input type="file" id="payImg'+ targetId +'" name="payImg'+ targetId + '" onchange="editImg(this)">'
					+ '</span>');
		
		return false;
	},
	
	/* 그리드 상태가 변경될경우 적용을 위한 ajax */
	saveFn		: function(option){
		
		var settings = {
			
			url		: "jqgridAdminPaySave.do",
			data	: "",
			cType	: "application/x-www-form-urlencoded",
			gubun	: true
		},
		
		settings = $.extend({}, settings, option);
		
		console.log(settings);
		
		$.ajax({
				
			type	: "POST",
			url		: settings.url,
			async	: false,
			processData : settings.gubun,
            contentType : settings.cType,
			data	: settings.data,
			success	: function(result){
				
				if (result == "SUCCESS") {
					
					alert("저장에 성공하였습니다.");
				}
			}
		});
	},
	
	/* 저장인지 삭제인지, 인서트인지 업데이트인지 구분 */
	selectData	: function(gubun){
		
		var gubunText = gubun == "save" ? "저장" : "삭제",
			checkData = $("#adminPayTable").getGridParam("selarrrow"),
			that = this;
		
		if (checkData.length == 0) {
			
			alert("저장할 데이터를 선택하세요.");
			
			return;
		}
		
		if (confirm("선택한 데이터를 "+gubunText+" 하시겠습니까?") == false) {
			
			return false;
		}
		
		var iCnt = 0,
			jonArr = new Array(),
			i = 0;
		
		for (i = 0; i < checkData.length; i++) {
			
			var jsonObj = {},
				payNumber = $("#adminPayTable").getCell(checkData[i], "payNumber"),
				editType = "";
			
			/* 기존 데이터가 수정되었으면 업데이트를 하고 새로운 데이터가 추가되었으면 인서트를 한다. */
			if (!CommonJsUtil.isEmpty(payNumber)) {
				
				editType = "U";
			} else {

				editType = "I";
			}
			
			jsonObj.editType = editType;
			jsonObj.payNumber = payNumber;
			
			var cellName = $("#adminPayTable").getGridParam("colModel"),
				$grid = $("#adminPayTable"),
				j = 0,
				subImg = new FormData($("#payImgFrm")[0]);
			
			for (j = 2; j < (cellName.length-1); j++) {
				
				/* 이미지셀에 있는 내용을 ajax로 업로드 하고 파일명을 리턴받아 payImg에 저장한다. */
				if (cellName[j].name == "payImg") {
					
					var fileTarget = $("#"+ cellName[j].name + payNumber),
						checkIp = $grid.children().children("#"+ checkData[i]).children().eq(3);
					
					/* 파일추가 인풋이 있다면, 인풋의 사진을 서버에 저장하고 이름을 제이슨 오브젝트로 저장, 아닐경우 이미지파일의 이름을 제이슨 오브젝트로 저장한다. */
					if (checkIp.find("input").length != 0) {
						
						subImg.append("fileObj", $(fileTarget)[0].files[0]);
						
						that.saveFn({url : "savePayIcon.do", data : subImg, gubun : false, cType : false});
						
						jsonObj[cellName[j].name] = $(fileTarget).val().split("\\").pop(); 
					} else {
						
						jsonObj[cellName[j].name] = checkIp.children("img").attr("src").split("/").pop();
					}

				/* 현재 노출중 버튼의 값을 저장한다. */
				} else if (cellName[j].name == "payUseyn") {
					
					jsonObj[cellName[j].name] = $($grid.getCell(checkData[i], cellName[j].name)).html() == "노출중" ? "Y" : "N";
					
				/* 이미지가 아닌 셀의 데이터를 각 name에 저장한다 */
				} else {
					
					jsonObj[cellName[j].name] = $grid.getCell(checkData[i], cellName[j].name);
				}
			}
			
			jonArr[iCnt] = jsonObj;
			
			iCnt++
		}

		var param1 = JSON.stringify(jonArr);
		
		return param1;
	},
	
	/* 이미지파일이 이미 있을경우 해당 이미지 파일을 이미지로 표현하고, 새로운 행을 추가할경우 이미지 파일 추가 버튼을 생성한다. */
	logoImage	: function(cellvalue, options, rowObject){
		
		if (rowObject.payNumber == "") {
			
			return '<img src="images/payIcon/'+ cellvalue +'" class="gridMiniImg" />'
					+'<span class="fileMask">파일 첨부'
					 	+ '<input type="file" id="payImg'+ rowObject.payNumber +'" name="payImg'+ rowObject.payNumber + '" onchange="editImg(this)">'
					+ '</span>';
		} else {

			return '<img src="images/payIcon/'+ cellvalue +'" class="gridMiniImg" />';
			
		}
	}
}

/******************************************
 * 상단 서치바 이벤트
 ******************************************/
var surchButton = {
	
	surchMore	: function(){

		if ($("#paySurchSelect").val() != "") {
			
			var surchSelect = $("#paySurchSelect").val() == "카드" ? "C" : "B";
			
			this.surchGrid({"surchSelect":surchSelect});
		} else {
			
			this.surchGrid();
		}
	},
	
	surchGrid	: function(options){
		
		var settings = {
			
			surchSelect	:"",
			page : "1"
		}
		settings = $.extend({}, settings, options);
		
		$("#adminPayTable").setGridParam({
			
			datatype	:"json",
			postData	:{"param":settings.surchSelect},
			page		: settings.page,
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

/******************************************
 * 인풋 이미지 변경시 미리보기 변경
 ******************************************/
 function editImg(eTarget){
	
	var img = eTarget.files[0],
		imgTarget = $(eTarget).parent().prev(),
		reader = new FileReader();
	
    reader.onload = function (e) {
    	
    	$(imgTarget).attr("src", e.target.result);
    }
    
    reader.readAsDataURL(img);
}
</script>
<form	id="payImgFrm"	name="payImgFrm">
</form>

<div class="mainbar">
   
	<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">결제수단 관리
			  <!-- page meta -->
			  <span class="page-meta">결제수단 노출관리창 입니다.</span>
			</h2>
			<!-- Breadcrumb -->
			<div class="pull-right widget-head-right">
				<div class="bread-crumb">
				  <a href="index.html"><i class="fa fa-home"></i> 예약관리</a> 
				  <!-- Divider -->
				  <span class="divider">/</span> 
				  <a href="#" class="bread-current">결제수단 관리</a>
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
						    <div class="pull-left col-md-3 set-surch btn-select-box">
						    	<form id="paySurchMoreFrm" name="paySurchMoreFrm">
									<div class="pull-left select-surch admin-select col-md-7">
		                                <select class="selectpicker form-control" data-size="8" data-live-search="false" title="결제종류 선택" id="paySurchSelect">
		                                    <option data-tokens="전체" value="">전체</option>
		                                    <option data-tokens="카드">카드</option>
		                                    <option data-tokens="무통장">무통장</option>
		                                </select>
									</div>
									<div class="pull-left">
										<button class="btn btn-default btn-navy" type="button" onclick="javascipt:surchButton.surchMore()">검색</button>
									</div>
								</form>
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
				<button class="btn btn-xs btn-green pull-left" type="button" onclick="javascript:gridButton.addRow()"><i class="fa fa-plus"></i> 행추가</button>
				<button class="btn btn-xs btn-green pull-left" type="button" onclick="javascript:gridButton.saveData()"><i class="fa fa-pencil"></i> 저장</button>
				<button class="btn btn-xs btn-yellow pull-left" onclick="javascript:gridButton.goEdit()"><i class="fa fa-unlock"></i> 수정</button>
			</div>
			<div class="clearfix"></div>
		</div>
		<div class="container">
			<table id="adminPayTable" class="table input-table table-bordered"></table>
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