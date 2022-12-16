<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>	
    
<jsp:include page="/WEB-INF/views/pay/wage/wageStepIncld.jsp"/>

<nav aria-label="PAYROLL_INFO">
  <ol class="breadcrumb">
    <li class="breadcrumb-item">
      <a href="#">${proll.ptNm }</a>
    </li>
    <li class="breadcrumb-item active text-dark">${proll.prNm }</li>
  </ol>
  <h3 class="text-dark fw-bold">지급항목</h3>
  <div class="text-lg-end">
   <button type="button" class="btn btn-success mvbtn">
	<i class='bx bx-right-arrow-alt'></i> 공제항목
  </button>
  </div>
</nav>


<div class="nav-align-top" id="mainPayTab" data-prno="${proll.prNo }" data-prptno="${proll.prPtno }">
  <ul class="nav nav-tabs" role="tablist">
    <li class="nav-item">
      <button type="button" class="nav-link active fs-5" role="tab" data-bs-toggle="tab" data-bs-target="#paySummary">요약</button>
    </li>
    <li class="nav-item">
      <button type="button" class="nav-link fs-5" role="tab" data-bs-toggle="tab" data-bs-target="#payBase">기본급</button>
    </li>
    <li class="nav-item">
      <button type="button" class="nav-link fs-5" role="tab" data-bs-toggle="tab" data-bs-target="#payOver">초과근무수당</button>
    </li>
    <li class="nav-item">
      <button type="button" class="nav-link fs-5" role="tab" data-bs-toggle="tab" data-bs-target="#payOther">기타수당</button>
    </li>
  </ul>
  <div class="tab-content">
  <!-- 지급 요약 TAB -->
    <div class="tab-pane fade show active" id="paySummary">
      <div class="container container-lg row ">
   	   <div class="col-4 border">
   	   		<div class="mt-5">총 지급액</div>
   	   		<div class="mt-2 fs-3"><span class="text-dark" id="paytotal"></span> 원</div>
   	   		<div class="mt-2 mb-4">대상자 <span id="payCnt"></span>명</div>
   	   </div>
   	   <div class="col-4 border">
   	   		<div class="mt-5">기본급</div>
   	   		<div class="mt-2 fs-3"><span id="WP001" class="text-dark pay-summary"></span> 원</div>
   	   		<div class="mt-2 mb-5 d-block"></div>
   	   </div>
   	   <div class="col-4 border">
   	   		<div class="mt-5">초과근무수당</div>
   	   		<div class="mt-2 fs-3"><span id="WP003" class="text-dark pay-summary"></span> 원</div>
   	   		<div class="mt-2 mb-5 d-block"></div>
   	   </div>
   	   <c:forEach items="${proll.ptmList }" var="ptm">
			<c:if test="${ptm.pyNm ne null and ptm.pyCode ne 'WP001' and ptm.pyCode ne 'WP003' }">
				   <div class="col-4 border">
			   	   		<div class="mt-5">${ptm.pyNm }</div>
			   	   		<div class="mt-2 fs-3 "><span id="${ptm.pyCode }" class="text-dark pay-summary"></span> 원</div>
			   	   		<div class="mt-2 mb-5 d-block"></div>
			   	   </div>
			</c:if>
		</c:forEach>
      </div>
    </div>
    <!-- 기본급 TAB -->
    <div class="tab-pane fade" id="payBase">
	      <div class="card">
			<h5 class="card-header">대상자</h5>
			<div class="table-responsive text-nowrap">
				<table class="table table-hover table-bordered" id="payBaseTable">
					<thead class="thead">
						<tr class="text-center align-middle">
							<th>사번</th>
							<th>이름</th>
							<th>기본급</th>
							<th>기본시급</th>
							<th>소정근무</th>
							<th>미달근무</th>
							<th>기본급차감금</th>
							<th>기본지급금</th>
						</tr>
					</thead>
					<tbody class="table-border-bottom-0">
						<c:choose>
						<c:when test="${not empty settledAlwList }">
							<c:forEach items="${settledAlwList }" var="set">
								<tr class="text-center empCntTr">
									<td>${set.empNo }</td>
									<td><strong>${set.empNm }</strong></td>
									<td class="text-end baseTd">${set.basePayMonth }</td>
									<td class="text-end baseTd">${set.basePayHour }</td>
									<td>${set.contractHour }시간</td>
									<td class="text-danger">${set.unpaidHour }</td>
									<td class="text-end baseTd">${set.unpaidAmount }</td>
									<td class="text-end baseTd baseSum paysum text-dark">${set.totalBasePayMonth }</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="7"></td>
							</tr>
						</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
    </div>
    <!-- 초과근무수당 TAB -->
    <div class="tab-pane fade" id="payOver">
	      <div class="card">
			<h5 class="card-header">대상자</h5>
			<div class="table-responsive text-nowrap">
				<table class="table table-hover table-bordered" id="payOverTable">
					<thead class="thead">
						<tr class="text-center align-middle">
							<th rowspan="2">사번</th>
							<th rowspan="2">이름</th>
							<th rowspan="2">기본시급</th>
							<th rowspan="2">인정시간</th>
							<th colspan="2">연장<span class="badge bg-label-primary fw-bold ms-3">+50% 가산</span></th>
							<th colspan="2">야간<span class="badge bg-label-primary fw-bold ms-3">+50% 가산</span></th>
							<th colspan="2">휴일<span class="badge bg-label-primary fw-bold ms-3">+50% 가산</span></th>
							<th rowspan="2">초과근무수당</th>
						</tr>
						<tr class="text-center">
							<th>근무시간</th>
							<th>금액</th>
							<th>근무시간</th>
							<th>금액</th>
							<th>근무시간</th>
							<th>금액</th>
						</tr>
					</thead>
					<tbody class="table-border-bottom-0">
						<c:choose>
						<c:when test="${not empty settledAlwList }">
							<c:forEach items="${settledAlwList }" var="set">
								<tr class="overPayTr">
									<td>${set.empNo }</td>
									<td><strong>${set.empNm }</strong></td>
									<td class="text-end baseTd">${set.basePayHour }</td>
									<td>${set.totalOvertime  }</td>
									<td>${set.extendWork     }</td>
									<td class="text-end payeach">${set.extendBonus }</td>
									<td>${set.nightWork      }</td>
									<td class="text-end payeach">${set.nightBonus  }</td>
									<td>${set.holydayWork    }</td>
									<td class="text-end payeach">${set.holydayBonus }</td>
									<td class="text-end paysum overSum text-dark">
										${set.totalOverBonus}
									</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="10">지급할 초과수당 목록이 없습니다.</td>
							</tr>
						</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
    </div>
    <!-- 기타수당 TAB -->
    <div class="tab-pane fade" id="payOther">
      <div class="card">
			<h5 class="card-header">대상자</h5>
			<div class="table-responsive text-nowrap">
				<table class="table table-hover table-bordered" id="payeditable">
					<thead class="thead">
						<tr>
							<th>사번</th>
							<th>이름</th>
							<c:set var="ptmList" value="${proll.ptmList }" />
							<c:if test="${not empty ptmList}">
								<c:forEach items="${ptmList}" var="ptm">
									<c:choose>
									<c:when test="${ptm.pyNm ne null and ptm.pyCode eq 'WP014'}">
										<th>${ptm.pyNm } (계약금액)</th>
									</c:when>
									<c:when test="${ptm.pyNm ne null and ptm.pyCode ne 'WP001'and ptm.pyCode ne 'WP003' and ptm.pyCode ne 'WP014' }">
										<th>${ptm.pyNm }</th>
									</c:when>
									</c:choose>
								</c:forEach>
							</c:if>
							<th class="text-end">기타수당 합계</th>
						</tr>
					</thead>
					<tbody class="table-border-bottom-0">
						<c:choose>
						<c:when test="${not empty settledAlwList }">
							<c:forEach items="${settledAlwList}" var="set">
							<tr>
								<td>${set.empNo }</td>
								<td>${set.empNm }</td>
								<c:set var="ptmList" value="${proll.ptmList }" />
								<c:if test="${not empty ptmList}">
									<c:forEach items="${ptmList}" var="ptm">
										<c:choose>
										<c:when test="${ptm.pyNm ne null and ptm.pyCode eq 'WP014' and ptm.pyCode ne 'WP003' }">
											<td class="payeach payeachEdit text-end" data-pycode="${ptm.pyCode }" data-pynm="${ptm.pyNm }">${set.mealAllowance }</td>
										</c:when>
										<c:when test="${not empty ptm.pyNm and ptm.pyCode ne 'WP001' and ptm.pyCode ne 'WP003' and ptm.pyCode ne 'WP014'  }">
											<td class="payeach payeachEdit text-end" contenteditable="true" data-pycode="${ptm.pyCode }" data-pynm="${ptm.pyNm }">${ptm.ppyAmt }</td>
										</c:when>
										</c:choose>
									</c:forEach>
								</c:if>
								<td class="paysum text-end text-dark"></td>
							</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="3">지급할 기타수당 목록이 없습니다.</td>
							</tr>
						</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
    </div>
  </div>
