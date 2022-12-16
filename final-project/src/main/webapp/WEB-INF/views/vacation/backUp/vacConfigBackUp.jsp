<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	$('#menuList').prepend('<li class="nav-item text-nowrap"><a class="nav-link active" href="javascript:window.history.back();">&lt;</a></li>');
 	$('#menu1').hide();
 	$('#menu2').hide();
 	$('#menu3').hide();
	$('#menu4').hide();
 	$('#subMenu1').hide();
 	$('#subMenu2').hide();
 	$('#subMenu3').hide();
 	$('#subMenu4').hide();
 	$('#subMenu5').hide();
</script>

<style>
	button:hover{
		background-color : #f7f7f7;
	}
</style>

<div class="container-xl flex-grow-1 container-p-y">
	
	<!-- 연차 정책 시작 -->
	<div class="container-lg container-p-y">
		<header class="d-flex justify-content-between py-2 w-auto">
			<h5 class="fw-semibold">연차 정책</h5> 
			<!--  
			<button type="button" class="btn border" data-bs-toggle="offcanvas" data-bs-target="#offcanvasEnd1">
		  		연차 정책 설정
		  		<i class='bx bxs-chevron-right bx-sm'></i>
			</button>
			-->
		</header>
		<div class="row border rounded row-cols-4 m-0">
			<div class="card">
			  	<ul class="list-group list-group-flush fw-semibold">
				    <li class="list-group-item border-bottom-0">
				    	<span class="text-primary">|</span>
				    	<span>연차 사용 단위</span>
				    </li>
				    <li class="list-group-item border-bottom-0 fs-big">반차 단위 사용</li>
	  			</ul>
			</div>
			<div class="card">
			  	<ul class="list-group list-group-flush fw-semibold">
				    <li class="list-group-item border-bottom-0">
				    	<span class="text-success">|</span>
				    	<span>연차 부여 기준</span>
				    </li>
				    <li class="list-group-item border-bottom-0 fs-big">1년 만근시 15일 부여</li>
	  			</ul>
			</div>
			<div class="card">
			  	<ul class="list-group list-group-flush fw-semibold">
				    <li class="list-group-item border-bottom-0">
				    	<span class="text-info">|</span>
				    	<span>월차 부여 기준</span>	
				    </li>
				    <li class="list-group-item border-bottom-0 fs-big">매월 개근시 1일 부여</li>
	  			</ul>
			</div>
			<div class="card">
			  	<ul class="list-group list-group-flush fw-semibold">
				    <li class="list-group-item border-bottom-0">
				    	<span class="text-warning">|</span>
				    	<span>연차 추가 부여</span>
				    </li>
				    <li class="list-group-item border-bottom-0 fs-big">없음</li>
	  			</ul>
			</div>
		</div>
	</div>
	<!-- 연차 정책 끝 -->
	
	<!-- 휴가 종류 시작 -->	
	<div class="container-lg container-p-y">
		<header class="d-flex justify-content-between py-2 w-auto">
			<h5 class="fw-semibold">휴가 종류</h5>
			<button type="button" class="btn border" data-bs-toggle="offcanvas" data-bs-target="#offcanvasEnd2">
		  		<i class='bx bx-plus bx-sm text-success' ></i>
				휴가 추가
			</button>
		</header>
		 <div class="row">
		    <div class="card border border-secondary col-md-2 m-2 cursor-pointer">
			  	<div class="card-header"><i class='bx bxs-hotel bx-sm bx-border-circle'></i></div>
			  	<div class="card-body">
				    <h5 class="card-title">연차</h5>
				    <p class="card-text">15일</p>
		  		</div>
			</div>
			<div class="card border border-secondary col-md-2 m-2 cursor-pointer">
			  	<div class="card-header"><i class='bx bx-plus-medical bx-sm bx-border-circle'></i></div>
			  	<div class="card-body">
				    <h5 class="card-title">보건</h5>
				    <p class="card-text">매월 1일 지급</p>
		  		</div>
			</div>
		</div>
	</div>
	<!-- 휴가 종류 끝 -->
	
</div>

