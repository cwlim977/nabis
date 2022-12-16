<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>	
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<jsp:include page="/WEB-INF/views/pay/wage/wageStepIncld.jsp"/>

<!-- MAIN DIV START (상단)- -->
<div class="calcdiv d-flex flex-column" style="float: left;">
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item">
      <a href="#">${proll.ptNm }</a>
    </li>
    <li class="breadcrumb-item active text-dark">${proll.prNm }</li>
  </ol>
  <h3 class="text-dark fw-bold">정산대상자</h3>
  <div class="text-lg-end">
  <!-- 
  	<c:url value="/pay/wagePay.do" var="moveURL">
  		<c:param name="prNo" value="${proll.prNo }" />
  		<c:param name="prPtno" value="${proll.prPtno }" />
  	</c:url>  -->
   <button type="button" class="btn btn-success mvbtn mb-3">
	<i class='bx bx-right-arrow-alt'></i> 지급항목
  </button>
  </div>
</nav>
<!-- MAIN DIV (하단 테이블)- -->
<div class="card" id="mainPayEmp" data-prno="${proll.prNo }" data-prptno="${proll.prPtno }" data-sdate="${proll.prSdate }" data-edate="${proll.prEdate }">
	<div class="card-header" >
		<span class="fs-5 fw-semibold" style="float: left;">대상자</span>
		<div class="vr mx-4" style="height:20px; float: left; color: lightgray"></div>
		<div class="mb-3 row">
		    <div class="weschdiv rounded">
		      <i class='bx bx-search-alt weschimg' ></i>
		      <input class="wesch form-control" type="search" id="empFilter" />
		    </div>
		</div>
		
	</div>
<!-- 	<i class='bx bxs-download text-lg-end'> 엑셀다운로드</i> -->
	<div class="table-responsive text-nowrap">
		<table class="table table-hover table-bordered" id="wageEmp">
			<thead>
				<tr>
					<th><input class="form-check-input me-1" type="checkbox" name="selectall" onclick="selectAll(this)"></th>
					<th>사번</th>
					<th>이름</th>
					<th>입사일</th>
					<th>재직여부</th>
					<th>주민번호</th>
					<th>근로유형</th>
					<th>조직</th>
					<th>직위</th>
					<th>직책</th>
					<th>직무</th>
					<th>특이사항</th>
				</tr>
			</thead>
			<tbody class="table-border-bottom-0 empTb">
				<c:if test="${not empty settledEmpList }">
					<c:forEach items="${settledEmpList }" var="emp">
<!-- 					<tr class="empTr" data-bs-toggle="offcanvas" data-bs-target="#offcanvasEnd" aria-controls="offcanvasEnd"> -->
					<tr class="empTr">
						<td><input class="form-check-input me-1 empChk checkinghere" type="checkbox" value="${emp.empNo }" name="empChkList" onclick="checkSelectAll(this)"></td>
						<td>${emp.empNo }</td> 									<!-- 사번 -->
						<td><strong>${emp.empNm }</strong></td>					<!-- 이름 -->
						<td>${emp.entDate }</td>								<!-- 입사일 -->
						<td>													<!-- 재직상태 -->
							<c:choose>
								<c:when test="${emp.empSt eq '재직중'}">
									<span class="badge bg-label-success me-1">재직</span>
								</c:when>
								<c:otherwise>
									<span class="badge bg-label-warning me-1">퇴직</span> 
								</c:otherwise>
							</c:choose>
						</td>
						<td>${emp.regno1 }-${emp.regno2 }</td>					<!-- 주민번호 -->
						<td>${emp.entCase }</td>								<!-- 근무유형 -->
						<td class="deptTest">
							<c:if test="${not empty emp.deptList }">
								<c:forEach items="${emp.deptList }" var="dept">
									${dept.dnm }						<!-- 조직 -->
								</c:forEach>
							</c:if>
						</td> 
						<td>${emp.ptnNm }</td>									<!-- 직위  -->
						<td>
							<c:choose>
								<c:when test="${not empty emp.deptList }">
									<c:forEach items="${emp.deptList }" var="dept">
										${dept.dtnm }							<!--직책 -->
									</c:forEach>
								</c:when>
								<c:otherwise>
									-
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:if test="${not empty emp.jobList }">
								<c:forEach items="${emp.jobList }" var="job">
									${job.jnm }
								</c:forEach>
							</c:if>
						</td>		<!-- jnm -->					<!-- 직무/job -->
						<td>${emp.empMm }</td>
					</tr>
				</c:forEach>
				</c:if>