</div>

<form:form modelAttribute="proll" id="moveForm" method="post" action="${cPath }/pay/wageDed.do">
   <form:hidden path="prNo"/>
   <form:hidden path="prPtno"/>
</form:form>


<script>

$(function(){
	$('#step2').css('color', '#4d4d4d');
	$('#icon1').removeClass('bxs-group').addClass('bxs-check-circle').css('color', '#07b419');
	
	selectTd(); //기본시급 천단위 반영
});


//td값 천단위 반영
function selectTd(){
	$(".baseTd").each(function(){
		let baseAmt = parseInt($(this).text());
		$(this).text(priceToString(baseAmt));
	});
}

//천단위 지정
function priceToString(price) {
    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

//천단위 해제
function removeToString(price){
	price = price.replace(/[^\d]+/g, "");
    return price;  
}

//요약 - 기본급, 초과수당 합계 계산
$(function(){
	let bSum = 0;
	$('#payBaseTable tr').each(function(){
		let basePay = $(this).find('.baseSum').text();
		let b = parseInt(removeToString(basePay));
		if(isNaN(b)) b = 0;
		bSum += b;
	})
		$('#WP001').text(priceToString(bSum));
	
	
	let oSum = 0;
	$('#payOverTable tr').each(function(){
		let overPay = $(this).find('.overSum').text();
		let o = parseInt(removeToString(overPay));
		if(isNaN(o)) o = 0;
		oSum += o;
	})
		$('#WP003').text(priceToString(oSum));



// 사원별, 항목별 수당 합계 계산
	let payeach = $(".payeach").bind("blur", function() {
		
		let ptr = $(this).parents('tr');
		let colSum = 0;
		let rowSum = 0;
		let modified;
		let c;
		
		//사원별 합계
		ptr.find('.payeach').each(function(){
			$this = $(this)
		    modified = $this.text();
		    console.log("modified"+modified);
		    c = parseInt(removeToString(modified));
			if(isNaN(c)) c = 0;
		   	colSum += c;
		   	$this.text(priceToString(modified));
		});
		
		
		ptr.find('.paysum').text(priceToString(colSum));
		
		let curCol = ptr.find('.payeachEdit').index($(this));
		$('table tr').each(function(){
			let z = parseInt(removeToString($(this).find('.payeachEdit').eq(curCol).text()));
			if(isNaN(z)) z = 0;
			rowSum += z;
		});
		
		let pyCode = $(this).data('pycode');
		console.log(pyCode);
		$('#'+pyCode).text(priceToString(rowSum));
		
		
		//----------------------------------------------------------
		//총 지급액 계산
		let paytotal = 0;
		$(".pay-summary").each(function() {
			let checking = parseInt(removeToString($(this).text()));
			paytotal += checking;
		});
		$('#paytotal').text(priceToString(paytotal));
		
		let empCnt = $('.empCntTr').length;
		$('#payCnt').text(empCnt);
		
	}).trigger('blur');

})



//항목 폰트 색상 변경
$(document).ready(function () {
  $(document).on("change keyup paste", ".payeach", function () {
	  $this = $(this);
	  $this.css('color', '#ff471a');
	  $this.parents('tr').find('.paysum').css('color', '#ff471a');
  });
});


//공제항목 버튼 클릭 시 실행되는 함수 , 화면에서 조회하는 지급 내역을 정산 기록 테이블에 추가한다	
function makeData(){
	let contents = [];
	
	//기타수당
	let tbl = document.querySelector("#payeditable");
	let trs = tbl.getElementsByTagName("tr");

	//각 tr의 td가 가지고있는 key,value 값을 객체(payrcd)에 추가 후 배열(contents)에 넣는다
	for(let i=1; i<trs.length; i++){
		let tds = trs[i].children;
		let empNo = tds[0].innerHTML;
		
		for(let j=2; j<tds.length-1; j++){
			let payrcd = {};
			payrcd.prNo = prNo; 	  //정산번호
			payrcd.empNo = empNo;     //사원번호
			let codeAmt = removeToString(tds[j].innerHTML);
			let codeCd = tds[j].dataset['pycode'];
			let codeNm = tds[j].dataset['pynm'];
			console.log(codeCd);
			payrcd.codeAmt = codeAmt; //항목금액
			payrcd.codeCd = codeCd;   //항목코드
			payrcd.codeNm = codeNm;   //항목명
			contents.push(payrcd);
		}
		console.log("---------------------");
		console.log(contents);
	}
	
//=================================================
	//기본급
	let btbl = document.querySelector ("#payBaseTable");
	let btrs = btbl.getElementsByTagName("tr");
	
	for(let b=1; b<btrs.length; b++){
		let btds = btrs[b].children;
		empNo = btds[0].innerHTML;
		codeAmt = removeToString(btds[6].innerHTML);
		codeCd = 'WP001';
		codeNm = '기본급';
		
		let payrcd = {};
		payrcd.prNo = prNo;
		payrcd.empNo = empNo;
		payrcd.codeAmt = codeAmt;
		payrcd.codeCd = codeCd;
		payrcd.codeNm = codeNm;
		contents.push(payrcd);
	}
	
	//초과근무수당
	let ntbl = document.querySelector("#payOverTable");
	let ntrs = ntbl.getElementsByTagName("tr");
	
	for(let n=2; n<ntrs.length; n++){
		let ntds = ntrs[n].children;
		empNo = ntds[0].innerHTML;
		codeAmt = removeToString(ntds[10].innerHTML);
		codeCd = 'WP003';
		codeNm = '초과근무수당';
		
		let payrcd = {};
		payrcd.prNo = prNo;
		payrcd.empNo = empNo;
		payrcd.codeAmt = codeAmt;
		payrcd.codeCd = codeCd;
		payrcd.codeNm = codeNm;
		contents.push(payrcd);
	}
	
	
//=================================================
	
	//배열을 리스트화한다.
	let data = JSON.stringify(contents);
	
	$.ajax({
		url : "${cPath}/pay/payrcdInsert.do",
		method : "POST",
		data : data,
		contentType: "application/json; charset=utf-8",
		dataType : "JSON",
		success : function(resp) {
	         toastr.success("지급 항목이 확정되었습니다.");
	         setTimeout(delay,1000); //1초 딜레이 후 공제항목 페이지로 이동
		},
		error : function(errorResp) {
			toastr.error("지급 항목 확정 중 오류가 발생했습니다.")
			console.log(errorResp.status);
		}
	});
}


//공제항목 버튼 클릭 시 함수 실행
$(".mvbtn").on("click", function(){
	makeData(); 	
});

let prNo = $("#mainPayTab").data("prno");
let prPtno = $("#mainPayTab").data("prptno");


//ajax 성공 시 페이지 이동 딜레이
function delay(){
	let moveForm = $("#moveForm");
	moveForm.find('[name=prNo]').val(prNo);
    moveForm.find('[name=prPtno]').val(prPtno);
  	moveForm.submit();
}

</script>