<!--  
<div id="offcanvasEnd1" class="offcanvas offcanvas-end w-px-500" tabindex="-1" aria-labelledby="offcanvasEndLabel">
  <div class="offcanvas-header border-bottom border-secondary sticky-top">
    <h5 id="offcanvasEndLabel" class="offcanvas-title fw-semibold">
    	연차 정책 설정
    </h5>
    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body mx-0 flex-grow-0">
	<section>
		<div class="divider text-start">
		 	<div class="divider-text fw-semibold">
			  	<i class='bx bx-cog'></i>
			  	연차 사용 · 부여 정책
			</div>
		</div>
		<div class="card border">
		  <div class="card-body">
		  	<div class="d-flex justify-content-between my-sm-3">
		  		<span class="py-1 fw-semibold">연차 사용 단위</span>
		  		<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off">
				  <label class="btn btn-outline-dark btn-sm" for="btnradio1">일</label>
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off">
				  <label class="btn btn-outline-dark btn-sm" for="btnradio2">반차</label>
				</div>
		  	</div>
		  	<div class="d-flex justify-content-between my-sm-3">
		  		<span class="py-1 fw-semibold">
			  		입사자 월차
			  		<i class='bx bx-question-mark bx-xs border rounded' 
			  		data-bs-toggle="tooltip" 
			  		data-bs-offset="0,4" 
			  		data-bs-placement="top" 
			  		title="법적으로 입사자에게 개근시 매월 1일 · 최대 11일을 부여해야 합니다."></i>
		  		</span>
		  		<select id="defaultSelect" class="form-select form-select-sm w-50">
				    <option>매월 개근시 1일 부여</option>
				    <option>입사일에 11일 선부여</option>
  				</select>
		  	</div>
		  	<div class="d-flex justify-content-between my-sm-3">
		  		<span class="py-1 fw-semibold">
			  		입사자 1년 만근 연차
			  		<i class='bx bx-question-mark bx-xs border rounded' 
			  		data-bs-toggle="tooltip" 
			  		data-bs-offset="0,4" 
			  		data-bs-placement="top" 
			  		title="법적으로 1년 만근시 연차 15일을 부여해야 합니다."></i>
		  		</span>
		  		<select id="defaultSelect1" class="form-select form-select-sm w-50">
				    <option>매월 개근시 1일 부여</option>
				    <option>입사일에 11일 선부여</option>
  				</select>
		  	</div>
		  	<div class="d-flex justify-content-between my-sm-3">
		  		<span class="py-1 fw-semibold">연차 추가 부여</span>
		  		<button id="annualVacAddBtn" type="button" class="btn border btn-sm w-px-250">
		  		추가 부여 설정
		  		<span class="badge bg-label-dark">없음</span>
				</button>
		  	</div>
		  	<div id="perfectScrollbar" class="my-sm-3">
			  	<div class="card overflow-hidden border" style="height: 500px;">
					  <div class="card-body p-0" id="vertical-example">
					    <div class="d-flex justify-content-between m-3">
					    	<span class="fw-semibold">부여 시점</span>
					    	<span class="fw-semibold">추가 부여</span>
					    </div>
					    <div class="d-flex justify-content-between m-3">
					    	<span class="py-1">입사일</span>
					    	<div class="input-group input-group-sm w-auto">
					    		<input class="form-control" type="number" value="0" />
					    		<span class="input-group-text">일</span>
					    	</div>
					    </div>
					    <div class="d-flex justify-content-between m-3">
					    	<span class="py-1">2년차</span>
					    	<div class="input-group input-group-sm w-auto">
					    		<input class="form-control" type="number" value="0" />
					    		<span class="input-group-text">일</span>
					    	</div>
					    </div>
					    <div class="d-flex justify-content-between m-3">
					    	<span class="py-1">3년차</span>
					    	<div class="input-group input-group-sm w-auto">
					    		<input class="form-control" type="number" value="0" />
					    		<span class="input-group-text">일</span>
					    	</div>
					    </div>
					    <div class="d-flex justify-content-between m-3">
					    	<span class="py-1">4년차</span>
					    	<div class="input-group input-group-sm w-auto">
					    		<input class="form-control" type="number" value="0" />
					    		<span class="input-group-text">일</span>
					    	</div>
					    </div>
					    <div class="d-flex justify-content-between m-3">
					    	<span class="py-1">5년차</span>
					    	<div class="input-group input-group-sm w-auto">
					    		<input class="form-control" type="number" value="0" />
					    		<span class="input-group-text">일</span>
					    	</div>
					    </div>
					    <div class="d-flex justify-content-between m-3">
					    	<span class="py-1">6년차</span>
					    	<div class="input-group input-group-sm w-auto">
					    		<input class="form-control" type="number" value="0" />
					    		<span class="input-group-text">일</span>
					    	</div>
					    </div>
					    <div class="d-flex justify-content-between m-3">
					    	<span class="py-1">7년차</span>
					    	<div class="input-group input-group-sm w-auto">
					    		<input class="form-control" type="number" value="0" />
					    		<span class="input-group-text">일</span>
					    	</div>
					    </div>
					    <div class="d-flex justify-content-between m-3">
					    	<span class="py-1">8년차</span>
					    	<div class="input-group input-group-sm w-auto">
					    		<input class="form-control" type="number" value="0" />
					    		<span class="input-group-text">일</span>
					    	</div>
					    </div>
					    <div class="d-flex justify-content-between m-3">
					    	<span class="py-1">9년차</span>
					    	<div class="input-group input-group-sm w-auto">
					    		<input class="form-control" type="number" value="0" />
					    		<span class="input-group-text">일</span>
					    	</div>
					    </div>
					    <div class="d-flex justify-content-between m-3">
					    	<span class="py-1">10년차</span>
					    	<div class="input-group input-group-sm w-auto">
					    		<input class="form-control" type="number" value="0" />
					    		<span class="input-group-text">일</span>
					    	</div>
					    </div>
						<div class="d-flex justify-content-end border-top border-secondary bg-white" style="position : sticky; bottom : 0;">
							<button type="button" class="btn border" id="annualVacAddCancelBtn">취소</button>
							<button type="button" class="btn btn-success ms-2" id="annualVacAddSaveBtn">저장</button>
	  					</div>
					  </div>
				</div>
			</div>
		  </div>
		</div>
	</section>
  </div>
  <div class="d-flex justify-content-end border-top border-secondary" style="position : sticky; bottom : 0;">
	<button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas">취소</button>
	<button type="button" class="btn btn-success ms-2"><i class='bx bx-check me-1'></i>연차 정책 변경하기</button>
  </div>
