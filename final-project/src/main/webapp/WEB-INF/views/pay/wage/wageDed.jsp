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
  <h3 class="text-dark fw-bold">공제항목</h3>
  <div class="text-lg-end">
   <button type="button" class="btn btn-success mvbtn">
	<i class='bx bx-right-arrow-alt'></i> 결과 미리보기
  </button>
  </div>
</nav>


<div class="nav-align-top" id="mainDedTab" data-prno="${proll.prNo }" data-prptno="${proll.prPtno }" data-sdate="${proll.prSdate }" data-edate="${proll.prEdate }">
  <ul class="nav nav-tabs" role="tablist">
    <li class="nav-item">
      <button type="button" class="nav-link active fs-5" role="tab" data-bs-toggle="tab" data-bs-target="#dedSummary">요약</button>
    </li>
    <li class="nav-item">
      <button type="button" class="nav-link fs-5" role="tab" data-bs-toggle="tab" data-bs-target="#dedOther">공제내역</button>
    </li>
  </ul>
  <div class="tab-content">
  <!-- 공제 요약 TAB -->
    <div class="tab-pane fade show active" id="dedSummary">
      <div class="container container-lg row">
      	<div class="col-4 border">
   	   		<div class="mt-5">총 공제액</div>
   	   		<div class="mt-2 fs-3"><span class="text-dark" id="dedtotal"></span> 원</div>
   	   		<div class="mt-2 mb-4 fs-tiny">대상자 <span id="dedCnt"></span>명</div>
   	   </div>
   	   <c:forEach items="${proll.ptmList }" var="ptm">
			<c:if test="${ptm.ddNm ne null}">
		   		<div class="col-4 border">
	   		   		<div class="mt-5">${ptm.ddNm }</div>
	   		   		<div class="mt-2 fs-3"><span class="text-dark ded-summary" id="${ptm.ddCode }"></span> 원</div>
	   	   			<div class="mt-2 mb-5 d-block"> </div>
	   	   		</div>
	   	   	</c:if>
		</c:forEach>
      </div>
    </div>
   <!-- 공제내역 TAB -->
    <div class="tab-pane fade" id="dedOther">
	      <div class="card  overflow-hidden">
			<h5 class="card-header">대상자</h5>
			<div class="card-body" id="horizontal">
			<div class="table-responsive text-nowrap">
				<table class="table table-hover table-bordered m-2" id="dededitible">
					<thead class="thead">
						<tr class="text-center align-middle">
							<th rowspan="2" class="text-start">사번</th>
							<th rowspan="2">이름</th>
							<th rowspan="2">공제대상<br>가족 수</th> 
							<th rowspan="2">과세총액</th>
							<th id="withhold">원천세</th>
							<th id="insuarance">사대보험</th>
							<th id="others">기타공제</th>
							<th rowspan="2">공제금액 합계</th>
						</tr> 
						<tr>
							<c:set var="ptmList" value="${proll.ptmList }" />
							<c:if test="${not empty ptmList}">
								<c:forEach items="${ptmList }" var="ptm">
									<c:if test="${ptm.ddNm ne null and ptm.ddPrCode eq 'WD100' }">
										<th class="text-center withArea">${ptm.ddNm }</th>
									</c:if>
								</c:forEach>
								
								<c:forEach items="${ptmList }" var="ptm">
									<c:if test="${ptm.ddNm ne null and ptm.ddPrCode eq 'WD200' }">
										<th class="text-center insArea">${ptm.ddNm }</th>
									</c:if>
								</c:forEach>
								
								<c:forEach items="${ptmList}" var="ptm">
									<c:if test="${ptm.ddNm ne null and ptm.ddPrCode eq 'WD300'}">
										<th class="text-center otherArea">${ptm.ddNm }</th>
									</c:if>
								</c:forEach>
								
							</c:if>
						</tr>
					</thead>
					<tbody class="table-border-bottom-0">
						<c:if test="${not empty settledTaxList}">
							<c:forEach items="${settledTaxList}" var="set">
								<tr>
									<td>${set.empNo }</td>								<!-- 사원번호 -->
									<td><strong>${set.empNm }</strong></td>				<!-- 사원이름 -->
									<td>${set.famCnt } 명</td>							<!-- 공제대상가족수 -->
									<td class="taxable text-end" data-taxable=${set.taxable }>${set.taxable }</td>			<!-- 과세금액 -->
									<c:set var="ptmList" value="${proll.ptmList }" />
									<c:if test="${not empty ptmList}">
										<c:forEach items="${ptmList}" var="ptm">
											<c:if test="${ptm.ddPrCode eq 'WD100' and not empty ptm.ddNm}">
												<td class="dedeach text-end" data-ddcode="${ptm.ddCode }" data-ddnm="${ptm.ddNm }">
													<c:choose>
														<c:when test="${ptm.ddCode eq 'WD101' }">${set.incomeTax 	  }</c:when>
														<c:when test="${ptm.ddCode eq 'WD102' }">${set.incomeTaxLocal }</c:when>
														<c:otherwise>
														</c:otherwise>
													</c:choose>
												</td>
											</c:if>
										</c:forEach>
										<c:forEach items="${ptmList}" var="ptm">
											<c:if test="${ptm.ddPrCode eq 'WD200' and not empty ptm.ddNm }">
												<td class="dedeach text-end" data-ddcode="${ptm.ddCode }" data-ddnm="${ptm.ddNm }">
													<c:choose>
														<c:when test="${ptm.ddCode eq 'WD201' }">${set.pension 		  }</c:when>
														<c:when test="${ptm.ddCode eq 'WD202' }">${set.health 	 	  }</c:when>
														<c:when test="${ptm.ddCode eq 'WD203' }">${set.longcare 	  }</c:when>
														<c:when test="${ptm.ddCode eq 'WD204' }">${set.employIns 	  }</c:when>
														<c:otherwise>
														</c:otherwise>
													</c:choose>
												</td>
											</c:if>
										</c:forEach>
										<c:forEach items="${ptmList}" var="ptm">
											<c:if test="${ptm.ddPrCode eq 'WD300' and not empty ptm.ddNm }">
												<td class="dedeach text-end" contenteditable="true" data-ddcode="${ptm.ddCode }" data-ddnm="${ptm.ddNm }">${ptm.pddAmt}</td>
											</c:if>
										</c:forEach>
									</c:if>
									<td class="dedsum text-end">합계</td>
								</tr>
						</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
			</div>
		</div>
    </div>
  </div>
