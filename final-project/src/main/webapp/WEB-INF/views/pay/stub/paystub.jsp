<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<link rel="stylesheet" href="${cPath }/resources/css/ijs.css" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script src="https://unpkg.com/html2canvas@1.0.0-rc.5/dist/html2canvas.js"></script>


<!-- 상단 우측 금액 숨기기버튼, 귀속연도 선택 via yearpicker -->
<div class="form-switch me-5 mb-3 d-flex justify-content-end">
   <div class="form-check pt-2 me-3">
         <input class="form-check-input" type="checkbox" id="hiddenStub" checked/>
         <label class="form-check-label" for="hiddenStub">금액 숨기기</label>
         <div class="vr mx-3 resvr" ></div>  
    </div>

   <div class="input-group input-group-merge float-start" style="width:150px;">
      <input type="text" class="yearpicker form-control  col-xs-2 " name="yearpicker" id="yearpicker" value=""/>
      <span class="input-group-text" id="basic-addon-search31"><i class="bx bx-search"></i></span>
    </div>
   
</div>

<!-- 선택한 귀속연도의 가장 최근 급여 정보 출력 -->
<div class="clearfix" id="recentDiv">
   <div class="card mb-4 me-4 mx-4 float-start" style="width: 65%; height: 250px; background-color: #fdfdfd;">
      <div class="card-body d-flex justify-content-start">
         <div class="flex-column w-50">
            <div class="card-subtitle text-muted mb-4 mt-2  d-inline">
               <div class="d-inline fw-semibold text-dark" id="recentMonth">최근 급여</div>
            </div>
            <div class="mt-3">
               <div class="sthd1 w-25" id="ceiling" style="display: hidden;"></div>
               <h3 class="card-title text-dark" id="recentTotal">-</h3>
            </div>
            <div class="d-flex mt-5">
               <div class="card-text w-25 ">지급</div>
               <div class="w-50">
                  <div class="ms-3 sthd2 w-25"></div>
                  <div class="card-text flex-row ms-3 text-dark"  id="recentPay">-</div>
               </div>
            </div>
            <div class="d-flex mt-2">
               <div class="card-text w-25 ">공제</div>
               <div class="w-50">
                  <div class="ms-3 sthd2 w-25"></div>
                  <div class="card-text flex-row ms-3 text-dark" id="recentDed">-</div>
               </div>
            </div>
            <div class="d-flex mt-2">
               <div class="card-text w-25 ">근무기간</div>
               <div class="card-text flex-row ms-3 text-dark" id="stubTerm">
                  <!-- 기간 들어오는 자리 via ajax -->
               </div>
            </div>
         </div>
         <div class="float-start w-50">
            <img src="${cPath }/resources/images/stubback.png" alt="배경일러스트" width="300px" class="rounded" style="box-shadow: 5px 10px 18px #888888;">
            <img src="${cPath }/resources/images/stubfront.png" alt="전방일러스트" width="190px" height="130px" class="rounded" style="position:absolute; right: 50px; bottom: 15px; box-shadow: 5px 10px 18px #888888;">         
         </div>
      </div>
   </div>
   
   <div class="card mb-4 float-start"  style="width: 30%;  height: 250px; background-color: #fdfdfd;">
      <div class="card-body">
         <p class="card-title"><span id="accumYear"></span> 누적 수령액</p>
         <div class="sthd1 end-0 w-100" style="display: hidden;"></div>
         <h3 class="d-flex justify-content-end text-dark" id="accumlate">-</h3>
         <hr style="border-top: 1px dashed #8592A3; background-color: transparent; opacity: 0.5">
         <br>
         <a href="javascript:void(0)" class="card-link fw-semibold" data-bs-toggle="modal"  data-bs-target="#withholdModal">갑종근로소득에 대한 소득세 원천징수확인서 발급</a>
      </div>
   </div>
</div> <!-- 급여명세 미리보기 div 끝 -->

<!-- 해당 귀속연도에 정산 내역이 있는 경우 급여명세 목록이 출력 -->
<div class="card mx-4 mt-5">
   <div class="table-responsive text-nowrap">
      <table class="table table-hover" id="stubTable">
         <tbody class="table-border-bottom-0  " id="stubListArea">
            <!-- 정산 내역 목록 tr 출력 via ajax data -->
         </tbody>
      </table>
   </div>
</div>



