<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<script>
	
	$('.headerMenu, .headerSubMenu').each(function(){
		switch($(this).attr('id')){
			case 'menu1':
				break;
			case 'menu2':
				$(this).find('span').addClass('text-dark');
				break;
			case 'subMenu3':
				break;
			case 'subMenu4':
				$(this).find('span').addClass('text-dark');
				break;
			default:
				$(this).hide();
		}
	});
	
	toastr.options.positionClass = "toast-top-center";
	
	let empNo = ${authEmp['empNo']};
	
	let dayNames = ["일", "월", "화", "수", "목", "금", "토"];
	
	function createFormattedDate(date){
		return [date.getFullYear(), date.getMonth()+1, date.getDate(), ['(', dayNames[date.getDay()], ')'].join('')].join('. ');
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
 		return ['<td id="vaapApSt">', '<span class="badge ', vacApStClass, '">', vacApStTxt, '</span></td>'].join('');
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
 		return ['<td id="vaapCertSt">', '<span class="badge ', vacCertStClass, '">', vacCertStTxt, '</span></td>'].join('');
	}
	
	function makeTrTag(obj){
		let trTag = ['<tr data-bs-toggle="modal" data-bs-target="#modal" class="appliedVac" data-vaap-date="', obj['vaapDate'], '" data-vaap-rsn="', obj['vaapRsn'], '" data-vaap-ap-emp="', obj['vaapApEmp'], '" id="', obj['vaapCode'], '">'];
		trTag.push(['<td id="empNm">', obj['empVo']['empNm'], '</td>'].join('')); // 이름
		trTag.push(['<td id="vaapEmp">', obj['vaapEmp'], '</td>'].join('')); // 사번
		let vacSchVoList = obj['vacSchVoList'];
		let startDate = new Date(vacSchVoList[0]['vsEachDate']);
		let endDate = new Date(vacSchVoList[vacSchVoList.length-1]['vsEachDate']);
		trTag.push(['<td id="vaapPeriod">', [createFormattedDate(startDate), ' - ', createFormattedDate(endDate)].join(''), '</td>'].join('')); // 기간
		let vcNm = obj['vacVo']['vcNm'];
		if(vcNm.match('연차')) vcNm = '연차';
		trTag.push(['<td id="vcNm">', vcNm, '</td>'].join('')); // 항목
		trTag.push(['<td id="vaapDays"><span class="badge bg-label-primary">', obj['vaapDays'], '일</span></td>'].join('')); // 사용 시간
 		trTag.push(createCertSpanTag(obj['vacVo']['vcCert'], obj['vaapFileCnt'])); // 증명 자료
		trTag.push(['<td id="vaapCcSt">', obj['vaapCcSt'], '</td>'].join('')); // 취소
   		trTag.push(createApSpanTag(obj['vaapApSt'])); // 승인
		trTag.push('</tr>');
		return trTag.join('');
	}
	
	$(function(){	
			
			let now = new Date();
		
			let tbody = $('tbody');
			
			let modal = $('#modal');
			
			let monthInput = $('#monthInput').on('change', function(){
				let value = monthInput.val();
				let point = value.indexOf('-');
				let year = parseInt(value.slice(0, point));
				let month = parseInt(value.slice(point+1));
				console.log(year, month);
				if(!Number.isNaN(year) && !Number.isNaN(month)){
					tbody.empty();
					$.ajax({
						url : "${cPath}/memberVacation/vacApplySchedule.do",
						method : "post",
						data : {
							year : year,
							month : month
						},
						dataType : 'json',
						success : function(resp) {
							console.log(resp['vacApplyVoList']);
							if(resp['status'] == 'success') {
								resp['vacApplyVoList'].forEach(function(e, i){
									let trTag = makeTrTag(e);
									tbody.append(trTag);
								});	
							};
						},
						error : function(errorResp) {
							console.log(errorResp.status);
						}
					}); 	
				}
			});
		
		$(document).on('click', '.appliedVac', function(){
			let trTag = $(this);
			let id = trTag.attr('id');
			modal.data('vaapCode', id);
			modal.find('#vacApplyEmpNm').text([trTag.find('#empNm').text(), '님의 휴가 요청'].join(''));
			modal.find('#vacApplyDate').text(['신청일 : ', createFormattedDate(new Date(trTag.data('vaapDate')))].join(''));
			modal.find('#vacName').text(trTag.find('#vcNm').text());
			modal.find('#vacPeriod').text(trTag.find('#vaapPeriod').text());
			modal.find('#vacApplyDays').html(trTag.find('#vaapDays').html());
			modal.find('#vacCertSt').html(trTag.find('#vaapCertSt').html());
			modal.find('#vacCcSt').text(trTag.find('#vaapCcSt').text());
			let vaapApStTag = trTag.find('#vaapApSt');
			modal.find('#vacApSt').html(vaapApStTag.html());
			modal.find('#vacMsg').text(trTag.data('vaapRsn'));
			if
			(
				empNo == trTag.data('vaapApEmp')
				&& trTag.find('#vaapCcSt').text() == 'N' 
				&& vaapApStTag.children().text().match('미승인')
			) 
			modal.find('#actionBtns').show();
			else modal.find('#actionBtns').hide();
		});
		
		modal.find('.actionBtns').on('click', function(){
			let btnId = $(this).attr('id');
			let vaapCode = modal.data('vaapCode');
			let behavior = '';
			if(btnId == 'vacRejBtn') behavior = 'reject';
			if(btnId == 'vacApBtn') behavior = 'approve';
			$.ajax({
				url : "${cPath}/memberVacation/vacApplyManage.do",
				method : "post",
				data : {
					vaapCode : vaapCode,
					behavior : behavior
				},
				dataType : 'json',
				success : function(resp) {
					let spanTag = tbody.find(['#', vaapCode].join('')).find('#vaapApSt').children();
					if(resp.status == 'success' && behavior == 'reject'){
						spanTag.removeClass('bg-label-secondary');
						spanTag.addClass('bg-label-warning');
						spanTag.text('반려');
						toastr.success('휴가 반려가 성공했습니다.');
					} 
					if(resp.status == 'success' && behavior == 'approve') {
						spanTag.removeClass('bg-label-secondary');
						spanTag.addClass('bg-label-success');
						spanTag.text('승인');
						toastr.success('휴가 승인이 성공했습니다.');
					}
					modal.modal('hide');
				},
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			});
		});
		
		monthInput.val([now.getFullYear(), now.getMonth()+1].join('-')).trigger('change');
		
	});
	
