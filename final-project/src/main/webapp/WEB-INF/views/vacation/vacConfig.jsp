<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<link rel="stylesheet" href="${cPath}/resources/css/hgk.css"/>

<script>

	$('#menuList').prepend('<li class="nav-item text-nowrap"><a class="nav-link active text-dark" href="javascript:window.history.back();">&lt;</a></li>');
	$('.headerMenu, .headerSubMenu').each(function(){
		if($(this).attr('id')=='menu5') $(this).find('span').addClass('text-dark');
		else $(this).hide();
	});

	$(function(){
		
		/* All */
		
		toastr.options.positionClass = "toast-top-center";
		
		let numberCheck = null;
		let clickedVac = null; 
		
		$(document).on('change', 'input[type=number]', function(){
			let number = $(this);
			let ancestor = number.closest('.numberAncestor');
			let negativeNumberAlert = ancestor.children('#negativeNumberAlert');
			if((number.val() < 0) && (negativeNumberAlert['length'] == 0)){
				number.parent().css({
					'border' : '2px solid red',
					'border-radius' : '0.375rem'
				});
				ancestor.append('<div class="alert alert-danger" role="alert" id="negativeNumberAlert">양의 정수만 입력이 가능합니다.</div>');
				numberCheck = false;
			}
			else if((number.val() >= 0) && (negativeNumberAlert['length'] != 0)){
				number.parent().removeAttr('style');
				negativeNumberAlert.remove();
				numberCheck = true;
			}
		});
		
		/* All */
		
		/* offcanvas */
		
		/* 휴가 추가 */
		
		let periodSelect = $('#periodSelect');
		let vcGmtd = $('#vcGmtd');
		let vcGmtdSelect = $('#vcGmtdSelect').on('change', function(){
			let vcGmtdSelect = $(this);
			if(vcGmtdSelect.val() == '근속시 지급') {
				periodSelect.css('display', 'block');
				$('.periodElement').on('change', function(){
					let number = $('#periodNumber').val();
					let unit = $('#periodUnit').val();
					vcGmtd.val(number+unit+' 근속시 지급');
				});
			}
			else {
				periodSelect.css('display', 'none');	
				vcGmtd.val(vcGmtdSelect.val());
			}
		});
		vcGmtd.val(vcGmtdSelect.val());
		
		$('#vacInsertForm').on('submit', function(){
			event.preventDefault();
			if(numberCheck == false){
				toastr.error('음수는 입력될 수 없습니다.');
				return false;
			};
			let form = $(this);
			form.find('input').each(function(){
				$(this).val($.trim($(this).val()));
			});
			let textarea = form.find('textarea');
			textarea.val($.trim($(textarea).val()));
			let url = this.action;
			let method = this.method;
			let data = form.serialize();
			$.ajax({
				url : url,
				method : method,
				data : data,
				dataType : 'json',
				async : false,
				success : function(resp) {
					let urlCheck = (url.indexOf('vacInsert.do') > 0) ? 'insert' : 'modify';
					switch(urlCheck){
						case 'insert':
							switch(resp.status){
								case 'success':
									toastr.success('휴가 추가에 성공했습니다.');
									let htmlTag = 	`<div class="card border border-secondary col-md-2 m-2 cursor-pointer" id="vacation" data-vc-nm="\${resp.addVac.vcNm}">
				  										<div class="card-body fw-semibold p-0 py-2">
					    									<p class="card-text">
					    										<span class="badge badge-dot bg-primary me-1">
					    										</span>
					    										\${resp.addVac.vcNm}
					    									</p> 
					    									<p class="card-text">
					    										<span class="badge badge-dot bg-success me-1">
					    										</span>
					    										\${resp.addVac.vcGdays}일
					    									</p>
					    									<p class="card-text">
						    									<span class="badge badge-dot bg-info me-1">
						    									</span>
					    										\${resp.addVac.vcGmtd}
					    									</p>
														</div>
													</div>`;
									/* \ : JSP에서 EL과 겹치기 때문에 \을 써준다. 단순히 문자열이라는 것을 JSP에게 알려주고 해석은 자바스크립트가 한다. */
									$('#vacListContainer').append(htmlTag);
								break;
								case 'fail':
									toastr.error('휴가 추가에 실패했습니다.');
								break;
								case 'pkduplicated':
									toastr.error('이미 동일한 휴가가 존재합니다.');
								break;
							}
						break;
						case 'modify':				
							switch(resp.status){
								case 'success':
									/* 여기 수정이 필요하다. */
									toastr.success('휴가 수정에 성공했습니다.');
									clickedVac.data('vcNm', resp.modifiedVac.vcNm);
									clickedVac.find('.card-text').each(function(i, e){
										switch(i){
											case 0:
												e.innerHTML = '<span class="badge badge-dot bg-primary me-1"> </span>'+resp.modifiedVac.vcNm;
												break;
											case 1:
												e.innerHTML = '<span class="badge badge-dot bg-success me-1"> </span>'+resp.modifiedVac.vcGdays+'일';
												break;
											case 2:
												e.innerHTML = '<span class="badge badge-dot bg-info me-1"> </span>'+resp.modifiedVac.vcGmtd;
												break;
										}
									});
								break;
								case 'fail':
									toastr.error('휴가 수정에 실패했습니다.');
								break;
							}
						break;
					}		
					$('#offcanvasEnd').offcanvas('hide');
				},
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			}); 
			return false;
		});
		
		let offcanvas = $('#offcanvasEnd').on('hide.bs.offcanvas', function() {
			offcanvas.children('#vacInsertForm').attr("action", "${cPath }/vacationConfig/vacInsert.do")[0].reset();
			offcanvas.find('#offcanvasEndLabel').text('휴가 추가');
			offcanvas.find('#vacDelBtn').css('display', 'none');
			offcanvas.find('button[type=submit]').text('추가하기');
			offcanvas.find('#periodSelect').css('display', 'none');
			offcanvas.find('input[type=number]').trigger('change');
			numberCheck = null;
		});
		
		/* 휴가 추가 */
		
		/* 휴가 수정 */

		$(document).on('click', '#vacation', function(){
			let form = offcanvas.children('#vacInsertForm');
			form.attr("action", "${cPath }/vacationConfig/vacModify.do");
			form.find('#offcanvasEndLabel').text('휴가 수정');
			form.find('#vacDelBtn').css('display', 'block');
			form.find('button[type=submit]').text('수정하기');
			clickedVac = $(this);
			$.ajax({
				url : '${cPath}/vacationConfig/vacDetail.do',
				method : 'post',
				data : {vcNm : clickedVac.data('vcNm')},
				dataType : 'json',
				success : function(resp) {
					let vacation = resp.vacation;
					form.find('#vcNm').val(vacation.vcNm);
					form.find('#vcInfo').val(vacation.vcInfo);
					form.find('#vcCode').val(vacation.vcCode);
					let respVcGmtd = vacation.vcGmtd;
					if(respVcGmtd.indexOf('근속시') > 0){
						vcGmtdSelect.val('근속시 지급').prop('selectd', true);
						let yearIndex = respVcGmtd.indexOf('년');
						let monthIndex = respVcGmtd.indexOf('개월');
						if(yearIndex > 0){
							$('#periodUnit option:eq(0)').prop('selected', true);
							$('#periodNumber').val(parseInt(respVcGmtd.substring(0, yearIndex)));
						}
						if(monthIndex > 0){
							$('#periodUnit option:eq(1)').prop('selected', true);
							$('#periodNumber').val(parseInt(respVcGmtd.substring(0, monthIndex)));
						}
					}else{
						vcGmtdSelect.val(vacation.vcGmtd);	
					}
					vcGmtdSelect.trigger('change');
					$('.periodElement').trigger('change');
					form.find('#vcGdays').val(vacation.vcGdays);
					form.find('input[name=vcUseunit]').each(function(){
						if($(this).val() == vacation.vcUseunit) $(this).prop('checked', true);
					});
					form.find('input[name=vcWpay]').each(function(){
						if($(this).val() == vacation.vcWpay) $(this).prop('checked', true);
					});
					form.find('input[name=vcGen]').each(function(){
						if($(this).val() == vacation.vcGen) $(this).prop('checked', true);
					});
					form.find('input[name=vcCert]').each(function(){
						if($(this).val() == vacation.vcCert) $(this).prop('checked', true);
					});
					offcanvas.offcanvas('show');
				},
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			});
		});
		
		/* 휴가 수정 */
		
		/* 휴가 삭제 */
		
		$('#vacDelBtn').on('click', function(){
			$.ajax({
				url : '${cPath}/vacationConfig/vacDelete.do',
				method : 'post',
				data : {vcNm : clickedVac.data('vcNm')},
				dataType : 'json',
				async : false,
				success : function(resp) {
					if(resp.status == 'success') toastr.success('휴가 삭제에 성공했습니다.');
					if(resp.status == 'fail') toastr.error('휴가 삭제에 실패했습니다.');
					clickedVac.remove();
					$('#offcanvasEnd').offcanvas('hide');
				},
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			});
		});
		
		/* 휴가 삭제 */
		
		/* offcanvas */
		
		/* modal */
		
		let modal = $('#exampleModal');
		
		/*
		
		modal.on('show.bs.modal', function () {
			new PerfectScrollbar(document.getElementById('vertical-example'), {
				  wheelPropagation: false
			});
		})
		
		*/
		
		$(document).on('change', '#workingYearsSelect', function(){
	   		let workingYearsList = $('#workingYearsList');
	    	let workingYears = $(this).val();
	    	let yearsVacAddGroup = workingYearsList.children('#'+workingYears+'YearsVacAddGroup');
	    	if((workingYears != '선택') && (yearsVacAddGroup['length'] == 0)){
	    		let htmlTag = `<div class="numberAncestor" id="\${workingYears}YearsVacAddGroup">
					    			<div class="d-flex justify-content-between m-3">
					    				<span class="py-1">\${workingYears}년차</span>   			
										<div class="input-group input-group-sm w-50">
										<input class="form-control yearsVacAddInput" type="number" value="0" data-years="\${workingYears}"/>
										<span class="input-group-text">일</span>
									</div>
									<button type="button" class="btn-close btn-sm yearsVacAddGroupDelBtn"></button>
									</div>
								</div>`;
				workingYearsList.append(htmlTag);
	    	};
		});
		
		$(document).on('click', '.yearsVacAddGroupDelBtn', function(){
			$(this).closest('.numberAncestor').remove();
		});
		
		$('#vacAddSaveBtn').on('click', function(){
			if(numberCheck == false){
				toastr.error('음수는 입력될 수 없습니다.');
				return false;
			};
			let count = 0;
			let modalData = [];
			$('.yearsVacAddInput').each(function(i, e){
				count = count + 1;
				modalData.push({
					years : $.trim($(e).data('years')),
					addDays : parseInt($.trim($(e).val()))
				});
			});
			let data = JSON.stringify(modalData);
			$.ajax({
				url : '${cPath}/vacationConfig/annualLeaveVacAddGive.do',
				method : 'post',
				data : data,
				contentType: 'application/json; charset=utf-8',
				dataType : 'json',
				success : function(resp) {
					if(resp.status == 'success') toastr.success('추가 부여 설정에 성공했습니다.');
					if(resp.status == 'fail') toastr.error('추가 부여 설정에 실패했습니다.');
					if(count > 0) $('#annualLeaveVacAddGiveExistence').text('있음');
					else $('#annualLeaveVacAddGiveExistence').text('없음');
				},
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			});
			let workingYearsList = $('#workingYearsList');
			let vacAddExistenceAlert = $('#vacAddExistenceAlert');
			if(workingYearsList.children().length == 0){
				vacAddExistenceAlert.attr('class', 'badge bg-secondary').text('없음');
			}else{
				vacAddExistenceAlert.attr('class', 'badge bg-success').text('있음');
			}
			modal.modal('hide');
			$('#workingYearsSelect option:first').prop('selected', true);
		});
		
		$('#vacAddCancelBtn').on('click', function(){
			modal.modal('hide');
			$('#refreshArea').load(location.href+' #modalBody');
		});
		
		modal.on('hidden.bs.modal', function () {
			numberCheck = null;
		})
		
		/* modal */
		
	});
	
