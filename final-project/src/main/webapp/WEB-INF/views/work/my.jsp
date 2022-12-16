<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="${cPath }/resources/css/jhy.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" >
let empRole = "${requestScope['empRole']}";

$('.headerMenu, .headerSubMenu').each(function(){
	switch($(this).attr('id')){
		case 'menu1':
			$(this).find('span').addClass('text-dark');
			break;
		case 'menu2':
			if(!(empRole == 'admin' || empRole == 'manager') ) $(this).hide();
			break;
	}
});
</script>
<style>
.se {
	width: 40%;
	display: inline-block;
	margin-top: 10px;
}
</style>


<div class="d-flex align-self-center align-items-center">

	<div class="btn-group" role="group"
		aria-label="Basic checkbox toggle button group">
		<button type="button" class="btn btn-sm btn-outline-info" onclick = "week_calandar(-1);">&#60;</button>

		<button type="button" id="calToday" class="btn btn-sm btn-outline-info" onclick="set_day()">오늘</button>

		<button type="button" class="btn btn-sm btn-outline-info" onclick="week_calandar(1);">&#62;</button>
	</div>
	
	<span class="badge bg-label-primary me-1 mx-2">조회</span> 
	<span id="calMon"></span>
</div>


<div class="card mt-3">
<div class="card-body">
		<div class="d-flex align-items-center">
			<div class="avatar-xs me-3">
					<span
						class="avatar-title rounded-circle bg-primary bg-soft text-primary font-size-18">
						<i class="bx bx-time-five"></i>
					</span>
				</div>
				<h5 class="fs-10 mb-0">근무시간 : <span id="workWeekTime"></span></h5>
			</div>
		</div>
</div>

<div class="row mt-3">
	<div class="col-xl-12">
		<div  style="width: auto; height: 600px;">
<!-- 			<div class="card-body"> -->
				<div class="mt-2">

					<div class="table-wrapper">
						<div class="table-responsive ">


							<table class="table table-bordered align-middle table-hover mb-0" style="height: 550px; table-layout: fixed;">
								<tbody id="myWorkTbody">

								</tbody>
							</table>
						</div>
					</div>
				</div>
<!-- 			</div> -->
		</div>
	</div>
