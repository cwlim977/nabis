<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/pay/wage/wageStepIncld.jsp"/>

<link rel="stylesheet" href="${cPath }/resources/css/ijs.css" />


<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item">
      <a href="#">${proll.ptNm }</a>
    </li>
    <li class="breadcrumb-item active text-dark">${proll.prNm }</li>
  </ol>
  <h3 class="fw-bold text-dark">결과 미리보기</h3>
  <div class="text-lg-end">
   <button type="button" class="btn btn-success mvbtn">
	<i class='bx bx-check'></i> 정산 완료
  </button>
  </div>
</nav>


<div class="nav-align-top" id="mainPrevTab" data-prno="${proll.prNo }">
  <ul class="nav nav-tabs" role="tablist">
    <li class="nav-item">
      <button type="button" class="nav-link active fs-5" role="tab" data-bs-toggle="tab" data-bs-target="#prevSumm">요약</button>
    </li>
    <li class="nav-item">
      <button type="button" class="nav-link fs-5" role="tab" data-bs-toggle="tab" data-bs-target="#prevDetail">상세내역</button>
    </li>
  </ul>
  <div class="tab-content">
  <!-- 미리보기 요약 TAB -->
    <div class="tab-pane fade show active" id="prevSumm">
      	  <div class="card">
			<br>
			<div class="table-responsive text-nowrap">
				<c:if test="${not empty totalList}">
					<table class="table table-hover table-bordered">
						<thead class="thead">
							<tr class="text-center">
	                          <th rowspan="2" class="align-middle">항목</th>
	                          <th colspan="2">${fn:substring(proll.prBlg,5,7) }월 <span class="badge bg-label-dark text-dark fw-bold">이번 정산</span></th>
	                          <th colspan="2">${fn:substring(prevBlg,5,7) }월 <span class="badge bg-label-dark text-dark fw-bold">지난 정산</span></th>
	                          <th colspan="2">지난 정산 대비</th>                   
	                        </tr>
	                        <tr>  
	                          <th>정산대상자</th>
	                          <th class="text-end">금액</th>
	                          <th>정산대상자</th>
	                          <th class="text-end">금액</th>
	                          <th class="text-end">금액</th>
	                          <th>증감률</th>
	                        </tr>
						</thead>
						<tbody class="table-border-bottom-0">
							<tr class="text-green fw-bold">
								<td class="fw-bold">지급 계</td>
								<td>-</td>
								<c:forEach items="${totalList }" var="ttl">
									<c:if test="${ttl.codeNo eq null and ttl.clf eq 'P' }">
										<td class="text-end fw-bold" id="alwTotal" data-pytl="${ttl.totalAmt }">
											<fmt:formatNumber value="${ttl.totalAmt }" pattern="#,###"/> 원
										</td>
										<c:set var="payCnt"   value="${ttl.totalCnt }"/>
										<c:set var="payTotal" value="${ttl.totalAmt }" />
									</c:if>
								</c:forEach>
								<td>-</td>
								<c:choose>
								<c:when test="${not empty prevTotalList }">
									<c:forEach items="${prevTotalList }" var="ptl">
									<c:if test="${ptl.codeNo eq null and ptl.clf eq 'P' }">
										<td class="text-end" id="prevAlwTotal">
											<fmt:formatNumber value="${ptl.totalAmt }" pattern="#,###"/> 원
										</td>
										<c:set var="prevPayCnt"   value="${ptl.totalCnt }"/>
										<c:set var="prevPayTotal" value="${ptl.totalAmt }" />
										<td class="text-end"><fmt:formatNumber value="${payTotal - prevPayTotal }" pattern="#,###"/> 원</td>
										<td class="text-end"><fmt:formatNumber value="${(payTotal-prevPayTotal)/payTotal }" type="percent"/></td>
									</c:if>
								</c:forEach>
								</c:when>
								<c:otherwise>
									<td>-</td>
									<td>-</td>
									<td>100%</td>
								</c:otherwise>
								</c:choose>
							</tr>
							<c:if test="${not empty sumList}">
								<c:forEach items="${sumList}" var="sum" varStatus="status">
									<c:set value="${status.end}" var="se" />
									<c:if test="${not empty sum.codeNm and sum.clf eq 'P' }">
										<tr><!-- foreach here -->
											<td class="ps-5">${sum.codeNm }</td>
											<td>${sum.empCnt }</td>
											<td class="text-end"><fmt:formatNumber value="${sum.sumAmt }" pattern="#,###"/></td>
											<c:choose>
											<c:when test="${not empty prevSumList }">
												<c:forEach items="${prevSumList }" var="psum">
													<c:if test="${psum.codeNm eq sum.codeNm }">
														<td>${psum.empCnt }</td>
														<td class="text-end"><fmt:formatNumber value="${psum.sumAmt }" pattern="#,###"/></td>
														<td class="text-end"><fmt:formatNumber value="${sum.sumAmt - psum.sumAmt }" pattern="#,###"/></td>
														<td class="text-end"><fmt:formatNumber value="${(sum.sumAmt-psum.sumAmt)/sum.sumAmt }" type="percent"/></td>
													</c:if>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<td>0</td>
												<td>0</td>
												<td>0</td>
												<td>0%</td>
											</c:otherwise>
											</c:choose>
											
										</tr>
									</c:if>
								</c:forEach>
							</c:if>
							<tr class="text-green fw-bold">
								<td class="fw-bold">공제 계</td>
								<td>-</td>
								<c:forEach items="${totalList }" var="ttl">
									<c:if test="${ttl.codeNo eq null and ttl.clf eq 'D' }">
										<td class="text-end fw-bold" id="dedTotal" data-ddtl="${ttl.totalAmt }">
											<fmt:formatNumber value="${ttl.totalAmt }" pattern="#,###"/> 원
										</td>
										<c:set var="dedCnt"   value="${ttl.totalCnt }"/>
										<c:set var="dedTotal" value="${ttl.totalAmt }" />
									</c:if>
								</c:forEach>
								<td>-</td>
								<c:choose>
								<c:when test="${not empty prevTotalList }">
									<c:forEach items="${prevTotalList }" var="ptl">
									<c:if test="${ptl.codeNo eq null and ptl.clf eq 'D' }">
										<td class="text-end fw-bold" id="prevDedTotal">
											<fmt:formatNumber value="${ptl.totalAmt }" pattern="#,###"/> 원
										</td>
										<c:set var="prevDedCnt"   value="${ptl.totalCnt }"/>
										<c:set var="prevDedTotal" value="${ptl.totalAmt }" />
										<td class="text-end"><fmt:formatNumber value="${dedTotal-prevDedTotal }" pattern="#,###"/> 원</td>
										<td class="text-end"><fmt:formatNumber value="${(dedTotal-prevDedTotal)/dedTotal }" type="percent"/></td>
									</c:if>
								</c:forEach>
								</c:when>
								<c:otherwise>
									<td>-</td>
									<td>-</td>
									<td>100%</td>
								</c:otherwise>
								</c:choose>
							</tr>
							<c:if test="${not empty sumList}">
								<c:forEach items="${sumList}" var="sum">
									<c:if test="${not empty sum.codeNm and sum.clf eq 'D' }">
										<tr><!-- foreach here -->
											<td class="ps-5">${sum.codeNm }</td>
											<td>${sum.empCnt }</td>
											<td class="text-end"><fmt:formatNumber value="${sum.sumAmt }" pattern="#,###"/></td>
											<c:choose>
											<c:when test="${not empty prevSumList }">
												<c:forEach items="${prevSumList }" var="psum">
													<c:if test="${psum.codeNm eq sum.codeNm }">
														<td>${psum.empCnt }</td>
														<td class="text-end"><fmt:formatNumber value="${psum.sumAmt }" pattern="#,###"/></td>
														<td class="text-end"><fmt:formatNumber value="${sum.sumAmt - psum.sumAmt }" pattern="#,###"/></td>
														<td class="text-end"><fmt:formatNumber value="${(sum.sumAmt-psum.sumAmt)/sum.sumAmt }" type="percent"/></td>
													</c:if>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<td>0</td>
												<td>0</td>
												<td>0</td>
												<td>0%</td>
											</c:otherwise>
											</c:choose>
										</tr>
									</c:if>
								</c:forEach>
							</c:if>
							<tr class="text-green fw-bold">
								<td class="fw-bold">실지급액</td>
								<td id="totalCnt fw-bold">
									<c:choose>
										<c:when test="${payCnt gt dedCnt }"><c:out value="${payCnt}" />명</c:when>
										<c:when test="${payCnt eq dedCnt }"><c:out value="${payCnt}" />명</c:when>
										<c:otherwise><c:out value="${dedCnt}" />명</c:otherwise>
									</c:choose>
								</td>
								<c:set value="${payTotal - dedTotal }" var="realTotal" /> <!-- 이번정산 실지급액 -->
								<td class="text-end fw-bold" id="realTotal" data-tlamt=${realTotal }><fmt:formatNumber value="${realTotal }" pattern="#,###"/> 원</td>
								<td>													  <!-- 이번정산  대상자 수-->
									<c:choose>
										<c:when test="${prevPayCnt gt prevDedCnt }"><c:out value="${prevPayCnt}" />명</c:when>
										<c:when test="${prevPayCnt eq prevDedCnt }"><c:out value="${prevPayCnt}" />명</c:when>
										<c:otherwise><c:out value="${prevDedCnt}" />명</c:otherwise>
									</c:choose>
								</td>
								<c:set value="${prevPayTotal - prevDedTotal }" var="prevRealTotal" />
								<td class="text-end"><fmt:formatNumber value="${prevRealTotal }" pattern="#,###"/> 원</td>
								<td class="text-end"><fmt:formatNumber value="${realTotal - prevRealTotal }" pattern="#,###"/> 원</td>
								<td class="text-end"><fmt:formatNumber value="${(realTotal-prevRealTotal)/realTotal }" type="percent"/></td>
							</tr>
						</tbody>
					</table>
				</c:if>
			</div>
		</div>
    </div>