</script>

<div class="container-xl flex-grow-1 container-p-y">
	
	<!-- 연차 정책 시작 -->
	<c:forEach items="${vacList }" var="vacVo" varStatus="vs">
		<c:choose>
			<c:when test="${vacVo['vclfCode'] eq 'A'}">
				<c:set var="everyMonthVac" value="${vacVo}"/>
			</c:when>
			<c:when test="${vacVo['vclfCode'] eq 'B'}">
				<c:set var="annualLeaveVac" value="${vacVo }"/>
				<c:if test="${fn:length(annualLeaveVac['annualVacAddGiveList']) gt 0}">
					<c:set var="annualLeaveVacAddGiveExistence" value="있음"/>
					<c:set var="annualLeaveVacAddGiveExistenceAlertClass" value="bg-success"/>
				</c:if>
				<c:if test="${fn:length(annualLeaveVac['annualVacAddGiveList']) eq 0}">
				    <c:set var="annualLeaveVacAddGiveExistence" value="없음"/>
				    <c:set var="annualLeaveVacAddGiveExistenceAlertClass" value="bg-secondary"/>
				</c:if>
			</c:when>
		</c:choose>
	</c:forEach>
	
	<div class="container-lg container-p-y">
		<header class="d-flex justify-content-between py-2 w-auto">
			<h5 class="fw-semibold">연차 정책</h5> 
			<button id="vacAddBtn" type="button" class="btn border btn-sm w-px-150" data-bs-toggle="modal" data-bs-target="#exampleModal">
				추가 부여 설정
				<span id="vacAddExistenceAlert" class="badge ${annualLeaveVacAddGiveExistenceAlertClass}">
					${annualLeaveVacAddGiveExistence}
				</span>
			</button>
		</header>
		<div class="row border rounded row-cols-4 m-0">
			<div class="card">
			  	<ul class="list-group list-group-flush fw-semibold">
				    <li class="list-group-item">
				    	<span class="text-primary">|</span>
				    	<span class="fs-big">연차 사용 단위</span>
				    </li>
				    <li class="list-group-item">
				    	<span class="badge badge-dot bg-secondary me-1">
				    	</span>
				    	${annualLeaveVac['vcUseunit']}
				    </li>
	  			</ul>
			</div>
			<div class="card">
			  	<ul class="list-group list-group-flush fw-semibold">
				    <li class="list-group-item">
				    	<span class="text-success">|</span>
				    	<span class="fs-big">연차 부여 정보</span>
				    </li>
				    <li class="list-group-item">
				    	<span class="badge badge-dot bg-secondary me-1">
				    	</span>
				    	${annualLeaveVac['vcGdays']}일
				    </li>
				    <li class="list-group-item">
				    	<span class="badge badge-dot bg-secondary me-1">
				    	</span>
				    	${annualLeaveVac['vcGmtd']}
				    </li>
	  			</ul>
			</div>
			<div class="card">
			  	<ul class="list-group list-group-flush fw-semibold">
				    <li class="list-group-item">
				    	<span class="text-info">|</span>
				    	<span class="fs-big">월차 부여 정보</span>	
				    </li>
				    <li class="list-group-item">
				  		<span class="badge badge-dot bg-secondary me-1">
				    	</span>  
				    	${everyMonthVac['vcGdays']}일
				    </li>
				    <li class="list-group-item">
				    	<span class="badge badge-dot bg-secondary me-1">
				    	</span>
				    	${everyMonthVac['vcGmtd']}
				    </li>
	  			</ul>
			</div>
			<div class="card">
			  	<ul class="list-group list-group-flush fw-semibold">
				    <li class="list-group-item">
				    	<span class="text-warning">|</span>
				    	<span class="fs-big">연차 추가 부여</span>
				    </li>
				    <li id="annualLeaveVacAddGiveExistence" class="list-group-item">
				    	<span class="badge badge-dot bg-secondary me-1">
				    	</span>
				    	${annualLeaveVacAddGiveExistence}
				    </li>
	  			</ul>
			</div>
		</div>
	</div>
	<!-- 연차 정책 끝 -->
	
	<!-- 휴가 종류 시작 -->	
	<div class="container-lg container-p-y">
		<header class="d-flex justify-content-between py-2 w-auto">
			<h5 class="fw-semibold">휴가 종류</h5>
			<button type="button" class="btn border" data-bs-toggle="offcanvas" data-bs-target="#offcanvasEnd">
		  		<i class='bx bx-plus bx-sm text-success' ></i>
				휴가 추가
			</button>
		</header>
		 <div id="vacListContainer" class="row">
		 	<c:forEach items="${vacList }" var="vacVo" varStatus="vs">
		 		<c:if test="${vacVo['vclfCode'] ne 'A' && vacVo['vclfCode'] ne 'B'}">
			 		<div class="card border border-secondary col-md-2 m-2 cursor-pointer" id="vacation" data-vc-nm="${vacVo['vcNm']}">
					  	<div class="card-body fw-semibold p-0 py-2">
					  		<P class="card-text">
					  			<span class="badge badge-dot bg-primary me-1">
					  			</span>
					  			${vacVo['vcNm']}
					  		</P>
						    <p class="card-text">
						    	<span class="badge badge-dot bg-success me-1">
					  			</span>
						    	${vacVo['vcGdays'] }일
						    </p>
						    <p class="card-text">
						    	<span class="badge badge-dot bg-info me-1">
					  			</span>
						    	${vacVo['vcGmtd'] }
						    </p>
				  		</div>
					</div>
				</c:if>
		 	</c:forEach>
		</div>
	</div>
	<!-- 휴가 종류 끝 -->
	
