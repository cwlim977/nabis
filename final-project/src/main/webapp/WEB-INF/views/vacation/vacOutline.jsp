<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<link rel="stylesheet" href="${cPath}/resources/css/hgk.css"/>

<script>
	
	let empRole = "${requestScope['empRole']}";
	
	$('.headerMenu, .headerSubMenu').each(function(){
		switch($(this).attr('id')){
			case 'menu1':
				$(this).find('span').addClass('text-dark');
				break;
			case 'menu2':
				if(!(empRole == 'admin' || empRole == 'manager')) $(this).hide();
				break;
			case 'subMenu1':
				$(this).find('span').addClass('text-dark');
				break;
			case 'subMenu2':
				break;
			default:
				$(this).hide();
		}
	});
	
	
	$(function(){
		
		/* 공통 */
		
		toastr.options.positionClass = "toast-top-center";
		
	 	$('#collapseBtn').click(function(){
	 	    if($(this).text() == '열기') $(this).html('<i class="bx bx-chevron-up"></i>접기');
	 	    else $(this).html('<i class="bx bx-chevron-down"></i>열기');
	 	});
	 	
	 	let selectedVac = null;
	 	let now = new Date();
	 	let vacData = new Object();
	 	let dayNames = ["일", "월", "화", "수", "목", "금", "토"];
	 	let vacApplyMap = new Object();
	 	let modal = $('#modal');
	 	let plannedVacList = $('#plannedVacList');
	 	let plannedVacCntTag = plannedVacList.prev().find('#plannedVacCnt');
	 	let usedVacList = $('#usedVacList');
	 	
		function createFormattedDate(date){return [date.getFullYear(), date.getMonth()+1, date.getDate(), '('+dayNames[date.getDay()]+')'].join('. ');};
		
		function createFormalDate(date){return [date.getFullYear(), date.getMonth()+1, date.getDate()].join('-');};
		
		function createTrTag(startDate, key, obj){
	 		let formattedStartDate = createFormattedDate(startDate);
	 		let endDate = new Date(obj['endDay']['date']);
	 		let formattedEndDate = createFormattedDate(endDate);
	 		let vacCertStClass = '';
	 		let vacCertStTxt = '';
	 		if(obj['vcCert'] == 'Y' && obj['vaapFileCnt'] == 0){
	 			vacCertStClass = 'bg-label-danger';
	 			vacCertStTxt = '제출 필요';
	 		}
	 		else if(obj['vcCert'] == 'Y' && obj['vaapFileCnt'] != 0){
	 			vacCertStClass = 'bg-label-info';
	 			vacCertStTxt = '제출 완료';
	 		}
	 		else{
	 			vacCertStClass = 'bg-label-secondary';
	 			vacCertStTxt = '제출 없음';
	 		}
	 		let vacApStClass = '';
	 		let vacApStTxt = '';
	 		if(obj['vaapApSt'] == '승인'){
	 			vacApStClass = 'bg-label-success';
	 			vacApStTxt = '승인';
	 		}
	 		else{
	 			vacApStClass = 'bg-label-secondary';
	 			vacApStTxt = '미승인';
	 		}
 			let htmlTag = `<tr class="cursor-pointer text-center appliedVac" data-bs-toggle="modal" data-bs-target="#modal" id="\${key}">
								<td class="col-md-1">	
									<i class='bx bx-calendar bx-sm'></i>
								</td>
								<td class="col-md-2">
							    	<strong id="appliedVacNm">\${obj['vcNm']}</strong>
							    </td>
							    <td class="col-md-3" id="appliedVacPeriod">
							    	\${formattedStartDate} - \${formattedEndDate} 
							    </td>
							    <td class="col-md-2" id="appliedVacDays">
							    	<span class="badge bg-label-primary">
							    		\${obj['vaapDays']}일
							    	</span>
							    </td>
							    <td class="col-md-2" id="appliedVacCertSt"> 
							    	<span class="badge \${vacCertStClass}">
							    		\${vacCertStTxt}
							    	</span>
							   	</td>
							    <td class="col-md-2" id="appliedVacApSt"> 
							    	<span class="badge \${vacApStClass}">
							    		\${vacApStTxt}
							    	</span>
							   	</td>
					  		</tr>`
			return htmlTag;
		};
		
	 	$('.vacApply').each(function(i, e){
	 		let vacApply = $(this);
	 		let vacApplyObj = new Object();
	 		vacApplyObj['vcCode'] = vacApply.data('vcCode');
	 		vacApplyObj['vcNm'] = vacApply.data('vcNm');
	 		vacApplyObj['vcUseunit'] = vacApply.data('vcUseunit');
	 		vacApplyObj['vcCert'] = vacApply.data('vcCert');
	 		vacApplyObj['vaapDate'] = vacApply.data('vaapDate');
	 		vacApplyObj['vaapRsn'] = vacApply.data('vaapRsn');
	 		vacApplyObj['vaapApSt'] = vacApply.data('vaapApSt');
	 		vacApplyObj['vaapFileCnt'] = vacApply.data('vaapFileCnt');	
	 		console.log("vacApplyObj['vcUseunit'] : ", vacApplyObj['vcUseunit']);
	 		if(vacApplyObj['vcUseunit'].match('일')) vacApplyObj['vaapDays'] = parseInt(vacApply.data('vaapDays'));
	 		else vacApplyObj['vaapDays'] = parseFloat(vacApply.data('vaapDays'));
	 		let eachDays = vacApply.find('.eachDay');
	 		let cnt = eachDays.length;
	 		eachDays.each(function(i, e){
	 			let eachDayInfoArr = $(this).val().split(',');
	 			let eachDayObj = new Object();
	 			eachDayObj['date'] = eachDayInfoArr[0];
	 			eachDayObj['sTime'] = eachDayInfoArr[1];
	 			eachDayObj['eTime'] = eachDayInfoArr[2];
	 			if(vacApplyObj['vcUseunit'].match('일')) eachDayObj['useDays'] = parseInt(eachDayInfoArr[3]);
	 			else eachDayObj['useDays'] = parseFloat(eachDayInfoArr[3]);
	 			if(i == 0) vacApplyObj['startDay'] = eachDayObj;
	 			if(i != 0 && i != (cnt-1)) vacApplyObj["'"+"middleDay"+i+"'"] = eachDayObj;
	 			if(i == (cnt-1)) vacApplyObj['endDay'] = eachDayObj;
	 		});
	 		vacApplyMap[vacApply.attr('id')] = vacApplyObj;
	 	});
	 	
	 	console.log(vacApplyMap);
	 	
		/* 공통 */
	 	
	 	/* 휴가 신청 */
	 
	 	let daterangepicker = $('#daterangepicker').daterangepicker({
	 		locale : {
	 			"format" : "YYYY-MM-DD",
		        "separator" : " → ",
		        "daysOfWeek" : dayNames,
		        "monthNames" : ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
	 		},
		    autoApply: true
		}, function (start, end) {
			addSchedule(start, end);
		});
	 	
	 	function addSchedule(start, end){
			let eachDayList = $('#eachDayList');
			eachDayList.empty();
		 	let startDate = new Date(start);
		 	let endDate = new Date(end);
		 	let days = parseInt((endDate.getTime() - startDate.getTime()) / (1000*60*60*24)) + 1;
		 	let count = days;
		 	let optionTag = '';
			if(vacData['vcUseunit'] == '일'){
				optionTag = '<option value="하루 종일">하루 종일</option>';
			}else{
				optionTag = '<option value="하루 종일">하루 종일</option><option value="오전 반차">오전 반차</option><option value="오후 반차">오후 반차</option>';
			}
		 	for(var i = 0; i < count; i++){
		 		if(i != 0) startDate.setDate(startDate.getDate()+1);
		 		let dayName = dayNames[startDate.getDay()];
		 		if(dayName == '토' || dayName == '일'){
		 			days = days - 1;
		 			continue;
		 		} 
		 		let headerText = createFormattedDate(startDate);
		 		let dataText = createFormalDate(startDate);
		 		let htmlTag = `<div class="card accordion-item active">
								    <h2 class="accordion-header" id="headingOne">
								      <button type="button" class="accordion-button" data-bs-toggle="collapse" data-bs-target="#accordion\${i+1}" role="tabpanel">
								        \${headerText}
								      </button>
								    </h2>
								    <div id="accordion\${i+1}" class="accordion-collapse collapse show bg-white" data-bs-parent="#accordionExample">
								      <div class="accordion-body d-flex justify-content-between">
									        <select class="form-select form-select-sm w-25 vcUseUnitSelect" data-date="\${dataText}">
										        \${optionTag}
									        </select>
						  					<div class="input-group input-group-sm w-50">
											  <input type="text" class="form-control text-center" id="startTime" value="09:00" readonly/>
											  <span class="input-group-text">→</span>
											  <input type="text" class="form-control text-center" id="endTime" value="18:00" readonly/>
											</div>
								      </div>
								    </div>
					    		</div>`
		 		eachDayList.append(htmlTag);
		 	};
		 	if(parseInt(vacData['vpDays']) < days){
		 		eachDayList.empty();
		 		toastr.error('사용 가능한 일 수를 초과했습니다.');
			}
		};
	 	
		let offcanvas = $('#offcanvasEnd').on('hide.bs.offcanvas', function() {
			form.find('#vaapRsn').val('');
		});
		
	 	/* 1. 휴가 보유 2. 휴가 신청 3. 휴가 일정  */
		let form = $('#vacApplyForm').on('submit', function(){
	 		event.preventDefault();
	 		let vaapDays = 0;
	 		let vacSchVoList = [];	 		
	 		offcanvas.find('.vcUseUnitSelect').each(function(i, e){
	 			let element = $(this);
	 			let vacSchVo = new Object();
	 			vacSchVo['vsEachDate'] = element.data('date');
	 			vacSchVo['vsStime'] = element.next().children('#startTime').val();
	 			vacSchVo['vsEtime'] = element.next().children('#endTime').val();
	 			if(element.val().match('반차')) {
	 				vaapDays = vaapDays + 0.5;
	 				vacSchVo['vsUseDays'] = 0.5;
	 			}
	 			else{
	 				vaapDays = vaapDays + 1;
	 				vacSchVo['vsUseDays'] = 1;
	 			}
	 			vacSchVoList.push(vacSchVo);
	 		});	 		
	 		if(vaapDays == 0) {
	 			toastr.error('휴가 일정이 입력되지 않았습니다.');
	 			return false;
	 		};	 		
		 	form.find('#vaapDays').val(vaapDays);
		 	form.find('#vcCode').val(vacData['vcCode']);		 	
	 		let url = this.action;
			let method = this.method;
			let vacApplyVo = form.serializeObject();			
	 		let data = {	
	 			vacApplyVo : vacApplyVo,
	 			vacSchVoList : vacSchVoList
	 		}; 		
	 		console.log(data);	 		
	 		
	 		let jsonData = JSON.stringify(data);	 		
	 		
	 		$.ajax({
				url : url,
				method : method,
				data : jsonData,
				contentType : 'application/json; charset=utf-8',
				dataType : 'json',
				success : function(resp) {
					if(resp.status == 'fail') {
						toastr.error('휴가 신청이 실패했습니다.');
						offcanvas.offcanvas('hide');
						return false;
					}
					if(resp.status == 'success') toastr.success('휴가 신청이 성공했습니다.');
					/* 비동기로 바꿀 것이 필요한 것들 바꾸자 */
					/* 1. #vacation의 data-vp-days 2. #vpDays의 text 3. datarangepicker / textarea reset*/
					if(!vacData['vcGmtd'].match('신청시')){
						let vpDays = vacData['vpDays'];
						if(vacData['vcUseunit'] == '일') vpDays = parseInt(vpDays) - vaapDays;
						else vpDays = parseFloat(vpDays) - vaapDays;
						selectedVac.data('vpDays', vpDays);
						selectedVac.find('#vpDays').html('<span class="badge badge-dot bg-success me-1"> </span>'+vpDays+'일');	
					}
					let newVacApplyObj = new Object();
					newVacApplyObj['vcCode'] = vacApplyVo['vcCode'];
					let vacApplyCard = $('#'+newVacApplyObj['vcCode']);
					newVacApplyObj['vcNm'] = vacApplyCard.data('vcNm');
					newVacApplyObj['vcUseunit'] = vacApplyCard.data('vcUseunit');
					newVacApplyObj['vcCert'] = vacApplyCard.data('vcCert');
					newVacApplyObj['vaapDate'] = createFormalDate(now);
					newVacApplyObj['vaapRsn'] = vacApplyVo['vaapRsn'];
					newVacApplyObj['vaapApSt'] = '대기';
					newVacApplyObj['vaapFileCnt'] = 0;
			 		if(newVacApplyObj['vcUseunit'].match('일')) newVacApplyObj['vaapDays'] = parseInt(vacApplyVo['vaapDays']);
			 		else newVacApplyObj['vaapDays'] = parseFloat(vacApplyVo['vaapDays']);
			 		let cnt = vacSchVoList.length;
			 		vacSchVoList.forEach(function(e, i){
			 			let eachDayObj = new Object();
			 			eachDayObj['date'] = e['vsEachDate'];
			 			eachDayObj['sTime'] = e['vsStime'];
			 			eachDayObj['eTime'] = e['vsEtime'];
			 			if(newVacApplyObj['vcUseunit'].match('일')) eachDayObj['useDays'] = parseInt(e['vsUseDays']);
			 			else eachDayObj['useDays'] = parseFloat(e['vsUseDays']);
			 			if(i == 0) newVacApplyObj['startDay'] = eachDayObj;
			 			if(i != 0 && i != (cnt-1)) newVacApplyObj["'"+"middleDay"+i+"'"] = eachDayObj;
			 			if(i == (cnt-1)) newVacApplyObj['endDay'] = eachDayObj;
			 		});
			 		let keys = Object.keys(vacApplyMap);
			 		let lastKey = keys[keys.length-1];
			 		let newKey = ''.concat(${authEmp['empNo']},'VAAP',parseInt(lastKey.slice(lastKey.indexOf('P')+1))+1);
			 		let startDate = new Date(newVacApplyObj['startDay']['date']);
		 			let trTag = createTrTag(startDate, newKey, newVacApplyObj);
				 	plannedVacList.append(trTag);
				 	plannedVacCntTag.text(parseInt(plannedVacCntTag.text())+1);
			 		vacApplyMap[newKey] = newVacApplyObj;
			 		console.log('vacApplyMap : ',vacApplyMap);
			 		offcanvas.offcanvas('hide');
				},
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			});	
	 		return false;
	 	});
			 	
		$(document).on('click', '.vacation', function(){
			
			selectedVac = $(this);
	 		vacData['vclfCode'] = selectedVac.data('vclfCode');
	 		vacData['vcCode'] = selectedVac.attr('id');
	 		vacData['vcNm'] = selectedVac.data('vcNm');
	 		vacData['vcInfo'] = selectedVac.data('vcInfo');
	 		vacData['vcGmtd'] = selectedVac.data('vcGmtd');
	 		vacData['vcUseunit'] = selectedVac.data('vcUseunit');
	 		vacData['vcWpay'] = selectedVac.data('vcWpay');
	 		vacData['vcCert'] = selectedVac.data('vcCert');
	 		vacData['vpDays'] = selectedVac.data('vpDays');
	 		
	 		console.log(vacData);
	 		
	 		offcanvas.find('#vacName').text(vacData['vcNm']);
	 		offcanvas.find('#vacInfo').text(vacData['vcInfo']);
	 		offcanvas.find('#badge1').text(vacData['vpDays']+'일 가능');
	 		offcanvas.find('#badge2').text(vacData['vcWpay'] == 'Y' ? '유급' : '무급');
	 		vacData['vcCert'] == 'Y' ? offcanvas.find('#badge3').show() : offcanvas.find('#badge3').hide(); 
	 
	 		daterangepicker.data('daterangepicker').setStartDate(now);
	 		daterangepicker.data('daterangepicker').setEndDate(now);
	 		addSchedule(now, now); 
	 		
		});
			 	
		$(document).on('change', '.vcUseUnitSelect', function(){	
			switch($(this).val()){
				case '하루 종일':
					$(this).next().children('#startTime').val('09:00');
					$(this).next().children('#endTime').val('18:00');
					break;
				case '오전 반차':
					$(this).next().children('#startTime').val('09:00');
					$(this).next().children('#endTime').val('14:00');
					break;
				case '오후 반차':
					$(this).next().children('#startTime').val('14:00');
					$(this).next().children('#endTime').val('18:00');
					break;
			};
		});
		
	 	/* 휴가 신청 */
	
	 	/* 예정 휴가 */
	 	
	 	/* 증명 자료 제출 */
	 	
	 	modal.find('#fileSubmitBtn').on('click', function(e){
	 		let formData = new FormData();
	 		let vaapCode = modal.data('vaapCode');
	 		let inputFile = $(this).prev()[0];
	 		console.log("inputFile : ", inputFile);
	 		let files = inputFile.files;
	 		if(files.length == 0){
	 			toastr.error('파일이 선택되지 않았습니다.');
	 			return false;
	 		}
	 		formData.append("vaapCode", vaapCode);
	 		formData.append("uploadFile", files[0]);
	 		$.ajax({
	 			url : "${cPath}/myVacation/vaapFileUpload.do",
	 			method : "post",
	 			processData : false,
	 			contentType : false,
	 			data : formData,
	 			dataType : 'json',
	 			success : function(resp) {
	 				if(resp.status == 'success') toastr.success('증명 자료 제출에 성공했습니다.');
					if(resp.status == 'fail') toastr.error('증명 자료 제출에 실패했습니다.');
					modal.find('#vaapFileSubmit').addClass("d-none");
					let tagClass = 'badge bg-label-info';
					let tagTxt = '제출 완료';
					let modalSpanTag = modal.find('#appliedVacCertStModal').children();
					modalSpanTag.attr('class', tagClass);
					modalSpanTag.text(tagTxt);
					let spanTag = plannedVacList.find('#'+vaapCode).find('#appliedVacCertSt').children();
					spanTag.attr('class', tagClass);
					spanTag.text(tagTxt);
					vacApplyMap[vaapCode]['vaapFileCnt'] = 1;
					console.log('vacApplyMap : ',vacApplyMap);
				},
	 			error : function(errorResp) {
					console.log(errorResp.status);
				}
	 		});
	 	});
	 	
	 	/* 증명 자료 제출 */
	 	
		/* 휴가 취소 */
 		
	 	let vacCcBtn = modal.find('#vacCcBtn').on('click', function(){
	 		let vaapCode = modal.data('vaapCode');
	 		console.log(vaapCode);
	 		$.ajax({
				url : "${cPath}/myVacation/vacCancel.do",
				method : "get",
				data : {vaapCode : vaapCode},
				dataType : "json",
				success : function(resp) {
					if(resp.status == 'fail') {
						toastr.error('휴가 취소가 실패했습니다.')
						modal.modal('hide');
						return false;
					} 
					if(resp.status == 'success') toastr.success('휴가 취소가 성공했습니다.');
					plannedVacList.find("#"+vaapCode).remove();
					plannedVacCntTag.text(plannedVacCntTag.text()-1);
					let vacApplyCard = $("#"+vacApplyMap[vaapCode]['vcCode']);
					if(!vacApplyCard.data('vcGmtd').match('신청시')){
						let vpDays = vacApplyCard.data('vpDays');
						if(vacApplyCard.data('vcUseunit') == '일') vpDays = parseInt(vpDays) + vacApplyMap[vaapCode]['vaapDays'];
						else vpDays = parseFloat(vpDays) + vacApplyMap[vaapCode]['vaapDays'];
						vacApplyCard.data('vpDays', vpDays);
						vacApplyCard.find('#vpDays').html('<span class="badge badge-dot bg-success me-1"> </span>'+vpDays+'일');
					}
					delete vacApplyMap[vaapCode];
					console.log(vacApplyMap);
					modal.modal('hide');
				},
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			});
	 	});
	 	
	 	/* 휴가 취소 */
		
	 	$(document).on('click', '.appliedVac', function(){
	 		let trTag = $(this);
	 		let id = trTag.attr('id');
	 		modal.data('vaapCode', id);
	 		let vaapDate = new Date(vacApplyMap[id]['vaapDate']);
	 		let formattedVaapDate = createFormattedDate(vaapDate);
	 		modal.find('#appliedVacApDateModal').text('신청일 : '+formattedVaapDate);
	 		modal.find('#appliedVacNmModal').text(trTag.find('#appliedVacNm').text());
	 		modal.find('#appliedVacPeriodModal').text(trTag.find('#appliedVacPeriod').text());
	 		modal.find('#appliedVacDaysModal').html(trTag.find('#appliedVacDays').html());
	 		let tdTag = trTag.find('#appliedVacCertSt');
	 		modal.find('#appliedVacCertStModal').html(tdTag.html());
	 		if(tdTag.children().text().match('필요')) modal.find('#vaapFileSubmit').removeClass("d-none");
	 		else modal.find('#vaapFileSubmit').addClass("d-none");
	 		modal.find('#appliedVacApStModal').html(trTag.find('#appliedVacApSt').html());
	 		modal.find('#appliedVacMsgModal').text(vacApplyMap[id]['vaapRsn']);
	 		let table = trTag.parent();
	 		if(table.attr('id') == 'usedVacList') vacCcBtn.hide();
	 		else vacCcBtn.show();
	 	});
		
	 	let plannedVacCnt = 0;
	 	$.each(vacApplyMap, function(key, obj){
	 		let startDate = new Date(obj['startDay']['date']);
	 		let formalNow = createFormalDate(now);
	 		let formalStartDate = createFormalDate(startDate);
	 		if(formalNow == formalStartDate || now < startDate){
	 			let trTag = createTrTag(startDate, key, obj);
			 	plannedVacCnt = plannedVacCnt + 1;
			 	plannedVacList.append(trTag);
	 		}
	 	});
	 	plannedVacCntTag.text(plannedVacCnt);
	 	
	 	/* 예정 휴가 */
	 	
	 	/* 사용 기록 */
	 	
	 	let datePicker = $("#datepicker").on('change', function(){
	 		usedVacList.empty();
	 		let usedVacCnt = 0;	
	 		$.each(vacApplyMap, function(key, obj){
	 			let startDate = new Date(obj['startDay']['date']);
	 			if(startDate < now && startDate.getFullYear() == datePicker.val() && obj['vaapApSt'] == '승인')
	 			{
	 				let trTag = createTrTag(startDate, key, obj);
	 				usedVacCnt = usedVacCnt + 1;
	 				usedVacList.append(trTag);
	 			}
	 		});
	 		usedVacList.prev().find('#usedVacCnt').text(usedVacCnt);
	 	});
	 	
	 	datePicker.datepicker({
	 		format : "yyyy",
	 	    viewMode : "years", 
	 	    minViewMode : "years",
	 	    autoclose : true
	 	});  
	 	
	 	datePicker.datepicker('setDate', 'today');
	 	
	 	$(document).on('click', '#prevYearBtn, #nextYearBtn', function(){
	 		let num = datePicker.datepicker('getDate').getFullYear();	
	 		let btn = $(this);
	 		if(btn.attr('id') == 'prevYearBtn') num--;
	 		else num++;
	 		datePicker.datepicker('setDate', num+'Y');
	 	});
	 	
	 	/* 사용 기록 */
	
	});
	
