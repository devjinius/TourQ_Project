<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="mainbar">
   
	<!-- Page heading -->
	<div class="page-head">
		<div class="widget-head">
		<!-- Page heading -->
			<h2 class="pull-left">통합 대쉬보드
			  <!-- page meta -->
			  <span class="page-meta">TourQ 어드민 페이지입니다.</span>
			</h2>
			<div class="clearfix"></div>
		</div>
	</div><!--/ Page heading ends -->

	<!-- Matter -->
	<div class="matter nonsurch">
		<div class="container dashboard">
		
			<div class="board-center">
				<div id="chart-container" class="pull-left">주간매출현황 그래프</div>
				<div id="pieChartContainer" class="pull-left">회원가입유형 그래프</div>
				<div class="clearfix"></div>
			</div>
			
			<div class="dashboard-bottom board-center">
				<div id="chartContainer" class="pull-left">전체 매출현황 그래프</div>
				<div class="clearfix"></div>
			</div>

		</div> <!-- 컨텐츠 영역 끝 // 삭제금지 -->
	</div><!--/ Matter ends -->
</div><!--/ Mainbar ends -->
<script>

/* 전체 매출현황 */
FusionCharts.ready(function () {
    var salesChart = new FusionCharts({
    type: 'MSColumn2D',
    renderAt: 'chartContainer',
    width: '1000',
    height: '300',
    dataFormat: 'json',
    dataSource: {
        "chart": {
            "caption": "2017년 매출 현황",
            "baseFont" : "Helvetica Neue,Arial",
            "captionFontSize" : "14",
            "baseFontColor" : "#333333",
            "decimals": "0",
            "numberprefix": "￦",
            // "numbersuffix": "만원",
            "placevaluesinside": "1",
            
            "paletteColors": "#f8bd19,#008ee4,#000",	//bar 색상
            "bgColor": "#ffffff",	//여기부터
            "showBorder" : "0",
            "borderAlpha": "20",
            "canvasBorderAlpha": "0",
            "usePlotGradientColor": "0",
            "plotBorderAlpha": "10",
            "rotatevalues": "1",
            "valueFontColor": "#ffffff",          
            "showXAxisLine": "1",
            "xAxisLineColor": "#999999",
            "divlineColor": "#999999",
            "divLineIsDashed" : "1",
            "divLineDashLen" : "1", 	// 여기까지 bg
            "theme": "zune"
        },
        "categories": [{
            "category": [
                { "label": "1월" },
                { "label": "2월" },
                { "label": "3월" },
                { "label": "4월" },
                { "label": "5월" },
                { "label": "6월" },
                { "label": "7월" },
                { "label": "8월" },
                { "label": "9월" },
                { "label": "10월" },
                { "label": "11월" },
                { "label": "12월" }
            ]
        }],
        "dataset": [{
                "seriesname": "도보",
                "data": [
                    { "value": "42" },
                    { "value": "42" },
                    { "value": "42" },
                    { "value": "42" },
                    { "value": "42" },
                    { "value": "42" },
                    { "value": "42" },
                    { "value": "42" },
                    { "value": "42" },
                    { "value": "42" },
                    { "value": "42" },
                    { "value": "42" }
                ]
            },
            {
                "seriesname": "버스",
                "data": [
                    { "value": "125" },
                    { "value": "125" },
                    { "value": "125" },
                    { "value": "125" },
                    { "value": "125" },
                    { "value": "125" },
                    { "value": "125" },
                    { "value": "125" },
                    { "value": "125" },
                    { "value": "125" },
                    { "value": "125" },
                    { "value": "125" }
                ]
            },
            {
                "seriesname": "전체",
                "data": [
                    { "value": "58" },
                    { "value": "58" },
                    { "value": "58" },
                    { "value": "58" },
                    { "value": "58" },
                    { "value": "58" },
                    { "value": "58" },
                    { "value": "58" },
                    { "value": "58" },
                    { "value": "58" },
                    { "value": "58" },
                    { "value": "58" }
                ]
            }
        ]
    }
}).render();
});

/* 회원가입 유형분석 */
FusionCharts.ready(function () {
    var revenueChart = new FusionCharts({
        type: 'doughnut2d',
        renderAt: 'pieChartContainer',
        width: '450',
        height: '340',
        dataFormat: 'json',
        dataSource: {
            "chart": {
                "caption": "2017 회원 유형분석",
                "numberPrefix": "$",
                "paletteColors": "#0075c2,#1aaf5d,#f2c500,#f45b00,#8e0000",
                "bgColor": "#ffffff",
                "showBorder": "0",
                "use3DLighting": "0",
                "showShadow": "0",
                "enableSmartLabels": "0",
                "startingAngle": "310",
                "showLabels": "0",
                "showPercentValues": "1",
                "showLegend": "1",
                "legendShadow": "0",
                "legendBorderAlpha": "0",
                "defaultCenterLabel": "총 방문자",
                "centerLabel": "Revenue from $label: $value",
                "centerLabelBold": "1",
                "showTooltip": "0",
                "decimals": "0",
                "captionFontSize": "14",
            },
            "data": [
                {
                    "label": "회원가입",
                    "value": "28504"
                }, 
                {
                    "label": "비회원주문",
                    "value": "14633"
                }, 
                {
                    "label": "메일링신청",
                    "value": "10507"
                }, 
                {
                    "label": "회원가입후 주문",
                    "value": "4910"
                }
            ]
        }
    }).render();
});

