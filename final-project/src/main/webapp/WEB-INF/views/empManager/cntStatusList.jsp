<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="${cPath }/resources/css/jhy.css" rel="stylesheet"
	type="text/css" />
<div class="row">
	<div class="col-md-6 col-xl-4">
		<div
			class="card shadow-none bg-transparent border border-secondary mb-3">
			<div class="card-body cntcard">
				<div>
					<span class="card-title">근로계약 만료예정</span>
					<h4 class="card-text">
						<span>${wkRecord}</span>명
					</h4>
				</div>
				<div class="cnticon">
					<i class='bx bxs-user bx-md cnti'></i>
				</div>
			</div>
		</div>
	</div>
	<div class="col-md-6 col-xl-4">
		<div
			class="card shadow-none bg-transparent border border-secondary mb-3">
			<div class="card-body cntcard">
				<div>
					<span class="card-title">임금계약 만료예정</span>
					<h4 class="card-text">
						<span>${wageRecord}</span>명
					</h4>
				</div>
				<div class="cnticon">
					<i class='bx bxs-user bx-md cnti'></i>
				</div>
			</div>
		</div>
	</div>
	<div class="col-md-6 col-xl-4">
		<div
			class="card shadow-none bg-transparent border border-secondary mb-3">
			<div class="card-body cntcard">
				<div>
					<span class="card-title">수습중</span>
					<h4 class="card-text">
						<span>${prRecord}</span>명
					</h4>
				</div>
				<div class="cnticon">
					<i class='bx bxs-user bx-md cnti'></i>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="demo-inline cntfilterdiv">
	<div class="statusdiv">상태</div>
	<!-- 필터 버튼 -->
	<div class="btn-group cntbtn">
		<button type="button"
			class="btn btn-icon dropdown-toggle hide-arrow ctnfilter"
			data-bs-toggle="dropdown" aria-expanded="false">
			<i class='bx bxs-filter-alt'></i>
		</button>
		<ul class="dropdown-menu dropdown-menu-end">
			<li>
				<div class="form-check cntcheckbox ps-5">
					<input class="form-check-input filter" type="checkbox" name="cntStFilter" value="근로계약만료"/> 
					<label class="form-check-label ms-2"> 근로계약 만료 </label>
				</div>
			</li>
			<li>
				<div class="form-check cntcheckbox ps-5">
					<input class="form-check-input filter" type="checkbox" name="cntStFilter" value="근로계약만료_예정"/> 
					<label class="form-check-label ms-2"> 근로계약 만료예정 </label>
				</div>
			</li>
			<li>
				<div class="form-check ps-5">
					<input class="form-check-input filter" type="checkbox" name="cntStFilter" value="임금계약만료" /> 
					<label class="form-check-label ms-2"> 임금계약 만료 </label>
				</div>
			<li>
			<li>
				<div class="form-check ps-5">
					<input class="form-check-input filter" type="checkbox" name="cntStFilter" value="임금계약만료_예정" /> 
					<label class="form-check-label ms-2"> 임금계약 만료예정 </label>
				</div>
			<li>
				<div class="form-check cntcheckbox ps-5">
					<input class="form-check-input filter" type="checkbox" name="cntStFilter" value="수습중"/> 
					<label class="form-check-label ms-2"> 수습중 </label>
				</div>
			</li>
			<li>
				<hr class="dropdown-divider" />
			</li>
			<li>
				<button type="reset" class="btn" id="btn-check" autocomplete="off">초기화</button>
			</li>
		</ul>
	</div>
</div>
<div class="card shadow-none cnttable ">

	<table class="table card-table table-hover cntborder" style="table-layout:auto;">
		<thead>
			<tr>
				<th class="w-px-200" style="font-size: 15px; padding-bottom: 15px">이름</th>
				<th style="font-size: 15px; padding-bottom: 15px">사번</th>
				<th class="w-px-300" style="font-size: 15px; padding-bottom: 15px">조직·직책</th>
				<th style="font-size: 15px; padding-bottom: 15px">직위</th>
				<th style="font-size: 15px; padding-bottom: 15px">상태</th>
			</tr>
		</thead>
		<tbody class="testbody">
			<c:if test="${empty empList}">
				<tr>
					<td class="text-center" colspan="5">표시할 내용이 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach items="${empList}" var="emp">
				<tr
					onclick="location.href='${cPath}/mypage/hrInfoRetrieve.do?empNo=${emp.empNo}' ">
					<!-- 이름 -->
					<td>
						<div class="d-flex align-self-center align-items-center">
							<img src="${cPath}/resources/images/basicProfile.png"
								alt="Avatar" class="empListimgradius emplistimgsize">
							<div class="mx-3 mt-1">
								<strong>${emp.empNm }</strong><br> 
								<span class="fs-tiny">
									<c:forEach items="${emp.jobList}" var="job" varStatus="status">
										<c:if test="${status.index eq 0}">
													${job.jnm}
												</c:if>
									</c:forEach>
								</span>
							</div>
						</div>
					</td>


					<!-- 사번 -->
					<td>${emp.empNo}</td>

					<!-- 조직･직책 -->
					<td>
						<c:forEach items="${emp.deptList}" var="dept"
							varStatus="status">
							<c:if test="${!status.last}">
								<span
									<c:if test="${dept.mainck eq 'Y'}">class="fw-semibold"</c:if>>
									${dept.dnm}<c:if test="${not empty dept.dtnm }"> · ${dept.dtnm}</c:if>
									,&nbsp;
								</span>
							</c:if>
							<c:if test="${status.last}">
								<span
									<c:if test="${dept.mainck eq 'Y'}">class="fw-semibold"</c:if>>
									${dept.dnm}<c:if test="${not empty dept.dtnm }"> · ${dept.dtnm}</c:if>
								</span>
							</c:if>
						</c:forEach>
					</td>

					<!-- 직위 -->
					<td>${emp.ptnNm}</td>


					<!-- 상태 -->
					<td>
						<c:forEach items="${emp.cnthxList}" var="cnthx">
							<c:if test="${not empty cnthx.cntSt}">
								<c:choose>
									<c:when test="${cnthx.cntSt eq '임금계약만료_예정' || cnthx.cntSt eq '임금계약만료'}">
										<span class="badge bg-label-danger">${cnthx.cntSt}</span>
									</c:when>
									<c:when test="${cnthx.cntSt eq '근로계약만료_예정' || cnthx.cntSt eq '근로계약만료'}">
										<span class="badge bg-label-warning">${cnthx.cntSt}</span>
									</c:when>
									<c:otherwise>
										<span class="badge bg-label-primary me-1">${cnthx.cntSt}</span>
									</c:otherwise>
								</c:choose>
							</c:if>
						</c:forEach>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<script type="text/javascript" defer="defer">
$(document).on('change', '.filter', function(){
	let cntStFilter = '?dummy=';
	
	$('input[name=cntStFilter]:checked').each(function(i, elements) {
		cntStFilter += '&cntStFilter='+$(elements).val();
	});
	
	console.log(cntStFilter);
	$(".cnttable").load("${cPath}/emp/cntStatusList.do"+cntStFilter+" .cntborder");
});
	
</script>