<!-- 미리보기 상세 TAB ========================================================================================-->
    <div class="tab-pane fade" id="prevDetail">
	      <div class="card">
	      	<div class="clearfix my-3">
				<h5 class="card-header float-left d-inline pe-1 fw-semibold text-dark">대상자</h5> 
				<h5 class="float-left d-inline text-green fw-bold">
				<c:choose>
					<c:when test="${payCnt gt dedCnt }"><c:out value="${payCnt}" /></c:when>
					<c:when test="${payCnt eq dedCnt }"><c:out value="${payCnt}" /></c:when>
					<c:otherwise><c:out value="${dedCnt}" /></c:otherwise>
				</c:choose>
				</h5>
			</div>
			<div class="table-responsive text-nowrap">
					<table class="table table-hover table-bordered">
					<thead class="thead">
						<tr class="text-center align-middle">
                          <th rowspan="2">사번</th>
                          <th rowspan="2">이름</th>
                          <th rowspan="2">계약유형</th>
                          <th rowspan="2">조직</th>
                          <th rowspan="2">직위</th>
                          <th rowspan="2">직책</th>
                          <th rowspan="2">직무</th>
                          <th rowspan="2">재직상태</th>
                          <th id="pyTh">지급</th>
                          <th id="ddTh">공제</th>
                          <th rowspan="2">실지급액</th>                   
                        </tr>
						<tr>
							<c:set var="ptmList" value="${proll.ptmList }" /> <!-- 지급항목 -->
							<c:if test="${not empty ptmList}">
								<c:forEach items="${ptmList }" var="ptm">
									<c:if test="${ptm.pyCode ne null }" >
										<th class="pyArea">${ptm.pyNm }</th>
									</c:if>
								</c:forEach>
								<th class="pyArea text-end">계</th>			  <!-- 공제항목 -->
								<c:forEach items="${ptmList }" var="ptm">
									<c:if test="${ptm.ddCode ne null }" >
										<th class="ddArea">${ptm.ddNm }</th>
									</c:if>
								</c:forEach>
								<th class="ddArea text-end">계</th>
							</c:if>
						</tr>
					</thead>
					<tbody class="table-border-bottom-0">
						<c:if test="${not empty settledEmpList }">
							<c:forEach items="${settledEmpList }" var="emp">
								<tr>
									<td>${emp.empNo }</td>									<!-- 사번 -->
									<td>${emp.empNm }</td>									<!-- 사원이름 -->
									<td>${emp.entCase }</td>								<!-- 계약유형 -->
									<td>
										<c:if test="${not empty emp.deptList }">
											<c:forEach items="${emp.deptList }" var="dept">
												${dept.dnm }								<!-- 조직 -->
											</c:forEach>
										</c:if>
									</td>
									<td>${emp.ptnNm }</td>									<!--직위 -->
									<td>
										<c:choose>
										<c:when test="${not empty emp.deptList }">
											<c:forEach items="${emp.deptList }" var="dept">
												${dept.dtnm }								<!--직책 -->
											</c:forEach>
										</c:when>
										<c:otherwise>
											-
										</c:otherwise>
										</c:choose>	
									</td>
									<td>
										<c:if test="${not empty emp.jobList }">
