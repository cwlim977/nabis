<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
    
<link rel="stylesheet" href="${cPath }/resources/css/ijs.css" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script src="https://unpkg.com/html2canvas@1.0.0-rc.5/dist/html2canvas.js"></script>

<!-- modal 내부에서 selectpicker 사용 중 -->

<style>
.list-group{
    min-height: 150px;
    max-height: 150px;
    margin-bottom: 10px;
    overflow-y:auto;
    overflow-x:hidden;
    -webkit-overflow-scrolling: touch;
}
</style>


<!-- 증명서 발급 -->
<div class="clearfix container p-0">
	<div class="divider text-start">
		<div class="divider-text fs-5 text-dark"><strong>근로소득 증명서</strong></div>
	</div>
	<div class="col-md-6 col-xl-4 float-start me-1">
		<div
			class="card shadow-none bg-transparent border border-secondary mb-3 me-3 ms-3">
			<div class="card-body">
				<h5 class="card-title text-dark">급여 명세서</h5>
				<span class="badge badge-green mb-3">근로소득</span><br><br>
				<button type="button" class="btn btn-primary" data-bs-toggle="modal"  data-bs-target="#paystubModal">
					<i class='bx bxs-download me-1'></i>발급하기
				</button>
			</div>
		</div>
	</div>
	<div class="col-md-6 col-xl-4 float-start ms-5">
		<div class="card shadow-none bg-transparent border border-secondary mb-3 ms-3">
			<div class="card-body">
				<h5 class="card-title text-dark">소득세 원천징수확인서</h5>
				<span class="badge badge-green mb-3">근로소득</span><br><br>
				<button type="button" class="btn btn-primary"  data-bs-toggle="modal"  data-bs-target="#withholdModal">
					<i class='bx bxs-download me-1'></i>발급하기
				</button>
			</div>
		</div>
	</div>
</div>
<br><br>


<!-- 급여명세서 발급 modal============================================================ -->
<div class="modal fade" id="paystubModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title text-dark fw-semibold fs-5" id="exampleModalLabel1">급여명세서 발급</h5>
        <span class="badge badge-green ms-1">근로소득</span>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div> <!-- modal header end -->
      <div class="modal-body">
        <div class="row">
          <div class="col mb-3"> <!-- 대상자 selectpicker -->
            <label for="nameBasic" class="form-label d-inline fs-6 text-dark">대상자</label>
            <h4 class="d-inline crimson align-text-top ms-2">*</h4>
            <select class="my-select selectpicker d-block w-100" data-live-search="true" data-size="5" name="selectEmp">
				<c:forEach items="${empList }" var="emp">
					<option value="${emp.empNo }" data-subtext="${emp.deptFlow }" class="text-dark">${emp.empNm }</option>
				</c:forEach>
			</select>
          </div>
        </div>
		
        <div class="row g-2"> 	<!-- 발급할 증명서 -->
          <div class="col mb-0">
            <label for="emailBasic" class="form-label text-dark fs-6 ">발급할 증명서 선택</label>
            <div class="list-group text-dark" id="stubArea">
            		<!-- 선택한 사원이 발급가능한 (정산내역이 있는) 급여명세서 목록 출력 via ajax -->
			</div>
          </div>

			<div class="row g-2">
				<div class="col mb-0 align-bottom">
					<div class="d-block">
						<label for="emailBasic" class="form-label fs-6 text-dark">발급사유</label>
						<h4 class="d-inline crimson align-text-top ms-2">*</h4>
					</div>
					<div class="form-check form-check-inline mt-1">
						<input class="form-check-input" type="radio"
							name="psPurpose" id="radio1" value="금융기관_제출" checked />
						<label class="form-check-label" for="radio1">금융기관 제출</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio"
							name="psPurpose" id="radio2" value="관공서_제출" /> <label
							class="form-check-label" for="radio2">관공서 제출</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio"
							name="psPurpose" id="radio3" value="학교_제출" /> <label
							class="form-check-label" for="radio3">학교 제출</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio"
							name="psPurpose" id="radio4" value="other" /> <label
							class="form-check-label" for="radio4">기타</label>
					</div>
				</div>
			</div>

			<div class="mt-3" id="psOtherReason">
				<textarea class="form-control" id="psOtherReasonArea"
					rows="2" placeholder="사용처를 직접 입력해주세요"></textarea>
			</div>

        </div>
      </div><!-- modal body end -->
      <div class="modal-footer">
        <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">취소</button>
        <button id="issuePsBtn" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#paystubDownModal">발급하기</button>
      </div><!-- modal footer end -->
    </div><!-- modal content end -->
  </div>