<!-- 명세서(tr) 클릭 시 열리는 offcanvas -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="stubCanvasArea" aria-labelledby="cBlgMonth" style="width: 550px;">
  <div class="offcanvas-header">
    <h5 id="offcanvasEndLabel" class="offcanvas-title text-dark fw-bold"><span id="cBlgMonth">10</span>월 급여명세서
<!--        <i class="bx bxs-download ms-4 issuePsBtn" data-prno="${ProllVO.prNo}" data-prptno="${ProllVO.prPtno}"></i> -->
    </h5>
    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body mx-0 flex-grow-0 flex-column" style="font-size: 14px;">
     <hr/>
   <div>실 수령액</div>
   <div class="fs-3 text-dark fw-semibold mb-2" id="cRealTotal">-</div>
   <div><span id="cGdate">-</span> 지급</div><br>
   <div class="progress" id="progressArea">
        <!-- progress bar 비율 동적 생성 via ajax -->
   </div>
   <div class="mt-3"><span>실 수령액 : 지급총액의 <span id="cPercent"></span>%</span></div>
   <hr/>
   <div aria-label="지급내역 구분">
      <span class="float-start text-dark fs-6"><strong>지급내역</strong></span>
      <div class="divider text-end divider-dashed">
        <div class="divider-text text-dark fs-6 fw-semibold" id="cPayTotal">-</div>
      </div>
      <div class="flex-column" id="stubPayArea">
         <!-- 지급 항목 들어오는 자리 via ajax data -->
      </div>
   </div>
   <br>
   <div aria-label="공제내역 구분">
      <span class="float-start text-dark fs-6"><strong>공제내역</strong></span>
      <div class="divider text-end divider-dashed">
        <div class="divider-text text-danger fs-6 fw-semibold" id="cDedTotal">-</div>
      </div>
      <div class="flex-column" id="stubDedArea">
         <!-- 공제 항목 들어오는 자리 via ajax data -->
      </div>
   </div>
  </div>
</div>


<!-- 원천징수확인서 발급 modal -->
<div class="modal fade" id="withholdModal" tabindex="-1" aria-hidden="true">
   <div class="modal-dialog" role="document">
      <div class="modal-content">
         <div class="modal-header border-bottom pb-2 border-1">
            <h5 class="modal-title text-dark fw-semibold fs-5"
               id="exampleModalLabel1">갑종근로소득에 대한 소득세 원천징수확인서</h5>
            <span class="badge badge-green ms-1">근로소득</span>
            <button type="button" class="btn-close" data-bs-dismiss="modal"
               aria-label="Close"></button>
         </div>
         <div class="modal-body  h-auto">
            <div class="row">
               <div class="col mb-3">
                  <label for="html5-date-input"
                     class="col-md-2 col-form-label d-inline fs-6">정산기간</label>
                  <h4 class="d-inline crimson align-text-top ms-2">*</h4>
                  <div class="w-100">
                     <input type="text" class="form-control mt-2" id="prollPeriod"
                        name="daterange" />
                  </div>
               </div>
            </div>

            <div class="row g-2">
               <div class="col mb-0 align-bottom">
                  <div class="d-block">
                     <label for="emailBasic" class="form-label fs-6">발급사유</label>
                     <h4 class="d-inline crimson align-text-top ms-2">*</h4>
                  </div>
                  <div class="form-check form-check-inline mt-1">
                     <input class="form-check-input" type="radio"
                        name="whPurpose" id="radio1" value="금융기관_제출" checked />
                     <label class="form-check-label" for="radio1">금융기관 제출</label>
                  </div>
                  <div class="form-check form-check-inline">
                     <input class="form-check-input" type="radio"
                        name="whPurpose" id="radio2" value="관공서_제출" /> <label
                        class="form-check-label" for="radio2">관공서 제출</label>
                  </div>
                  <div class="form-check form-check-inline">
                     <input class="form-check-input" type="radio"
                        name="whPurpose" id="radio3" value="학교_제출" /> <label
                        class="form-check-label" for="radio3">학교 제출</label>
                  </div>
                  <div class="form-check form-check-inline">
                     <input class="form-check-input" type="radio"
                        name="whPurpose" id="radio4" value="other"/> <label
                        class="form-check-label" for="radio4">기타</label>
                  </div>
               </div>
            </div>

            <div class="mt-3" id="otherReason">
               <textarea class="form-control" id="otherReasonArea"
                  rows="2" placeholder="사용처를 직접 입력해주세요"></textarea>
            </div>

            <div class="my-3">
               <label for="exampleFormControlSelect1"
                  class="form-label d-inline fs-6">선택항목</label>
            </div>

            <div class="form-check mt-3">
               <input class="form-check-input" type="checkbox" value=""
                  id="showRegno2" /> <label class="form-check-label"
                  for="regnoBlind"> 주민등록번호 뒷자리 표시 </label>
            </div>

         </div>
         <div class="modal-footer">
            <div class="d-grid gap-2 col mx-auto">
               <button id="issueWhBtn" type="button" class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#withholdDownModal">발급하기</button>
            </div>
         </div>
      </div>
      <!-- modal content end -->
   </div>
