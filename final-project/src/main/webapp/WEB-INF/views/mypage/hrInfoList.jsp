<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
#hideBtn {
	display: none;
}
</style>
<div class="empFormheader">
	<div class="mypagetablewidth">
		<div class="card shadow-none ">
			<div class="arcodiancheck">
				<h5 class="card-header pt-2 ps-3 fs-4 fw-bold">인사정보</h5>
				<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')">
				<div class="dropdown p-4 py-0 empaddbutton">
					<button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
						<i class='bx bxs-pencil'></i>
					</button>



					<div class="dropdown-menu">
						<a class="dropdown-item" href="javascript:void(0);"> <i class='bx bxs-user'></i>
							<button id="hrBtn" type="button" class="btn p-0" data-bs-toggle="offcanvas" data-bs-target="#offcanvasBothbasicHr1" aria-controls="offcanvasBoth" data-empno="${empVo.empNo }">인사 정보 변경</button>
						</a> <a class="dropdown-item" href="javascript:void(0);"> <i class="bx bx-edit-alt me-1"></i>
							<button id="basicBtn" type="button" class="btn p-0" data-bs-toggle="offcanvas" data-bs-target="#offcanvasBothbasicHr2" aria-controls="offcanvasBoth" data-empno="${empVo.empNo }">기본 정보 변경</button>
						</a>
					</div>


					<!--=========================================== 인사 정보 변경 폼 =====================================  -->
					<div class="offcanvas offcanvas-end mypagetoggle w-px-600" data-bs-scroll="true" tabindex="-1" id="offcanvasBothbasicHr1">
						<div class="offcanvas-header">
							<h4 id="offcanvasBothLabel" class="offcanvas-title">인사 정보 변경</h4>
							<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
						</div>


						<form id="hrForm">
							<input name="asgmtPers" type="hidden" value="${empVo.empNo}" />
							<div class="offcanvas-body my-auto mx-0 flex-grow-0">

								<div class=" arcodiancheck mb-2">
									<div class="basicnamediv">
										<label class="form-label">발령일</label> <input name="asgmtDate" class="form-control" type="date" id="asgmtDate" />
									</div>

									<div class="basicenglishname mb-4">
										<div>
											<label class="form-label">발령 라벨</label>
										</div>

										<select name="asgmtClf" data-live-search="true" data-width="100%" data-size="6" class=" selectpicker selectlabel show-tick" data-style="border">
											<option value="">--발령 라벨 선택--</option>
											<c:forEach items="${labelList }" var="label">
												<option value="${label.codeNm }">${label.codeNm }</option>
											</c:forEach>
										</select>
									</div>
								</div>


								<div class="mb-4">
									<label class="form-label">직무</label>
									<select id="jcode" name="jcodeList[]" data-style="border" data-width="100%" data-size="6" class="selectpicker selectlabel" multiple="multiple" data-content="<span class='badge badge-success'></span>" data-none-selected-text="직무선택">
										<c:forEach items="${jobList }" var="job">
											<option value="${job.jcode }">${job.jnm }</option>
										</c:forEach>
									</select>
								</div>


								<div class=" arcodiancheck mb-2">
									<div class="basicnamediv">
										<label class="form-label">직위</label>
										<select id="selectPtn" name="ptnCode" data-live-search="true" data-width="100%" data-size="6" class="selectlabel show-tick  ptnCode" data-style="border" data-none-selected-text="직위선택">
											<option value="">--직위 선택--</option>
											<c:forEach items="${pstnList }" var="pstn">
												<option value="${pstn.ptnCode}">${pstn.ptnNm}</option>
											</c:forEach>
										</select>

									</div>

									<div class="basicenglishname mb-4">
										<label class="form-label">직급</label>

										<select id="selectGrd" name="grdCode" data-live-search="true" data-width="100%" data-size="6" class=" selectpicker selectlabel show-tick grdCode" data-style="border" data-none-selected-text="직급선택">
											<option value="">--직급 선택--</option>
											<c:forEach items="${grdList }" var="grd">
												<option value="${grd.grdCode}">${grd.grdNm}</option>
											</c:forEach>
										</select>
									</div>

								</div>

								<label class="form-label">조직 / 직책</label> <br>
								<div id="deptBody">

									<div class="mb-2 mainDeptCheck">
										<div class=" mb-4 ">

											<div class="d-flex ">
												<div class="form-check pt-2">
													<input name="deptList[].mainck" class="form-check-input mainckList" type="radio" value="Y" checked />
												</div>

												<div class="input-group">
													<select name="deptList[].dcode" class="form-select dcodeList">
														<option value>조직</option>
														<c:forEach items="${deptList}" var="dept">
															<option value="${dept.dcode}" label="${dept.dnm}" />
														</c:forEach>
													</select>
													<select name="deptList[].dtcode" class="form-select dtcodeList">
														<option value>직책(선택)</option>
														<c:forEach items="${dutyList}" var="duty">
															<option value="${duty.dtcode}" label="${duty.dtnm}" />
														</c:forEach>
													</select>

													<div class="input-group-text">
														<div class="form-check mt-0">
															<input name="deptList[].dno" class="form-check-input dnoList" type="checkbox" value="1" /> <label class="form-check-label"> 조직장 </label>
														</div>
													</div>
												</div>
												<button type="button" class="btn btn-icon btn-outline-danger ms-2  " name="deptRemoveBtn" id="hideBtn">
													<i class='bx bx-x'></i>
												</button>
											</div>
										</div>
									</div>

								</div>
								<!-- 조직 추가 버튼 -->
								<button type="button" class="btn btn-outline-primary mb-4" id="deptAddBtn">
									<span class="bx-plus bx bx-pie-chart-alt"></span>&nbsp; 조직 추가
								</button>

								<div class="mb-2">
									<label class="form-label">변경 메모</label>
									<textarea name="asgmtMm" class="form-control" rows="3"></textarea>
								</div>
							</div>


							<div class="arcodiancheck">
								<button type="button" class="btn btn-outline-secondary mb-2 w-30 empaddbutton" data-bs-dismiss="offcanvas">취소</button>
								<button id="hrSubmitBtn" type="button" class="btn btn-primary mb-2 ms-3 w-40">저장하기</button>
							</div>


						</form>
						<!--=========================================== /인사 정보 변경 폼 =====================================  -->
					</div>




					<!-- 기본 정보 변경 토글 -->
					<div class="offcanvas offcanvas-end mypagetoggle w-px-500" data-bs-scroll="true" tabindex="-1" id="offcanvasBothbasicHr2" aria-labelledby="offcanvasBothLabel">
						<div class="offcanvas-header">
							<h4 id="offcanvasBothLabel" class="offcanvas-title">기본 정보 변경</h4>
							<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
						</div>


						<!-- 토글 내용  -->
						<form:form modelAttribute="emp" action="${cPath}/mypage/hrInfoUpdate.do" method="post">

							<div class="offcanvas-body my-auto mx-0 flex-grow-0">

								<div class="mb-4">
									<label for="entDatelabel" class="form-label">입사일</label> <input class="form-control" type="date" value="${empVo.entDate}" name="entDate" /> <span class="error">${errors.entDate }</span>
								</div>


								<div class="mb-4">
									<label class="form-label">입사 유형</label>
									<select id="entCaseSelect" class="form-select" name="entCase">
										<option value="신입">신입</option>
										<option value="경력">경력</option>
									</select>
									<span class="error">${errors.entCase }</span> <input type="hidden" value="${empVo.empNo}" name="empNo" />
								</div>

								<div class="arcodiancheck">
									<button type="reset" class="btn btn-outline-secondary mb-2 w-30 empaddbutton" data-bs-dismiss="offcanvas">취소</button>
									<button type="submit" class="btn btn-primary mb-2 ms-3 w-40">저장하기</button>
								</div>
							</div>
						</form:form>
					</div>

					<!-- 토글 끝  -->

				</div>
			</security:authorize>
			</div>


			<!-- 인사 정보 테이블  -->
			<div class="table-responsive text-nowrap">
				<table class="table table-borderless">
					<tbody>
						<c:if test="${empRole eq 'admin' || empRole eq 'manager' ||  authEmp.empNo eq empVo.empNo}">
						<tr>
							<td class="tdwidth">사번</td>
							<td>${empVo.empNo}</td>

						</tr>
						<tr>
							<td class="tdwidth">입사일</td>
							<td>${empVo.entDate}<c:if test="${not empty empVo.tneurePeriod }">
									<span class="badge bg-label-dark">${empVo.tneurePeriod} </span>
								</c:if>
							</td>
						</tr>
						<tr>
							<td class="tdwidth">입사 유형</td>
							<td>${empVo.entCase}</td>
						</tr>
						</c:if>
						<tr>
							<td class="tdwidth">조직·직책</td>

							<td id="hrTdDept">
								<c:choose>
									<c:when test="${not empty empVo.deptList }">
										<c:forEach items="${empVo.deptList}" var="dept">
											${dept.dnm} <c:if test="${not empty dept.dtnm }"> · ${dept.dtnm } </c:if>
											<c:if test="${dept.mainck eq 'Y' }">
				                      			&nbsp; <span class="badge bg-label-primary">주조직</span>
												<br>
											</c:if>
										</c:forEach>
									</c:when>
									<c:otherwise>
			                   			 정보 미입력
			                   		</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td class="tdwidth">직무</td>
							<td id="hrTdJob">
								<c:choose>
									<c:when test="${not empty empVo.jobList }">
										<c:forEach items="${empVo.jobList }" var="job" varStatus="status">
											${job.jnm}<br>
										</c:forEach>
									</c:when>
									<c:otherwise>
                   						정보 미입력
                   					</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td class="tdwidth">직위</td>
							<td id="hrTdPtn">
								<c:choose>
									<c:when test="${not empty empVo.ptnNm }">
	                      				${empVo.ptnNm }
	                      			</c:when>
									<c:otherwise>
	                      				정보 미입력
	                      			</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<c:if test="${empRole eq 'admin' || empRole eq 'manager' ||  authEmp.empNo eq empVo.empNo}">
						<tr>
							<td class="tdwidth">직급</td>
							<td id="hrTdGrd">
								<c:choose>
									<c:when test="${not empty empVo.grdNm }">
                      					${empVo.grdNm}
                      				</c:when>
									<c:otherwise>
                      					정보 미입력
                      				</c:otherwise>
								</c:choose>
							</td>
						</tr>
						</c:if>
					</tbody>
				</table>
			</div>

		</div>

	</div>



