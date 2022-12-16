<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 해당 jsp는 '급여명세서'의 양식으로 급여 카테고리 (paystub.jsp)와 급여정산 자료관리 카테고리(cerfList.jsp)에 include 되어있음 -->

<style>
.stubList{
	width: 480px;
	border-bottom : 2px solid black;
}
.stubDetail{
	width: 480px;
	border-bottom : 1px solid lightgray;
}
</style>


<div id="paystubCerfArea" style="width:1150px; height:1600px; z-index: 9999; padding: 70px;">
	<div aria-label="귀속월정보" class="mb-4">
		<div class="d-inline fs-4 border border-muted rounded p-2">귀속월</div>
		<div class="d-inline text-dark  fs-4 fw-semibold ms-3" id="ps0_belong">2022.12</div>
	</div>
	<div aria-label="사원정보" style="margin-bottom: 100px;">
		<div class="fw-bold d-inline float-start text-dark fs-1">급여명세서</div>
		<div class="d-inline float-end">
			<h6 class="d-inline  fs-5 text-dark fw-semibold" id="ps1_empNm">김나비 </h6>
			<div class="vr mx-3"></div>
			<h6 class="d-inline  fs-5 text-dark fw-semibold" id="ps2_empBir">97.07.18</h6>
			<div class="vr mx-3"></div>
			<h6 class="d-inline  fs-5 text-dark fw-semibold" id="ps3_empNo">E4524</h6>
			<div class="vr mx-3"></div>
			<h6  class="d-inline  fs-5 text-dark fw-semibold" id="ps4_dept">연구소</h6>
		</div>
	</div>
	<br><br>
	<div aria-label="실수령액" class="mb-5">
		<div class="float-start fw-bold text-dark fs-4">실수령액</div>
		<div class="float-start fs-5 pt-1 ms-4 text-secondary" id="ps5_gdate">2023. 1. 5 지급</div>
		<div class="divider text-end divider-dashed">
		  <div class="divider-text text-dark fs-4 fw-semibold" id="ps6_realTotal">3,594,510원</div>
		</div>
	</div> <!-- 실수령액 end -->
	
	<div class="clearfix" aria-label="항목내역" style="height: auto;">
		<div class="float-start" aria-label="지급내역" >
			<div class="fw-bold text-dark fs-4 pb-3 stubList">
				지급 내역
				<p class="d-inline float-end" id="ps7_payTotal">100만원</p>
			</div>
			<div id="ps7_payArea">
				<!-- 지급항목 내역 출력 -->
			</div>

		</div>
		<div class="float-start ms-5" aria-label="공제내역" >
			<div class="fw-bold text-dark fs-4 pb-3 stubList">
				공제 내역
				<p class="d-inline float-end" id="ps8_dedTotal">10만원</p>
			</div>
			<div id="ps8_dedArea">
				<!-- 공제항목 내역 출력 -->
			</div>
		</div>
	</div><!-- 항목내역 end -->
	
	<div aria-label="계산식안내" style="height: auto; margin-top: 100px;">
		<ul class="fs-5" style="list-style: disc;">
			<li>
				기본시급 = 연봉 포함 통상임금 ÷ 월소정근무시간, 기본급과 미달 근무 차감금에 활용합니다. <br>
				기본시급은 소수점 첫째 자리에서 올림 표기합니다.
			</li>
			<li>
				기본근무 산정기간(<p class="ps13_term d-inline">2022. 11. 1 ~ 2022. 12. 31</p>)의 기본시급은 <p class="ps14_basePayHour d-inline"></p>원입니다.
			</li>
			<li>
				초과근무 산정기간(<p class="ps13_term d-inline">2022. 11. 1 ~ 2022. 12. 31</p>)의 기본시급은 <p class="ps14_basePayHour d-inline"></p>원입니다. <br>
				초과근무수당은 기본시급에 초과한 시간과 가산율(%)을 곱한 금액으로 계산되어 지급됩니다.
			</li>
		</ul>
	</div>
	
	
	<div class="clearfix text-dark fs-5 fw-semibold position-relative" aria-label="발급자정보" style="margin-top: 250px;">
		<div class="float-start me-5">
			<div>발급일</div>
			<div id="ps9_issueDate">2022.12.10</div>
		</div>
		<div class="float-start ms-5">
			<div class="d-inline">회사명</div>
			<br>
			<div class="d-inline me-2">대표이사</div>
		</div>
		<div class="float-start ms-5 ">
			<div class="d-inline fw-bold" id="ps10_comNm">나비스</div>
			<br>
			<div class="d-inline me-2" id="ps11_represNm">강동원</div>
		</div>
		<div class="float-end me-3" id="ps12_comSeal">
			(서명  인)
			<img src="${cPath }/resources/images/nabisStemp.png" alt="회사직인" width="130px" style="position: absolute; right:3px; bottom: 1px;">
		</div>
	
	</div>
</div> <!-- #paystubCerfArea end -->