</div>
<!-- 근무 등록 오픈캔버스 -->
<div class="offcanvas offcanvas-end w-px-400 mypagetoggle" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" id="offcanvasWork"
 style="box-shadow: -1px -3px 5px 0px">
	<div class="offcanvas-header border-bottom border-secondary sticky-top">
			<h4 id="offcanvasWorkTitle" class="offcanvas-title fw-semibold">
				근무 등록
			</h4>
	    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"></button>
	  </div>
	<div id="workCanvasBody">
		<div class="offcanvas-body mx-0 flex-grow-0">
			<form id="workForm">
				<div class="mb-4">
					<label class="form-label">근무 유형</label>
					<select class="form-select se" name="wkCode">
						<c:forEach items="${workList}" var="work">
							<c:if test="${work.wkCode ne 'WK1' && work.wkCode ne 'WK6' && work.wkCode ne 'WK7'}">
								<option value="${work.wkCode}">${work.wkNm}</option>
							</c:if>
						</c:forEach>
					</select> 
				</div>
				
				<div class="mb-4">
					<i class="bx bx-time-five"></i>
						<select id="sltWorkTimeFrom" onchange="setRealWorkTime();" name="waStime"
							aria-hidden="true" data-select2-id="4"
							class="form-control se">
							<option value="09:00" selected>오전 9:00</option>
							<option value="09:30">오전 9:30</option>
							<option value="10:00">오전 10:00</option>
							<option value="10:30">오전 10:30</option>
							<option value="11:00">오전 11:00</option>
							<option value="11:30">오전 11:30</option>
						</select> 
							&nbsp;-&nbsp; 
						<select id="sltWorkTimeTo" onchange="setRealWorkTime();" name="waEtime"
								aria-hidden="true" data-select2-id="4"
								class="form-control se">
							<option value="12:00">오후 12:00</option>
							<option value="12:30">오후 12:30</option>
							<option value="13:00">오후 01:00</option>
							<option value="13:30">오후 01:30</option>
							<option value="14:00">오후 02:00</option>
							<option value="14:30">오후 02:30</option>
							<option value="15:00">오후 03:00</option>
							<option value="15:30">오후 03:30</option>
							<option value="16:00">오후 04:00</option>
							<option value="16:30">오후 04:30</option>
							<option value="17:00">오후 05:00</option>
							<option value="17:30">오후 05:30</option>
							<option value="18:00" selected>오후 06:00</option>
							<option value="18:30">오후 06:30</option>
							<option value="19:00">오후 07:00</option>
							<option value="19:30">오후 07:30</option>
							<option value="20:00">오후 08:00</option>
							<option value="20:30">오후 08:30</option>
							<option value="21:00">오후 09:00</option>
							<option value="21:30">오후 09:30</option>
							<option value="22:00">오후 10:00</option>
							<option value="22:30">오후 10:30</option>
							<option value="23:00">오후 11:00</option>
							<option value="23:30">오후 11:30</option>
							<option value="24:00">익일 오전 12:00</option>
							<option value="00:30">익일 오전 12:30</option>
							<option value="01:00">익일 오전 01:00</option>
							<option value="01:30">익일 오전 01:30</option>
							<option value="02:00">익일 오전 02:00</option>
							<option value="02:30">익일 오전 02:30</option>
							<option value="03:00">익일 오전 03:00</option>
						</select>
						<input id="tlTimeInput" name="waTltime" type="hidden" />
						<input id="nigtTimeInput" name="waNigtime" type="hidden" />
						<input id="exTimeInput" name="waExtime" type="hidden" />
						<input id="hdTimeInput" name="waHdtime" type="hidden" value="0"/>
						<input id="waDateInput" name="waDate" type="hidden" />
						<input name="waAper" type="hidden" value="${empNo}"/>
						<input name="waArsn" type="hidden"/>
						<input name="wano" type="hidden"/>
				</div>
			</form>
			
			<div class="mt-auto arcodiancheck">
				<button type="button" class="btn btn-outline-danger mb-2 w-30 ms-4" id="waDelBtn" data-wano="">삭제</button>
				
				<button type="reset" class="btn btn-outline-secondary mb-2 w-30 empaddbutton" data-bs-dismiss="offcanvas">취소</button>
				<button id="workSubmitBtn" type="button" class="btn btn-primary mb-2 ms-3 w-40"><i class='bx bx-pencil'></i>저장하기</button>
			</div>
		</div>
	</div>

	<div id="vactionCanvasBody" class="offcanvas-body mx-0 flex-grow-0">
		<p class="fw-semibold">총일정</p>
		<div class="card mt-3"   data-bs-toggle="tooltip" data-bs-offset="0,9" data-bs-placement="bottom" data-bs-html="true" title=" <span>휴가는 휴가메뉴에서 수정해주세요</span>">
			<div class="card-body">
				<div class="input-group mb-3">
					<label class="input-group-text" >휴가</label>
					<input id="vacType" type="text" class="form-control" readonly="readonly" value="하루종일"/>
				</div>
				<div id="vacWork">
					<div class="divider text-start my-3">
						<div class="divider-text fw-semibold">
							<i class="bx bx-time-five bx-sm me-1"></i> 근무 일정
						</div>
					</div>
					<div class="input-group">
						<label class="input-group-text" >근무</label>
						<input id="vacWorkTime" type="text" class="form-control" readonly="readonly" value="14:00~ 18:00"/>
					</div>
				</div>
			</div>
		</div>
		<div class="mt-3 arcodiancheck">
			<button type="reset" class="btn btn-outline-secondary mb-2 w-30 empaddbutton" data-bs-dismiss="offcanvas">닫기</button>
		</div>
	</div>
</div>



