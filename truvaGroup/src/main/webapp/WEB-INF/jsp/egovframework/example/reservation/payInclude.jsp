<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="tab-content row">
	<div id="pay-tab1" class="tab-pane fade in active">
		<ul class="card-select">
			<li class="kb-card">국민은행</li>
			<li class="woori-card">우리은행</li>
			<li class="sinhan-card">신한은행</li>
			<li class="ibk-card">기업은행</li>
			<li class="hana-card">하나은행</li>
			<li class="hyundai-card">외환은행</li>
			<li class="nh-card">농협은행</li>
		</ul>
		<div class="col-sm-12">
			<div class="col-sm-3 comment-input-area">
				<div class="comment-input">할부개월을 선택하세요</div>
			</div>
			<div class="col-sm-3">
				<select class="form-control">
					<optgroup>
						<option>일시불</option>
						<option>2개월</option>
						<option>3개월</option>
						<option>4개월</option>
						<option>5개월</option>
						<option>6개월</option>
						<option>7개월</option>
					</optgroup>
				</select>
			</div>
		</div>
	</div>

	<div id="pay-tab2" class="tab-pane fade">
		<ul class="card-select">
			<li class="kb-card">국민은행</li>
			<li class="woori-card">우리은행</li>
			<li class="sinhan-card">신한은행</li>
			<li class="ibk-card">기업은행</li>
			<li class="hana-card">하나은행</li>
			<li class="hyundai-card">외환은행</li>
			<li class="nh-card">농협은행</li>
		</ul>
		<div class="col-md-12 row">
			<div class="col-sm-12 comment-input-area">
				<div class="comment-input">선택한 은행의 계좌번호가 여기에 나옵니다.</div>
			</div>
			<div class="col-sm-12 comment-input-area">
                 	<p>입금 마감일 : ㅇㅇㅇㅇㅇ</p>
                 	<h5 class="pd-top-10">무통장 입금안내 </h5>
                 	<p>
						- 주문후 5영업일 이내 입금확인이 되지 않으면 주문이 자동취소될 수 있습니다.<br/>
						- 입금시 예금주명은 '11번가,SK플래닛'으로 확인될 수 있습니다.<br/>
						- 입금 시 주문자 이름과 상관없이 금액만 일치하면 정상 입금처리 됩니다.<br/>
						- 해외은행 계좌에서 입금 시에는 반드시 원화로 입금하셔야 합니다.<br/>
						- 취소/반품 신청 시 환불수단을 무통장이나 캐시로 선택하여 환불 받으실 수 있습니다.
					</p>
				</div>
                <div class="col-sm-12 row pd-top-20 cash-receipts">
					<h5 class="col-sm-12">현금영수증 신청</h5>
					<div class="col-sm-12 receipts-select pd-top-10">
						<div class="col-sm-2">
							<input type="checkbox">
							<span>핸드폰번호</span>
						</div>
						<div class="col-sm-2">
				          	<input type="checkbox">
				          	<span>개인</span>
						</div>
						<div class="col-sm-2">
							<input type="checkbox">
							<span>사업자</span>
						</div>
					</div>
                 	<div class="col-md-12 form-group receipts-contents">
                 		<div class="col-sm-6 pd-top-10">
							<input type="text" class="form-control" name="website" placeholder="현금영수증 번호를 입력하세요.">
       					</div>
                 	</div>
				</div>
			</div>
		</div>

		<div id="pay-tab3" class="tab-pane fade">
			<div class="col-md-12">
				<div class="col-sm-6 form-group">
					<input type="text" class="form-control col-sm-8" name="name" id="name" placeholder="결제할 핸드폰번호를 입력하세요.">
				</div>
				<div class="col-sm-12 comment-input-area">
					<h5 class="pd-top-10">휴대폰 간편결제 안내 </h5>
					<p>
						- 휴대폰 결제한도는 최대 30만원입니다.<br/>
						- 단, 개인별 한도는 통신사별 회원등급에 따라 적용됩니다.
					</p>
				</div>
			</div>
		</div>
	</div>