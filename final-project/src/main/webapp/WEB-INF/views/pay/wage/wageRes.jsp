<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/pay/wage/wageStepIncld.jsp"/>

<div class="conainter-fluid">
	<nav aria-label="breadcrumb">
	  <ol class="breadcrumb">
	    <li class="breadcrumb-item">
	      <a href="#">${proll.ptNm }</a>
	    </li>
	    <li class="breadcrumb-item active text-dark">${proll.prNm }</li>
	  </ol>
	</nav>
	
	<div class="mb-4" id="resTitleDiv" data-prno="${proll.prNo }" data-gdate="${proll.prGdate }">
		<h4 class="text-dark fw-bold">정산을 완료했습니다 <i class='bx bxs-magic-wand bx-sm'></i></h4>
	</div>
	
	<div class="row">
	 <div class="col-12 mb-3">
	   <div class="card overflow-hidden p-3 resTopCard">
	     <div class="card-body">
	     	<div class="divres w-50">
	     		<span class="badge badge-blue mb-3">권한자</span>
	     		<h6 class="fw-semibold text-dark">정산 결과 엑셀 다운로드</h6>
	     		<div class="mb-4">
<!-- 		     		<button type="button" class="btn btn-outline-primary border-light">급여대장 <i class='bx bxs-download text-lg-end'> </i></button> -->
<!-- 		     		<div class="vr mx-4 resvr" ></div> -->
		     		<button id="excelDown" type="button" class="btn btn-outline-primary border-light">이체리스트<i class='bx bxs-download text-lg-end'> </i></button>
	     		</div>
	     		<img src="${cPath }/resources/images/resback.png" alt="배경일러스트" width="270px" class="rounded" style="box-shadow: 5px 10px 18px #888888;">
	     		<img src="${cPath }/resources/images/resfront.png" alt="전방일러스트" width="180px" height="140px" class="rounded" style="position:absolute; left: 220px; bottom: 30px; box-shadow: 5px 10px 18px #888888;">		
	     	</div>
	     	<div class="divres w-50 row" >
	     		<div class="mb-5">
					<div>
						<i class='bx bx-money d-inline align-middle'></i>
						<div class="fw-semibold d-inline align-middle">원천세 신고하기</div>
					</div>
					<div class="mt-3 pl-4">
						<a href="https://hometax.go.kr/websquare/websquare.html?w2xPath=/ui/pp/index.xml">홈택스</a>
						<div class="vr mx-4 resvr" ></div>   
						<a href="https://www.wetax.go.kr/main/">위택스</a>
						<div class="vr mx-4 resvr" ></div>   
						<a href="https://etax.seoul.go.kr/index.html?20221108">ETAX</a>
					</div>
				</div>
				<div class="mb-5">
					<div>
						<i class='bx bxs-check-shield d-inline align-middle' ></i>
						<div class="fw-semibold d-inline align-middle">사회보험 신고하기</div>
					</div>
					<div class="mt-3">
						<a href="https://edi.nhis.or.kr/homeapp/wep/m/retrieveMain.xx">건강보험EDI</a>
						<div class="vr mx-4 resvr" ></div>       
						<a href="https://total.comwel.or.kr/">고용・산재 토탈서비스</a>
					</div>
				</div>
				<div>
					<div>
						<i class='bx bx-calendar-check d-inline align-middle'></i>
						<div class="fw-semibold d-inline align-middle">급여자료 다운로드</div>
					</div>
					<div class="mt-3">
						<a href="${cPath }/pay/pastPayroll.do">지난 정산 내역<i class='bx bx-arrow-back bx-rotate-180 ms-2' ></i></a> 
	     			</div>
	     			</div>
	     		</div>
	     	</div>
	     </div>
	   </div>
	   