/* 주간 매출현황 */
FusionCharts.ready(function () {
    var visitChart = new FusionCharts({
        type: 'msline',
        renderAt: 'chart-container',
        width: '550',
        height: '340',
        dataFormat: 'json',
        dataSource: {
            "chart": {
                "caption": "8월 4주차 매출 현황",
                "decimals": "0",
                "numberprefix": "￦",
                "placevaluesinside": "1",
                "numberScaleValue":  "10000",
                //"numberScaleUnit":  "만원",
                	
                //Cosmetics
                "lineThickness" : "3",
                "paletteColors": "#dddddd, #0075c2",
                "baseFontColor" : "#333333",
                "baseFont" : "Helvetica Neue,Arial",
                "captionFontSize" : "14",
                "showBorder" : "0",
                "bgColor" : "#ffffff",
                "showShadow" : "0",
                "canvasBgColor" : "#ffffff",
                "canvasBorderAlpha" : "0",
                "divlineAlpha" : "100",
                "divlineColor" : "#999999",
                "divlineThickness" : "1",
                "divLineIsDashed" : "1",
                "divLineDashLen" : "1",
                "divLineGapLen" : "1",
                "showXAxisLine" : "1",
                "xAxisLineThickness" : "1",
                "xAxisLineColor" : "#999999",
                "showAlternateHGridColor" : "0",
                
            },
            "categories": [
                           {
                               "category": [
                                   { "label": "월" }, 
                                   { "label": "화" }, 
                                   { "label": "수" },
                                   { "label": "목" }, 
                                   { "label": "금" }, 
                                   { "label": "토" }, 
                                   { "label": "일" }
                               ]
                           }
                       ],
                       "dataset": [
                           {
                               "seriesname": "전주 매출",
                               "showValues": "0",
                               "data": [
                                   { "value": "13400" }, 
                                   { "value": "12800" }, 
                                   { "value": "22800" }, 
                                   { "value": "12400" }, 
                                   { "value": "15800" }, 
                                   { "value": "19800" }, 
                                   { "value": "21800" }
                               ]
                           },
                           {
                               "seriesname": "이번주 매출 추이",
                               "data": [
                                   { "value": "15123" }, 
                                   { "value": "14233" }, 
                                   { "value": "25507" }, 
                                   { "value": "9110" }, 
                                   { "value": "15529" }, 
                                   { "value": "20803" }, 
                                   { "value": "19202" }
                               ]
                           }
                       ], 
                       "trendlines": [
                           {
                               "line": [
                                   {
                                       "startvalue": "17022",
                                       "color": "#6baa01",
                                       "valueOnRight": "1",
                                       "displayvalue": "전주평균"
                                   }
                               ]
                           }
                       ]
        }
    });
    
    visitChart.render();
});

FusionCharts.ready(function () {
    var visitChart = new FusionCharts({
        type: 'line',
        renderAt: 'chart-container2',
        width: '500',
        height: '300',
        dataFormat: 'json',
        dataSource: {
            "chart": {
                "caption": "Total footfall in Bakersfield Central",
                "xAxisName": "Day",
                "yAxisName": "No. of Visitors",
                
                //Cosmetics
                "lineThickness" : "2",
                "paletteColors" : "#000000",
                "baseFontColor" : "#333333",
                "baseFont" : "Helvetica Neue,Arial",
                "captionFontSize" : "14",
                "showBorder" : "0",
                "bgColor" : "#ffffff",
                "showShadow" : "0",
                "canvasBgColor" : "#ffffff",
                "canvasBorderAlpha" : "0",
                "divlineAlpha" : "100",
                "divlineColor" : "#999999",
                "divlineThickness" : "1",
                "divLineIsDashed" : "1",
                "divLineDashLen" : "1",
                "divLineGapLen" : "1",
                "showXAxisLine" : "1",
                "xAxisLineThickness" : "1",
                "xAxisLineColor" : "#999999",
                "showAlternateHGridColor" : "0",
                
            },
            "data": [
                {
                    "label": "Mon",
                    "value": "15123"
                },
                {
                    "label": "Tue",
                    "value": "14233"
                },
                {
                    "label": "Wed",
                    "value": "23507"
                },
                {
                    "label": "Thu",
                    "value": "9110"
                },
                {
                    "label": "Fri",
                    "value": "15529"
                },
                {
                    "label": "Sat",
                    "value": "20803"
                },
                {
                    "label": "Sun",
                    "value": "19202"
                }
            ]
        }
    });
    
    visitChart.render();
});
</script>