<!-- 				<tr class="empTr" data-bs-toggle="offcanvas" data-bs-target="#offcanvasEnd" aria-controls="offcanvasEnd"> -->
<!-- 					<td class="chkbox"><input class="form-check-input me-1 empChk" type="checkbox" value="202003001" name="empChkList"></td> -->
<!-- 					<td>사번</td> -->
<!-- 					<td><strong>짭3</strong></td> -->
<!-- 					<td>입사일</td> -->
<!-- 					<td> -->
<!-- 						<span class="badge bg-label-success me-1">재직</span>  -->
<!-- 						<span class="badge bg-label-warning me-1">퇴직</span>  -->
<!-- 					</td> -->
<!-- 					<td>주민번호</td> -->
<!-- 					<td>근로유형</td> -->
<!-- 					<td>조직</td> -->
<!-- 					<td>직위</td> -->
<!-- 					<td>직책</td> -->
<!-- 					<td>직무</td> -->
<!-- 					<td>특이사항</td> -->
<!-- 				</tr> -->
			</tbody>
		</table>
	</div>
</div>
<!-- MAIN DIV END -->

<!-- tr 클릭 시 사원정보 offcanvas -->
<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasEnd" aria-labelledby="offcanvasEndLabel" style="width: 600px;">
  <div class="offcanvas-header">
    <h5 id="offcanvasEndLabel" class="offcanvas-title">구성원 급여 정보</h5>
    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body mx-0 flex-grow-0">
  	<div class="clearfix">
  		<div class="float-start d-flex flex-row ">
		  	<img src="${cPath}/resources/assets/img/avatars/5.png" alt="Avatar" class="w-px-75 rounded m-3">
	  	</div>
	  	<div class="float-start mt-3">
	  		<span class="fw-semibold me-2">고양이</span>
		  	<span class="badge bg-label-success">재직</span>
		  	<div class="flex-column mt-2 fs-tiny">
		  		<span>직무</span>
		  		<div></div>
		  		<span>조직</span>
		  		<div></div>
	  		</div>
	  	</div>
  	</div>
  	<br><br>
  	<!-- tabs -->
  	<div class="nav-align-top ">
	  <ul class="nav nav-tabs" role="tablist">
	    <li class="nav-item">
	      <button type="button" class="nav-link active fs-6" role="tab" data-bs-toggle="tab" data-bs-target="#navs-top-home" aria-controls="navs-top-home" aria-selected="true">급여 정보</button>
	    </li>
	    <li class="nav-item">
	      <button type="button" class="nav-link fs-6" role="tab" data-bs-toggle="tab" data-bs-target="#navs-top-profile" aria-controls="navs-top-profile" aria-selected="false">인사·계약</button>
	    </li>
	    <li class="nav-item">
	      <button type="button" class="nav-link fs-6" role="tab" data-bs-toggle="tab" data-bs-target="#navs-top-messages" aria-controls="navs-top-messages" aria-selected="false">개인 정보</button>
	    </li>
	  </ul>
	  <div class="tab-content shadow-none">
	  <!-- tab1 -->
	    <div class="tab-pane fade show active" id="navs-top-home" role="tabpanel">
	      <dl class="d-flex">
	      	<dt class="fw-normal d-inline-flex flex-fill">원천징수세율</dt>
	      	<dd class="d-inline-flex p-2 bd-highlight">100%</dd>
	      </dl>
	      <dl class="d-flex">
	      	<dt class="fw-normal d-inline-flex flex-fill fw-normal">공제대상 가족 수 <i class='bx bx-help-circle' data-bs-toggle="tooltip" data-bs-offset="0,4" data-bs-placement="top" data-bs-html="true" title="<span>기본 공제 대상에 포함되는 가족 수에 본인을 더한 수 입니다.</span>"></i></dt>
	      	<dd class="d-inline-flex p-2 bd-highlight">2명</dd>
	      </dl>
		  <dl class="d-flex">		
			<dt class="fw-normal d-inline-flex flex-fill"><i class='bx bx-subdirectory-right'></i>7세 이상 20세 이하 자녀</dt>
	      </dl>	
	    </div>
	    <!-- tab2 -->
	    <div class="tab-pane fade" id="navs-top-profile" role="tabpanel">
	      <p class="fw-bold">
			인사 정보
	      </p>
	      <dl class="d-flex">
	      	<dt class="fw-normal d-inline-flex flex-fill">사번</dt>
	      	<dd class="d-inline-flex p-2 bd-highlight ">001</dd>
	      </dl>
	      <dl class="d-flex">
	      	<dt class="fw-normal d-inline-flex flex-fill">입사일</dt>
	      	<dd class="d-inline-flex p-2 bd-highlight">2022.11.10</dd>
	      </dl>
	      <dl class="d-flex">
	      	<dt class="fw-normal d-inline-flex flex-fill">조직·직책</dt>
	      	<dd class="d-inline-flex p-2 bd-highlight">개발팀</dd>
	      </dl>
	      <dl class="d-flex">
	      	<dt class="fw-normal d-inline-flex flex-fill">직무</dt>
	      	<dd class="d-inline-flex p-2 bd-highlight">.</dd>
	      </dl>
	      <dl class="d-flex">
	      	<dt class="fw-normal d-inline-flex flex-fill">직위</dt>
	      	<dd class="d-inline-flex p-2 bd-highlight">.</dd>
	      </dl>  
	      <br>
	      <p class="fw-bold">
			근로 계약
	      </p>
	      <dl class="d-flex">
	      	<dt class="fw-normal d-inline-flex flex-fill">근로 유형</dt>
	      	<dd class="d-inline-flex p-2 bd-highlight">정규직</dd>
	      </dl>
	      <dl class="d-flex">
	      	<dt class="fw-normal d-inline-flex flex-fill">근로계약기간</dt>
	      	<dd class="d-inline-flex p-2 bd-highlight">2022.11.10 ~</dd>
	      </dl>
	      <br>
	      <p class="fw-bold">
			임금 계약
	      </p>
	      <dl class="d-flex">
	      	<dt class="fw-normal d-inline-flex flex-fill">소득 구분</dt>
	      	<dd class="d-inline-flex p-2 bd-highlight">정규직</dd>
	      </dl>
	      <dl class="d-flex">
	      	<dt class="fw-normal d-inline-flex flex-fill">임금계약기간</dt>
	      	<dd class="d-inline-flex p-2 bd-highlight">2022.11.10 ~</dd>
	      </dl>
	      <dl class="d-flex">
	      	<dt class="fw-normal d-inline-flex flex-fill">계약금액</dt>
	      	<dd class="d-inline-flex bd-highlight"><span class="badge bg-label-dark" style="margin-right: 10px;">연봉</span>	36,000,000</dd>
	      </dl>
	    </div>
	    
	    <!-- tab3 -->
	    <div class="tab-pane fade" id="navs-top-messages" role="tabpanel">
	      <p class="fw-bold">
			개인 정보
	      </p>
	      <table class="table table-sm table-borderless">
	      	<tr>
	      		<td>이름</td>
	      		<td class="px-5">김나비</td>
	      	</tr>
	      	<tr>
	      		<td>생년월일</td>
	      		<td class="px-5">1991.09.22</td>
	      	</tr>
	      	<tr>
	      		<td>주민등록번호</td>
	      		<td class="px-5">910922-1454556</td>
	      	</tr>
	      	<tr>
	      		<td>휴대전화번호</td>
	      		<td class="px-5">010-2222-2222</td>
	      	</tr>
	      	<tr>
	      		<td>집주소</td>
	      		<td class="px-5">대전광역시 중구 오류동</td>
	      	</tr>
	      	<tr>
	      		<td>급여계좌</td>
	      		<td class="px-5">카카오뱅크 <br>
	      		542-221-324855</td>
	      	</tr>
	      </table>
	      <br>
	       <p class="fw-bold">
			가족 정보
	      </p>
	      <table class="table table-sm table-borderless">
	      	<tr>
	      		<td>자녀</td>
	      		<td class="px-5">김뽀삐</td>
	      	</tr>
	      	<tr>
	      		<td>생년월일</td>
	      		<td class="px-5">2021.09.23</td>
	      	</tr>
	      	<tr>
	      		<td>주민등록번호</td>
	      		<td class="px-5">210923-4454556</td>
	      	</tr>
	      </table>
	    </div>
	  </div>
	</div>
  	<!-- tabs end -->
  </div>