</div> <!-- modal end -->


<!-- 원천징수영수증 미리보기 Modal -->
<div class="modal fade" id="withholdDownModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-fullscreen" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background-color: #efeff5">
        <h5 class="modal-title text-dark  mb-3" id="modalFullTitle">🔎 소득세원천징수확인서 미리보기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
      <!-- 원천징수영수증 PDF 생성 영역================================================================================ -->
        <jsp:include page="/WEB-INF/views/pay/cerf/withholdCerf.jsp"/>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">닫기</button>
        <button id="withholdPDFBtn" type="button" class="btn btn-primary">PDF 다운로드</button>
      </div>
    </div>
  </div>
</div>


<!-- 급여명세서 미리보기 Modal -->
<div class="modal fade" id="paystubDownModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-fullscreen" role="document">
    <div class="modal-content">
      <div class="modal-header" style="background-color: #efeff5">
        <h4 class="modal-title text-dark  mb-3" id="modalFullTitle">🔎 급여명세서 미리보기</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
      
      <!-- 급여명세서 PDF 생성 영역================================================================================ -->
        <jsp:include page="/WEB-INF/views/pay/cerf/paystubCerf.jsp"/>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-label-secondary fs-4" data-bs-dismiss="modal">닫기</button>
        <button id="paystubPDFBtn" type="button" class="btn btn-primary fs-4">PDF 다운로드</button>
      </div>
    </div>
  </div>
</div>




<script>



//정산 귀속연도 선택 via yearPicker
let blgYear = "";
$(document).ready(function(){
    
    //페이지 로드 시 default로 2022년 세팅
    makePaystubList(2022);
    setTimeout(firstRecord,500);
    setTimeout(calSum,500);
    

   
   //금액 숨기기 via toggle
   $(document).on("click", "#hiddenStub", function(){
   //$('#hiddenStub').click(function(){
      if($(this).is(":checked")){
         $( '.sthd1, .sthd2' ).slideDown(200);  
      }else{
         $( '.sthd1, .sthd2' ).slideUp(200);
      }
   });

   
      $("#yearpicker").yearpicker({
         year : 2022,
         startYear : 1980,
         endYear : 2050,
         autoclose:true
      });

      //연도 클릭하였을 때 실행
      $(document).on("click",".yearpicker-items",function(){
         blgYear = $(this).text();
         $("#accumYear").text(blgYear);
         
          console.log("blgYear",blgYear);
          makePaystubList(blgYear);

          setTimeout(() => {
                firstRecord();
                calSum();
        }, 600);
        
          setTimeout(() => {
                if($("#hiddenStub").is(":checked")){
                 $( '.sthd1, .sthd2' ).slideDown(200);  
              }else{
                 $( '.sthd1, .sthd2' ).slideUp(200);
              }
        }, 110);
         
      });
      
});

let stubListArea = $('#stubListArea');
let empNo =  ${authEmp.empNo}; 