<!-- ==================================================================================================== -->	   
	   
	   <div class="mt-5">
	   		<h5 class="fw-bold text-dark">급여대장 요약</h5>
	   </div>
	   <div class="container container-lg row ">
	   	   <div class="col-4 border-start-0 border">
	   	   		<div class="mt-4 mb-3 fw-semibold">지급일</div>
	   	   		<h4 class="text-dark mt-3 d-inline">
	   	   			<fmt:parseDate value="${proll.prGdate }" var="dateValue" pattern="yyyy. MM. dd"/>
	   	   			<fmt:formatDate  var="gdate" value="${dateValue}" type="DATE" pattern="M월 d일"/>
	   	   			<fmt:formatDate  var="day" value="${dateValue}" type="DATE" pattern="E요일"/>
	   	   			${gdate }
	   	   		</h4>
	   	   		<span class="badge bg-label-dark d-inline p-1 mt-3">${day }</span>
	   	   		<div class="mb-4 fs-tiny mt-2">지난 정산 
	   	   			<fmt:parseDate value="${prevProll.prGdate }" var="prevDateValue" pattern="yyyy. MM. dd"/>
	   	   			<fmt:formatDate  var="pgdate" value="${prevDateValue}" type="DATE" pattern="M월 d일"/>
	   	   			<fmt:formatDate  var="pday" value="${prevDateValue}" type="DATE" pattern="E요일"/>
	   	   			${pgdate }
	   	   		</div>
	   	   </div>
	        <div class="col-4 border">
	        	<div class="mt-4 fw-semibold">정산대상자</div>
	   	   		<h4 class="text-dark mt-3">
	   	   			<c:forEach items="${totalList }" var="ttl">
						<c:if test="${ttl.codeNo eq null and ttl.clf eq 'P' }">
							<c:set var="payCnt" value="${ttl.totalCnt }" />
						</c:if>
						<c:if test="${ttl.codeNo eq null and ttl.clf eq 'D' }">
							<c:set var="dedCnt"   value="${ttl.totalCnt }"/>
						</c:if>
					</c:forEach>
					<c:choose>
						<c:when test="${payCnt gt dedCnt }"><c:out value="${payCnt}" />명</c:when>
						<c:when test="${payCnt eq dedCnt }"><c:out value="${payCnt}" />명</c:when>
						<c:otherwise><c:out value="${dedCnt}" />명</c:otherwise>
					</c:choose>	
	   	   		</h4>
	   	   		<div class="mb-4 fs-tiny mt-2">지난 정산
	   	   			<c:forEach items="${prevTotalList }" var="pttl">
						<c:if test="${pttl.codeNo eq null and pttl.clf eq 'P' }">
							<c:set var="ppayCnt" value="${pttl.totalCnt }" />
						</c:if>
						<c:if test="${pttl.codeNo eq null and pttl.clf eq 'D' }">
							<c:set var="pdedCnt"   value="${pttl.totalCnt }"/>
						</c:if>
					</c:forEach>
					<c:choose>
						<c:when test="${ppayCnt gt pdedCnt }"><c:out value="${ppayCnt}" />명</c:when>
						<c:when test="${ppayCnt eq pdedCnt }"><c:out value="${ppayCnt}" />명</c:when>
						<c:otherwise><c:out value="${pdedCnt}" />명</c:otherwise>
					</c:choose>	
	   	   		</div>
	        </div>
			<div class="col-4 border border-end-0">
				<div class="mt-4 fw-semibold">정산완료일</div>
	   	   		<h4 class="text-dark mt-3">
	   	   			<fmt:parseDate value="${proll.prFdate }" var="fdateval" pattern="yyyy-MM-dd"/>
	   	   			<fmt:formatDate  var="fdate" value="${fdateval}" type="DATE" pattern="M월 d일"/>
	   	   			${fdate }
	   	   		</h4>
	   	   		<div class="mb-4 fs-tiny mt-2">지난 정산
	   	   			<fmt:parseDate value="${prevProll.prFdate }" var="pfdateval" pattern="yyyy-MM-dd"/>
	   	   			<fmt:formatDate  var="pfdate" value="${pfdateval}" type="DATE" pattern="M월 d일"/>
	   	   			${pfdate }
	   	   		</div>
			</div>
			<div class="col-4 border border-start-0">
				<div class="mt-4 fw-semibold">지급 계</div>
	   	   		<h4 class="text-dark mt-3">
		   	   		<c:forEach items="${totalList }" var="ttl">
						<c:if test="${ttl.codeNo eq null and ttl.clf eq 'P' }">
							<fmt:formatNumber value="${ttl.totalAmt }" pattern="#,###"/> 원
							<c:set var="payTotal" value="${ttl.totalAmt }" />
						</c:if>
					</c:forEach>	
				</h4>
	   	   		<div class="mb-4 fs-tiny mt-2">지난 정산
	   	   			<c:forEach items="${prevTotalList }" var="pttl">
						<c:if test="${pttl.codeNo eq null and pttl.clf eq 'P' }">
							<fmt:formatNumber value="${pttl.totalAmt }" pattern="#,###"/> 원
							<c:set var="ppayTotal" value="${pttl.totalAmt }" />
						</c:if>
					</c:forEach>
	   	   		</div>
			</div>
			<div class="col-4 border">
				<div class="mt-4 fw-semibold">공제 계</div>
	   	   		<h4 class="text-dark mt-3">
	   	   			<c:forEach items="${totalList }" var="ttl">
						<c:if test="${ttl.codeNo eq null and ttl.clf eq 'D' }">
							<fmt:formatNumber value="${ttl.totalAmt }" pattern="#,###"/> 원
							<c:set var="dedTotal" value="${ttl.totalAmt }" />
						</c:if>
					</c:forEach>
	   	   		</h4>
	   	   		<div class="mb-4 fs-tiny mt-2">지난 정산
	   	   			<c:forEach items="${prevTotalList }" var="pttl">
						<c:if test="${pttl.codeNo eq null and pttl.clf eq 'D' }">
							<fmt:formatNumber value="${pttl.totalAmt }" pattern="#,###"/> 원
							<c:set var="pdedTotal" value="${pttl.totalAmt }" />
						</c:if>
					</c:forEach>
	   	   		</div>
			</div>
			<div class="col-4 border border-end-0">
				<div class="mt-4 fw-semibold">실지급액</div>
	   	   		<h4 class="text-dark mt-3"><fmt:formatNumber value="${payTotal - dedTotal }" pattern="#,###"/> 원</h4>
	   	   		<div class="mb-4 fs-tiny mt-2">지난 정산
	   	   			<fmt:formatNumber value="${ppayTotal - pdedTotal }" pattern="#,###"/> 원
	   	   		</div>
			</div>
	      </div>
	 </div>
</div>

<script>

$(function(){
	$('#step5').css('color', '#4d4d4d');
	$('#icon1').removeClass('bxs-group').addClass('bxs-check-circle').css('color', '#07b419');
	$('#icon2').removeClass('bx-money').addClass('bxs-check-circle').css('color', '#07b419');
	$('#icon3').removeClass('bx-bookmark-alt-minus').addClass('bxs-check-circle').css('color', '#07b419');
	$('#icon4').removeClass('bx-copy-alt').addClass('bxs-check-circle').css('color', '#07b419');
});

$('#excelDown').on('click', function(){
	let $resDiv = $('#resTitleDiv');
	let prNo = $resDiv.data('prno');		 //정산번호
	let transferDate = $resDiv.data('gdate'); //지급일
	
	location.href = CONTEXTPATH+"/pay/excelDown.do?prNo="+prNo+"&transferDate="+transferDate;
});
</script>