</div>
</div>

<form id="moveForm" method="post" action="${cPath }/pay/wagePay.do">
   <input type="hidden" name="prNo" value="" />
   <input type="hidden" name="prPtno" value="" />
   <input type="hidden" name="prSdate" value="" />
   <input type="hidden" name="prEdate" value="" />
   <sec:csrfInput/>
</form>



<script>

 
$(function(){
	$('#step1').css('color', '#4d4d4d');
});

//검색
$('#empFilter').keyup(function(event) {
	$('.empChk').removeClass('checkinghere');
    var val = $(this).val();
    if (val == "") {
        $('.empTb > tr').show();
        $('.empChk').addClass('checkinghere');
    } else {
        $('#wageEmp > tbody > tr').hide();
        var searched = $("#wageEmp > tbody > tr > td:contains('"+val+"')");
		$(searched).parent().show();
		
		
		$(searched).siblings().children('.empChk').addClass('checkinghere');
				
    }
});



//체크박스 td 클릭시 offcanvas 이벤트 막기
/*
$(function(){
	$('#wageEmp tbody').on('click', 'tr td:not(:first-child)', function () {
		$('.offcanvas').offcanvas('show');
    });
})*/

let empList = [];
let targetEmp = [];



//체크박스 전체 선택, 전체 해제 (검색결과 있을 경우 검색결과에만 전체선택)
function selectAll(selectAll)  {
  const checkboxes = document.querySelectorAll('input[type="checkbox"].checkinghere');
  
  console.log(checkboxes);
  
  
  checkboxes.forEach((checkbox) =>{
    checkbox.checked = selectAll.checked
  })
}