//하단 선택한 귀속연도에 속하는 급여 목록 출력 (#stubListArea)
function makePaystubList(blgYear){
   console.log("empNo",empNo);
   
   let htmlCodeList = "";
   
   $.ajax({
      url : "${cPath}/pay/paystubBelong.do",
      method : "POST",
      data : JSON.stringify({
         blgYear : blgYear,
         empNo : empNo
      }),
      dataType : "JSON",
      contentType: "application/json; charset=utf-8",
      success : function(resp) {
         console.log(resp);
         
         let htmlCodeList = "";
         
         if(resp.length==0){
            console.log("출력할 데이터 없음");
            htmlCodeList += `<h5 class="text-center fw-semibold m-2"><i class='bx bx-error-circle'></i> 해당 귀속연도에 급여명세서가 없습니다.</h5>`;
            $("#stubTerm").empty();
            $("#recentDiv").hide();
         }else{
            console.log("출력할 데이터 있음");
            $("#recentDiv").show();
            $(resp).each(function(i, ProllVO){
               
               htmlCodeList += `<tr height="60px;"
                            data-prsdate="\${ProllVO.prSdate}" data-predate="\${ProllVO.prEdate}"
                            data-prno="\${ProllVO.prNo}" data-prptno="\${ProllVO.prPtno}">
                  <td class="w-75">
                       <div class="float-start belong text-dark" style="width:100px;"><strong>\${monthFormat(ProllVO.prBlg)}월 급여 명세서</strong></div>
                       <div class="ms-5 float-start">\${ProllVO.prGdate} 지급</div>
                  </td>
                  <td>
                     <div class="d-flex">
                        <div class="card-text">지급</div>
                        <div class="paycheck">
                           <div class="ms-3 sthd2 w-px-100"></div>
                           <div class="card-text flex-row ms-3 tdpay" id="P\${ProllVO.prNo}"></div>
                        </div>
                     </div>
                  </td>
                  <td>
                     <div class="d-flex">
                        <div class="card-text">공제</div>
                        <div class="paycheck">
                           <div class="ms-3 sthd2 w-px-75"></div>
                           <div class="card-text flex-row ms-3 tdded" id="D\${ProllVO.prNo}">-</div>
                        </div>
                     </div>
                  </td>
                  <td>
                     <div class="paycheck">
                        <div class="ms-3 sthd2 w-px-100 pe-5"></div>
                        <div class="card-text flex-row ms-3 fw-bold tdtotal text-dark" id="R\${ProllVO.prNo}">-</div>
                     </div>
                  </td>
                  <td>
                     <button type="button" class="issuePsBtn btn btn-icon me-2 btn-label-primary"
                         data-prno="\${ProllVO.prNo}" data-prptno="\${ProllVO.prPtno}"
                         data-bs-toggle="modal" data-bs-target="#paystubDownModal">
                       <span class="tf-icons bx bxs-download"></span>
                     </button>
                  </td>
               </tr>`
               
               insertTotal(ProllVO.prNo);
               
            })
         }
         stubListArea.html(htmlCodeList);
      },
      error : function(errorResp) {
         console.log(errorResp.status);
      }
   });   
   
}

let payTotal;
let dedTotal;
let resTotal;

//정산 별 총 지급 금액, 공제 금액, 실지급액 출력
function insertTotal(prNo){
   
   $.ajax({
      url : "${cPath}/pay/paystubTotal.do",
      method : "POST",
      data : JSON.stringify({
         prNo : prNo,
         empNo : empNo
      }),
      dataType : "JSON",
      contentType: "application/json; charset=utf-8",
      success : function(resp) {
         $(resp).each(function(i, prcd){
            console.log("=====",prcd.codeNo);
            if(prcd.codeNo == null && prcd.clf == "P"){
               console.log("P TOTAL", i, prcd.totalAmt);
               payTotal = prcd.totalAmt;
               payLocale = numberFormat(payTotal);
               $("#P"+prcd.prNo).text(payLocale+"원");    //총 지급 금액
            }
            if(prcd.codeNo == null && prcd.clf == "D"){
               console.log("D TOTAL", i, prcd.totalAmt);
               dedTotal = prcd.totalAmt;
               dedLocale = numberFormat(dedTotal);
               $("#D"+prcd.prNo).text(dedLocale+"원");   //총 공제 금액
            }
            resTotal = payTotal - dedTotal;
            resLocale = numberFormat(resTotal);
            $("#R"+prcd.prNo).text(resLocale+"원");      //실지급액
         })
      },
      error : function(errorResp) {
         console.log(errorResp.status);
      }
   });
   
}

//숫자 천단위 적용
function numberFormat(total){
   let localeTotal = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
   return localeTotal;
}

//천단위 해제
function removeNumberFormat(price){
   price = price.replace(/[^\d]+/g, "");
    return price;  
}

//귀속연월 월단위만 출력
function monthFormat(prBlg){
   let month = prBlg.substring(5, 7);
   let setMonth = "";
   
   if( month.substring(0,1) == "0" ){
      setMonth = prBlg.substring(6,7);
   }else{
      setMonth = month;
   }
   return setMonth;
}

