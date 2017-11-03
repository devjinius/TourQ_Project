/*어드민 모달창*/
var modal = {
		
	adminReservation : function(target){

		var modalHeight = "",
			$adminModal = $("."+ target),
			$adminModalBg = $(".admin-modal-bg"),
			selectBox = $adminModal.find("select");
		
		$adminModal.toggleClass("hidden");
		$adminModalBg.toggleClass("hidden");
		
		
		// 모달 중앙정렬
		if (!($adminModal.hasClass("hidden"))) {
			
			modalHeight = $adminModal.children(".admin-m-content").height();
			
			$adminModal.children(".admin-m-content").css("margin-top",(-modalHeight/2));
		} else {

			/* 모달창 초기화 */
			$adminModal.find("input").val("");
			
			selectBox.each(function(){
				
				var $this = $(this),
					placeholder = $this.children(".bs-title-option").text();
				
				$this.prev().children().children().removeClass();
				
				$this.prev().prev().attr("title", placeholder).children(".filter-option").text(placeholder);
				
				$this.children(".bs-title-option").prop("selected", true);
			})
			
			var $productTime = $("#productTime"),
				$adminSeatArea = $("#adminSeatArea"),
				$showSeatArea = $("#showSeatArea");
			
			if ($productTime.length != 0) {
				
				$productTime.parent().children("button").remove();
			}
			
			if ($adminSeatArea.length != 0) {
				$adminSeatArea.children().remove();
			}
			if ($showSeatArea.length != 0) {
				$showSeatArea.children().remove();
			}
		}
	}
}

/*좌석 드래그를 할경우 새로운 좌석 아이콘을 생성하고 드래그 기능 및 좌표 지정*/
var adminBus = {
		
	addRowSeat : function() {
		
		var $selectRow = $(".seatRow.active"),
			$totalseat = $("#totalSeat")
			totalVal = $("#totalSeat").val() * 1;
		
		if ($selectRow.length == 0) {
			alert("선택될 열이 없어 좌석 추가를 할 수 없습니다.");
			
			return;
		}
		
		var makeSeat = '<div class="bus-seat bus-seat-admin" new="busSeat" id="seat_'+ totalVal +'" onmouseenter="javascript:adminBus.dragSeat('+ totalVal +')">'
							+'<div class="bus-seat-mask"></div>'
						+'</div>';
		
		$selectRow.append(makeSeat);
		
		$totalseat.val(totalVal + 1);
		
	},
	
	delRow : function() {

		var $selectRow = $(".seatRow.active");
		
		if ($selectRow.length == 0) {
			alert("삭제할 열을 선택해주세요.");
			
			return;
		}
		
		$selectRow.remove();
	},
		
	btnClick : function(clickItem){
		
		var $addSeat = $("[new=busSeat]"),
			$newSeat = $("#newSeat"),
			maxSeat = parseInt($("#adminSeatArea").width() / 27),
			$seatRow = $(".seatRow");

		if ($newSeat.val() == "" || $newSeat.val() == 0) {
			alert("생성될 좌석수를 입력하세요.");
			
			return;
		}
		
		if ($newSeat.val() > maxSeat) {
			alert("한줄에 추가할 수 있는 최대 좌석수를 초과하였습니다. 최대 "+ maxSeat + "석 생성 가능합니다.");
			
			return;
		}
		
		this.rowId = $seatRow.length;
		
		this.creatSeat($addSeat.length, $newSeat.val());
	},
		
	rowId : 0,
	
	creatSeat : function(seatId, addSeat){

		var makeSeat = "",
			$totalSeat = $("#totalSeat");

		if (this.rowId < 5) {

			for (var i = 0; i < addSeat; i++) {
	
				makeSeat += '<div class="bus-seat bus-seat-admin" new="busSeat" id="seat_'+ (seatId + i) +'" onmouseenter="javascript:adminBus.dragSeat('+ (seatId + i) +')">'
				+'<div class="bus-seat-mask"></div>'
				+'</div>';
			}

			$("#adminSeatArea").append('<div id="seatRow_'+ this.rowId +'" class="seatRow" ondblclick="javascript:adminBus.dragRow(this)">'+ makeSeat +'</div>');

			this.dragSeat();

			$totalSeat.val(seatId + (addSeat * 1));
		} else {
			
			alert("좌석 열을 더이상 추가 할 수 없습니다.");
			return;
		}
	},
	
	// 좌석 드래그 가능하게 지정
	dragSeat : function(target){
			
		var seatPosition = "",
			$seatTarget = $("#seat_"+ target);
		
		$seatTarget.draggable({
			containment : "parent",
			grid	: [5, 0],
			axis	: "x",
			connectToSortable	: '.seatRow'
		});
	},

	// 열을 더블클릭하면 이동가능하도록 지정
	dragRow : function(target) {
		
		var $seatRow = $(".seatRow");
		
		$(target).toggleClass("active");
		
		$seatRow.not(target).removeClass("active");
		
		if ($(target).hasClass("active")) {

			$seatRow.draggable({disabled : true});

			$(target).draggable({
				disabled : false,
				containment: "parent",
				axis	: "y"
			});
		} else {
			
			$(target).draggable({disabled : true});
		}
	}
}