</script>

<div class="">
	
	<div class="container-lg container-p-y">
		<header>
			<h5 class="fw-semibold">휴가 종류</h5>
		</header>
		<div class="collapse" id="collapse">
			<div id="vacListContainer" class="row">
				<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
				<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="nowDate"/>
				<c:set var="vacPosnVoList" value="${map['vacPosnVoList']}"></c:set>
				<c:set var="vacApplyVoList" value="${map['vacApplyVoList']}"></c:set>
			  	<c:forEach items="${vacPosnVoList}" var="vacPosnVo" varStatus="vs">
			  		<c:set var="vcNm" value="${vacPosnVo['vacVo']['vcNm']}"/>
		 			<c:if test="${fn:contains(vcNm, '연차')}">
		 				<c:set var="vcNm" value="연차"/>
		 			</c:if>
				 	<c:set var="vpDays" value="${vacPosnVo['vpDays']}"/>
			  		<c:if test="${vacPosnVo['vacVo']['vcUseunit'] eq '일'}">
		 				<fmt:parseNumber var="vpDays" value="${vpDays}" integerOnly="true"/>
		 			</c:if>
				 	<c:forEach items="${vacApplyVoList}" var="vacApplyVo" varStatus="vs">
				 		<c:if test="${!fn:contains(vacPosnVo['vacVo']['vcGmtd'], '신청시') 
				 					&& vacPosnVo['vcCode'] == vacApplyVo['vcCode'] 
				 					&& vacApplyVo['vaapApSt'] eq '대기' 
				 					&& vacApplyVo['vaapCcSt'] eq 'N'}"
				 		>
				 			<fmt:parseDate var="vsEachDate" value="${vacApplyVo['vacSchVoList'][0]['vsEachDate']}" pattern="yyyy-MM-dd"/>
				 			<fmt:formatDate value="${vsEachDate}" pattern="yyyy-MM-dd" var="startDate"/>
				 			<c:if test="${nowDate == startDate or nowDate < startDate}">
				 				<c:set var="vpDays" value="${vpDays - vacApplyVo['vaapDays']}"/>
				 			</c:if>
				 		</c:if>
				 	</c:forEach>
					<div class="card border border-secondary col-md-2 m-2 cursor-pointer vacation" id="${vacPosnVo['vacVo']['vcCode']}" data-bs-toggle="offcanvas" data-bs-target="#offcanvasEnd"  
							data-vp-days="${vpDays}"
							data-vclf-code="${vacPosnVo['vacVo']['vclfCode']}"
							data-vc-nm="${vcNm}"
							data-vc-info="${vacPosnVo['vacVo']['vcInfo']}"
							data-vc-gmtd="${vacPosnVo['vacVo']['vcGmtd']}"
							data-vc-useunit="${vacPosnVo['vacVo']['vcUseunit']}"
							data-vc-wpay="${vacPosnVo['vacVo']['vcWpay']}"
							data-vc-cert="${vacPosnVo['vacVo']['vcCert']}"
					>
						 <div class="card-body fw-semibold p-0 py-2">
						 	<P class="card-text">
						 		<span class="badge badge-dot bg-primary me-1">
						 		</span>
						 		${vcNm}
						 	</P>
						    <p class="card-text" id="vpDays">
						    	<span class="badge badge-dot bg-success me-1">
						 		</span>
						    	${vpDays}일
						    </p>
						    <p class="card-text">
						    	<span class="badge badge-dot bg-info me-1">
						 		</span>
						    	${vacPosnVo['vacVo']['vcGmtd']}
						    </p>
					  	</div>
					</div>
			  	</c:forEach>
			</div>
		</div>
		<div class="divider">
			<div class="divider-text">
			  <button id="collapseBtn" class="btn rounded-pill btn-outline-dark btn-sm" type="button" data-bs-toggle="collapse" data-bs-target="#collapse" aria-expanded="false" aria-controls="collapse"><i class="bx bx-chevron-down"></i>열기</button>
			</div>
		</div>
	</div>
	
	<c:forEach items="${vacApplyVoList}" var="vacApplyVo" varStatus="vs">
		<c:if test="${vacApplyVo['vaapApSt'] ne '반려' && vacApplyVo['vaapCcSt'] eq 'N'}"> <!-- 예정 휴가 사용 기록 -->
			<div class="d-none vacApply" id="${vacApplyVo['vaapCode']}" 
					data-vc-code="${vacApplyVo['vcCode']}"
					data-vc-nm="${vacApplyVo['vacVo']['vcNm']}"
					data-vc-useunit="${vacApplyVo['vacVo']['vcUseunit']}"
					data-vc-cert="${vacApplyVo['vacVo']['vcCert']}"
					data-vaap-date="${vacApplyVo['vaapDate']}"
					data-vaap-days="${vacApplyVo['vaapDays']}"
					data-vaap-rsn="${vacApplyVo['vaapRsn']}"
					data-vaap-ap-st="${vacApplyVo['vaapApSt']}"
					data-vaap-file-cnt="${vacApplyVo['vaapFileCnt']}"
			>
				<c:forEach items="${vacApplyVo['vacSchVoList']}" var="vacSchVo" varStatus="vs">
					<input type="text" value="${vacSchVo['vsEachDate']},${vacSchVo['vsStime']},${vacSchVo['vsEtime']},${vacSchVo['vsUseDays']}" class="eachDay" readonly>
				</c:forEach>
			</div>
		</c:if>
	</c:forEach>
	
	<div class="container-lg container-p-y">
		<header>
			<div class="h-px-30 w-px-150 mx-2 float-start">
				<h5 class="fw-semibold">예정 휴가<span class="text-success fw-semibold mx-2" id="plannedVacCnt"></span></h5>
			</div>
		</header>
	  	<table class="table" id="plannedVacList">
	    </table>
	</div>
	
	<div class="container-lg container-p-y">
		<header>
			<div class="h-px-30 w-px-150 mx-2 float-start">
				<h5 class="fw-semibold">사용 기록<span class="text-success fw-semibold mx-2" id="usedVacCnt"></span></h5>
			</div> 	
			<div class="input-group w-px-250 float-end">
				<input type="text" class="form-control text-center h-px-30" id="datepicker"/>
				<span class="input-group-text h-px-30">년</span>
				<button type="button" class="btn btn-icon btn-outline-primary h-px-30 mx-2" id="prevYearBtn">
				  	<span class="tf-icon bx bx-chevron-left"></span>
				</button>
				<button type="button" class="btn btn-icon btn-outline-primary h-px-30" id="nextYearBtn">
				  	<span class="tf-icon bx bx-chevron-right"></span>
				</button>
			</div>
		</header>	
		<table class="table" id="usedVacList">
	    </table>
	</div>
