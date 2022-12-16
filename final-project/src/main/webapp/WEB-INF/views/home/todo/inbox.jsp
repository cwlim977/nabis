<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.hide {
	display: none;
}

.todoList:hover .hide {
	display: inline-block;
}

.todoList:hover .unhide {
	display: none;
}
.c1{
width:75%;
}
.text-green{
	color: green !important;
}
.custombg-gray{
 	background-color: rgba(67, 89, 113, 0.06); 
}
</style>

<ul class="px-0">
	<li>
		<!-- 해야할 일 li start -->
		<table class="table table-hover" style="table-layout: fixed">
			<thead><tr class="custombg-gray" ><th class="c1" colspan="2">해야할 일(<span id="todoListCount"></span>)</th></tr></thead>
			<tbody id="applicationTodoListTbody" class="table-border-bottom-0; table-border-right-0"></tbody>
		</table>
	</li>
	<!-- 해야할 일 li end -->
	<li>
		<!-- 완료한 일 --> 
		<table class="table table-hover" style="table-layout: fixed">
			<thead><tr class="custombg-gray"><th class="c1" colspan="2">완료한 일(<span id="finishedListCount"></span>)</th></tr></thead>
			<tbody id="applicationFinishedListTbody" class="table-border-bottom-0; table-border-right-0"></tbody>
		</table>
	</li>
</ul>
<!-- #################################################################################################################### -->
<!-- 근무오픈캔버스  -->
<div id="offcanvasWork" class="offcanvas offcanvas-end w-px-600" tabindex="-1">
	<div class="offcanvas-header border-bottom border-secondary sticky-top">
		<div id="canvasWorkTitle" class="d-flex menu-link">
		</div>
		<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"></button>
	</div>
	<div class="offcanvas-body mx-0 flex-grow-0">
		<section>
			<div class="divider text-start">
				<div class="divider-text fw-semibold">
					<i class='bx bxs-user-check'></i> 승인 상태
				</div>
			</div>
			<div class="card border">
				<div class="p-3 d-flex Justify-content-between">
					<div class="menu-link">
						<c:choose>
							<c:when test="${empty authEmp.empImg}">
								<img src="${cPath}/resources/images/basicProfile.png" alt="프로필" class="empListimgradius emplistimgsize" />
							</c:when>
							<c:otherwise>
								<img src="${cPath}/resources/empImages/${authEmp.empImg }" alt="프로필" class="empListimgradius emplistimgsize" />
							</c:otherwise>
						</c:choose>
						<div class="mx-3 mt-1">
							<strong>${authEmp.empNm}</strong> <br> 
							<span class="fs-tiny"> 
								<c:forEach items="${authEmp.jobList}" var="job" varStatus="st">
									<c:if test="${st.first}">
										${job.jnm}
									</c:if>
								</c:forEach>
							</span>
						</div>
					</div>
					<div id="waStat" class="ms-auto my-auto">승인 진행중 ···</div>
				</div>
			</div>
		</section>
		
		<section>
			<div class="divider text-start">
				<div class="divider-text fw-semibold">
					<i class='bx bxs-paper-plane'></i> 요청 내용
				</div>
			</div>
			<div class="card border p-3">
				<p>
					· 승인 항목 : <span id="waModalTilte" class="fw-semibold"></span>
				</p>
				<p>
					· 날짜 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : <span id="waModalDate"></span>
				</p>
				<p>
					· 요청 메시지: <span id="waMsg"></span>
				</p>
				<hr>
				<div id="waModalDetail"></div>
			</div>
		</section>
	</div>
	<div class="d-flex flex-row-reverse border-top border-secondary p-2">
		<div class="d-flex Justify-content-end">
			<button type="button" class="noBtn btn btn-outline-danger">반려</button>
			<button type="button" class="okBtn btn btn-success ms-2">
				<i class='bx bx-check me-1'></i>승인하기
			</button>
		</div>
	</div>
</div>
<!-- #################################################################################################################### -->