//귀속연도의 가장 최근 급여 내역을 상단에 출력
function firstRecord(){
   let trf = $("#stubListArea .paycheck");
   let firstPay = trf.find('.tdpay').eq(0).text();
   $("#recentPay").text(firstPay);
   
   let firstDed = trf.find('.tdded').eq(0).text();
   $("#recentDed").text(firstDed);

   let firstTtl = trf.find('.tdtotal').eq(0).text();
   $("#recentTotal").text(firstTtl);
   
   let belong = $("#stubListArea .belong").eq(0).text();
   let firstBelong = belong.substring(0,6);
   $("#recentMonth").text(firstBelong);
   
   let prSdate = $("#stubListArea tr:first").data("prsdate");
   let prEdate = $("#stubListArea tr:first").data("predate");
   
   let subSdate = prSdate.substring(5).replace(/-/g, '. ').replace('. 0','. '); // 근무기간(정산시작일)
   let subEdate = prEdate.substring(5).replace(/-/g, '. ').replace('. 0','. '); // 근무기간(정산종료일)
   
   //$("#sdate").text(subSdate);
   //$("#edate").text(subEdate);
   
   $('#stubTerm').text(subSdate + ' ~ ' + subEdate);
   
}


//조회할 급여명세서 tr 클릭시  우측 급여명세 offcanvas 출력

let stubPayArea = $('#stubPayArea');
let stubDedArea = $('#stubDedArea');
let progressArea = $('#progressArea');
let prNo;    //정산번호
let prPtno;  //정산템플릿번호

$(document).on('click', 'tr' , function(){

   prNo = $(this).data('prno');
   prPtno = $(this).data('prptno'); 
   
   $.ajax({
      url : '${cPath}/pay/retrievePaystub.do',
      method : 'POST',
      data : JSON.stringify({
         prNo   : prNo,
         empNo  : empNo,
         prPtno : prPtno
      }),
      dataType : 'JSON',
      contentType: 'application/json; charset=utf-8',
      success : function(resp) {
         //console.log(resp.prollInfo);
         //console.log(resp.totalInfo);
         //console.log(resp.stubInfo);
         
         $('#cBlgMonth').text(monthFormat(resp.prollInfo.prBlg)); //귀속월
         $('#cGdate').text(resp.prollInfo.prGdate);             //지급일
         
         let psubPayTotal;
         let psubDedTotal;
         let payStubHtml = '';
         let dedStubHtml = '';
         let progressHtml = '';
         $(resp.totalInfo).each(function(i, total){
            if(total.codeNo == null && total.clf == 'P'){
               psubPayTotal = total.totalAmt;
               $('#cPayTotal').text(numberFormat(psubPayTotal)+' 원'); //총 지급 금액
            }
            if(total.codeNo == null && total.clf == 'D'){
               psubDedTotal = total.totalAmt;
               $('#cDedTotal').text(numberFormat(psubDedTotal)+' 원'); //총 공제 금액
            }
            $('#cRealTotal').text(numberFormat(psubPayTotal - psubDedTotal)+' 원'); // 실지급액
            
            let percent = (psubPayTotal - psubDedTotal)/psubPayTotal * 100;
            
            $('#cPercent').text(percent.toFixed(2));            // 지급비율 (소수 두번째자리까지만 출력)
            
            //지급비율 progress bar 동적 생성
            progressHtml = `<div class="progress-bar progress-bar-striped progress-bar-animated bg-success" 
                 role="progressbar" style="width: \${percent.toFixed(2)}%" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>`;            
            
         });
         
         $(resp.stubInfo).each(function(i, stub){               //지급 항목 내역 (항목명, 금액)
            if(stub.codeNm !=null && stub.clf == 'P'){
               payStubHtml += `<div class="mb-3">
                  <span class="float-start">\${stub.codeNm}</span>   
                  <span class="float-end text-dark">\${numberFormat(stub.codeAmt)}</span><br>
                  </div>   `;
            }
            if(stub.codeNm !=null && stub.clf == 'D'){            //공제 항목 내역 (항목명, 금액)
               dedStubHtml += `<div class="mb-3">
                  <span class="float-start">\${stub.codeNm}</span>
                  <span class="float-end text-dark">\${numberFormat(stub.codeAmt)}</span><br>
                  </div>   `;
            }
            
         });
         
         stubPayArea.html(payStubHtml);
         stubDedArea.html(dedStubHtml);
         progressArea.html(progressHtml);
           
      },
      error : function(errorResp) {
         console.log(errorResp.status);
      }
   });
})