</div>
-->

<div id="offcanvasEnd2" class="offcanvas offcanvas-end w-px-500" tabindex="-1" aria-labelledby="offcanvasEndLabel">
  <div class="offcanvas-header border-bottom border-secondary sticky-top">
    <h5 id="offcanvasEndLabel" class="offcanvas-title fw-semibold">
    	휴가 추가
    </h5>
    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body mx-0 flex-grow-0">
	<section>
		<div class="divider text-start">
		 	<div class="divider-text fw-semibold">
			  	<i class='bx bx-edit-alt'></i>
			  	기본 설정
			</div>
		</div>
		<input type="text" class="form-control my-3" id="defaultFormControlInput" placeholder="휴가 이름 입력" aria-describedby="defaultFormControlHelp" />
		<textarea class="form-control my-3" id="exampleFormControlTextarea1" rows="3" placeholder="휴가에 대한 설명을 입력하면 구성원이 확인할 수 있습니다."></textarea>
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
		  			<select id="select1" class="form-select form-select-sm w-75">
					    <option value="매월 지급">매월 지급</option>
					    <option value="매년 지급">매년 지급</option>
					    <option value="근속시 지급">근속시 지급</option>
					    <option value="신청시 지급">신청시 지급</option>
					    <option value="관리자가 직접 지급">관리자가 직접 지급</option>
  					</select>
				</div>
				<div id="workPeriodInput" class="numberAncestor">
					<div class="d-flex justify-content-between my-sm-3">
			 			<span class="py-1 fw-semibold">근속 년(월)수</span>
			 			<div class="input-group input-group-sm w-75">
						    <input class="form-control w-50" type="number" value="0" />
						    <select id="select2" class="form-select">
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
						    <input class="form-control" type="number" value="0" />
						    <span class="input-group-text">일</span>
						</div>
					</div>
				</div>
		  		<div class="d-flex justify-content-between my-sm-3">
		  			<span class="py-1 fw-semibold">사용 단위</span>
		  			<div class="btn-group w-75" role="group" aria-label="Basic radio toggle button group">
					  <input type="radio" class="btn-check" name="btnradio" id="btnradio3" autocomplete="off">
					  <label class="btn btn-outline-dark btn-sm" for="btnradio3">일</label>
					  <input type="radio" class="btn-check" name="btnradio" id="btnradio4" autocomplete="off">
					  <label class="btn btn-outline-dark btn-sm" for="btnradio4">반차</label>
					</div>
				</div>
		  		<div class="d-flex justify-content-between my-sm-3">
		  			<span class="py-1 fw-semibold">급여 지급</span>
		  			<div class="btn-group w-75" role="group" aria-label="Basic radio toggle button group">
					  <input type="radio" class="btn-check" name="btnradio" id="btnradio5" autocomplete="off">
					  <label class="btn btn-outline-dark btn-sm" for="btnradio5">유급</label>
					  <input type="radio" class="btn-check" name="btnradio" id="btnradio6" autocomplete="off">
					  <label class="btn btn-outline-dark btn-sm" for="btnradio6">무급</label>
					</div>
				</div>
		  		<div class="d-flex justify-content-between my-sm-3">
		  			<span class="py-1 fw-semibold">적용 성별</span>
		  			<div class="btn-group w-75" role="group" aria-label="Basic radio toggle button group">
					  <input type="radio" class="btn-check" name="btnradio" id="btnradio7" autocomplete="off">
					  <label class="btn btn-outline-dark btn-sm" for="btnradio7">모두</label>
					  <input type="radio" class="btn-check" name="btnradio" id="btnradio8" autocomplete="off">
					  <label class="btn btn-outline-dark btn-sm" for="btnradio8">남자</label>
					  <input type="radio" class="btn-check" name="btnradio" id="btnradio9" autocomplete="off">
					  <label class="btn btn-outline-dark btn-sm" for="btnradio9">여자</label>
					</div>
				</div>
		  		<div class="d-flex justify-content-between my-sm-3">
		  			<span class="py-1 fw-semibold">증명 자료</span>
		  			<div class="btn-group w-75" role="group" aria-label="Basic radio toggle button group">
					  <input type="radio" class="btn-check" name="btnradio" id="btnradio10" autocomplete="off">
					  <label class="btn btn-outline-dark btn-sm" for="btnradio10">없음</label>
					  <input type="radio" class="btn-check" name="btnradio" id="btnradio11" autocomplete="off">
					  <label class="btn btn-outline-dark btn-sm" for="btnradio11">제출</label>
					</div>
				</div>
			</div>
		</div>
	</section>
  </div>
  <div class="d-flex justify-content-end border-top border-secondary" style="position : sticky; bottom : 0;">
	<button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas">취소</button>
	<button type="button" class="btn btn-success ms-2"><i class='bx bx-check me-1'></i>저장하기</button>
  </div>
