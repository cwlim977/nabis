<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- css -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
 
<!-- js -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<script type="text/javascript" >
let empRole = "${requestScope['empRole']}";

$('.headerMenu, .headerSubMenu').each(function(){
	switch($(this).attr('id')){
		case 'menu1':
			break;
		case 'menu2':
			$(this).find('span').addClass('text-dark');
			if(!(empRole == 'admin' || empRole == 'manager') ) $(this).hide();
			break;
		default:
			$(this).hide();
	}
});
</script>
<style type="text/css">
th {
	text-align: center;
	font-size: 16px;
}

td {
	height: 65px;
	font-size: 15px;
}

</style>

<div class="d-flex align-self-center align-items-center">

	<div class="btn-group" role="group"
		aria-label="Basic checkbox toggle button group">
		<button type="button" class="btn btn-sm btn-outline-info" onclick = "week_calandar(-1);">&#60;</button>

		<button type="button" id="calToday" class="btn btn-sm btn-outline-info" onclick="set_day()">현재주기</button>

		<button type="button" class="btn btn-sm btn-outline-info" onclick="week_calandar(1);">&#62;</button>
	</div>

	<span class="badge bg-label-primary me-1 mx-2">조회</span> 
	<span id="calMon">2022.10.31 - 2022.11.6 </span> 
	<select id="defaultSelect" class="w-px-300 ms-auto selectpicker selectlabel" data-style="border" data-width="100%" data-size="6" 
			 multiple="multiple" data-live-search="true"
			data-content="<span class='badge badge-success'></span>" data-none-selected-text="조직을 선택해주세요">
		<option value="name">전체</option>
		<option value="address">인사2팀</option>
		<option value="address">개발1팀</option>
		<option value="address">마케팅팀</option>
		<option value="address">연구개발부서</option>
	</select>

</div>


<div class="card mt-3">
	<div class="table-responsive">

		<table class="table card-table table-bordered table-hover">
		
			<tr>
				<th id="calMM" class="">이름</th>
				<th id="calM" class="w-px-150"></th>
				<th id="calTs" class="w-px-150"></th>
				<th id="calW" class="w-px-150"></th>
				<th id="calTr" class="w-px-150"></th>
				<th id="calF" class="w-px-150"></th>
				<th id="calSa" class="text-danger w-px-150"></th>
				<th id="calSu" class="text-danger w-px-150"></th>
			</tr>
			<tbody id="dataResult">
				
			</tbody>

		</table>
	</div>
</div>
		<div class="d-flex mt-2">
			<button type="button" class="btn btn-sm btn-outline-secondary ms-auto" data-bs-toggle="modal" data-bs-target="#workExcelModal">
			<i class='bx bx-download'></i> 기간별 근무시간 다운로드
			</button>
		</div>
		<div class="pagingArea mt-3"></div>
<!-- 기간별 근무시간 다운로드 Modal -->
<div class="modal fade" id="workExcelModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw-semibold" id="modalToggleLabel2">기간별 근무시간</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          </button>
      </div>
      <div class="modal-body">
      	<div class="card">
        	<div class="card-body">
        		  <div class="row">
				    <label class="col-md-3 col-form-label fs-big">조회기간</label>
				    <div class="col-md-9">
				      <input type="text" class="form-control w-px-250" id="demo2" name="daterange" />
				    </div>
				  </div>
        	</div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button id="excelDownbtn" type="button" class="btn btn-success"><i class='bx bx-download'></i> 다운로드</button>
      </div>
    </div>
  </div>
</div>


<form id="searchForm">
	<input type="hidden" name="page"/>
	<input type="hidden" name="searchType" value=""/>
	<input type="hidden" name="searchWord" value=""/>
</form>
<script type="text/javascript" defer="defer">
//#####################################################################################################################################################################
// 엑셀 다운로드

	$workExcelModal = $('#workExcelModal');
	let stdDate = new Date(); //date rangepicker 시작일 (엑셀근무시작일)
	let endDate = new Date(); //date rangepicker 종료일 (엑셀근무종료일)
	
	$('#excelDownbtn').on('click', function() {
		console.log(stdDate,endDate);
		location.href = CONTEXTPATH+"/work/excelDown.do?sDate="+stdDate+"&eDate="+endDate;
		$workExcelModal.modal("hide");
	});
	
	$('#demo2').daterangepicker({
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
	    stdDate =  start.format('YYYY-MM-DD'); 
	    endDate =  end.format('YYYY-MM-DD');
	});