// 귀속연도 실지급액 합계 구하기 (상단 우측 출력)
function calSum(){
   let sum = 0;
   $('#stubListArea tr').each(function(){
      let tdsum = $(this).find('.tdtotal').text();
      let b = parseInt(removeNumberFormat(tdsum));
      if(isNaN(b)) b = 0;
      sum += b;
   })
   $('#accumlate').text(numberFormat(sum)+' 원');
}


//=============================================================================================
//원천징수 영수증 모달창 내 datepicker   
$(function(){
   
   $('#prollPeriod').daterangepicker({
      showDropdowns: true,
       "locale": {
           "format": "YYYY-MM-DD",
           "separator": " → ",
           "applyLabel": "확인",
           "cancelLabel": "취소",
           "fromLabel": "From",
           "toLabel": "To",
           "customRangeLabel": "Custom",
           "weekLabel": "W",
           "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
           "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
       },
       "startDate": new Date(),
       "endDate": new Date(),
       "drops": "auto"
   }, function (start, end, label) {
       console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');

   });
   
});
   



//모달창 내 textarea 숨겨두기
$('#otherReason').hide();

$('#radio4').on('click',function(){
   $('#otherReason').show();
})

$('#radio1, #radio2, #radio3').on('click',function(){
   $('#otherReason').hide();
})


//===========================================================================
//증명서 발급 (원천징수영수증)

let blgSdate; //원천징수영수증 발급대상 기간 시작일
let blgEdate; //원천징수영수증 발급대상 기간 종료일
let whPurpose;//발급사유
let showRegno2;     //주민번호 뒷자리 여부
$(document).ready(function() {
   
   //기간
   $('#prollPeriod').on('apply.daterangepicker', function(ev, picker) {
      blgSdate = picker.startDate.format('YYYY-MM-DD');
      blgEdate = picker.endDate.format('YYYY-MM-DD');
      console.log(blgSdate,blgEdate);
   });
   

   //원천징수영수증 발급 버튼 클릭 시
   $('#issueWhBtn').click(function(){
      
      //발급사유
      whPurpose = $('input:radio[name="whPurpose"]:checked').val() ;
      //발급사유 - 기타 - 직접입력
      if(whPurpose=='other'){
         whPurpose = $("#otherReasonArea").val();
      }
      //주민번호 뒷자리 표시 여부      
      if($('#showRegno2').prop("checked")){
         showRegno2  = 'Y';
      }else{
         showRegno2  = 'N';
      }
      console.log("REGNOCHECK", showRegno2);
      
      $.ajax({
         url : "${cPath}/pay/withholdPDF.do",
         method : "POST",
         data : JSON.stringify({
            empNo : empNo,
            blgSdate : blgSdate,
            blgEdate : blgEdate
         }),
         dataType : "JSON",
         contentType: "application/json; charset=utf-8",
         success : function(resp) {
            console.log("test>>>>>>",resp);
            let now = new Date();
            let key = now.valueOf();                				//현재시간으로 키 생성
            $('#issueNum').text(key);                				//발급번호
            $('#wh1_empNm, #wh_isEmp').text(resp.empInfo.empNm);    //사원명
            $('#wh2_regno1').text(resp.empInfo.regno1); 			//주민번호
            if(showRegno2=='Y'){
               $('#wh2_regno2').text(resp.empInfo.regno2);
            }else{
               $('#wh2_regno2').text('*******');
            }
            $('#wh3_empAddr').text(resp.empInfo.empAddr);
            $('#wh9_purpose').text(whPurpose.replace('_',' '));
            
            //년,월,일 format  
            let whmonth= now.getMonth() +1;  
            let whday  = now.getDate();  
            let whyear = now.getFullYear();
            let whDateFormat = whyear + '년 ' + whmonth + '월 ' + whday + '일'
            $('.issueDate').text(whDateFormat);         //발급일
            
          	$(resp.totalInfoList).each(function(i, total){
          		
            	$('#belong'+i).text(total[i].prBlg);           	
            	
            	$(total).each(function(n, inside){
            		console.log(inside.codeNo)
            	
            		if( inside.codeNo==null && inside.clf=='P'){
            			$('#insidePay'+i).text(numberFormat(inside.totalAmt)); //지급금액
            		}
            		if( inside.codeNo==null && inside.clf=='D'){
            			$('#insideDed'+i).text(numberFormat(inside.totalAmt)); //공제금액
            		}
					let insYear = total[i].prBlg.substring(0,4);
					let insMonth = total[i].prBlg.substring(5,7);
            		$('#insideDate'+i).text(insYear+'-'+insMonth+'-20' ); //납부예정연월일
            		
            		//지급항목 계 구하기
            		let paySum = 0;
					$('#withholdCerfTable tr').each(function(){
						let pay = $(this).find('.insidePay').text();
						let p = parseInt(removeNumberFormat(pay));
						if(isNaN(p)) p = 0;
						paySum += p;
					})
					$('#whPayTotal').text(numberFormat(paySum));
            		
					//공제항목 계 구하기
					let dedSum = 0;
					$('#withholdCerfTable tr').each(function(){
						let ded = $(this).find('.insideDed').text();
						let d = parseInt(removeNumberFormat(ded));
						if(isNaN(d)) d = 0;
						dedSum += d;
					})
					$('#whDedTotal').text(numberFormat(dedSum));
					
					
            	});
            	
             });

			//PDF 저장명
          	let withholdSaveName = '갑근세원천징수확인서_'+resp.empInfo.empNm+'_'+resp.empInfo.empNo;
            
            makePDF('withholdPDFBtn', 'withholdCerfTable', withholdSaveName); //PDF 저장 (모달 내 버튼ID, 출력할 영역 ID, 저장파일명);
            
            insertCerfRecord('갑근세원천징수확인서', whPurpose);	//명세서 발급내역 등록
         },
         error : function(errorResp) {
            console.log(errorResp.status);
            toastr.error("PDF 생성 중 오류가 발생했습니다.")
         }
     });
      
   });
   
});