var add = {
	
	busData : function() {

		var $seat = $("[new=busSeat]");
		
		if ($seat.length == 0) {
			alert("저장할 좌석이 없습니다.");
			
			return;
		}

		if (!(confirm("해당 정보를 저장하시겠습니까?"))) {
			alert("저장이 취소되었습니다.");
			
			return;
		}
		
		var $seatRow = $("#adminSeatArea").children(".seatRow"),
			topPosition = new Array;
		
		$seatRow.each(function(i, item) {
			
			topPosition.push($(item).position().top);
		});
		
		// 열의 좌표값을 크기순으로 재 정렬
		topPosition = topPosition.sort(this.sortNm);
		
		var addData = new Array,
			i = 0,
			that = this;
		
		for (i = 0; i < topPosition.length; i++) {
			
			$seatRow.each(function(j, item) {
				
				if ($(item).position().top == topPosition[i]) {
					var positionArr = [],
						positionArrRes = [];
					
					$(item).children().each(function(k, seat) {
						
						positionArr[k] = $(seat).position().left;
					});
					
					// 좌석의 좌표값을 크기순으로 재 정렬
					positionArrRes = positionArr.sort(that.sortNm);
					
					addData.push({"rowNum" : ""+ i +"", "seatLeft" : positionArrRes.join(","), "seatTop" : topPosition[i]});
				}
			});
		}
		
		var selectBus = $("#selectBus").val();
			totalSeat = $("#totalSeat").val();
			busName = $("#busName").val();
			
		this.seatSaveFn({"param" : addData, "url" : "seatSave.do", "selectBus" : selectBus, "totalSeat" : totalSeat, "busName" : busName});
	},
	
	// 배열 크기순으로 정렬하는 Fn
	sortNm : function(a, b) {
		
		return a - b;
	},
	
	// 버스정보 저장하는 Ajax
	seatSaveFn : function(option) {
		
		var settings = {
			url		: "adminSeat.do",
			param	: "",
			selectBus : "",
			busName	: "",
			totalSeat : ""
		}
		settings = $.extend({}, settings, option);
		
		$.ajax({
			
			type	: "POST",
			async	: false,
			url		: settings.url,
			data	: {"param" : JSON.stringify(settings.param),
						"selectBus" : settings.selectBus,
						"busName" : settings.busName,
						"totalSeat" : settings.totalSeat},
			success	: function(result) {
				
				alert("저장에 "+ (result == "SUCESS") ? "성공" : "실패" + "하였습니다.");
				
				modal.adminReservation('admin-modal');
				
				$("#adminSeatTable").trigger("reloadGrid");
			},
			complete : function() {

				$.jgrid.gridUnload("#adminProductTable"); 
				adminGrid();
			}
		});
	}
}