<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 해당 jsp는 '갑종근로소득에 대한 소득세원천징수확인서'의 양식으로 급여 카테고리 (paystub.jsp)와 급여정산 자료관리 카테고리(cerfList.jsp)에 include 되어있음 -->

<div id="root" class="page ms-2" style="width:1150px; height:1600px; z-index: 9999">
   <table class="tg cell-fit" id="withholdCerfTable" style="width: 1100px; height: 1550px;">
   <thead class="text-center">
     <tr>
       <th class="px-5" colspan="2">발급 번호</th>
       <th class="px-5" colspan="4" rowspan="2">
          <div class="fw-bold fs-3 mt-2">갑종근로소득에 대한 소득세원천징수확인서</div>
          <div class="p-0 fs-5 mb-2">(☑ 매월신고납부대상자 확인 &nbsp;&nbsp;  ☐ 반기별 신고납부 대상자 확인)</div>
       </th>
       <th class="text-center" colspan="2">처리 기간</th>
     </tr>
     <tr>
       <th class="" colspan="2" id="issueNum">22121520</th>
       <th class="text-center" colspan="2" id="takeNum">즉&nbsp;&nbsp;&nbsp;시</th>
     </tr>
   </thead>
   <tbody>
     <tr>
       <td class="text-center cell-fit" rowspan="2">납<br>세<br>자</td>
       <td class="px-2" colspan="2">① 성명</td>
       <td class=" text-center" colspan="2" id="wh1_empNm"></td>
       <td class="ps-2" colspan="2">② 주민등록번호</td>
       <td class="px-4" colspan="2"><p id="wh2_regno1" class="d-inline" style="letter-spacing:1px">앞자리</p> - <p id="wh2_regno2" class="d-inline" style="letter-spacing:1px">뒷자리</p></td>
     </tr>
     <tr>
       <td class="ps-2 pe-4" colspan="2">③ 주소 또는 거소</td>
       <td class="ps-4" colspan="6" id="wh3_empAddr"></td>
     </tr>
     <tr>
       <td rowspan="3" class="text-center cell-fit">
          징<br>수<br>의<br>무<br>자
       </td>
       <td class="px-2" colspan="2">④ 상호 또는 명칭</td>
       <td class="text-center" colspan="2" id="wh4_comNm">NABIS</td>
       <td class="px-2" colspan="2">⑤ 사업자등록번호</td>
       <td class="text-center" colspan="2" id="wh5_comRegNum" style="letter-spacing:1px">211-86-00870</td>
     </tr>
     <tr>
       <td class="px-2" colspan="2">⑥ 사업장소재지</td>
       <td class="px-4" colspan="6" id="wh6_comAddr">대전 유성구 대덕대로 593 (우)34112, 대덕테크비즈센터</td>
     </tr>
     <tr>
       <td class="px-2" colspan="2">⑦ 대표자</td>
       <td class="text-center" colspan="2" id="wh7_comRep">강동원</td>
       <td class="px-2" colspan="2">⑧ 주민(법인) 등록번호</td>
       <td class="text-center" colspan="2" id="wh8_comRepNum" style="letter-spacing:1px">211-86-00870</td>
     </tr>
     <tr>
       <td class="text-center px-5 py-2" colspan="2">⑨ 확인서의 사용 목적</td>
       <td class="text-center" colspan="2" id="wh9_purpose">관공서제출용</td>
       <td class="px-2 text-center">⑩ 제출처</td>
       <td class=""></td>
       <td class="px-2">⑪ 소요수량</td>
       <td class="text-center">1통</td>
     </tr>
     <tr class="text-center">
       <td class="px-2">연월</td>
       <td class="px-2">⑫ 급여액</td>
       <td class="px-2">⑬ 세액</td>
       <td class="px-2">⑭ 납부(예정)<br>연월일</td>
       <td class="">연월</td>
       <td class="">⑫ 급여액</td>
       <td class="px-2">⑬ 세액</td>
       <td class="px-2">⑭ 납부(예정) <br>연월일</td>
     </tr>
      <tr>
       <td class="px-2" id="belong0">-</td>
       <td class="text-center insidePay" id="insidePay0"></td>
       <td class="text-center insideDed" id="insideDed0"></td>
       <td class="text-center" id="insideDate0"></td>
       <td class="" id=""></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
     </tr>
     <tr>
       <td class="px-2" id="belong1">-</td>
       <td class="text-center insidePay" id="insidePay1"></td>
       <td class="text-center insideDed" id="insideDed1"></td>
       <td class="text-center" id="insideDate1"></td>
       <td class="" id=""></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
     </tr>
     <tr>
       <td class="px-2" id="belong2">-</td>
       <td class="text-center insidePay" id="insidePay2">-</td>
       <td class="text-center insideDed" id="insideDed2"></td>
       <td class="text-center" id="insideDate2"></td>
       <td class="" id=""></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
     </tr>
     <tr>
       <td class="px-2" id="belong3">-</td>
       <td class="text-center insidePay" id="insidePay3">-</td>
       <td class="text-center insideDed" id="insideDed3"></td>
       <td class="text-center" id="insideDate3"></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
     </tr>
     <tr>
       <td class="px-2" id="belong4">-</td>
       <td class="text-center insidePay" id="insidePay4">-</td>
       <td class="text-center insideDed" id="insideDed4"></td>
       <td class="text-center" id="insideDate4"></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
     </tr>
     <tr>
       <td class="px-2" id="belong5">-</td>
       <td class="text-center insidePay" id="insidePay5">-</td>
       <td class="text-center insideDed" id="insideDed5"></td>
       <td class="text-center" id="insideDate5"></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
     </tr>
     <tr>
       <td class="px-2" id="belong6">-</td>
       <td class="text-center insidePay" id="insidePay6">-</td>
       <td class="text-center insideDed" id="insideDed6"></td>
       <td class="text-center" id="insideDate6"></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
     </tr>
     <tr>
       <td class="px-2" id="belong7">-</td>
       <td class="text-center insidePay" id="insidePay7">-</td>
       <td class="text-center insideDed" id="insideDed7"></td>
       <td class="" id="insideDate7"></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
     </tr>
     <tr>
       <td class="px-2" id="belong8">-</td>
       <td class="text-center insidePay" id="insidePay8">-</td>
       <td class="text-center insideDed" id="insideDed8"></td>
       <td class="text-center" id="insideDate8"></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
     </tr>
     <tr>
       <td class="px-2" id="belong9">-</td>
       <td class="text-center insidePay" id="insidePay9">-</td>
       <td class="text-center insideDed" id="insideDed9"></td>
       <td class="text-center" id="insideDate9"></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
     </tr>
     <tr>
       <td class="px-2" id="belong10">-</td>
       <td class="text-center insidePay" id="insidePay10">-</td>
       <td class="text-center insideDed" id="insideDed10"></td>
       <td class="text-center" id="insideDate10"></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
     </tr>
     <tr>
       <td class="px-2" id="belong11">-</td>
       <td class="text-center insidePay" id="insidePay11">-</td>
       <td class="text-center insideDed" id="insideDed11"></td>
       <td class="text-center" id="insideDate11"></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
       <td class=""></td>
     </tr>
     <tr>
       <td class="px-2" id="insidePay12">-</td>
       <td class="text-center insidePay"></td>
       <td class="text-center insideDed"></td>
       <td class="text-center"></td>
       <td class="text-center">계</td>
       <td class="text-center" id="whPayTotal">4,000,000</td>
       <td class="text-center" id="whDedTotal">405,490</td>
       <td class=""></td>
     </tr>
     <tr>
       <td class="" colspan="8">
          <div class="confirm"  style="margin-left: 200px;">발급일 현재 위와 같이 원천징수하였음을 확인하여 주시기 바랍니다.</div>
          <div class="confirmDate text-center issueDate"></div>
          <div class="confirmSub float-end">
             <div class="d-inline">신청인 <p class="d-inline ms-4" id="wh_isEmp">강달래</p></div>
             <div class="d-inline me-4">(서명 또는 인)</div>
            </div>
       </td>
     </tr>
     <tr>
       <td class="position-relative" colspan="8">
          <div class="confirm" style="margin-left: 200px;">위와 같이 원천징수하였음을 확인합니다.</div>
          <div class="confirmDate text-center issueDate"></div>
          <div class="confirmSub float-end">
             <div class="d-inline">확인자(원천징수의무자)</div>
             <div class="d-inline">강동원</div>
             <div class="d-inline me-4">(서명 또는 인)</div>
             <img src="${cPath }/resources/images/nabisStemp.png" alt="회사직인" width="90px" style="position: absolute; right:3px; bottom: 1px;">
          </div>
       </td>
     </tr>
     <tr>
       <td class="px-2" rowspan="2">확인자</td>
       <td class="text-center" colspan="2">사업장소재지</td>
       <td class="" colspan="6"></td>
     </tr>
     <tr class="cell-fit">
       <td class="text-center" colspan="2">세무사 등록번호</td>
       <td class="" colspan="2"></td>
       <td class="text-center" colspan="2">전화번호</td>
       <td class="" colspan="2"></td>
     </tr>
     <tr>
       <td class="" colspan="8">
          <div class="text-center">위와 같이 원천징수의무자가 원천징수하였음을 확인합니다.</div>
          <div class="float-end me-5">년  &nbsp;&nbsp;&nbsp;&nbsp;월   &nbsp;&nbsp;&nbsp;일</div><br>
          <div class="float-end me-4">세무사   (인)</div>
       </td>
     </tr>
   </tbody>
   </table>
</div>