</div> <!-- 급여명세서 발급 modal end -->

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
		          <div class="col mb-3"> <!-- 대상자 selectpicker -->
		            <label for="nameBasic" class="form-label d-inline fs-6 text-dark">대상자</label>
		            <h4 class="d-inline crimson align-text-top ms-2">*</h4>
		            <select class="my-select selectpicker d-block w-100" data-live-search="true" data-size="5" name="empInfo">
						<c:forEach items="${empList }" var="emp">
							<option value="${emp.empNo }" data-subtext="${emp.deptFlow }" class="text-dark">${emp.empNm }</option>
						</c:forEach>
					</select>
		          </div>
		        </div>
			
				<div class="row">
					<div class="col mb-3">
						<label for="html5-date-input"
							class="col-md-2 col-form-label d-inline fs-6 test-dark">정산기간</label>
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
							<label for="emailBasic" class="form-label fs-6  test-dark">발급사유</label>
							<h4 class="d-inline crimson align-text-top ms-2">*</h4>
						</div>
						<div class="form-check form-check-inline mt-1">
							<input class="form-check-input" type="radio"
								name="whPurpose" id="sradio1" value="금융기관_제출" checked />
							<label class="form-check-label" for="sradio1">금융기관 제출</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio"
								name="whPurpose" id="sradio2" value="관공서_제출" /> <label
								class="form-check-label" for="sradio2">관공서 제출</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio"
								name="whPurpose" id="sradio3" value="학교_제출" /> <label
								class="form-check-label" for="sradio3">학교 제출</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio"
								name="whPurpose" id="sradio4" value="other" /> <label
								class="form-check-label" for="sradio4">기타</label>
						</div>
					</div>
				</div>

				<div class="mt-3" id="whOtherReason">
					<textarea class="form-control" id="whOtherReasonArea"
						rows="2" placeholder="사용처를 직접 입력해주세요"></textarea>
				</div>

				<div class="my-3">
					<label for="exampleFormControlSelect1"
						class="form-label d-inline fs-6 test-dark">선택항목</label>
				</div>

				<div class="form-check mt-3">
					<input class="form-check-input" type="checkbox" value=""
						id="showRegno2" /> <label class="form-check-label"
						for="showRegno2"> 주민등록번호 뒷자리 표시 </label>
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
        <button type="button" class="btn btn-label-secondary fs-4" data-bs-dismiss="modal">닫기</button>
        <button id="withholdPDFBtn" type="button" class="btn btn-primary fs-4">PDF 다운로드</button>
      </div>
    </div>
  </div>
</div>



		