<c:if test="${empRole eq 'admin' || empRole eq 'manager' ||  authEmp.empNo eq empVo.empNo}">
	<!-- 오른쪽 card들 -->
	<div class="col-md-6 col-xl-4 mypagerightwidth">
		<div class="card shadow-none bg-transparent border border-secondary mb-4 mypagecardheigh">
			<div class="card-body cntcard mt-5 pb-4">
				<div>
					<span class="card-title">근무시간</span>
					<h4 class="card-text">
						<fmt:parseNumber var="workTime" integerOnly="true" value="${workTime }" />
						<span>${workTime }</span>시간
					</h4>
				</div>
				<div class="cnticon">
					<i class='bx bxs-user bx-md cnti'></i>
				</div>
			</div>
		</div>

		<div class="card shadow-none bg-transparent border border-secondary mb-4 mypagecardheigh">
			<div class="card-body cntcard mt-5 pb-4">
				<div>
					<span class="card-title">남은 연차</span>
					<h4 class="card-text">
						<span>0</span>일
					</h4>
				</div>
				<div class="cnticon">
					<i class='bx bxs-user bx-md cnti'></i>
				</div>
			</div>
		</div>

		<div class="card shadow-none bg-transparent border border-secondary mb-4 mypagecardheigh">
			<div class="card-body cntcard mt-5 pb-4">
				<div>
					<span class="card-title">급여</span>
					<h4 class="card-text">
						<span>11</span>월 급여 명세서
					</h4>
				</div>
				<div class="cnticon">
					<i class='bx bxs-user bx-md cnti'></i>
				</div>
			</div>
		</div>


	</div>
