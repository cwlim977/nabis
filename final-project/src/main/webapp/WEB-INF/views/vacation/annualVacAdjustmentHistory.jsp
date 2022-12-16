<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	button:hover{
		background-color : #f7f7f7;
	}
</style>

<script>
	$('#menuList').prepend('<li class="nav-item text-nowrap"><a class="nav-link active" href="javascript:window.history.back();">&lt;</a></li>');
 	$('#menu1').hide();
	$('#menu2').hide();
	$('#menu4').hide();
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
			<button type="button" class="btn border">
			  	<i class='bx bx-refresh' ></i> 새로고침
			</button>
			<div class="d-flex w-auto">
				<button type="button" class="btn btn-danger mx-3">
			  			<i class='bx bxs-collection'></i> 모든 조정 기록 삭제
				</button>
				<button type="button" class="btn btn-danger">
			  			<i class='bx bxs-trash-alt'></i> 선택 항목 삭제
				</button>
			</div>
		</div>
		<div class="table-responsive border rounded">
	        <table class="table table-hover table-bordered fw-semibold text-center m-0">
	          <thead>
	            <tr>
	              <th>
	              	<input class="form-check-input" type="checkbox" value="">
	              </th>
	              <th>대상 구성원</th>
	              <th>사번</th>
	              <th>조정 적용일</th> 
	              <th>추가/차감일</th>      
	              <th>조정 사유</th>      
	              <th>마지막 수정</th>      
	            </tr>
	          </thead>
	          <tbody class="cursor-pointer">
	          	<tr>
	          		<td>
	          			<input class="form-check-input" type="checkbox" value="">
	          		</td>
	          		<td>김나비</td>
	          		<td>A003</td>
	          		<td>2021-11-08</td>
	          		<td class="text-info">+3일</td>
	          		<td>포상 휴가</td>   
		            <td>2022-11-08 07:23 김나비</td>   
	          	</tr>
	          </tbody>
	        </table>
   		</div>
   	</div>	
</div>