</div>

<c:set var="deptList" value="${sessionScope['authEmp']['deptList']}"/> <!-- 휴가 결재자 -->
<c:if test="${empty deptList}">
	<c:set var="vaapApEmp" value="199701001"/>
</c:if>
<c:if test="${not empty deptList}">
	<c:forEach items="${deptList}" var="blgDeptVo" varStatus="vs">
			<c:if test="${not empty blgDeptVo['dhno']}">
				<c:set var="vaapApEmp" value="${blgDeptVo['dhno']}"/>
			</c:if>
	</c:forEach>	
	<c:if test="${empty vaapApEmp}">
		<c:set var="vaapApEmp" value="199701001"/>
	</c:if>
</c:if> 

<div id="offcanvasEnd" class="offcanvas offcanvas-end w-px-500" tabindex="-1">
	  <div class="offcanvas-header border-bottom border-secondary sticky-top">
	    <div class="d-flex">
			<div class="spinner-border text-primary me-2" role="status">
			</div>
			<h4 id="offcanvasEndLabel" class="offcanvas-title fw-semibold">
				휴가 신청
			</h4>
		</div>
	    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"></button>
	  </div>
	  <div class="offcanvas-body mx-0 flex-grow-0">
		<section>
			<div class="divider text-start">
			 	<div class="divider-text fw-semibold">
				  	<i class='bx bx-error-circle bx-sm me-1'></i>
				  	휴가 정보
				</div>
			</div>
			<div class="card border border-secondary">
			  <div class="card-body">
			    <h5 id="vacName" class="card-title fw-semibold"></h5>
			    <p id="vacInfo" class="card-text"></p>
			    <span id="badge1" class="badge bg-info"></span>
				<span id="badge2" class="badge bg-success"></span>
				<span id="badge3" class="badge bg-danger">증명자료</span>
			  </div>
			</div>
		</section>
		<section>
			<div class="divider text-start my-3">
			 	<div class="divider-text fw-semibold">
				  	<i class='bx bx-edit-alt bx-sm me-1' ></i>
				  	휴가 일정ㆍ필요 정보 입력
				</div>
			</div>
			<div class="input-group input-group-merge my-3">
				<input type="text" class="form-control text-center" id="daterangepicker"/>
				<span class="input-group-text"><i class="bx bx-chevron-down"></i></span>
			</div>
			<form action="${cPath }/myVacation/vacApply.do" enctype="multipart/form-data" method="post" id="vacApplyForm">
				<div class="input-group input-group-merge my-3">
					<textarea class="form-control" placeholder="휴가 등록 메시지 입력" id="vaapRsn" name="vaapRsn"></textarea>
				</div>
				<input type="hidden" id="vcCode" name="vcCode">
				<input type="hidden" id="vaapDays" name="vaapDays">
				<input type="hidden" id="vaapEmp" name="vaapEmp" value="${authEmp['empNo']}">
				<input type="hidden" id="vaapApEmp" name="vaapApEmp" value="${vaapApEmp}">
			</form>
		</section>
		<section>
			<div class="divider text-start my-3">
			 	<div class="divider-text fw-semibold">
				  	<i class='bx bx-calendar bx-sm me-1'></i>
				  	상세 일정 편집
				</div>
			</div>
			<div class="accordion border rounded" id="eachDayList">
	    	</div>
		</section>
	 </div>
	 <div class="d-flex justify-content-end border-top border-secondary" style="position : sticky; bottom : 0;">
		<button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas">취소</button>
		<button type="submit" class="btn btn-success ms-2" form="vacApplyForm"><i class='bx bx-check me-1'></i>휴가 신청하기</button>
	 </div>  