</div>

<div id="offcanvasEnd" class="offcanvas offcanvas-end w-px-500" tabindex="-1">
	<form:form action="${cPath }/vacationConfig/vacInsert.do" method="post" id="vacInsertForm">
	  <div class="offcanvas-header border-bottom border-secondary sticky-top">
	  		<div class="d-flex">
			    <div class="spinner-border text-primary me-2" role="status">
				</div>
			    <h4 id="offcanvasEndLabel" class="offcanvas-title fw-semibold">
			    	휴가 추가
			    </h4>
		    </div>
	    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"></button>
	  </div>
	  <div class="offcanvas-body mx-0 flex-grow-0">
			<section>
				<div class="divider text-start">
				 	<div class="divider-text fw-semibold">
					  	<i class='bx bx-edit-alt'></i>
					  	기본 설정
					</div>
				</div>
				<input type="text" class="form-control my-3" id="vcNm" name="vcNm" placeholder="휴가 이름 입력" required/>
				<textarea class="form-control my-3" id="vcInfo" name="vcInfo" rows="3" placeholder="휴가에 대한 설명을 입력하면 구성원이 확인할 수 있습니다." required></textarea>
			</section>
			<section>
				<div class="divider text-start">
				 	<div class="divider-text fw-semibold">
					  	<i class='bx bx-cog'></i>
					  	상세 설정
					</div>
				</div>
				<div class="card border">
				  	<div class="card-body">
				  		<div class="d-flex justify-content-between my-sm-3">
				  			<span class="py-1 fw-semibold">부여 방법</span>
				  			<select id="vcGmtdSelect" class="form-select form-select-sm w-75">
							    <option value="매월 지급">매월 지급</option>
							    <option value="매년 지급">매년 지급</option>
							    <option value="근속시 지급">근속시 지급</option>
							    <option value="신청시 지급">신청시 지급</option>
							   	<option value="관리자가 직접 지급">관리자가 직접 지급</option>
		  					</select>
		  					<input type="hidden" id="vcGmtd" name="vcGmtd">
						</div>
						<div id="periodSelect" class="numberAncestor" style="display : none;">
							<div class="d-flex justify-content-between my-sm-3">
					 			<span class="py-1 fw-semibold">근속 수</span>
					 			<div class="input-group input-group-sm w-75">
								    <input id="periodNumber" class="form-control w-50 periodElement" type="number" value="0"/>
								    <select id="periodUnit" class="form-select periodElement">
									    <option value="년">년</option>
									    <option value="개월">개월</option>
			  						</select>
								</div>
					  		</div>
				  		</div>
				  		<div class="numberAncestor">
					  		<div class="d-flex justify-content-between my-sm-3">
					  			<span class="py-1 fw-semibold">부여 일수</span>
					  			<div class="input-group input-group-sm w-75">
								    <input class="form-control" type="number" id="vcGdays" name="vcGdays" value="0"/>
								    <span class="input-group-text">일</span>
								</div>
							</div>
						</div>
				  		<div class="d-flex justify-content-between my-sm-3">
				  			<span class="py-1 fw-semibold">사용 단위</span>
				  			<div class="btn-group w-75" role="group">
							  <input type="radio" class="btn-check" name="vcUseunit" id="vcUseUnit1" value="일" autocomplete="off" checked>
							  <label class="btn btn-outline-dark btn-sm" for="vcUseUnit1">일</label>
							  <input type="radio" class="btn-check" name="vcUseunit" id="vcUseUnit2" value="반차" autocomplete="off">
							  <label class="btn btn-outline-dark btn-sm" for="vcUseUnit2">반차</label>
							</div>
						</div>
				  		<div class="d-flex justify-content-between my-sm-3">
				  			<span class="py-1 fw-semibold">급여 지급</span>
				  			<div class="btn-group w-75" role="group">
							  <input type="radio" class="btn-check" name="vcWpay" id="vcWpay1" value="Y" autocomplete="off" checked>
							  <label class="btn btn-outline-dark btn-sm" for="vcWpay1">유급</label>
							  <input type="radio" class="btn-check" name="vcWpay" id="vcWpay2" value="N" autocomplete="off">
							  <label class="btn btn-outline-dark btn-sm" for="vcWpay2">무급</label>
							</div>
						</div>
				  		<div class="d-flex justify-content-between my-sm-3">
				  			<span class="py-1 fw-semibold">적용 성별</span>
				  			<div class="btn-group w-75" role="group">
							  <input type="radio" class="btn-check" name="vcGen" id="vcGen1" value="모두" autocomplete="off" checked>
							  <label class="btn btn-outline-dark btn-sm" for="vcGen1">모두</label>
							  <input type="radio" class="btn-check" name="vcGen" id="vcGen2" value="남자" autocomplete="off">
							  <label class="btn btn-outline-dark btn-sm" for="vcGen2">남자</label>
							  <input type="radio" class="btn-check" name="vcGen" id="vcGen3" value="여자" autocomplete="off">
							  <label class="btn btn-outline-dark btn-sm" for="vcGen3">여자</label>
							</div>
						</div>
				  		<div class="d-flex justify-content-between my-sm-3">
				  			<span class="py-1 fw-semibold">증명 자료</span>
				  			<div class="btn-group w-75" role="group">
							  <input type="radio" class="btn-check" name="vcCert" id="vcCert1" value="N" autocomplete="off" checked>
							  <label class="btn btn-outline-dark btn-sm" for="vcCert1">없음</label>
							  <input type="radio" class="btn-check" name="vcCert" id="vcCert2" value="Y" autocomplete="off">
							  <label class="btn btn-outline-dark btn-sm" for="vcCert2">제출</label>
							</div>
						</div>
					</div>
				</div>
			</section>
	  </div>
	  <div class="d-flex justify-content-between border-top border-secondary p-2">
	 	<button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas">취소</button>
	 	<div class="d-flex justify-content-between">
		  	<button type="button" class="btn btn-danger" id="vacDelBtn" style="display : none;">삭제하기</button>
			<button type="submit" class="btn btn-success ms-2"><i class='bx bx-check me-1'></i>추가하기</button>
	  	</div>
	  </div>
	  <input type="hidden" id="vcCode" name="vcCode">
	</form:form>