<!-- 증명서발급내역==================================================================== -->
<div class="clearfix">
	<div class="divider text-start">
		<div class="divider-text fs-5 text-dark"><strong>발급내역</strong>
			<span class="badge bg-label-secondary text-dark fs-tiny"><span id="countArea"></span> 건</span>
		</div>
	</div>
	<br>
	<div class="table-responsive">
		<table class="table table-bordered table-hover" id="cerfListTable">
			<thead>
				<tr class="thead cell-fit">
					<th class="fs-6">발급일</th>
					<th class="fs-6">사번</th>
					<th class="fs-6">대상자</th>
					<th class="fs-6">이메일</th>
					<th class="fs-6">증명서</th>
					<th class="fs-6">발급사유</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
				<c:when test="${not empty cerfList }">
				<c:forEach items="${cerfList }" var="cerf">
				<tr data-count="${count }">
					<td>${cerf.isdate }</td>
					<td>${cerf.empNo }</td>
					<td>${cerf.empNm }
						<c:choose>
						<c:when test="${not empty empCerfList }">
							<c:forEach items="${empCerfList}" var="empCerf">
								<c:if test="${cerf.empNo eq empCerf.empNo and empCerf.empSt eq '재직중'}">
									<span class="badge badge-green fs-tiny fw-normal">재직</span>
								</c:if>
								<c:if test="${cerf.empNo eq empCerf.empNo and empCerf.empSt eq '휴직'}">
									<span class="badge badge-red fs-tiny fw-normal">휴직</span>
								</c:if>
								<c:if test="${cerf.empNo eq empCerf.empNo and empCerf.empSt eq '퇴직'}">
									<span class="badge badge-purple fs-tiny fw-normal">퇴직</span>
								</c:if>
							</c:forEach>
						</c:when>
						</c:choose>
						
					</td>
					<td>${cerf.empMail }</td>
					<td>${cerf.cfNm }</td>
					<td>${cerf.isueRsn }</td>
				</tr>
				</c:forEach>
				</c:when>
				<c:otherwise>
					<td colspan="6" class="text-center py-2"><i class='bx bx-error-circle'></i>&nbsp;표시할 내용이 없습니다.</td>
				</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
</div>


<script>


//급여명세서 모달 창 start ======================================================
	
//모달 창 내 selectpicker
$(function () {
	$('.my-select').selectpicker();
});

let empNo; //사원번호
let stubArea = $("#stubArea");

//선택한 사원의 급여명세서 목록 조회
$("[name=selectEmp]").on("change", function(){
	
	empNo = $('select[name=selectEmp] option:selected').val();
	console.log(empNo);
	
	let htmlCodeStub = "";
	
	$.ajax({
		url : "${cPath}/pay/cerfStubList.do",
		method : "POST",
		data : JSON.stringify({
			empNo : empNo
		}),
		dataType : "JSON",
		contentType: "application/json; charset=utf-8",
		success : function(resp) {
			console.log(resp);
			
			if(resp.length==0){
				console.log("출력할 데이터 없음");
				htmlCodeStub += `<label class="list-group-item">
					<i class='bx bx-error-circle'></i> 발급 가능한 증명서가 없습니다.
				  </label>`;
			}else{
				$(resp).each(function(i, stub){
				htmlCodeStub += `<label class="list-group-item text-dark">
				    <input class="form-check-input me-1" type="checkbox" value="\${stub.prNo}" name="selectedStub" onclick="checkOnlyOne(this)"
				    data-prno="\${stub.prNo}" data-prptno="\${stub.prPtno}">
				    \${stubListFormat(stub.prBlg)}
				    <span class="d-inline float-end text-muted">\${stub.prGdate}&nbsp;지급</span>
				  </label>`;
				});
			}
			stubArea.html(htmlCodeStub);
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
	
	
})

//급여명세서 귀속연월 format 적용
function stubListFormat(prBlg){
	let stubYear = prBlg.substring(0,4);
	let stubMonth = prBlg.substring(5,7);
	let setMonth = "";
	let setList = "";
	
	if( stubMonth.substring(0,1) == "0" ){
		setMonth = prBlg.substring(6,7);
	}else{
		setMonth = stubMonth;
	}
	
	setList = stubYear + "년 " + setMonth + "월 급여명세서";
	
	return setList;
	
}

//모달창 내 체크박스 다중 선택 막기
function checkOnlyOne(element) {
  
  let checkboxes = document.getElementsByName("selectedStub");
  checkboxes.forEach((cb) => {
    cb.checked = false;
  })
  element.checked = true;
}

//급여명세서 모달창 내 textarea 숨겨두기
$('#psOtherReason').hide();

$('#radio4').on('click',function(){
	$('#psOtherReason').show();
})

$('#radio1, #radio2, #radio3').on('click',function(){
	$('#psOtherReason').hide();
})

//원천징수 모달창 내 textarea 숨겨두기
$('#whOtherReason').hide();

$('#sradio4').on('click',function(){
	$('#whOtherReason').show();
})

$('#sradio1, #sradio2, #sradio3').on('click',function(){
	$('#whOtherReason').hide();
})


//원천징수 모달 창 ======================================================

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
	    "startDate": '2022-01-01',
	    "endDate": '2022-12-31',
	    "drops": "auto"
	}, function (start, end, label) {
	    console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');

	});
	
});
		
