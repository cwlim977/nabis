<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	$('#menuList').prepend('<li class="nav-item text-nowrap"><a class="nav-link active" href="javascript:window.history.back();">&lt;</a></li>');
 	$('#menu1').hide();
	$('#menu2').hide();
	$('#menu3').hide();
	$('#menu5').hide();
 	$('#subMenu1').hide();
 	$('#subMenu2').hide();
 	$('#subMenu3').hide();
 	$('#subMenu4').hide();
 	$('#subMenu5').hide();
</script>

<div class="container-xl flex-grow-1 container-p-y">
	<div class="container-lg container-p-y">
		<div class="container-md container-p-y d-flex justify-content-between border border-bottom-0 rounded">
			<div class="d-flex w-auto">
				<select id="defaultSelect" class="form-select">
					<option value="1">전체 조직</option>
					<option value="2">개발팀</option>
					<option value="3">영업팀</option>
				</select>
			</div>
			<div class="d-flex w-auto">
				<div class="input-group w-auto">
					<span class="input-group-text">조정 적용일</span>
					<input type="text" class="form-control" id="daterangepicker" style="text-align : center;"/>
				</div>
				<button type="button" class="btn btn-success ms-3">
				  	<i class='bx bx-check'></i> 적용하기
				</button>
			</div>
		</div>
	    <div class="table-responsive border rounded">
	        <table class="table table-hover table-bordered fw-semibold text-center m-0">
	          <thead>
	            <tr>
	              <th>이름</th>
	              <th>사번</th>
	              <th>입사일</th> 
	              <th>조정</th> 
	              <th>조정 후 미리보기</th>   
	              <th>연차 현황</th>      
	            </tr>
	          </thead>
	          <tbody class="cursor-pointer">
	          	<tr>
	          		<td>고양이</td>
	          		<td>A001</td>
	          		<td>2020-11-03</td>
	          		<td>15</td>
	          		<td>
	          			<div class="input-group w-auto">
		          			<select class="form-select">
							    <option value="1">연차 추가</option>
							    <option value="2">연차 차감</option>
		  					</select>
		  					<input type="text" class="form-control" placeholder="0.0일">
	  					</div>
	          		</td>   
		            <td>
		            	<a href="#">
		            		<i class='bx bx-link-external'></i>
		            	</a>
		            </td>        
	          	</tr>
	          	<tr>
	          		<td>김나비</td>
	          		<td>A003</td>
	          		<td>2021-11-01</td>
	          		<td>22</td>
	          		<td>
	          			<div class="input-group w-auto">
		          			<select class="form-select">
							    <option value="1">연차 추가</option>
							    <option value="2">연차 차감</option>
		  					</select>
		  					<input type="text" class="form-control" placeholder="0.0일">
	  					</div>
	          		</td>   
		            <td>
		            	<a href="#">
		            		<i class='bx bx-link-external'></i>
		            	</a>
		            </td>
	          	</tr>
	          </tbody>
	        </table>
	   	</div>
   	</div>
</div>

<script>
	$(function(){
	 	$('#daterangepicker').daterangepicker({
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
		    "singleDatePicker" : true,
		    "startDate": new Date(),
		    "endDate": new Date(),
		    "drops": "auto"
		}, function (start, end, label) {
		    console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
		}); 
	});
</script>