//증명서발급 (급여명세서)
$(function(){
   //tr클릭 시 열리는 offcanvas에서 tr내 다운로드 버튼을 클릭했을 때 열리는 event 막기 (수동으로 event)
   $('#stubTable tbody').on('click', 'tr td:not(:last-child)', function () {
      $('.offcanvas').offcanvas('show');
    });
   
   //급여명세서 발급 버튼 클릭 시
   $(document).on('click','.issuePsBtn',function(){      

      prNo = $(this).data('prno');
      prPtno = $(this).data('prptno'); 
      
      $.ajax({
         url : '${cPath}/pay/paystubPDF.do', //급여명세내역 조회
         method : 'POST',
         data : JSON.stringify({
            prNo : prNo,
            prPtno : prPtno,
            empNo : empNo
         }),
         dataType : 'JSON',
         contentType: 'application/json; charset=utf-8',
         success : function(resp) {
         
            console.log('test>>>>>>',resp);
            let prBlg = resp.prollInfo.prBlg;
            $('#ps0_belong').text(prBlg.replace('-','. '));                     //0.귀속월
            $('#ps1_empNm').text(resp.empInfo.empNm);                        	//1.사원이름
            
            let birth = String(resp.empInfo.regno1);
            let yearFormat = birth.substring(0,2);
            let monthFormat = birth.substring(2,4);
            let dateFormat = birth.substring(4,6);
            let birthFormat = yearFormat + '. ' + monthFormat + '. ' + dateFormat;
            $('#ps2_empBir').text(birthFormat);                              	//2.사원생년월일
            
            $('#ps3_empNo').text(resp.empInfo.empNo);                        	//3.사원번호   
            let deptFlow = resp.empInfo.deptFlow;
            let dept = deptFlow.split('>')[0];
            $('#ps4_dept').text(dept);                                    		//4.소속부서
            $('#ps5_gdate').text(resp.prollInfo.prGdate+' 지급');                 //5.지급일
            
            
            let psPayTotal;
            let psDedTotal;
            $(resp.totalInfo).each(function(i, total){
               if(total.codeNo == null && total.clf == 'P'){
                  psPayTotal = total.totalAmt;
                  $('#ps7_payTotal').text(numberFormat(psPayTotal)+' 원');       //7-1.총 지급 금액
               }
               if(total.codeNo == null && total.clf == 'D'){
                  psDedTotal = total.totalAmt;
                  $('#ps8_dedTotal').text(numberFormat(psDedTotal)+' 원');       //8-1.총 공제 금액
               }
               $('#ps6_realTotal').text(numberFormat(psPayTotal - psDedTotal)+' 원'); // 6.실지급액
               
            });
            
            let stubPayHTML = '';
            let stubDedHTML = '';
            $(resp.stubInfo).each(function(i, stub){               
               if(stub.codeNm !=null && stub.clf == 'P'){
                  stubPayHTML += `<div class="text-dark fs-5 pb-3 mt-3 stubDetail">
                     \${stub.codeNm}
                     <span class="d-inline float-end fw-semibold">\${numberFormat(stub.codeAmt)}</span>
                  </div>`;
               }
               if(stub.codeNm !=null && stub.clf == 'D'){            
                  stubDedHTML += `<div class="text-dark fs-5 pb-3 mt-3 stubDetail">
                     \${stub.codeNm}
                     <span class="d-inline float-end fw-semibold">\${numberFormat(stub.codeAmt)}</span>
                  </div>`;
               }
               
            });
            $('#ps7_payArea').html(stubPayHTML);                        //7-2.지급 항목 내역 (항목명, 금액) 
            $('#ps8_dedArea').html(stubDedHTML);                        //8-2. 공제 항목 내역 (항목명, 금액)
            
            
            let date = new Intl.DateTimeFormat('kr').format(new Date());
            $('#ps9_issueDate').text(date);                                 //9.발급날짜
            
            let sdate = resp.prollInfo.prSdate;
            let edate = resp.prollInfo.prEdate;
            let sFormat = sdate.replaceAll('-','. ');
            let eFormat = edate.replaceAll('-','. ');
            let termFormat = sFormat + ' ~ ' + eFormat;
            $('.ps13_term').text(termFormat);                              //13.정산기간
            $('.ps14_basePayHour').text(numberFormat(resp.hourlyInc));            //14.기본시급
            
            let stubSaveName = '';
            let stubSaveYear = prBlg.substring(0,4);
            let stubSaveMonth = prBlg.substring(5,7);
            
            stubSaveName = stubSaveYear+'년_'+stubSaveMonth+'월_급여명세서_'+resp.empInfo.empNm+'_'+resp.empInfo.empNo;
            
            makePDF('paystubPDFBtn', 'paystubCerfArea', stubSaveName); //PDF 저장 (모달 내 버튼ID, 출력할 영역 ID, 저장파일명);
            
            insertCerfRecord(stubSaveMonth+'월 급여명세서', '본인 발급');	//명세서 발급내역 등록
         },
         error : function(errorResp) {
            console.log(errorResp.status);
            toastr.error("PDF 생성 중 오류가 발생했습니다.")
         }
      });
   })
})