//모달창 내 textarea 숨겨두기
$('#whOtherReason').hide();

$('#sradio4').on('click',function(){
	$('#whOtherReason').show();
})

$('#sradio1, #sradio2, #sradio3').on('click',function(){
	$('#whOtherReason').hide();
})

//증명서 발급내역 카운트
let cerfCount = $('#cerfListTable tr:not(:first)').length;
$('#countArea').text(cerfCount);

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

//===================================================================================================
//증명서발급 (급여명세서)

let prNo;    //정산번호
let prPtno;  //정산템플릿번호
let psPurpose; //급여명세서 발급사유
$(function(){
	//모달창에서 급여명세서로 저장할 급여 정산 선택
	$(document).on('click', 'input[name=selectedStub]', function(){
		prNo = $(this).data('prno');
		prPtno = $(this).data('prptno');
	})
	
	//급여명세서 발급 버튼 클릭 시
	$(document).on('click','#issuePsBtn',function(){		
		//사번
		empNo  =  $("select[name=selectEmp] option:selected").val();
		//발급사유
		psPurpose = $('input:radio[name="psPurpose"]:checked').val() ;
		
		if(psPurpose=='other'){
			psPurpose = $("#psOtherReasonArea").val();
	      }
		
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
				$('#ps0_belong').text(prBlg.replace('-','. '));							//0.귀속월
				$('#ps1_empNm').text(resp.empInfo.empNm);								//1.사원이름
				
				let birth = String(resp.empInfo.regno1);
				let yearFormat = birth.substring(0,2);
				let monthFormat = birth.substring(2,4);
				let dateFormat = birth.substring(4,6);
				let birthFormat = yearFormat + '. ' + monthFormat + '. ' + dateFormat;
				$('#ps2_empBir').text(birthFormat);										//2.사원생년월일
				
				$('#ps3_empNo').text(resp.empInfo.empNo);								//3.사원번호	
				let deptFlow = resp.empInfo.deptFlow;
				let dept = deptFlow.split('>')[0];
				$('#ps4_dept').text(dept);												//4.소속부서
				$('#ps5_gdate').text(resp.prollInfo.prGdate+' 지급');						//5.지급일
				
				
				let psPayTotal;
				let psDedTotal;
				$(resp.totalInfo).each(function(i, total){
					if(total.codeNo == null && total.clf == 'P'){
						psPayTotal = total.totalAmt;
						$('#ps7_payTotal').text(numberFormat(psPayTotal)+' 원'); 		//7-1.총 지급 금액
					}
					if(total.codeNo == null && total.clf == 'D'){
						psDedTotal = total.totalAmt;
						$('#ps8_dedTotal').text(numberFormat(psDedTotal)+' 원'); 		//8-1.총 공제 금액
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
				$('#ps7_payArea').html(stubPayHTML);								//7-2.지급 항목 내역 (항목명, 금액) 
				$('#ps8_dedArea').html(stubDedHTML);								//8-2. 공제 항목 내역 (항목명, 금액)
				
				
				let date = new Intl.DateTimeFormat('kr').format(new Date());
				$('#ps9_issueDate').text(date);											//9.발급날짜
				
				let sdate = resp.prollInfo.prSdate;
				let edate = resp.prollInfo.prEdate;
				let sFormat = sdate.replaceAll('-','. ');
				let eFormat = edate.replaceAll('-','. ');
				let termFormat = sFormat + ' ~ ' + eFormat;
				$('.ps13_term').text(termFormat);										//13.정산기간
				$('.ps14_basePayHour').text(numberFormat(resp.hourlyInc));				//14.기본시급
				
				
				let stubSaveName = '';
				let stubSaveYear = prBlg.substring(0,4);
				let stubSaveMonth = prBlg.substring(5,7);
				
				stubSaveName = stubSaveYear+'년_'+stubSaveMonth+'월_급여명세서_'+resp.empInfo.empNm+'_'+resp.empInfo.empNo;
				
				makePDF('paystubPDFBtn', 'paystubCerfArea', stubSaveName); //PDF 저장 (모달 내 버튼ID, 출력할 영역 ID, 저장파일명);
				
				insertCerfRecord(stubSaveMonth+'월 급여명세서', psPurpose);	//명세서 발급내역 등록
				
			},
			error : function(errorResp) {
				console.log(errorResp.status);
				toastr.error("PDF 생성 중 오류가 발생했습니다.")
			}
		});
	
	});
});

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
      empNo = $("select[name=empInfo] option:selected").val();
      //발급사유
      whPurpose = $('input:radio[name="whPurpose"]:checked').val() ;
      //발급사유 - 기타 - 직접입력
      if(whPurpose=='other'){
         whPurpose = $("#whOtherReasonArea").val();
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
            $('#wh2_regno1').text(resp.empInfo.regno1); 			//주민번호 앞자리
            if(showRegno2=='Y'){									//주민번호 뒷자리
               $('#wh2_regno2').text(resp.empInfo.regno2);
            }else{
               $('#wh2_regno2').text('*******');
            }
            $('#wh3_empAddr').text(resp.empInfo.empAddr);			//사원주소
            
            $('#wh9_purpose').text(whPurpose.replace('_',' '));		//발급목적
            
            //년,월,일 format  
            let whmonth= now.getMonth() +1;  
            let whday  = now.getDate();  
            let whyear = now.getFullYear();
            let whDateFormat = whyear + '년 ' + whmonth + '월 ' + whday + '일'
            $('.issueDate').text(whDateFormat);         			//발급일
            
            //영수증 내 금액 입력
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
            
            //insertCerfRecord('갑근세원천징수확인서', whPurpose);	//명세서 발급내역 등록
         },
         error : function(errorResp) {
            console.log(errorResp.status);
            toastr.error("PDF 생성 중 오류가 발생했습니다.")
         }
     });
      
   });
   
});



//PDF 생성
function makePDF(btnId, divId, fileName){
	//---------------------------------------------------------
	//  HTML > IMG > PDF 저장  via  html2canvas & jspdf
	//---------------------------------------------------------
	$('#'+btnId).click(function() { // pdf저장 button id
		
	    html2canvas($('#'+divId)[0],{
	    	scale : 1 				//해상도 조정
	    }).then(function(canvas) { //저장 영역 div id
		
	    // 캔버스를 이미지로 변환
	    var imgData = canvas.toDataURL('image/png');
		     
	    var imgWidth = 210; // 이미지 가로 길이(mm) / A4 기준 210mm
	    var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
	    var imgHeight = canvas.height * imgWidth / canvas.width;
	    var heightLeft = imgHeight;
	    var margin = 4; // 출력 페이지 여백설정
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


//증명서 발급 내역 등록
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
			console.log("증명서 발급 등록 성공");
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
	
   
}



</script>