</script>

<div class="container-xl flex-grow-1 container-p-y">
	<div class="container-lg container-p-y">
		<div class="d-flex justify-content-end">
      		<div class="input-group input-group-lg w-px-300 mb-3">
      			<span class="input-group-text">휴가 신청월</span>
      			<input class="form-control" type="month" id="monthInput"/>
			</div>
		</div>
		<div class="table-responsive">
	        <table class="table table-bordered table-hover fw-semibold text-center m-0">
	          <thead>
	            <tr>  
	              <th>이름</th>
	              <th>사번</th>
	              <th>기간</th>   
	              <th>항목</th>   
	              <th>사용 시간</th>   
	              <th>증명자료</th>   
	              <th>취소</th>
	              <th>승인</th>   
	            </tr>
	          </thead>
	          <tbody class="cursor-pointer">
	          </tbody>
	        </table>
	   	</div>
   	</div>
</div>

<div class="modal fade" id="modal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header border-bottom border-secondary">
				<div class="spinner-border spinner-border text-primary me-2" role="status"></div>
				<div>
					<h5 class="modal-title fw-semibold" id="vacApplyEmpNm"></h5>
					<span id="vacApplyDate"></span>
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
				</div>
			</div>
			<div class="modal-footer justify-content-between border-top border-secondary">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				<div id="actionBtns">
					<button type="button" class="btn btn-warning actionBtns" id="vacRejBtn">반려하기</button>
					<button type="button" class="btn btn-success actionBtns" id="vacApBtn">승인하기</button>
				</div>
			</div>
		</div>
	</div>
</div>