//#####################################################################################################################################################################
	let page = 1;
	let pagingArea = $(".pagingArea").on("click", "a", function(event) {
		event.preventDefault();
		
		page = $(this).data('page');
		if(!page) return false;
		week_calandar(3);
		return false;
	});
	//let kday = new Date ();
	let day = new Date();
	//kday.setDate(kday.getDate()-1);
	//let theDayOfWeek = kday.getDay();
	let theDayOfWeek = day.getDay();
	
	day.setDate(day.getDate() - theDayOfWeek+1);
    console.log("데이 뭐임",day.getDate());
	let num = 0;

	$(function() {

		document.getElementById('calToday').click();

	});

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

		day.setDate(day.getDate() + week * 7);
		let title = day.getFullYear() + "." + (day.getMonth() + 1);
		let data = []

		for (var i = 0; i < 7; i++) {

			data[i] = day.getDate();

			if (day.getDate() == 1)
				title += "~" + day.getFullYear() + "." + (day.getMonth() + 1);
			day.setDate(day.getDate() + 1);

		}

		day.setDate(day.getDate() - 7);

		document.getElementById("calMon").innerHTML = title

		document.getElementById("calM").innerHTML = data[0] + '(월)';
		document.getElementById("calTs").innerHTML = data[1] + '(화)';
		document.getElementById("calW").innerHTML = data[2] + '(수)';
		document.getElementById("calTr").innerHTML = data[3] + '(목)';
		document.getElementById("calF").innerHTML = data[4] + '(금)';
		document.getElementById("calSa").innerHTML = data[5] + '(토)';
		document.getElementById("calSu").innerHTML = data[6] + '(일)';

		$.ajax({
			url : CONTEXTPATH+"/work/members.do",
			type : "post",
			dataType : "json",
			data : {num : num, page : page},
			success : function(resp){
				console.log(resp)
				let pagingVO = resp;
				let empList = pagingVO.dataList;
				
				let htmlCode = "";
				// 사원리스트 반복
				$(empList).each(function (empIndex, emp) {
					
					let jnm = ""; // 직무명
					// 직무명 리스트에서 꺼내기
					$(emp.jobList).each(function(jobIndex, job) {
						if(jobIndex == 0) jnm = job.jnm;
					});
					
					// 프로필 유무로 이미지주소설정
					let empImg = `\${CONTEXTPATH}/resources/empImages/\${emp.empImg}`;
					if(!emp.empImg)
						empImg =`\${CONTEXTPATH}/resources/images/basicProfile.png`;
					
					// 일주일 근무시간
					let workTotalTime = 0;
					$(emp.workApList).each(function(workIndex, work) {
						workTotalTime += work.waTltime;
					})
					workTotalTime = workTotalTime+"";
					let workTimeH = workTotalTime.split('.')[0]
					let workTimeM = workTotalTime.split('.')[1] == '5' ? '30' : '';
					if(workTotalTime == 0){
						workTotalTime = "";
					}else if(workTimeH == 0){
						workTotalTime = `<span class="badge bg-label-info me-1 ms-auto text-dark">\${workTimeM}분</span>`;
					}else if(!workTimeM){
						workTotalTime = `<span class="badge bg-label-info me-1 ms-auto text-dark">\${workTimeH}시간</span>`;
					}else{
						workTotalTime = `<span class="badge bg-label-info me-1 ms-auto text-dark">\${workTimeH}시간\${workTimeM}분</span>`;
						
					}
					// 이름 프로필 직무
					htmlCode += `<tr class="cell-fit cursor-pointer" onClick="location.href='\${CONTEXTPATH}/work/memberwork.do?empNo=\${emp.empNo}'" >
								<td class="d-flex align-self-center align-items-center">
									<img src="\${empImg}"
										alt="emp" class="empListimgradius emplistimgsize">
									<div class="mx-3 mt-1">
										<strong>\${emp.empNm}</strong><br> 
										<span class="fs-tiny">\${jnm}</span>
									</div>
									\${workTotalTime}
								</td>`;
					// 일주일 반복
					$(data).each(function(weekIndex, week) {
						htmlCode += `<td class="align-top">`;
						$(emp.workApList).each(function(workIndex, work) {
							// 근무기록이 일주일 날짜와 일치시 입력
							data[weekIndex] = String(data[weekIndex]).length === 1 ? '0' + data[weekIndex] : data[weekIndex];
							if(work.waDate.split('-')[2] == data[weekIndex]){
								
								// 근무코드가 근무 일때
								if(work.wkCode == 'WK2'){
									htmlCode += `<span class="badge bg-label-info text-dark">근무 \${work.waStime} - \${work.waEtime} </span><br>`;

								// 근무코드가 오전 반차 인경우
								}else if(work.wkCode == 'WK1'){
									htmlCode += `<span class="badge bg-label-primary text-dark">\${work.wkNm} 하루종일 </span><br>`;
												
								// 근무코드가 오전 반차 인경우
								}else if(work.wkCode == 'WK6'){
									htmlCode += `<span class="badge bg-label-primary text-dark">휴가 오전반차 </span><br>
												<span class="badge bg-label-info text-dark">근무 14:00 - 18:00 </span><br>`;
							
								// 근무코드가 오후 반차 인경우
								}else if(work.wkCode == 'WK7'){
									htmlCode += `<span class="badge bg-label-info text-dark">근무 09:00 - 14:00 </span><br>
												<span class="badge bg-label-primary text-dark">휴가 오후반차 </span><br>`;
								// 근무코드가 그 이외인 경우	
								}else{
									htmlCode += `<span class="badge bg-label-warning text-dark">\${work.wkNm} \${work.waStime} - \${work.waEtime} </span><br>`;
									
								}
							}
						});
						htmlCode+= "</td>";
					})
					htmlCode += "</tr>";
				})
				pagingArea.html(pagingVO.pagingHtml);
				$("#dataResult").html(htmlCode);
				
				// 현재페이지 버튼 활성화 
				pagingArea.find('a').each(function (index, a){
					let curnPage = $(a).data('page');
					if(curnPage == page) $(a).closest('li').addClass('active');
				});
			},
			error : function(){
				alert("error");
			}
		})
	}

	function set_day() {
		//let kday = new Date ();
		day = new Date();
		//kday.setDate(kday.getDate()-1);
		//let theDayOfWeek = kday.getDay();
		let theDayOfWeek = day.getDay();
		
		day = new Date();
		console.log("today" + day);
		day.setDate(day.getDate() - theDayOfWeek+1);
		console.log("today2" + day);

		week_calandar(0);
	}
</script>