<%-- 											<c:forEach items="${emp.jobList }" var="job"> --%>
<%-- 												${job.jnm }									<!-- 직무 --> --%>
<%-- 											</c:forEach> --%>
											<c:forEach items="${emp.jobList }" var="job">
												<c:forTokens var="item" items="${job.jnm}" delims=",">
													${item}
												</c:forTokens>								<!--직책 -->
											</c:forEach>
										</c:if>
									</td>
									<td>													<!-- 재직상태 -->
										<c:choose>
											<c:when test="${emp.empSt eq '재직중'}">
												<span class="badge me-1 badge-green">재직</span>
											</c:when>
											<c:otherwise>
												<span class="badge bg-label-warning me-1">퇴직</span> 
											</c:otherwise>
										</c:choose>
									</td>
									<c:set var="dtPayTotal" value="0" />
									<c:set var="dtDedTotal" value="0" />
									<c:if test="${not empty settledDetailList }">
										<c:forEach items="${settledDetailList }" var="sdl"> <!-- 지급항목 금액 -->
											<c:if test="${emp.empNo eq sdl.empNo and sdl.clf eq 'P' and sdl.codeAmt ne null}">
												<c:set var="dtPayTotal" value="${dtPayTotal + sdl.codeAmt }"/>
												<td class="text-end"><fmt:formatNumber value="${sdl.codeAmt }" pattern="#,###"/></td>
											</c:if>
										</c:forEach>
										<td class="text-end"><fmt:formatNumber value="${dtPayTotal }" pattern="#,###"/></td>
										<c:forEach items="${settledDetailList }" var="sdl">	<!-- 공제항목 금액 -->
											<c:if test="${emp.empNo eq sdl.empNo and sdl.clf eq 'D' and sdl.codeAmt ne null}">
												<c:set var="dtDedTotal" value="${dtDedTotal + sdl.codeAmt }"/>
												<td class="text-end"><fmt:formatNumber value="${sdl.codeAmt }" pattern="#,###"/></td>
											</c:if>
										</c:forEach>
									</c:if>
									<td class="text-end"><fmt:formatNumber value="${dtDedTotal }" pattern="#,###"/></td>
									<td class="text-end"><fmt:formatNumber value="${dtPayTotal - dtDedTotal }" pattern="#,###"/></td> <!-- 사원별 실지급액 -->
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