</div>
	
<!-- Modal -->
<div id="modalRefreshArea">
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header border-bottom border-secondary">
				<div class="spinner-border text-primary me-2 mb-1" role="status"></div>
				<h4 class="modal-title fw-semibold" id="exampleModalLabel">추가 부여 설정</h4>
		        <button type="button" class="btn-close" data-bs-dismiss="modal">
		        </button>
	      </div>
	      <div id="refreshArea">
		      <div id="modalBody" class="modal-body">
		        <!-- <div id="perfectScrollbar" class="my-sm-3"> -->
				 	<div class="card overflow-hidden border" style="height: 500px;">
					  <div class="card-body overflow-auto p-0" id="vertical-example">
					  	<div class="d-flex justify-content-between border rounded p-2 m-2">
					  		<span class="fw-semibold mt-1">년차 선택</span>
					  		<div class="input-group input-group-sm w-50">
					    		<select class="form-select periodElement" id="workingYearsSelect">
								    <option>선택</option>
								    <c:forEach var="i" begin="1" end="40">
										<option value="${i}">${i}년차</option>
									</c:forEach>
								</select>
					    		<span class="input-group-text">년차</span>
							</div>
					  	</div>
					    <div class="d-flex justify-content-between border-bottom m-3">
					    	<span class="fw-semibold mb-sm-2">부여 시점</span>
					    	<span class="fw-semibold mb-sm-2">추가 일수</span>
					    	<span class="fw-semibold mb-sm-2">추가 삭제</span>
					    </div>
					    <div id="workingYearsList">
					    	<c:forEach items="${annualLeaveVac['annualVacAddGiveList'] }" var="yearsAddDaysMap" varStatus="vs">
								<div class="numberAncestor" id="${yearsAddDaysMap['years'] }YearsVacAddGroup">
		    						<div class="d-flex justify-content-between m-3">
		    							<span class="py-1">${yearsAddDaysMap['years'] }년차</span>   			
										<div class="input-group input-group-sm w-50">
											<input class="form-control yearsVacAddInput" type="number" value="${yearsAddDaysMap['addDays']}" data-years="${yearsAddDaysMap['years']}"/>
											<span class="input-group-text">일</span>
										</div>
										<button type="button" class="btn-close btn-sm yearsVacAddGroupDelBtn"></button>
									</div>
								</div>
				 			</c:forEach>
					    </div>
					  </div>
					</div>
				<!-- </div> -->
		      </div>
	      </div>
	      <div class="modal-footer border-top border-secondary">
	        <button type="button" class="btn border" id="vacAddCancelBtn">취소</button>
			<button type="button" class="btn btn-success ms-2" id="vacAddSaveBtn">저장하기</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>