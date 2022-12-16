<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
  
<script>
	
	let empRole = "${requestScope['empRole']}";

 	toastr.options.positionClass = "toast-top-center";
 	
	$('.headerMenu, .headerSubMenu').each(function(){
		switch($(this).attr('id')){
			case 'menu1':
				$(this).find('span').addClass('text-dark');
				break;
			case 'menu2':
				if(!(empRole == 'admin' || empRole == 'manager')) $(this).hide();
				break;
			case 'subMenu1':
				break;
			case 'subMenu2':
				$(this).find('span').addClass('text-dark');
				break;
			default:
				$(this).hide();
		}
	});
 	
 	function detailFactory(e, obj){
 		let vpAddDays = parseInt(e['vpAddDays']);
		let vpSubDays = parseInt(e['vpSubDays']);
		switch(e['vpCngCase']){
			case '부여':
				obj['gived'] += vpAddDays;
				obj['remained'] += vpAddDays;
				break;
			case '조정':
				let realNum = 0;
				if(e['vpAddDays'] != 0) realNum = vpAddDays;
				else realNum = -vpSubDays;
				obj['adjusted'] += realNum;
				obj['remained'] += realNum;
				break;
			case '사용':
				obj['used'] += vpSubDays;
				obj['remained'] -= vpSubDays;
				break;
			case '취소':
				obj['used'] -= vpAddDays;
				obj['remained'] += vpAddDays;
				break;
		}
		return obj;
 	};
 	
 	function annualVacDetail(empNo, year){
 		
 		let tbody = $('#detailList');
 		tbody.empty();
 		
 		$.ajax({
			url : "${cPath}/myVacation/annualVacDetail.do",
			method : "post",
			data : {
				empNo : empNo,
				year : year
			},
			dataType : "json",
			success : function(resp) {
				if(resp.status != 'empty'){
					let details = new Object();
					let vacPosnList = resp.vacPosnList;
					vacPosnList.forEach(function(e, i){
						let vpCngDate = new Date(e['vpCngDate']);
						let key = [vpCngDate.getFullYear(), vpCngDate.getMonth()+1].join('. ');
						if(details.hasOwnProperty(key)){
							details[key] = detailFactory(e, details[key]);
						}else{
							let obj = new Object();
							obj['gived'] = 0;
							obj['adjusted'] = 0;
							obj['used'] = 0;
							obj['remained'] = 0;
							details[key] = detailFactory(e, obj);
						}
					});
					let givedTotal = 0;
					let adjustedTotal = 0;
					let usedTotal = 0;
					let remainedTotal =0;
					$.each(details, function(key, obj){
						let gived = obj['gived'];
						givedTotal += gived;
						let adjusted = obj['adjusted'];
						adjustedTotal += adjusted;
						let used = obj['used'];
						usedTotal += used;
						let remained = obj['remained'];
						remainedTotal += remained; 
						let htmlTag = `<tr>
									       <td>\${key}</td>
									       <td>+\${gived}</td>
									       <td>\${adjusted}</td>
									       <td>-\${used}</td>
									       <td>\${remainedTotal}</td>
								     	</tr>`
						tbody.append(htmlTag);
					});
					$('#givedTotal').text(['+', givedTotal].join(''));
					$('#adjustedTotal').text(adjustedTotal);
					$('#usedTotal').text(['-', usedTotal].join(''));
					$('#remainedTotal').text(remainedTotal);
				}
				else{
					$('#givedTotal').text(0);
					$('#adjustedTotal').text(0);
					$('#usedTotal').text(0);
					$('#remainedTotal').text(0);
				}
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
 		
 	};
 	
 	let empNo = ${authEmp['empNo']};
 	
 	$(function(){
 		
 		let datePicker = $('#datepicker').datepicker({
	 		format : "yyyy",
	 	    viewMode : "years", 
	 	    minViewMode : "years",
	 	    autoclose : true
	 	});  
	 	
	 	$(document).on('click', '#prevYearBtn, #nextYearBtn', function(){
	 		let num = datePicker.datepicker('getDate').getFullYear();	
	 		let btn = $(this);
	 		if(btn.attr('id') == 'prevYearBtn') num--;
	 		else num++;
	 		datePicker.datepicker('setDate', num+'Y');
	 	});
	 	
	 	datePicker.on('change', function(){
	 		let year = datePicker.val();
	 		annualVacDetail(empNo, year);
	 	});
	 	
	 	datePicker.datepicker('setDate', 'today');
	 	
 	});
 	
</script>
 
<div class="container-xl flex-grow-1 container-p-y">
 	<div class="container-lg container-p-y">
	 	<header class="d-flex justify-content-between">
			<h5 class="fw-semibold">연차 상세 현황</h5>
			<div class="input-group w-px-250">
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
		<div class="row border rounded row-cols-4 m-0">
			<div class="card">
			  	<ul class="list-group list-group-flush fw-semibold">
				    <li class="list-group-item border-bottom-0">
				    	<span class="text-success">|</span>
				    	<span>부여</span>
				    </li>
				    <li class="list-group-item border-bottom-0 fs-large text-success" id="givedTotal"></li>
	  			</ul>
			</div>
			<div class="card">
			  	<ul class="list-group list-group-flush fw-semibold">
				    <li class="list-group-item border-bottom-0">
				    	<span class="text-warning">|</span>
				    	<span>조정</span>
				    </li>
				    <li class="list-group-item border-bottom-0 fs-large" id="adjustedTotal"></li>
	  			</ul>
			</div>
			<div class="card">
			  	<ul class="list-group list-group-flush fw-semibold">
				    <li class="list-group-item border-bottom-0">
				    	<span class="text-danger">|</span>
				    	<span>사용</span>	
				    </li>
				    <li class="list-group-item border-bottom-0 fs-large text-danger" id="usedTotal"></li>
	  			</ul>
			</div>
			<div class="card">
			  	<ul class="list-group list-group-flush fw-semibold">
				    <li class="list-group-item border-bottom-0">
				    	<span class="text-primary">|</span>
				    	<span>잔여</span>
				    </li>
				    <li class="list-group-item border-bottom-0 fs-large text-primary" id="remainedTotal"></li>
	  			</ul>
			</div>
		</div>
		<div class="table-responsive border rounded mt-3">
		  <table class="table fw-semibold text-center m-0">
		    <thead>
		      <tr>
		        <th>날짜</th>
		        <th>부여</th>
		        <th>조정</th>
		        <th>사용</th>
		        <th>잔여</th>
		      </tr>
		    </thead>
		    <tbody id="detailList">
		    </tbody>
		  </table>
		</div>
	</div>
</div>