<form:form modelAttribute="proll" id="moveForm" method="post" action="${cPath }/pay/wageRes.do">
   <form:hidden path="prNo"/>
   <form:hidden path="prPtno"/>
</form:form>



<script>

//정산 완료 버튼 클릭 시 페이지 이동
$(".mvbtn").on("click", function(){
	completePayroll();
 });
 
$(function(){
	$('#step4').css('color', '#4d4d4d');
	$('#icon1').removeClass('bxs-group').addClass('bxs-check-circle').css('color', '#07b419');
	$('#icon2').removeClass('bx-money').addClass('bxs-check-circle').css('color', '#07b419');
	$('#icon3').removeClass('bx-bookmark-alt-minus').addClass('bxs-check-circle').css('color', '#07b419');
	
	makeTh();
});


//템플릿 정보에 따른 공제항목 테이블 th 동적 생성
function makeTh(){
	let pyArea  = $('.pyArea').length;
	let ddArea  = $('.ddArea').length;
    $('#pyTh').attr('colspan', pyArea);
    $('#ddTh').attr('colspan', ddArea);
}


// 정산 완료 버튼 클릭 시 해당 정산의 정보를 수정한다.
function completePayroll(){
	
	let prNo  = $("#mainPrevTab").data("prno"); //정산번호
	let pytl  = $("#alwTotal").data("pytl");	//지급총액
	let ddtl  = $("#dedTotal").data("ddtl");	//공제총액
	let tlamt = $("#realTotal").data("tlamt");	//실지급액
	
	$.ajax({
		url : "updateProllFin.do",
		method : "POST",
		data : {
		 	  prNo : prNo
			, pytl : pytl
			, ddtl : ddtl
			, tlamt : tlamt
		},
		success : function(resp) {
			console.log(resp);
			setTimeout(delay,1000);
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
	
}

//ajax 성공 시 페이지 이동 딜레이
function delay(){
	let moveForm = $("#moveForm");
  	moveForm.submit();
}







</script>