</div>

<div class="modal fade" id="modal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header border-bottom border-secondary">
				<div class="spinner-border spinner-border text-primary me-2" role="status"></div>
				<div>
					<h5 class="modal-title fw-semibold" id="exampleModalLabel">${authEmp['empNm']}님의 휴가 요청</h5>
					<span id="appliedVacApDateModal"></span>
				</div>
				<button type="button" class="btn-close" data-bs-dismiss="modal">
				</button>
			</div>
			<div id="modalBody" class="modal-body">
				<div class="divider text-start my-3">
				 	<div class="divider-text fw-semibold">
				 		<i class='bx bx-paper-plane bx-sm me-1'></i>
					  	신청 내용
					</div>
				</div>
				<div class="card border">
					<div class="card-body fw-semibold">
						<div class="d-flex">
						    <p class="card-text col-3">· 휴가 종류</p>
						    <p class="card-text col-9" id="appliedVacNmModal"></p>
					    </div>
						<div class="d-flex">
						    <p class="card-text col-3">· 휴가 기간</p>
						    <p class="card-text col-9" id="appliedVacPeriodModal"></p>
					    </div>
						<div class="d-flex">
							<p class="card-text col-3">· 사용 일수</p>
						    <p class="card-text col-9" id="appliedVacDaysModal"></p>
						</div>
						<div class="d-flex">
							<p class="card-text col-3">· 증명 자료</p>
						    <p class="card-text col-9" id="appliedVacCertStModal"></p>
						</div>
						<div class="d-flex mb-3 d-none" id="vaapFileSubmit">
							<input type="file" class="form-control">
							<button type="button" class="btn btn-outline-success ms-2 col-3" id="fileSubmitBtn">제출 하기</button>
						</div>
						<div class="d-flex">
							<p class="card-text col-3">· 승인 상태</p>
							<p class="card-text col-9" id="appliedVacApStModal"></p>
						</div>
						<div class="d-flex">
							<p class="card-text col-3">· 메시지</p>
							<textarea class="form-control overflow-auto w-px-350" id="appliedVacMsgModal" readonly></textarea>
						</div>
  					</div>
				</div>
			</div>
			<div class="modal-footer justify-content-between border-top border-secondary">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-danger" id="vacCcBtn">휴가 취소하기</button>
			</div>
		</div>
	</div>
</div>