<!-- #################################################################################################################### -->
<!-- 휴가오픈캔버스 - hgk -->
<div id="offcanvasVac" class="offcanvas offcanvas-end w-px-600" tabindex="-1">
	  <div class="offcanvas-header border-bottom border-secondary sticky-top">
	  		<div id="canvasVacTitle" class="d-flex menu-link">
				<img src="${cPath}/resources/images/basicProfile.png" alt="Avatar" class="empListimgradius emplistimgsize">
					<div class="mx-3 mt-1">
						<strong></strong>
						<br> 
						<span class="fs-tiny"></span>
					</div>
		    </div>
	    	<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"></button>
	  </div>
	  <div class="offcanvas-body mx-0 flex-grow-0">
			<section>
				<div class="divider text-start">
				 	<div class="divider-text fw-semibold">
					  	<i class='bx bxs-user-check'></i>
					  	승인 상태
					</div>
				</div>
				<div class="card border">
				  	<div class="p-3 d-flex Justify-content-between">
				  		<div class="menu-link">
				  			<c:choose>
				  				<c:when test="${empty authEmp.empImg}">
			                      	<img src="${cPath}/resources/images/basicProfile.png" alt="프로필" class="empListimgradius emplistimgsize"/>
				  				</c:when>
				  				<c:otherwise>
			                       <img	src="${cPath}/resources/empImages/${authEmp.empImg }" alt="프로필" class="empListimgradius emplistimgsize"/>
				  				</c:otherwise>
				  			</c:choose>
							<div class="mx-3 mt-1">
								<strong>${authEmp.empNm}</strong> 
								<br>
								<span class="fs-tiny">
								<c:forEach items="${authEmp.jobList}" var="job" varStatus="st">
									<c:if test="${st.first}">
									${job.jnm}
									</c:if>
								</c:forEach>
								</span>
							</div>
				  		</div>
				  		<div id="vaStat" class="ms-auto my-auto">승인 진행중 ···</div>
					</div>
				</div>
			</section>
			<section>
				<div class="divider text-start">
				 	<div class="divider-text fw-semibold">
					  	<i class='bx bxs-paper-plane'></i>  요청 내용
					</div>
				</div>
				<div class="card border p-3">
					<div class="d-flex">
					    <p class="card-text col-3">· 휴가 종류</p>
					    <p class="card-text col-9" id="vacName"></p>
					</div>
					<div class="d-flex">
					    <p class="card-text col-3">· 휴가 기간</p>
					    <p class="card-text col-9" id="vacPeriod"></p>
						</div>
					<div class="d-flex">
						<p class="card-text col-3">· 사용 일수</p>
					    <p class="card-text col-9" id="vacApplyDays"></p>
					</div>
					<div class="d-flex">
						<p class="card-text col-3">· 증명 자료</p>
					    <p class="card-text col-9" id="vacCertSt"></p>
					</div>
					<div class="d-flex">
						<p class="card-text col-3">· 취소 상태</p>
						<p class="card-text col-9" id="vacCcSt"></p>
					</div>
					<div class="d-flex">
						<p class="card-text col-3">· 승인 상태</p>
						<p class="card-text col-9" id="vacApSt"></p>
					</div>
					<div class="d-flex">
						<p class="card-text col-3">· 메시지</p>
						<textarea class="form-control overflow-auto w-px-350" id="vacMsg" readonly></textarea>
					</div>
				</div> 
			</section>
	  </div>
	  <div class="d-flex flex-row-reverse border-top border-secondary p-2">
	 	<div class="d-flex Justify-content-end">
		  	<button type="button" class="noBtn btn btn-outline-danger" >반려</button>
			<button type="button" class="okBtn btn btn-success ms-2"><i class='bx bx-check me-1'></i>승인하기</button>
	  	</div>
	  </div>
</div>
<!-- #################################################################################################################### -->

<script>