//체크박스 전체 선택 후 한 항목 해지 시 전체 체크도 해지
function checkSelectAll(checkbox)  {
  const selectall = document.querySelector('input[name="selectall"]');
  
  if(checkbox.checked === false)  {
    selectall.checked = false;
  }
}


//체크된 사원 
function empCheck(){
	$("input[name='empChkList']:checked").each(function() {
	    let empNo = $(this).val();
	    console.log(empNo);
		targetEmp.push(empNo);
	});
}

//지급항목 버튼 클릭 시
$(".mvbtn").on("click", function(){
 	empCheck();
 	
 	if(targetEmp.length == 0){
 		toastr.options = {
			"closeButton": true,
		  	"positionClass": "toast-top-center"
 		}
 		toastr.warning("대상자를 선택해주세요.");
 		return;
 	}
 	
 	sendEmpList();
});

let prNo = $("#mainPayEmp").data("prno");
let prPtno = $("#mainPayEmp").data("prptno");
let prSdate = $("#mainPayEmp").data("sdate");
let prEdate = $("#mainPayEmp").data("edate");

//ajax 성공 시 페이지 이동 딜레이
function delay(){
	let moveForm = $("#moveForm");
	moveForm.find('[name=prNo]').val(prNo);
    moveForm.find('[name=prPtno]').val(prPtno);
    moveForm.find('[name=prSdate]').val(prSdate);
    moveForm.find('[name=prEdate]').val(prEdate);
    moveForm.submit();
}


function sendEmpList(){
	
	for(let i=0; i<targetEmp.length; i++){
		let checkEmp = {};
		
		checkEmp.empNo = targetEmp[i];
		checkEmp.prNo = prNo;
		empList.push(checkEmp);
	}
	console.log("empList",empList);
	
	let data = JSON.stringify(empList);

	$.ajax({
		url : "${cPath}/pay/payempInsert.do",
		method : "POST",
		data : data,
		contentType: "application/json; charset=utf-8",
		dataType : "JSON",
		success : function(resp) {
			toastr.success("정산 대상자 목록이 확정되었습니다.");
			setTimeout(delay,1000); //1초 딜레이 후 공제항목 페이지로 이동
		},
		error : function(errorResp) {
			toastr.error("대상자 확정 중 오류가 발생했습니다.")
			console.log(errorResp.status);
		}
	});

}

$('.deptTest').text(function(index,dept){
	console.log(">>>>>>>>",dept);
})


</script>