</c:if>
</div>


<script type="text/javascript" defer="defer">
	// 인사정보 테이블 TD태그
	let hrTdDept = $("#hrTdDept");
	let hrTdJob = $("#hrTdJob");
	let hrTdPtn = $("#hrTdPtn");
	let hrTdGrd = $("#hrTdGrd");

	// 프로필 부분
	let deptHeader = $("#deptHeader");
	let jobHeader = $("#jobHeader");

	// 조직리스트
	let deptList;
	// 직책리스트
	let dutyList;

	// 조직,직책 리스트 아작스
	$.ajax({
		url : CONTEXTPATH + "/mypage/getDeptList.do",
		dataType : "json",
		success : function(resp) {
			console.log(resp);
			deptList = resp.deptList;
			dutyList = resp.dutyList;
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}

	});

	// .selectlabel 셀렉트피커 사용 
	$(function() {
		$('.selectlabel').selectpicker();
	});

	// 발령일 오늘날짜 부여
	let today = new Date().toISOString().substring(0, 10);
	document.getElementById('asgmtDate').value = today
	$("#asgmtDate").attr("min", today);

	// 조직 직책 추가 버튼
	$('#deptAddBtn')
			.on(
					"click",
					function() {

						var deptform = '<div class="  mb-2 mainDeptCheck">'
						deptform += ' <div class=" mb-4 " >'
						deptform += '  <div class="d-flex " >'
						deptform += '	<div class="form-check pt-2">      '
						deptform += '	    <input                         '
			deptform +='	      name="deptList[].mainck"       '
			deptform +='	      class="form-check-input mainckList"     '
			deptform +='	      type="radio"                 '
			deptform +='	      value="Y"                     '
			deptform +='	       /> </div>					'
						deptform += '	<div class="input-group">		   '
						deptform += '	<select name="deptList[].dcode" class="form-select dcodeList"> '
						deptform += '      <option value>조직</option>'

						$(deptList)
								.each(
										function(i, dept) {
											deptform += '  <option value="'+dept.dcode+'">'
													+ dept.dnm + '</option> '
										});

						deptform += '    </select>			                                                                              '
						deptform += '	<select name="deptList[].dtcode" class="form-select dtcodeList">                          '
						deptform += '	<option value>직책(선택)</option>  '

						$(dutyList)
								.each(
										function(i, duty) {
											deptform += '  <option value="'+duty.dtcode+'">'
													+ duty.dtnm + '</option> '
										});

						deptform += '	</select>								                                                          '
						deptform += '	<div class="input-group-text">                                                                    '
						deptform += '	<div class="form-check mt-0">                                                                     '
						deptform += '	<input name="deptList[].dno" class="form-check-input dnoList" type="checkbox" value="Y"/> '
						deptform += '	<label class="form-check-label"> 조직장 </label>                              '
						deptform += '	</div>                                                                                            '
						deptform += '	</div>      				                                                                      '
						deptform += '	</div>                                                                                            '
						deptform += ' <button type="button" class="btn btn-icon btn-outline-danger ms-2 " name="deptRemoveBtn" ><i class="bx bx-x"></i></button> '
						deptform += '	</div>   '
						deptform += ' </div>'
						deptform += '</div>';

						$('#deptBody').append(deptform);
						$('#hideBtn').show();
						var length = $(".mainDeptCheck").length;
						if (length >= 2) {
							$('button[name=deptRemoveBtn]').show();
						}

					});

	// 조직 / 직책  지우기 버튼 
	$('body').on("click", '[name=deptRemoveBtn]', function(event) {

		$(this).closest(".mainDeptCheck").remove();
		var length = $(".mainDeptCheck").length;
		if (length == 1) {
			$('button[name=deptRemoveBtn]').hide();
		}

	})

	// 자신의 부서직책 리스트가 반영된 UI를 html로 만들어주는 함수
	// myDeptList : 자신의 부서직책 객체가 담긴 리스트
	// return : htmlCode
	// 주의 스크립트 전역변수로 코드와 이름이 담긴 deptList, dutyList 활용하고 있습니다.
	function makeDeptBody(myDeptList) {
		let htmlCode = "";
		$(myDeptList)
				.each(
						function(i, myDept) {

							htmlCode += '<div class="  mb-2 mainDeptCheck">'
							htmlCode += ' <div class=" mb-4 " >'
							htmlCode += '  <div class="d-flex " >'
							htmlCode += '	<div class="form-check pt-2">      '
							if (myDept.mainck == "Y") {
								htmlCode += '	    <input name="deptList[].mainck" class="form-check-input mainckList" type="radio" value="Y" checked /> '
							} else {
								htmlCode += '	    <input name="deptList[].mainck" class="form-check-input mainckList" type="radio" value="Y"/> '
							}
							htmlCode += '	</div> <div class="input-group">		   '
							htmlCode += '	<select name="deptList[].dcode" class="form-select dcodeList"> '
							htmlCode += '      <option value>조직</option>'

							$(deptList)
									.each(
											function(index, dept) {
												if (myDept.dcode == dept.dcode) {
													htmlCode += '  <option value="'+dept.dcode+'" selected>'
															+ dept.dnm
															+ '</option> '
												} else {
													htmlCode += '  <option value="'+dept.dcode+'">'
															+ dept.dnm
															+ '</option> '
												}
											});

							htmlCode += '    </select>			                                                                              '
							htmlCode += '	<select name="deptList[].dtcode" class="form-select dtcodeList">                          '
							htmlCode += '	<option value>직책(선택)</option>  '

							$(dutyList)
									.each(
											function(index, duty) {
												if (myDept.dtcode == duty.dtcode) {
													htmlCode += '  <option value="'+duty.dtcode+'" selected>'
															+ duty.dtnm
															+ '</option> '
												} else {
													htmlCode += '  <option value="'+duty.dtcode+'">'
															+ duty.dtnm
															+ '</option> '
												}
											});

							htmlCode += '	</select>								                                                          '
							htmlCode += '	<div class="input-group-text">                                                                    '
							htmlCode += '	<div class="form-check mt-0">                                                                     '
							if (myDept.dno == "Y") {
								htmlCode += '	<input name="deptList[].dno" class="form-check-input dnoList" type="checkbox" value="Y" checked/> '
							} else {
								htmlCode += '	<input name="deptList[].dno" class="form-check-input dnoList" type="checkbox" value="Y"/> '
							}
							htmlCode += '	<label class="form-check-label"> 조직장 </label>                              '
							htmlCode += '	</div>                                                                                            '
							htmlCode += '	</div>      				                                                                      '
							htmlCode += '	</div>                                                                                            '
							htmlCode += ' <button type="button" class="btn btn-icon btn-outline-danger ms-2 " name="deptRemoveBtn" ><i class="bx bx-x"></i></button> '
							htmlCode += '	</div>   '
							htmlCode += ' </div>'
							htmlCode += '</div>';

						});

		return htmlCode;
	}
	// 인사정보 변경 폼의 기존정보 가져오기
	$('#hrBtn').on("click", function() {
		let empNo = $(this).data("empno");

		$.ajax({
			url : CONTEXTPATH + "/mypage/hrInfoview.do",
			data : {
				empNo : empNo
			},
			dataType : "json",
			success : function(resp) {
				console.log(resp);
				let myDeptList = resp.deptList;
				let jobList = resp.jobList;
				let grdCode = resp.grdCode;
				let ptnCode = resp.ptnCode;

				let jcodeArr = [];
				$(jobList).each(function(i, job) {
					jcodeArr.push(job.jcode);
				});
				$("#jcode").selectpicker('val', jcodeArr);
				$("select[name=ptnCode]").selectpicker('val', ptnCode);
				$("select[name=grdCode]").selectpicker('val', grdCode);

				// 조직직책 데이터에 일치하게 가져오기
				var html = makeDeptBody(myDeptList);
				$("#deptBody").html(html);

				let length = $(".mainDeptCheck").length;
				if (length >= 2) {
					$('button[name=deptRemoveBtn]').show();
				} else {
					$('button[name=deptRemoveBtn]').hide();
				}

			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}

		});
	})

	// 인사정보 페이지 비동기 갱신
	function hrTdRefresh(empNo) {
		$
				.ajax({
					url : CONTEXTPATH + "/mypage/hrInfoview.do",
					data : {
						empNo : empNo
					},
					dataType : "json",
					success : function(resp) {
						let myDeptList = resp.deptList;
						let jobList = resp.jobList;
						let grdNm = resp.grdNm;
						let ptnNm = resp.ptnNm;

						// 갱신 테이블 html
						let deptTdContent = "";
						let jobTdContent = "";
						let grdTdContent = "";
						let ptnTdContent = "";
						// 갱신 프로필 html
						let deptHContent = "";
						let jobHContent = "";

						// 조직직책 TD 내용
						if (myDeptList != null) {
							$(myDeptList)
									.each(
											function(index, myDept) {
												deptTdContent += myDept.dnm;
												if (myDept.dtnm != null)
													deptTdContent += " · "
															+ myDept.dtnm;
												if (myDept.mainck == 'Y')
													deptTdContent += "&nbsp; <span class='badge bg-label-primary'>주조직</span><br>";
											});
						} else {
							deptTdContent += "정보 미입력";
						}
						// 직무 TD 내용				
						if (jobList != null) {
							$(jobList).each(function(index, job) {
								jobTdContent += job.jnm + "<br>";
							});
						} else {
							jobTdContent += "정보 미입력";
						}
						//
						if (grdNm != null) {
							grdTdContent += grdNm;
						} else {
							grdTdContent += "정보 미입력";
						}

						if (ptnNm != null) {
							ptnTdContent += ptnNm;
						} else {
							ptnTdContent += "정보 미입력";
						}
						// 조직 프로필 내용
						if (myDeptList != null) {
							$(myDeptList).each(function(index, myDept) {
								if (index != (myDeptList.length - 1)) {
									deptHContent += myDept.dnm + ",&nbsp;";
								} else {
									deptHContent += myDept.dnm;
								}
							});
						} else {
							deptHContent += "정보 미입력";
						}
						// 직무 프로필 내용
						if (jobList != null) {
							$(jobList).each(function(index, job) {
								if (index != (jobList.length - 1)) {
									jobHContent += job.jnm + ",&nbsp;";
								} else {
									jobHContent += job.jnm;
								}
							});
						} else {
							jobHContent += "정보 미입력";
						}

						hrTdDept.html(deptTdContent);
						hrTdJob.html(jobTdContent);
						hrTdGrd.html(grdTdContent);
						hrTdPtn.html(ptnTdContent);
						deptHeader.html(deptHContent);
						jobHeader.html(jobHContent);
					},
					error : function(errorResp) {
						console.log(errorResp.status);
					}

				});
	}

	// 인사정보 변경하기
	let hrform = $("#hrForm");
	$("#hrSubmitBtn").on(
			"click",
			function(event) {

				// 인사정보 동적으로 추가된 조직직책 폼들의 name을 배열순으로 수정
				$(".mainckList").each(function(i, elements) {
					$(elements).attr("name", "deptList[" + i + "][mainck]");
				});
				$(".dcodeList").each(function(i, elements) {
					$(elements).attr("name", "deptList[" + i + "][dcode]");
				});
				$(".dtcodeList").each(function(i, elements) {
					$(elements).attr("name", "deptList[" + i + "][dtcode]");
				});
				$(".dnoList").each(function(i, elements) {
					$(elements).attr("name", "deptList[" + i + "][dno]");
				});

				let hrformData = hrform.serializeObject();
				console.log("SERIALIZE : ", hrformData);
				console.log("JSON : ", JSON.stringify(hrformData));

				$.ajax({
					url : CONTEXTPATH + "/mypage/hrInfoInsert.do",
					method : "POST",
					data : JSON.stringify(hrformData), //전송 데이터
					dataType : "json",
					contentType : "application/json; charset=utf-8",
					success : function(resp) {

						if (resp.status == 'success') {
							toastr.success('인사 정보를 수정했습니다.');
						} else if (resp.status == 'fail') {
							toastr.error('인사 정보 수정을 실패했습니다.');
						}

						hrTdRefresh(hrformData.asgmtPers);

						$("#navs-pills-top-hr").load(
								"${cPath}/mypage/hrInfoRetrieve.do?empNo="
										+ hrformData.asgmtPers
										+ " #hrDataResult");

						$('#offcanvasBothbasicHr1').offcanvas('hide');
					},
					error : function(errorResp) {
						console.log(errorResp.status);
						toastr.error('인사 정보를 수정 중 오류가 발생 했습니다.');
						$('#offcanvasBothbasicHr1').offcanvas('hide');
					}
				});
			})

	// 기본정보 변경 폼의 기존정보 가져오기
	$('#basicBtn').on("click", function() {
		/* let entCaseSelect = $('#entCaseSelect'); */
		let empNo = $(this).data("empno");

		$.ajax({

			url : CONTEXTPATH + "/mypage/hrInfoview.do", //어디로
			method : "get", //어떻게
			data : {
				empNo : empNo
			},
			dataType : "json",
			success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
				console.log(resp);

				let entDate = resp.entDate;
				let entCase = resp.entCase;

				console.log(entDate, entCase)

				$("#entCaseSelect").val(entCase).attr("selected", "selected");
				$("input[name=entDate]").val(entDate);
			},
			error : function(errorResp) {

				console.log(errorResp.status);
			}

		});
	})
</script>