//	근무목록
let workList;
//	할일 목록 Tbody
let applicationTodoListTbody = $('#applicationTodoListTbody');
//	완료한일 목록 Tbody
let applicationFinishedListTbody = $('#applicationFinishedListTbody');
// 	해야할일 카운트
let todoListCount = $('#todoListCount');
//	완료한일 카운트
let finishedListCount = $('#finishedListCount');

// 메인 컨테이너 클래스 삭제
applicationTodoListTbody.closest('.container-xxl').removeClass( 'container-xxl flex-grow-1 container-p-y' );

//	페이지 로드시 모든 리스트가져오기
getApplicationList();

// 근무목록 가져오기
$.ajax({
	url : CONTEXTPATH+"/work/getWorkOptionList.do",
	dataType : "json",
	success : function(resp) {
		workList = resp;
		console.log(resp);
	},
	error : function(errorResp) {
		console.log(errorResp.status);
	}
});

//#######################################################################################################################################
//	근무 오픈캔버스 열기

//  근무 오픈캔버스
let offcanvasWork = $('#offcanvasWork');
//	근무 오픈캔버스 제목
let canvasWorkTitle = $('#canvasWorkTitle');
//	근무 오픈캔버스 승인반려상태
let waStat = $('#waStat');
//	근무 요청 리스트 클릭시 이벤트
$(document).on('click', '.work', function() {
	let apNo = $(this).data('apno');
	let apStat = $(this).data('apstat');
	// 근무 상세내용 갱신 함수
	getApplicationWorkDetail(apNo);
	let empNm = $(this).data('empnm');
	let empImg = $(this).data('empimg');
	let apDate = $(this).data('apdate');
	// 프로필 유무로 이미지주소설정
	if(!empImg){
		empImg =`\${CONTEXTPATH}/resources/images/basicProfile.png`;
	}else{
		empImg = `\${CONTEXTPATH}/resources/empImages/\${empImg}`;
	}
	// 오픈캔버스 타이틀 내용
	let canvasWorkTitleCode =`<img src="\${empImg}"
								alt="Avatar" class="empListimgradius emplistimgsize">
								<div class="mx-3 mt-1">
									<strong>\${empNm}님의 근무 요청</strong>
									<br> <span class="fs-tiny">\${apDate}</span>
								</div>`;
	canvasWorkTitle.html(canvasWorkTitleCode);
	
	if(apStat == '대기'){
		waStat.html("승인 진행중 ···");
		// 근무 오픈캔버스 버튼들에 apNo,apType,canvasHide 데이터 넣기
		offcanvasWork.find('button').data('apno', apNo);
		offcanvasWork.find('button').data('aptype', 'work');
		offcanvasWork.find('button').data('canvashide', 'y');
		offcanvasWork.find('button').show();
	// 완료한일인 경우 버튼 숨기기	
	}else if(apStat == '승인'){
		let str = `<span class="text-success">승인 완료 <i class='bx bxs-check-circle' ></i></span>`;
		waStat.html(str)
		offcanvasWork.find('button').hide();
	}else{
		let str = `승인 반려 <i class='bx bxs-x-circle text-danger' ></i>`;
		waStat.html(str);
		offcanvasWork.find('button').hide();
	}
	
	// 근무 오픈캔버스 출력
	offcanvasWork.offcanvas('show');
});

//#######################################################################################################################################
// 근무오픈캔버스 상세내용 가공