</div>


<form:form modelAttribute="proll" id="moveForm" method="post" action="${cPath }/pay/wagePrev.do">
   <form:hidden path="prNo"/>
   <form:hidden path="prPtno"/>
   <form:hidden path="prSdate"/>
   <form:hidden path="prEdate"/>
</form:form>


<script>

$(function(){
	$('#step3').css('color', '#4d4d4d');
	$('#icon1').removeClass('bxs-group').addClass('bxs-check-circle').css('color', '#07b419');
	$('#icon2').removeClass('bx-money').addClass('bxs-check-circle').css('color', '#07b419');
	
	//과세금액 천단위 반영
	selectTd();
	makeTh();
});


//템플릿 정보에 따른 공제항목 테이블 th 동적 생성
function makeTh(){
	let withLen  = $('.withArea').length;
	let insLen   = $('.insArea').length;
	let otherLen = $('.otherArea').length;
    $('#withhold').attr('colspan', withLen);
    $('#insuarance').attr('colspan', insLen);
    $('#others').attr('colspan', otherLen);
}


//과세금액 td값 천단위 반영
function selectTd(){
	$(".taxable").each(function(){
		let totalTax = parseInt($(this).text());
		$(this).text(priceToString(totalTax));
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

//사원별, 항목별 공제 합계 계산
$(function(){
	
	let dedeach = $(".dedeach").bind("blur", function() {
		
		let ptr = $(this).parents('tr');
		let colSum = 0;
		let rowSum = 0;
		let modified;
		let c;
		
		//사원별 합계
		
		ptr.find('.dedeach').each(function(){
		    $this = $(this);
			modified = $this.text();
		    console.log("modified"+modified);
		    c = parseInt(removeToString(modified));
			if(isNaN(c)) c = 0;
		   	colSum += c;
		   	$this.text(priceToString(modified));
		});
		
		ptr.find('.dedsum').text(priceToString(colSum));
	
		//요약 - 항목별 합계
		let curCol = ptr.find('.dedeach').index($(this));
		$('table tr').each(function(){
			let z = parseInt(removeToString($(this).find('.dedeach').eq(curCol).text()));
			if(isNaN(z)) z = 0;
			rowSum += z;
		});
		
		let ddCode = $(this).data('ddcode');
		console.log(ddCode);
		$('#'+ddCode).text(priceToString(rowSum));

		
		//요약 - 총대상자수
		let dedCnt = $('.taxable').length;
		$('#dedCnt').text(dedCnt);
		
		//--------------------------------------------------
		//총 공제액 계산
		let dedtotal = 0;
		$('.ded-summary').each(function(){
			let dedsumm = parseInt(removeToString($(this).text()));
			if(isNaN(dedsumm)) dedsumm = 0;
			dedtotal += dedsumm;
		})
		$('#dedtotal').text(priceToString(dedtotal));
		
	}).trigger('blur');
})

//항목 폰트 색상 변경
$(document).ready(function () {
  $(document).on("change keyup paste", ".dedeach", function () {
	  $this = $(this);
	  $this.css('color', '#ff471a');
	  $this.parents('tr').find('.dedsum').css('color', '#ff471a');
  });
});

let prNo    = $("#mainDedTab").data("prno");
let prPtno  = $("#mainDedTab").data("prptno");
let prSdate = $("#mainDedTab").data("sdate");
let prEdate = $("#mainDedTab").data("edate");

let tbl = document.querySelector("#dededitible"); //금액이 수정가능한 공제항목
let trs = tbl.getElementsByTagName("tr");

//확정하기 버튼 클릭 시 실행되는 함수 , 화면에서 조회하는 공제 내역을 정산 기록 테이블에 추가한다	
function makeData(){
	
	let contents = []; //급여정산 기록 등록 시 사용

	//각 tr의 td가 가지고있는 key,value 값을 객체(payrcd)에 추가 후 배열(contents)에 넣는다
	for(let i=2; i<trs.length; i++){
		let tds = trs[i].children;
		let empNo = tds[0].innerHTML;
		
		for(let j=4; j<tds.length-1; j++){
			let dedrcd = {};
			dedrcd.prNo = prNo;			//정산번호
			dedrcd.empNo = empNo;       //사원번호
			let codeAmt = removeToString(tds[j].innerHTML);
			let codeCd = tds[j].dataset['ddcode'];
			let codeNm = tds[j].dataset['ddnm'];
			dedrcd.codeAmt = codeAmt;   //항목금액
			dedrcd.codeCd = codeCd;     //항목코드
			dedrcd.codeNm = codeNm;     //항목명
			contents.push(dedrcd);
			
		}
		
		console.log("---------------------");
		console.log("확인"+contents);
	}
	//배열을 리스트화한다.
	let data = JSON.stringify(contents);
	
	$.ajax({
		url : "${cPath}/pay/payrcdInsert.do",
		method : "POST",
		data : data,
		contentType: "application/json; charset=utf-8",
		dataType : "JSON",
		success : function(resp) {
	         toastr.success("공제 항목이 확정되었습니다.");
	         setTimeout(delay,1000); //1초 딜레이 후 정산 미리보기 페이지로 이동
		},
		error : function(errorResp) {
			toastr.error("공제 항목 확정 중 오류가 발생했습니다.")
			console.log(errorResp.status);
		}
	});
	
}

//확정하기 버튼 클릭 시 함수 실행
$(".mvbtn").on("click", function(){
	makeData(); 	
});

//ajax 성공 시 페이지 이동 딜레이
function delay(){
	let moveForm = $("#moveForm");
	moveForm.find('[name=prNo]').val(prNo);
  	moveForm.find('[name=prPtno]').val(prPtno);
  	moveForm.find('[name=prSdate]').val(prSdate);
  	moveForm.find('[name=prEdate]').val(prEdate);
  	moveForm.submit();
}


// $(function(){
// new PerfectScrollbar(document.getElementById('horizontal'), {
//   suppressScrollY: true,
//   wheelPropagation: false
// });
// })



</script>