<!-- 근무승인 모달창  -->
<div class="modal fade" id="waModal2" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header px-5">
				<h5 class="modal-title fs-3 fw-bold" id="modalScrollableTitle">근무 승인 요청</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<hr>
			<div class="modal-body py-0 px-5">
				<div class="divider text-start">
				 	<div class="divider-text fw-semibold">
					  	<i class="bx bx-time-five"></i>  근무 승인
					</div>
				</div>
				<div class="card p-3">
					<p>· 승인 항목 : <span id="waModalTilte" class="fw-semibold"></span></p>
					<p>· 날짜 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <span id="waModalDate"></span></p>
					<hr><div id="waModalDetail"></div>
				</div> 
				<!-- 메모 -->
				<div class="my-3">
					<label  class="form-label"><i class='bx bx-pencil'></i>요청 메시지</label>
					<textarea id="waModalMemo" class="form-control" rows="3" placeholder="요청 메시지 입력"></textarea>
				</div>
			</div>
			<div class="modal-footer px-5 ">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
				<button id="workRequestBtn" type="button" class="btn btn-primary">
					<i class='bx bx-pencil'></i>승인 요청하기
				</button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" defer="defer">

	let workList;
	let offcanvasWork = $('#offcanvasWork');		// 근무등록 오픈캔버스
	let $workCanvasBody = $('#workCanvasBody');
	let $vactionCanvasBody = $('#vactionCanvasBody');
	let $vacType = $('#vacType');
	let $vacWork = $('#vacWork');
	let $vacWorkTime = $('#vacWorkTime');
	let $offcanvasWorkTitle = $('#offcanvasWorkTitle');// 근무오픈캔버스 제목
	let waDelBtn = $('#waDelBtn');					// 근무등록 삭제버튼
	let workWeekTime = $('#workWeekTime');			// 일주 근무시간
	// 사원번호
	let empNo = '${empNo}';
	// 오늘날짜
	let day = new Date();
	// 0 : 이번주 , ±7 : 한주간격 
	let num = 0;

	// 오늘날짜로 일정출력
	function set_day() {
		day = new Date();
		console.log("today" + day);
	
		week_calandar(0);
	}
	
	let waDateInput = $("#waDateInput");
	let tlTimeInput = $("#tlTimeInput");
	let nigtTimeInput = $("#nigtTimeInput");
	let exTimeInput = $('#exTimeInput');
	let hdTimeInput = $('#hdTimeInput');
	$(function() {

		// 오늘 날짜 버튼 클릭
		document.getElementById('calToday').click();
		
		$.ajax({
			url : "getWorkOptionList.do",
			dataType : "json",
			success : function(resp) {
				workList = resp;
				console.log(resp);
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
		
		// 날짜 클릭시 오픈캔버스 열리는 이벤트
		$(document).on("click", ".workList", function() {
			let sltWorkCode = $('select[name="wkCode"]');
			let sltWorkTimeFrom = $('#sltWorkTimeFrom');
			let sltWorkTimeTo = $('#sltWorkTimeTo');
			waDateInput.val($(this).data("wadate"));
			// 근무등록이 안된 경우
			if(!$(this).data('wano')){
				$offcanvasWorkTitle.html('근무 등록');
				waDelBtn.data('wano', '');
				waDelBtn.hide();
				sltWorkCode.val("WK2").prop("selected", true);
				sltWorkTimeFrom.val("09:00").prop("selected", true);
				sltWorkTimeTo.val("18:00").prop("selected", true);
				
				$workCanvasBody.show();
				$vactionCanvasBody.hide();
				
			// 근무등록이 되어있는 경우
			}else{
				let wcode = $(this).data('wkcode');
				if(wcode == 'WK1'){
					$offcanvasWorkTitle.html('휴가');
					$vacType.val("하루종일");
					$vacWork.hide();
					
					$workCanvasBody.hide();
					$vactionCanvasBody.show();
					
				}else if(wcode == 'WK6'){
						$offcanvasWorkTitle.html('휴가');
						$vacType.val("오전반차");
						$vacWorkTimeval("14:00 ~ 18:00");
						$vacWork.show();
						
						$workCanvasBody.hide();
						$vactionCanvasBody.show();
				}else if(wcode == 'WK7'){
					$offcanvasWorkTitle.html('휴가');
					$vacType.val("오후반차");
					$vacWorkTimeval("09:00 ~ 14:00");
					$vacWork.show();
					
					$workCanvasBody.hide();
					$vactionCanvasBody.show();	
				}else{
					$offcanvasWorkTitle.html('근무 수정');
					console.log($(this).data('wano'));
					let wano = $(this).data('wano');
					waDelBtn.data('wano', wano);
					waDelBtn.show();
					sltWorkCode.val(wcode).prop("selected", true);
					console.log(wcode);
					sltWorkTimeFrom.val($(this).data('wastime')).prop("selected", true);
					sltWorkTimeTo.val($(this).data('waetime')).prop("selected", true);
					
					$workCanvasBody.show();
					$vactionCanvasBody.hide();
				}
			}
			setRealWorkTime();

			offcanvasWork.offcanvas("show");
		});
		
	});
	
	// 비동기 일정 출력
	function week_calandar(week) {
		if (week == 1) {
			num = parseInt(num) + 7;
		} else if (week == -1) {
			num = parseInt(num) - 7;
		} else if (week == 0) {
			num = parseInt(0);
			
		// 현재주 그대로 출력
		} else if (week == 3){
			week = 0;
		}
		console.log("num",num);
		day.setDate(day.getDate() + (week * 7));
		let theYear = day.getFullYear();
		let theMonth = day.getMonth();
		let theDate = day.getDate();
		let theDayOfWeek = day.getDay();
		if(day.getDay() == 0) theDayOfWeek = 7;
		
		
		let title = day.getFullYear() + "." + (day.getMonth() + 1);
		
		
		let thisWeek = [];
		let thisWeekDay = [];
		let thisDate = [];
	
		for (let i = 0; i < 7; i++) {
			let resultDay = new Date(theYear, theMonth, (theDate + (i - theDayOfWeek +1)));
			console.log(resultDay);
			let mm = Number(resultDay.getMonth()) + 1;
			let dd = resultDay.getDate();
			let ddd = resultDay.getDay();
	
			if (dd == 1)
				title += "~" + resultDay.getFullYear() + "." + (resultDay.getMonth() + 1);
			mm = String(mm).length === 1 ? '0' + mm : mm;
			dd = String(dd).length === 1 ? '0' + dd : dd;
	
			thisWeekDay[i] = ddd;
			if (ddd == 1) {
				ddd = '(월)';
			} else if (ddd == 2) {
				ddd = '(화)'
			} else if (ddd == 3) {
				ddd = '(수)'
			} else if (ddd == 4) {
				ddd = '(목)'
			} else if (ddd == 5) {
				ddd = '(금)'
			} else if (ddd == 6) {
				ddd = '(토)'
			} else if (ddd == 0) {
				ddd = '(일)'
			}
			thisWeek[i] = mm + '월' + dd + '일' + ddd;
			thisDate[i] = theYear + "-" + mm + '-' + dd;
		}
		
		$.ajax({
			url : CONTEXTPATH+"/work/myWork.do",
			dataType : "json",
			data : { empNo : empNo, num : num},
			method : "post",
			async: false,
			success : function(resp) {
				console.log("근무기록 : ",resp);
				if(makeTimeFormat(resp.workWeekTime) == ""){
					workWeekTime.html("0 시간");
				}else{
					workWeekTime.html(makeTimeFormat(resp.workWeekTime));
				}
				let htmlCode = "";
 				$(thisWeek).each(function(i, week) {
 					
 					theDate = String(theDate).length === 1 ? '0' + theDate : theDate;
 					
 					let date = thisWeek[i].substr(3, 2); // 그날 일자 예시) 29
 					let todyBadge ="";	// 오늘날짜 표시
 					if (new Date().getDate() == date) {
 						todyBadge = `<span class="badge rounded-pill bg-label-success font-size-12">오늘</span>`;
 					}

 					// data 속성용
 					let waNo = "";		// 근무신청번호
 					let wkCode = "";	// 근무코드
 					let waDate = thisDate[i];	// 근무일자
 					let waStime = "";	// 시작시간
 					let waEtime = "";	// 종료시간
 					
 					let wkNm = "";			// 근무명
 					let waTime = "";		// 근무시간
 					let waTltime = "";		// 총근무시간
 					let ewApst = "";		// 결재상태
 					let workContent = "";	// 근무일정내용
 					let workColor ="dark";	// 날짜 글씨색
 					$(resp.workApList).each(function (workIndex, work) {
 						console.log(date);
 						if(work.waDate.split('-')[2] == date){
 							waNo = work.waNo;		
 		 					wkCode = work.wkCode;	
 		 					//waDate = work.waDate;	
 		 					waStime = work.waStime;	
 		 					waEtime = work.waEtime;
 		 					
 							wkNm = work.wkNm;
 	 	 					waTime = `\${work.waStime} ~ \${work.waEtime}`;
 	 	 					
 	 	 					waTltime = `\${work.waTltime} 시간`;
 	 	 					ewApst = work.ewApst;
 	 	 					
 	 	 					let workBg = "info";
 	 	 					if(wkCode != 'WK2') workBg = "warning"
 	 	 					workContent =`<div class="d-flex flex-wrap gap-3">
											<a href="#" class="text-dark font-size-16"> 
											<span class="badge bg-label-\${workBg}">\${wkNm}</span>
											&nbsp; \${waTime}
										</a>
									</div>`;
							// 휴가일 경우 
							if(wkCode == 'WK1'){
								workContent =`<a href="#" class="text-dark font-size-16">
												 <span class="badge bg-primary">휴가</span>
												&nbsp; 하루종일
											</a>`;
							}
							// 오전반차
							if(wkCode == 'WK6'){
								workContent =`<div class="d-flex flex-wrap gap-3">
												<a href="#" class="text-dark font-size-16"> 
													<span class="badge bg-primary">휴가</span>
													&nbsp; 오전반차 <br>
													<span class="badge bg-info">근무</span>
													&nbsp; 14:00 ~ 18:00
												</a>
											</div>`;
							}
							// 오후반차
							if(wkCode == 'WK7'){
								workContent =`<div class="d-flex flex-wrap gap-3">
									<a href="#" class="text-dark font-size-16"> 
										<span class="badge bg-info">근무</span>
										&nbsp; 09:00 ~ 14:00<br>
										<span class="badge bg-primary">휴가</span>
										&nbsp; 오후반차
									</a>
								</div>`;
							}
 						}
					});
 					
 					// 주말 글씨 빨간색 변경 및 근무가 없을시 쉬는날 표시
 					if(thisWeekDay[i] == 0 || thisWeekDay[i] == 6){
	 					if(!workContent){
	 							workContent = `<span class="badge bg-success">쉬는날</span>`;	
	 					}
	 					workColor = "danger";
 					}
 					
 					
					htmlCode +=`<tr class="workList" data-wano="\${waNo}" data-wadate="\${waDate}" data-wastime="\${waStime}" data-waetime="\${waEtime}" data-wkcode="\${wkCode}">
									<td>
									<h5 class="text-truncate font-size-16 mb-1">
										<a href="javascript: void(0);" class="text-\${workColor}">\${thisWeek[i]}</a>&nbsp; \${todyBadge}
									</h5>
								</td>
								<td>
									\${workContent}
								</td>
								<td>
									\${waTltime}
								</td>
								<td>
									\${ewApst}
								</td>
							</tr>
					`;
 				});
				document.getElementById("myWorkTbody").innerHTML = htmlCode;
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
		document.getElementById("calMon").innerHTML = title;			
	}

//#######################################################################################################################################
// 선택한 근무시간 계산 함수

function getTimeDiff(sTime, eTime) {
	let timeArr;		// 결과배열리턴값
	let tlTime = "0";	// 총근무시간
	let exTime = "0";	// 연장근무시간
	let nigTime = "0";	// 야간근무시간
	let hdTime = "0";	// 휴일근무시간
	
	let strStartTime = ""; //문자형
	let strEndTime = ""; //문자형

		if (sTime == eTime) {
			tmpTime = "24"; //최대시간 24시간
		} else {
			strStartTime = sTime+":00"; //strStartTime을 시간 형태의 문자형으로 변환
			strEndTime = eTime+":00"; //strEndTime을 시간 형태의 문자형으로 변환
			
			//기준 날짜(2020/10/20)는 함수 만든날짜로 임의 설정
			strStartTime = "2022/11/20 " + strStartTime;
			if (parseInt(sTime) > parseInt(eTime)) {
				//strEndTime 을 다음날로 설정
				strEndTime = "2022/11/21 " + strEndTime;
			} else {
				//strStartTime, strEndTime 동일로 설정
				strEndTime = "2022/11/20 " + strEndTime;
			}

			let sDate = new Date(strStartTime);
			let eDate = new Date(strEndTime);
			let nigtDate = new Date("2022/11/20 22:00:00");
			tlTime = (eDate.getTime() - sDate.getTime()) / (1000 * 60 * 60);
			if(tlTime > 8) tlTime = tlTime - 1; //8시간 초과시 휴게시간 1시간
			nigTime = (eDate.getTime() - nigtDate.getTime()) / (1000 * 60 * 60);
			if(nigTime < 0) nigTime = 0;
			exTime = tlTime - 8 - nigTime;
			
			timeArr =[tlTime ,exTime ,nigTime]
			console.log(timeArr);
		}
	return timeArr;
}
// 시간 변경시 근무시간 반영
function setRealWorkTime() {
	var workTimeFrom = $("#sltWorkTimeFrom option:selected").val(); //시작시간
	var workTimeTo = $("#sltWorkTimeTo option:selected").val(); //종료시간
	console.log(workTimeFrom,workTimeTo);
	let timeArr = getTimeDiff(workTimeFrom, workTimeTo);
	tlTimeInput.val(timeArr[0]);
	nigtTimeInput.val(timeArr[2]);
	exTimeInput.val(timeArr[1]);
}
//#######################################################################################################################################
// 근무 저장

// 근무오픈캔버스 폼
let workForm = $("#workForm");
// 근무승인모달 날짜
let waModalDate = $("#waModalDate");
// 근무승인모달 항목
let waModalTilte = $('#waModalTilte');
// 근무승인모달 상세
let waModalDetail = $('#waModalDetail');

// 근무 저장 버튼클릭시 오픈캔버스의 내용 전달 후 비동기로 요청하여 기록저장 하거나 요청 판단
let workSubmitBtn = $("#workSubmitBtn").on("click", function() {
	
	// 주말일 경우 휴일근무시간으로 셋팅
	let dayOfWeek = getDayOfWeek(waDateInput.val())
	if(dayOfWeek == '일' || dayOfWeek == '토'){
		nigtTimeInput.val(0);
		exTimeInput.val(0);
		hdTimeInput.val(tlTimeInput.val());
	}
	// 폼 데이터 객체화
	let workData = workForm.serializeObject();
	console.log("workSubmitBtn 클릭이벤트 workData :",workData);
 	$.ajax({
		url : CONTEXTPATH+"/work/workApplication.do",
		method : "post",
		dataType : "json",
		data : JSON.stringify(workData),
		contentType: "application/json; charset=utf-8",
		success : function(resp) {
        	let wkNm = '근무';
        	$(workList).each(function (i, work) {
        		if(workData.wkCode == work.wkCode) wkNm = work.wkNm
        	});
        	
			if(resp.status == 'success'){
	            toastr.success('변경사항을 저장했습니다.');
	            week_calandar(3);
	            offcanvasWork.offcanvas('hide');
	        }else if(resp.status == 'fail'){ 
	            toastr.error('변경사항 저장 중 오류가 발생 했습니다.');
	        }else if(resp.status == 'nigtBan'){ 
	            toastr.info(wkNm+'(은)는 야간(저녁 10:00 ~ 익일 오전 03:00)에 등록할 수 없습니다.');
	        }else if(resp.status == 'HdBan'){ 
	            toastr.info('회사 정책 상 '+wkNm+'(은)는 휴일에 등록할 수 없어요.');
	            
	        // 근무 신청 모달창출력
	        }else if(resp.status == 'need'){
	        	// 날짜 지정
	        	waModalDate.html(makeDateFormat(workData.waDate));
	        	// 항목 지정
	        	let waModalTilteCode = wkNm;
	        	if(workData.waExtime > 0) waModalTilteCode += ', 연장근무'
	        	if(workData.waNigtime > 0) waModalTilteCode += ', 야간근무'
	        	if(workData.waHdtime > 0) waModalTilteCode += ', 휴일근무'
	        	waModalTilte.html(waModalTilteCode);
	        	// 상세 지정
	        	let waModalDetailCode = `· \${wkNm} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        	\${workData.waStime} ~ \${workData.waEtime} <span class="badge bg-label-success">\${makeTimeFormat(workData.waTltime)}</span>`;
	        	if(workData.waExtime > 0) waModalDetailCode += `<br> · 연장 근무 : \${makeTimeFormat(workData.waExtime)}</span>`;
		        if(workData.waNigtime > 0) waModalDetailCode += `<br> · 야간 근무 : \${makeTimeFormat(workData.waNigtime)}</span>`;
		        if(workData.waHdtime > 0) waModalDetailCode += `<br> · 휴일 근무 : \${makeTimeFormat(workData.waHdtime)}</span>`;
		        waModalDetail.html(waModalDetailCode);
	        	$("#waModal2").modal('show');
	        }
			
		},
		error : function(errorResp) {
			console.log(errorResp.status);
			toastr.error('변경사항 저장 중 오류가 발생 했습니다.');
			offcanvasBottom.offcanvas('hide');
		}
	});
	
});
//################################################################################################
// 근무 요청

// 신청사유
let waModalMemo = $('#waModalMemo');

// 승인 요청하기 버튼 클릭시 근무기록 요청 저장
let workRequestBtn = $('#workRequestBtn').on('click', function() {
	
	// 신청사유 폼에 전달
	workForm.find('input[name="waArsn"]').val(waModalMemo.val());
	
	// 신청사유를 반영한 폼을 다시 객체화
	let workData = workForm.serializeObject();
	
	console.log("workSubmitBtn 클릭이벤트 workData :",workData);
 	$.ajax({
		url : CONTEXTPATH+"/work/workApprovalApplication.do",
		method : "post",
		dataType : "json",
		data : JSON.stringify(workData),
		contentType: "application/json; charset=utf-8",
		success : function(resp) {
			if(resp.status == 'success'){
	            toastr.success('승인 요청을 보냈습니다.');
	            week_calandar(3);
	            $("#waModal2").modal('hide');
	            offcanvasWork.offcanvas('hide');
	        }else if(resp.status == 'fail'){ 
	            toastr.error('변경사항 저장 중 오류가 발생 했습니다.');
	            $("#waModal2").modal('hide');
	        }
			
		},
		error : function(errorResp) {
			console.log(errorResp.status);
			toastr.error('변경사항 저장 중 오류가 발생 했습니다.');
			$("#waModal2").modal('hide');
		}
	});
	
});
//################################################################################################
// 근무삭제
waDelBtn.on('click', function() {
	
	// 폼 데이터 객체화
	let workData = workForm.serializeObject();
	console.log("waDelBtn 클릭이벤트 workData :",workData);
	
  	$.ajax({
		url : CONTEXTPATH+"/work/workApRemove.do",
		method : "post",
		dataType : "json",
		data : JSON.stringify(workData),
		contentType: "application/json; charset=utf-8",
		success : function(resp) {
			if(resp.status == 'success'){
	            toastr.success('변경사항을 저장했습니다.');
	            week_calandar(3);
	            offcanvasWork.offcanvas('hide');
	        }else if(resp.status == 'fail'){ 
	            toastr.error('근무승인 요청 중 오류가 발생 했습니다.');
	        }
			
		},
		error : function(errorResp) {
			console.log(errorResp.status);
			toastr.error('근무승인 요청 중 오류가 발생 했습니다.');
			$("#waModal2").modal('hide');
		}
	});
	
});


//################################################################################################
// yy-MM-dd 문자열 날짜를 yy년 mm월 dd일 (요일) 형식으로 바꿔주는 함수  
function makeDateFormat(strDate) {
	let resultDay = new Date(strDate);
	let yy = resultDay.getFullYear();
	let mm = Number(resultDay.getMonth()) + 1;
	let dd = resultDay.getDate();
	let ddd = resultDay.getDay();

	mm = String(mm).length === 1 ? '0' + mm : mm;
	dd = String(dd).length === 1 ? '0' + dd : dd;

	if (ddd == 1) {
		ddd = '(월)';
	} else if (ddd == 2) {
		ddd = '(화)'
	} else if (ddd == 3) {
		ddd = '(수)'
	} else if (ddd == 4) {
		ddd = '(목)'
	} else if (ddd == 5) {
		ddd = '(금)'
	} else if (ddd == 6) {
		ddd = '(토)'
	} else if (ddd == 0) {
		ddd = '(일)'
	}
	
	return yy + '년 ' + mm + '월 ' + dd + '일 ' + ddd;
}
//##############################################################################################
// 4.5 숫자 시간을 4시간 30분 문자열로 바꿔주는 함수
function makeTimeFormat(paramtime) { //ex) makeTimeFormat(4.5)
	// 받은 시간 문자열로 바꾸기
	resultTime = paramtime+"";
	
	// 소숫점기준으로 문자열시간 나누기
	let workTimeH = resultTime.split('.')[0]
	let workTimeM = resultTime.split('.')[1] == '5' ? '30' : '';
	
	// 나눈 문자열로 시간,분을 알맞게 포맷해준다. 
	if(resultTime == 0){
		resultTime = "";
	}else if(workTimeH == 0){
		resultTime = `\${workTimeM}분`;
		
	}else if(!workTimeM){
		resultTime = `\${workTimeH}시간`;
		
	}else{
		resultTime = `\${workTimeH}시간 \${workTimeM}분`;
		
	}
	
	return resultTime;
}
//################################################################################################
// 특정 날짜가 무슨요일인지 구하는 함수
function getDayOfWeek(strDate){ //ex) getDayOfWeek('2022-06-13')

    const week = ['일', '월', '화', '수', '목', '금', '토'];

    const dayOfWeek = week[new Date(strDate).getDay()];

    return dayOfWeek;

}
</script>