//PDF 생성
function makePDF(btnId, divId, fileName){
   //---------------------------------------------------------
   //  HTML > IMG > PDF 저장 via html2canvas & jspdf
   //---------------------------------------------------------
   $('#'+btnId).click(function() { // pdf저장 button id
      
       html2canvas($('#'+divId)[0],{
          scale : 2             //해상도 조정
       }).then(function(canvas) { //저장 영역 div id
      
       // 캔버스를 이미지로 변환
       var imgData = canvas.toDataURL('image/png');
           
       var imgWidth = 210; // 이미지 가로 길이(mm) / A4 기준 210mm
       var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
       var imgHeight = canvas.height * imgWidth / canvas.width;
       var heightLeft = imgHeight;
       var margin = 3; // 출력 페이지 여백설정
       var doc = new jsPDF('p', 'mm');
       var position = 0;
          
       // 첫 페이지 출력
       doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
       heightLeft -= pageHeight;
            
       // 한 페이지 이상일 경우 루프 돌면서 출력
       while (heightLeft >= 20) {
           position = heightLeft - imgHeight;
           doc.addPage();
           doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
           heightLeft -= pageHeight;
       }
    
       // 파일 저장
       doc.save(fileName +'.pdf');
        
      });
   });
}


function insertCerfRecord(cfNm, isueRsn){
	
	$.ajax({
		url : "${cPath}/pay/cerfInsert.do",
		method : "POST",
		data : JSON.stringify({
            empNo : empNo,		//사번
            cfNm : cfNm,		//증명서이름
            isueRsn : isueRsn	//발급사유
         }),
        dataType : "JSON",
        contentType: 'application/json; charset=utf-8',
		success : function(resp) {
			console.log(resp);
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
	
   
}


</script>