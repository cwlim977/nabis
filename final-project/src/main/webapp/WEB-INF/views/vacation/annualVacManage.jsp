<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	$('#menu3').hide();
	$('#menu4').hide();
	$('#menu5').hide();
	$('#subMenu1').hide();
	$('#subMenu2').hide();
</script>

<style>
	button:hover{
		background-color : #f7f7f7;
	}
</style>

<div class="container-xl flex-grow-1 container-p-y">
	<div class="container-lg container-p-y">
		<div class="container-md container-p-y d-flex justify-content-between border border-bottom-0 rounded">
			<div class="input-group input-group-merge w-px-250">
				<input type="text" class="form-control h-px-30" id="datepicker" style="text-align : center;"/>
				<span class="input-group-text h-px-30"><i class="bx bx-chevron-down"></i></span>
				<button type="button" class="btn btn-icon btn-outline-primary h-px-30 mx-2">
				  	<span class="tf-icon bx bx-chevron-left"></span>
				</button>
				<button type="button" class="btn btn-icon btn-outline-primary h-px-30">
				  	<span class="tf-icon bx bx-chevron-right"></span>
				</button>
			</div>
			<div class="d-flex w-auto">
				<button type="button" class="btn border" data-bs-toggle="modal" data-bs-target="#basicModal">
		  			<i class='bx bxs-download'></i> 리포트 다운로드
				</button>
				<a href="${cPath }/memberVacation/annualVacAdjustmentHistory.do">
					<button type="button" class="btn btn-icon border mx-3" data-bs-toggle="tooltip" data-bs-offset="0,4" data-bs-placement="top" title="연차 조정 내역">
		  				<i class='bx bx-history'></i>
					</button>
				</a>
				<a href="${cPath }/memberVacation/annualVacBatchAdjustment.do">
					<button type="button" class="btn btn-success">
			  			<i class='bx bx-pencil'></i> 연차 일괄 조정
					</button>
				</a>
			</div>
		</div>
		<div class="container-md container-p-y d-flex border border-bottom-0 rounded">
			<div class="container-sm d-flex">
				<div class='d-flex me-2'>
					<i class='bx bx-filter bx-md me-2'></i>
				  	<select id="defaultSelect" class="form-select">
					    <option value="1">전체 조직</option>
					    <option value="2">개발팀</option>
					    <option value="3">영업팀</option>
				  	</select>
				</div>
				<div class="btn-group">
				  <button class="btn dropdown-toggle border rounded" type="button" id="dropdownMenuButtonIcon" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				    <i class="bx bx-menu"></i> 
				   		항목 보기
				    <span class="text-success">3</span>
				  </button>
				  <div class="dropdown-menu" aria-labelledby="dropdownMenuButtonIcon">
					<div class="form-check ms-5">
					     <input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="option1" />
					     <label class="form-check-label" for="inlineCheckbox1">전체 선택</label>
					</div>
					<hr class="dropdown-divider">
					<div class="form-check ms-5">
					     <input class="form-check-input" type="checkbox" id="inlineCheckbox2" value="option1" />
					     <label class="form-check-label" for="inlineCheckbox2">사번</label>
					</div>
					<div class="form-check ms-5">
					     <input class="form-check-input" type="checkbox" id="inlineCheckbox3" value="option2" />
					     <label class="form-check-label" for="inlineCheckbox3">입사일</label>
					</div>
					<div class="form-check ms-5">
					     <input class="form-check-input" type="checkbox" id="inlineCheckbox4" value="option2" />
					     <label class="form-check-label" for="inlineCheckbox4">잔여 연차</label>
					</div>
				  </div>
				</div>
			</div>
			<div class="container-sm w-px-300">
				<div class="input-group input-group-merge">
					<span class="input-group-text" id="basic-addon-search31"><i class="bx bx-search"></i></span>
					<input type="text" class="form-control" placeholder="이름, 조직, 직무 검색" aria-label="Search..." aria-describedby="basic-addon-search31" />
				</div>
			</div>
		</div>
	    <div class="table-responsive border rounded">
	        <table class="table table-hover table-bordered fw-semibold text-center m-0">
	          <thead>
	            <tr>  
	              <th colspan="4">기본 정보</th> 
	              <th colspan="12">사용 일수</th>
	            </tr>
	            <tr>
	              <th>이름</th>
	              <th>사번</th>
	              <th>입사일</th> 
	              <th>잔여 연차</th> 
	              <th>1월</th>   
	              <th>2월</th>   
	              <th>3월</th>   
	              <th>4월</th>   
	              <th>5월</th>   
	              <th>6월</th>   
	              <th>7월</th>   
	              <th>8월</th>   
	              <th>9월</th>   
	              <th>10월</th>   
	              <th>11월</th>   
	              <th>12월</th>      
	            </tr>
	          </thead>
	          <tbody class="cursor-pointer">
	          	<tr>
	          		<td>고양이</td>
	          		<td>A001</td>
	          		<td>2020-11-03</td>
	          		<td>15</td>
	          		<td>0</td>   
		            <td>0</td>   
		            <td>0</td>   
		            <td>0</td>   
		            <td>0</td>   
		            <td>0</td>   
		            <td>0</td>   
		            <td>0</td>   
		            <td>0</td>   
		            <td>0</td>   
		            <td>0</td>   
		            <td>0</td>     
	          	</tr>
	          	<tr>
	          		<td>김나비</td>
	          		<td>A003</td>
	          		<td>2021-11-01</td>
	          		<td>22</td>
	          		<td>0</td>   
		            <td>0</td>   
		            <td>0</td>   
		            <td>0</td>   
		            <td>0</td>   
		            <td>0</td>   
		            <td>0</td>   
		            <td>0</td>   
		            <td>0</td>   
		            <td>0</td>   
		            <td>3</td>   
		            <td>0</td>
	          	</tr>
	          </tbody>
	        </table>
	   	</div>
   	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="basicModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header border-bottom">
        <h5 class="modal-title fw-semibold" id="exampleModalLabel1">연차 리포트 다운로드</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="divider text-start my-3">
		 	<div class="divider-text fw-semibold">
			  	<i class='bx bx-calendar bx-sm me-1'></i>
			  	조회 기간 선택
			</div>
			<div class="input-group input-group-merge my-3">
				<input type="text" class="form-control" id="datarangepicker" style="text-align : center;"/>
				<span class="input-group-text"><i class="bx bx-chevron-down"></i></span>
			</div>
		</div>
      </div>
      <div class="modal-footer border-top">
        <button type="button" class="btn border" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-success">
        	<i class='bx bxs-download'></i> 다운로드
        </button>
      </div>
    </div>
  </div>
</div>

<script>
	$(function(){
	 	$("#datepicker").datepicker({
	 	     format: "yyyy년",
	 	     viewMode: "years", 
	 	     minViewMode: "years",
	 	     autoclose:true
	 	});
	 	$('#datarangepicker').daterangepicker({
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
	 	$('[data-bs-toggle="tooltip"]').tooltip();
	});
</script>