// 근무승인 날짜
let waModalDate = $("#waModalDate");
// 근무승인 항목
let waModalTilte = $('#waModalTilte');
// 근무승인 메시지
let waMsg = $('#waMsg');
// 근무승인 상세
let waModalDetail = $('#waModalDetail');
// 근무승인 내용 템플릿화
function getApplicationWorkDetail(apNo) {
	$.ajax({
		url : CONTEXTPATH+"/work/getWorkApDetail.do",
		dataType : "json",
		data : { apNo : apNo},
		success : function(resp) {
			console.log("getWorkApDetail.do 리턴값 : ",resp)
			let workData = resp;

			// 요청 메시지 지정
			waMsg.html(workData.waArsn);
        	// 날짜 지정
        	waModalDate.html(makeDateFormat(workData.waDate));
        	// 항목 지정
        	let wkNm = '근무';
        	$(workList).each(function (i, work) {
        		if(workData.wkCode == work.wkCode) wkNm = work.wkNm
        	});
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
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
}

//#######################################################################################################################################
//휴가 오픈캔버스 열기 - hgk

//휴가 오픈캔버스
let offcanvasVac = $('#offcanvasVac');
//휴가 오픈캔버스 제목
let canvasVacTitle = offcanvasVac.find('#canvasVacTitle');
//근무 오픈캔버스 승인반려상태
let vaStat = offcanvasVac.find('#vaStat');
//휴가 요청 리스트 클릭시 이벤트
$(document).on('click', '.vac', function() {
	let apNo = $(this).data('apno');
	let apStat = $(this).data('apstat');
	// 휴가 요청 내용 갱신 함수
	getApplicationVacDetail(apNo); 
	let empNm = $(this).data('empnm');
	let empImg = $(this).data('empimg');
	let apDate = $(this).data('apdate');
	// 프로필 유무로 이미지주소설정
	if(!empImg){
		empImg =`\${CONTEXTPATH}/resources/images/basicProfile.png`;
	}else{
		empImg = `\${CONTEXTPATH}/resources/empImages/\${empImg}`;
	}
	// 오픈캔버스 타이틀 내용
	let canvasVacTitleCode =`<img src="\${empImg}"
								alt="Avatar" class="empListimgradius emplistimgsize">
								<div class="mx-3 mt-1">
									<strong>\${empNm}님의 휴가 요청</strong>
									<br> <span class="fs-tiny">\${apDate}</span>
								</div>`;
	canvasVacTitle.html(canvasVacTitleCode);
	
	if(apStat == '대기'){
		vaStat.html("승인 진행중 ···");
		// 휴가 오픈캔버스 버튼들에 apNo,apType,canvasHide 데이터 넣기
		offcanvasVac.find('button').data('apno', apNo);
		console.log("디버그",offcanvasVac.find('button').data('apno'));
		offcanvasVac.find('button').data('aptype', 'vac');
		offcanvasVac.find('button').data('canvashide', 'y');
		offcanvasVac.find('button').show();
	// 완료한일인 경우 버튼 숨기기	
	}else if(apStat == '승인'){
		let str = `<span class="text-success">승인 완료 <i class='bx bxs-check-circle' ></i></span>`;
		vaStat.html(str)
		offcanvasVac.find('button').hide();
	}else{
		let str = `승인 반려 <i class='bx bxs-x-circle text-danger' ></i>`;
		vaStat.html(str);
		offcanvasVac.find('button').hide();
	}
	
	// 휴가 오픈캔버스 출력
	offcanvasVac.offcanvas('show');
});

//#######################################################################################################################################
//휴가오픈캔버스 상세내용 가공 - hgk

let dayNames = ["일", "월", "화", "수", "목", "금", "토"];

function createFormattedDate(date){
	return [date.getFullYear(), date.getMonth()+1, date.getDate(), ['(', dayNames[date.getDay()], ')'].join('')].join('. ');
}

function createCertSpanTag(vcCert, vaapFileCnt){
	let vacCertStClass = '';
	let vacCertStTxt = '';
	if(vcCert == 'Y'){
		if(vaapFileCnt == 0){
			vacCertStClass = 'bg-label-danger';
	 		vacCertStTxt = '제출 필요';	
		}else{
			vacCertStClass = 'bg-label-info';
	 		vacCertStTxt = '제출 완료';
		}
	}else{
			vacCertStClass = 'bg-label-secondary';
			vacCertStTxt = '제출 없음';
	}
	return ['<span class="badge ', vacCertStClass, '">', vacCertStTxt, '</span>'].join('');
}

function createApSpanTag(vaapApSt){
	let vacApStClass = '';
	let vacApStTxt = '';
	if(vaapApSt == '승인'){
		vacApStClass = 'bg-label-success';
		vacApStTxt = '승인';
	}else if(vaapApSt == '반려'){
		vacApStClass = 'bg-label-warning';
		vacApStTxt = '반려';
	}else{
		vacApStClass = 'bg-label-secondary';
		vacApStTxt = '미승인';
	}
	return ['<span class="badge ', vacApStClass, '">', vacApStTxt, '</span>'].join('');
}

//휴가 종류
let vacName = offcanvasVac.find('#vacName');
//휴가 기간
let vacPeriod = offcanvasVac.find('#vacPeriod');
//휴가 사용 일수
let vacApplyDays = offcanvasVac.find('#vacApplyDays');
//휴가 증명 자료
let vacCertSt = offcanvasVac.find('#vacCertSt');
//휴가 취소 상태
let vacCcSt = offcanvasVac.find('#vacCcSt');
//휴가 승인 상태
let vacApSt = offcanvasVac.find('#vacApSt');
//휴가 메시지
let vacMsg = offcanvasVac.find('#vacMsg');
//휴가 요청 내용 갱신 함수
function getApplicationVacDetail(apNo) {
	$.ajax({
		url : CONTEXTPATH+"/memberVacation/getVacApplyDetail.do",
		method : "post",
		data : {vaapCode : apNo},
		dataType : "json",
		success : function(resp) {
			if(resp['status'] == 'fail') return false;
			let obj = resp['vacApplyVo'];			
			let vcNm = obj['vacVo']['vcNm'];
			if(vcNm.match('연차')) vcNm = '연차';
			vacName.text(vcNm);			
			let vacSchVoList = obj['vacSchVoList'];
			let startDate = new Date(vacSchVoList[0]['vsEachDate']);
			let endDate = new Date(vacSchVoList[vacSchVoList.length-1]['vsEachDate']);
			vacPeriod.text([createFormattedDate(startDate), ' - ', createFormattedDate(endDate)].join(''));		
			vacApplyDays.html(['<span class="badge bg-label-primary">', obj['vaapDays'], '일</span>'].join(''));			
			vacCertSt.html(createCertSpanTag(obj['vacVo']['vcCert'], obj['vaapFileCnt']));		
			vacCcSt.text(obj['vaapCcSt']);
			vacApSt.html(createApSpanTag(obj['vaapApSt']));
			vacMsg.text(obj['vaapRsn']);
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});	
}

//#######################################################################################################################################
// 할일, 완료한일 리스트 비동기 갱신 함수
function getApplicationList() {
	$.ajax({
		url : CONTEXTPATH+"/home/applicationList.do",
		dataType : "json",
		contentType: "application/json; charset=utf-8",
		success : function(resp) {
			console.log("applicationList.do 리턴값 : ",resp)
			let todoHtmlCode = "";
			let finishedHtmlCode = "";
			// 프로필 주소
			let empImg;
			// 승인 종류
			let apType;
			
			// 해야할일 갯수			
			let todoCnt = 0;
			// 완료한일 갯수
			let finishedCnt = 0;
			
			$(resp).each(function (i, apVO) {
				
				// 해야할일 카운트
				if(apVO.apStat == '대기'){ 
					todoCnt++;
				// 완료한일 카운트
				}else{
					finishedCnt++;
				}
				
				// 결재상태 대기일시 할일 리스트 html 생성
				if(apVO.apStat == '대기'){ 
					
					if(apVO.apType == 'work'){
						apType = '근무';
					}else{
						apType = '휴가';
					}
					// 프로필 유무로 이미지주소설정
					empImg = `\${CONTEXTPATH}/resources/empImages/\${apVO.empImg}`;
					if(!apVO.empImg)
						empImg =`\${CONTEXTPATH}/resources/images/basicProfile.png`;
						
					todoHtmlCode +=`<tr class="todoList \${apVO.apType}" data-apno="\${apVO.apNo}" data-empnm="\${apVO.empNm}" data-empimg="\${apVO.empImg}" data-apdate="\${apVO.apDate}" data-apstat="\${apVO.apStat}">
									<td class="menu-link">
									<img src="\${empImg}"
											alt="Avatar" class="empListimgradius emplistimgsize">
										<div class="mx-3 mt-1">
											<strong>\${apType} 승인 요청</strong> 
											<span class="fs-tiny">\${apVO.empNm} · \${elapsedTime(apVO.apDate)}</span>
											<br> <span class="fs-tiny">\${makeDateFormat(apVO.apDate)}</span>
										</div>
								</td>
								<td>
									<div data-role="hover-extra" class="text-end">
										<button type="button" class="btn unhide">
											<i class="bx bx-chevron-right"></i>
										</button>
										<button type="button" class="noBtn btn btn-sm btn-outline-secondary hide" data-apno="\${apVO.apNo}" data-aptype="\${apVO.apType}">
											<span>반려</span>
										</button>
										<button type="button" class="okBtn btn btn-sm btn-primary hide" data-apno="\${apVO.apNo}" data-aptype="\${apVO.apType}">
											<span>승인하기</span>
										</button>
									</div>
								</td>
							</tr>`;	
				
							
				// 완료한일 리스트 html 생성		
				}else{
					if(apVO.apType == 'work'){
						apType = '근무';
					}else{
						apType = '휴가';
					}
					
					let statBadge;
					if(apVO.apStat == '승인'){
						statBadge = `<span class="text-green badge rounded-pill bg-label-success">승인</span>`;
					}else{
						statBadge = `<span class="badge rounded-pill bg-label-danger">반려</span>`;
					}
					// 프로필 유무로 이미지주소설정
					empImg = `\${CONTEXTPATH}/resources/empImages/\${apVO.empImg}`;
					if(!apVO.empImg)
						empImg =`\${CONTEXTPATH}/resources/images/basicProfile.png`;
						
					finishedHtmlCode +=`<tr class="todoList \${apVO.apType}" data-apno="\${apVO.apNo}" data-empnm="\${apVO.empNm}" data-empimg="\${apVO.empImg}" data-apdate="\${apVO.apDate}" data-apstat="\${apVO.apStat}">
									<td class="menu-link">
									<img src="\${empImg}"
											alt="Avatar" class="empListimgradius emplistimgsize">
										<div class="mx-3 mt-1">
											<strong>\${apType} 승인 요청</strong> 
											<span class="fs-tiny">\${apVO.empNm} · \${elapsedTime(apVO.apDate)}</span>
											<br> <span class="fs-tiny">\${makeDateFormat(apVO.apDate)}</span>
										</div>
								</td>
								<td>
									<div class="text-end">
										\${statBadge}
										<button type="button" class="btn">
											<i class="bx bx-chevron-right"></i>
										</button>
									</div>
								</td>
							</tr>`;
				}
			});
			
			todoListCount.html(todoCnt);
			finishedListCount.html(finishedCnt);
			// 할일리스트 Tbody에 반영
			applicationTodoListTbody.html(todoHtmlCode);
			// 완료한일리스트 Tbody에 반영
			applicationFinishedListTbody.html(finishedHtmlCode);
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
}

//#######################################################################################################################################
// 승인반려 버튼 이벤트 관련

	// 반려버튼
	$(document).on("click", ".noBtn", function(event) {
		event.stopPropagation();
		
		let apNo = $(this).data('apno');
		let apType = $(this).data('aptype');
		let url;
		let canvasHide = $(this).data('canvashide');
		
		// 근무인 경우
		if(apType == 'work'){
			url = CONTEXTPATH+"/home/workApReject.do";
		// 휴가인 경우
		}else{
			/* hgk */
			url = CONTEXTPATH+"/memberVacation/vacApplyManage.do";
			/* hgk */
		}
		
		// 승인,반려 비동기 처리 함수 호출
		ajaxConfirmOrReject(url, apNo, '반려');
		
		if(canvasHide == 'y' && apType == 'work'){
			// 근무 오픈캔버스 닫기
			offcanvasWork.offcanvas('hide');
		}else if(canvasHide == 'y' && apType == 'vac'){
			// 휴가 오픈캔버스 닫기
			/* hgk */
			offcanvasVac.offcanvas('hide')
			/* hgk */
		}
		
	})
	// 승인버튼
	$(document).on("click", ".okBtn", function(event) {
		event.stopPropagation();
		
		let apNo = $(this).data('apno');
		let apType = $(this).data('aptype');
		let url;
		let canvasHide = $(this).data('canvashide');
		
		// 근무인 경우
		if(apType == 'work'){
			url = CONTEXTPATH+"/home/workApConfirm.do";
		// 휴가인 경우
		}else{
			/* hgk */
			url = CONTEXTPATH+"/memberVacation/vacApplyManage.do";
			/* hgk */
		}
		
		// 승인,반려 비동기 처리 함수 호출
		ajaxConfirmOrReject(url, apNo, '승인');
		
		if(canvasHide == 'y' && apType == 'work'){
			// 근무 오픈캔버스 닫기
			offcanvasWork.offcanvas('hide');
		}else if(canvasHide == 'y' && apType == 'vac'){
			// 휴가 오픈캔버스 닫기
			/* hgk */
			offcanvasVac.offcanvas('hide');
			/* hgk */
		}
	})
	
	// 승인,반려 비동기 처리
	// url - 비동기 접속 주소
	// apNo - 보낼 기록 번호
	// action - 승인/반려 상태 문자열
	function ajaxConfirmOrReject(url, apNo, action) {
		/* hgk */
		let data = null;
		if(String(apNo).match('VAAP')){
			data = new Object();
			let behavior = null;
			if(action == '반려') behavior ='reject';
			if(action == '승인') behavior ='approve';
			data['vaapCode'] = apNo;
			data['behavior'] = behavior;
		}else{
			data = {apNo : apNo};
		}
		/* hgk */
	  	$.ajax({
			url : url,
			method : "post",
			dataType : "json",
			data : data,
			success : function(resp) {
				if(resp.status == 'success'){
		            toastr.success(action + ' 처리되었습니다.');
		            // 할일 리스트 갱신
		            getApplicationList();
		        }else if(resp.status == 'fail'){ 
		            toastr.error(action + ' 처리 중 오류가 발생 했습니다.');
		        }
			},
			error : function(errorResp) {
				console.log(errorResp.status);
				toastr.error(action + ' 처리 중 오류가 발생 했습니다.');
			}
		});
	}
//#######################################################################################################################################
// 경과시간 표현 함수
function elapsedTime(date) {
  let start = new Date(date);
  let end = new Date();

  let diff = (end - start) / 1000;
  
  let times = [
    { name: '년', milliSeconds: 60 * 60 * 24 * 365 },
    { name: '개월', milliSeconds: 60 * 60 * 24 * 30 },
    { name: '일', milliSeconds: 60 * 60 * 24 },
    { name: '시간', milliSeconds: 60 * 60 },
    { name: '분', milliSeconds: 60 },
  ];

  for (let value of times) {
    let betweenTime = Math.floor(diff / value.milliSeconds);

    if (betweenTime > 0) {
      return `\${betweenTime}\${value.name} 전`;
    }
  }
  return '방금 전';
}
//#######################################################################################################################################
//yy-MM-dd 문자열 날짜를 yy. mm. dd (요일) 형식으로 바꿔주는 함수  
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
	
	return yy + '. ' + mm + '. ' + dd + '. ' + ddd;
}
//#####################################################################################################################################
//4.5 숫자 시간을 4시간 30분 문자열로 바꿔주는 함수
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
</script>