</div>

<script>
	$(function(){
		
		let workPeriodInput = $('#workPeriodInput');
		workPeriodInput.hide(); 
		
		$('#select1').on('change', function(){
			let value = $(this).val();
			if(value == '근속시 지급') workPeriodInput.show();
			else workPeriodInput.hide();
		});
		
		$('input[type=number]').on('change', function(){
			let number = $(this);
			let ancestor = number.closest('.numberAncestor');
			let negativeNumberAlert = ancestor.children('#negativeNumberAlert');
			console.log(number.attr('style'));
			if((number.val() < 0) && (negativeNumberAlert['length'] == 0)){
				number.parent().css({
					'border' : '2px solid red',
					'border-radius' : '0.375rem'
				});
				ancestor.append('<div class="alert alert-danger" role="alert" id="negativeNumberAlert">양의 정수만 입력이 가능합니다.</div>');	
			}
			else if((number.val() >= 0) && (negativeNumberAlert['length'] != 0)){
				number.parent().removeAttr('style');
				negativeNumberAlert.remove();
			} 
		});
		
		/*
		$('[data-bs-toggle="tooltip"]').tooltip();
		
		new PerfectScrollbar(document.getElementById('vertical-example'), {
			  wheelPropagation: false
			});
	
		let perfectScrollbar = $('#perfectScrollbar');
		
		perfectScrollbar.hide();
		
		$('#annualVacAddBtn').on('click', function(){
			perfectScrollbar.show();
		});
		
		$('#annualVacAddCancelBtn').on('click', function(){
			perfectScrollbar.hide();
		});
		*/
		
	});
</script>