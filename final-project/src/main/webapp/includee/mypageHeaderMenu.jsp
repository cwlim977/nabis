<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %> 
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="${cPath }/resources/css/jhy.css" rel="stylesheet" type="text/css" />
<style>
.modal-backdrop.show:nth-of-type(even) {
    position: relative !important;
}
.modal-backdrop.show {
    display: none; !important;
}
.hrcutomScroll{
	height: 70vh;
}
</style>
<div class="mypagecontainer m-5 mb-0">


	<div class="ps-0">
		<a href="${cpath}/emp/empTable.do">구성원</a>/<span>${empVo.empNm}</span>
	</div>



	<div class="">
		<div class="card my-4 shadow-none">

			<!-- Account -->
			<div class="card-body ps-0">
				<div class="d-flex align-items-start align-items-sm-center ">
						 <c:if test="${empty empVo.empImg}">
		                      	<img
		                          src="${cPath}/resources/images/기본프로필.jpg"
		                          alt="기본프로필"
		                          class="d-block rounded mypageimg"
		                          height="148"
		                          width="148"
		                          id="uploadedemp"
		                        />
	                      
	                      </c:if>
	                      <c:if test="${not empty empVo.empImg }">
		                       <img
		                          src="${cPath}/resources/empImages/${empVo.empImg }"
		                          alt="${empVo.empImg}"
		                          class="d-block rounded mypageimg"
		                          height="148"
		                          width="148"
		                          id="uploadedemp"
		                          
		                        />
	                      </c:if>	
						<div class=" dropend">
	                      <c:if test="${empRole eq 'admin' || empRole eq 'manager' ||  authEmp.empNo eq empVo.empNo}">	
	                         <button
	                            type="button"
	                            class="btn btn-primary btn-icon rounded-pill uploadbtn dropdown-toggle hide-arrow shadow-none"
	                            data-bs-toggle="dropdown"
	                            aria-expanded="false"
	                          >
	                           <i class='bx bxs-camera'></i>
	                          </button>
						</c:if>
	                       	 <ul class="dropdown-menu dropdown-menu-end">	                        
	                            <li>	                            	                            
		                 	       <form:form id="empImgForm" modelAttribute="emp" action="${cPath}/mypage/updateEmpImg.do"   enctype="multipart/form-data">                 	       
			                            <label for="upload" class="btn dropdown-item" tabindex="0">
			                          	 <i class='bx bx-upload bx-fw'></i>사진 업로드하기
				                          	 <input type="file" id="upload" class="account-file-input" hidden="" accept="image/png, image/jpeg" name="empImage" onchange="imgUpdate()">
				                           	 <input type="hidden" name="empNo" value="${empVo.empNo}"/>
			                            </label>
		                            </form:form>                    	                            
	                            </li>                            
	                            <li  class="btn dropdown-item" tabindex="0"  onclick="delProfile('${empVo.empImg}')"><i class='bx bxs-trash-alt bx-fw '></i>삭제하기</li><!-- id="delProfile" -->
	                        </ul>
                        </div>
					<div class="button-wrapper mypageinfo ms-5">
						<div>
							<span id="empNm-No" class="empname" data-empno="${empVo.empNo }" data-empst="${empVo.empSt }">${empVo.empNm }</span><span id="nowState"></span>

							<p class="text-muted mb-0">
								조직 &nbsp; 
								<span id="deptHeader"> 
									<c:choose>
										<c:when test="${not empty empVo.deptList }">
											<c:forEach items="${empVo.deptList}" var="dept" varStatus="status">
												<c:if test="${!status.last }">
				                      			${dept.dnm} ,&nbsp; 
					                     		</c:if>
												<c:if test="${status.last}"> 
					                       			${dept.dnm}
					                     		</c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
					                   		정보 미입력
					                   	</c:otherwise>
									</c:choose>
								</span>
							</p>

							<p class="text-muted mb-3">
								직무 &nbsp; 
								<span id="jobHeader"> 
									<c:choose>
										<c:when test="${not empty empVo.jobList }">
											<c:forEach items="${empVo.jobList }" var="job" varStatus="status">
												<c:if test="${!status.last }">
							                   		 ${job.jnm} ,&nbsp;
						                     	</c:if>
												<c:if test="${status.last}"> 
						                  			${job.jnm} 
						                    	</c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
				                   			정보 미입력
				                   		</c:otherwise>
									</c:choose>
								</span>
							</p>
						</div>

						<div class="arcodiancheck" style="align-self: flex-start;">
							<div class="col me-1">							
								<button type="button" onclick="empPhoneCopy('${empVo.cpNo}')" class="btn btn-primary" data-bs-toggle="tooltip" data-bs-offset="0,4" data-bs-placement="top" data-bs-html="true" title="</i><span>${empVo.cpNo }</span>">
									<i class='bx bxs-phone'></i>
								</button>
							</div>
							<div class="col me-1">
								<button type="button" onclick="empPhoneCopy('${empVo.empMail}')" class="btn btn-primary" data-bs-toggle="tooltip" data-bs-offset="0,4" data-bs-placement="top" data-bs-html="true" title="</i>${empVo.empMail }">
									<i class='bx bx-envelope'></i>
								</button>
							</div>
					
 							<div class="btn-group"> 						
								  <c:choose>
								  	<c:when test="${empVo.empSt eq '퇴직'}">
										  <button id="stBtn" style="border-radius: 7px;" class="btn btn-danger  
										  <c:if test="${empRole eq 'admin' || empRole eq 'manager'}">dropdown-toggle dropdown-toggle-split empstat-toggle-padding</c:if>" 
										  type="button" 
										  <c:if test="${empRole eq 'admin' || empRole eq 'manager'}">id="dropdownMenuButton1" data-bs-toggle="dropdown"</c:if> 
										  aria-expanded="false">
											  ${empVo.empSt}
								  		  </button>
								  	</c:when>
								  	<c:when test="${empVo.empSt eq '휴직'}">
										  <button id="stBtn" style="border-radius: 7px;" class="btn btn-warning 
										  <c:if test="${empRole eq 'admin' || empRole eq 'manager'}">dropdown-toggle dropdown-toggle-split empstat-toggle-padding</c:if>" 
										  type="button" 
										  <c:if test="${empRole eq 'admin' || empRole eq 'manager'}">id="dropdownMenuButton1" data-bs-toggle="dropdown"</c:if> 
										  aria-expanded="false">
											   ${empVo.empSt}
										  </button>
								  	</c:when>
								  	<c:otherwise>
								  			<button id="stBtn" style="border-radius: 7px;" class="btn btn-primary 
										  <c:if test="${empRole eq 'admin' || empRole eq 'manager'}">dropdown-toggle dropdown-toggle-split empstat-toggle-padding</c:if>" 
										  type="button" 
										  <c:if test="${empRole eq 'admin' || empRole eq 'manager'}">id="dropdownMenuButton1" data-bs-toggle="dropdown"</c:if> 
										  aria-expanded="false">
											     재직중
										  </button>
								  	</c:otherwise>
								  </c:choose>
								  <c:if test="${empRole eq 'admin' || empRole eq 'manager'}">
									  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
									    <li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#outModal" >퇴직 처리하기</a></li>
										<li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#breakModal">휴직 처리하기</a></li>
									  </ul>
								  </c:if> 
							</div> 

						</div>
					</div>
				</div>
			</div>
		</div>
		
 <c:if test="${empRole eq 'admin' || empRole eq 'manager'}">
		<!-- 퇴직 Modal -->
		<div class="modal fade" id="outModal" tabindex="-1" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel1">퇴직</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <hr>
		      <div class="modal-body">
<!-- 		        <div class="row"> -->
		          <div class="col mb-3">
		            <label for="nameBasic" class="form-label">퇴직사유</label>
<!-- 		            <input type="text" id="" class="form-control" placeholder="Enter Name"> -->
		            <select class="form-select" id="outSt" title="퇴직사유를 선택해주세요">
		            	<option>개인사정 자진퇴사</option>
		            	<option>고용주 사유로 자진퇴사</option>
		            	<option>폐업/도산</option>
		            	<option>경영상 인원감축</option>
		            	<option>근로자 귀책사유에 의한 퇴사</option>
		            	<option>정년퇴직</option>
		            	<option selected="selected">계약기간 만료</option>
		            	<option>이중고용</option>
		            	<option>기타</option>
		            </select>
		          </div>
		          <div class="col mb-3">
		            <label for="nameBasic" class="form-label">퇴직일자</label>
		            <input type="text" class="form-control" name="outdate" value="" required="required"/>
		          </div>
		          <div class="col mb-3">
		            <label for="nameBasic" class="form-label">메모</label>
		            <textarea id="outMemo" name="noteCont"
							class="form-control hrnotewrite" onfocus="this.value='';"
							rows="10" cols="20" wrap="hard" placeholder="내용을 입력해주세요."></textarea>
		          </div>
<!-- 		        </div> -->
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">취소</button>
		        <button type="button" class="btn btn-danger " id="outBtn">퇴직처리하기</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		
		<!-- 휴직 Modal -->
		<div class="modal fade" id="breakModal" tabindex="-1" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel1">휴직</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <hr>
		      <div class="modal-body">
		      	<div class="col mb-3">
		            <label for="nameBasic" class="form-label">휴직종류</label>
		            <select class="form-select" id="bkSt" title="휴직종류를 선택해주세요">
		            	<option selected="selected">일반휴직</option>
		            	<option>육아휴직</option>
		            	<option>산재휴직</option>
		            	<option>부상/질병휴직</option>
		            	<option>가족돌봄휴직</option>
		            	<option>병역휴직</option>
		            	<option>연수휴직</option>
		            	<option>무급노조전임자휴직</option>
		            </select>
		        </div>
		        <div class="col mb-3">	<!-- row g-2 -->
		            <label for="dobBasic" class="form-label">휴직기간선택</label>
		            <input type="text" name="datefilter" value="" class="form-control" required="required"/>
		        </div>
		        <div class="col mb-3">
		            <label for="nameBasic" class="form-label">메모</label>
		            <textarea id="bkMemo" name="noteCont"
							class="form-control hrnotewrite" onfocus="this.value='';"
							rows="10" cols="20" wrap="hard" placeholder="내용을 입력해주세요."></textarea>
		          </div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">취소</button>
		        <button type="button" class="btn btn-primary" id="bkBtn">적용하기</button>
		      </div>
		    </div>
		  </div>
		</div>
</c:if> 


<!-- ############################################################################################################################################ -->


		<nav class="d-flex navbar-light bg-white flex-md-nowrap w-100 p-0 mypageheadernav">

			<ul class="nav col">
				<li class="nav-item text-nowrap"><a class="nav-link active p-0 pe-4 fs-5" href="${cPath}/mypage/hrInfoRetrieve.do?empNo=${empVo.empNo}">인사 정보</a></li>
				<li class="nav-item text-nowrap"><a class="nav-link active p-0 pe-4 fs-5" href="${cPath}/mypage/basicInfoRetrieve.do?empNo=${empVo.empNo}">개인 정보</a></li>
				 <c:if test="${empRole eq 'admin' || empRole eq 'manager' ||  authEmp.empNo eq empVo.empNo}">
				<li class="nav-item text-nowrap"><a class="nav-link active p-0 pe-4 fs-5" href="${cPath}/mypage/contractInfoRetrieve.do?empNo=${empVo.empNo}">계약 정보</a></li>
				<li class="nav-item text-nowrap"><a class="nav-link active p-0 pe-4 fs-5" href="${cPath}/mypage/careerInfoRetrieve.do?empNo=${empVo.empNo}">경력·학력</a></li>
				</c:if>
				<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')">
				<li class="nav-item text-nowrap"><a class="nav-link active p-0 pe-4 fs-5" href="${cPath}/mypage/hrNoteRetrieve.do?empNo=${empVo.empNo}">인사 노트</a></li>
				</security:authorize>
			</ul>



			<div>
				<c:if test="${empRole eq 'admin' || empRole eq 'manager' ||  authEmp.empNo eq empVo.empNo}">
					<a class="btn btn-outline-primary mb-2" type="button" data-bs-toggle="offcanvas" href="#offcanvasBottom" aria-controls="offcanvasBottom">
						<span class="tf-icons bx bx-pie-chart-alt"></span>&nbsp; 정보 변경 내역
					</a>
				</c:if>
				<div class=" offcanvas offcanvas-bottom infohistoryh  border-top shadow-lg bg-white" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" id="offcanvasBottom" style="height: 85vh;">
					<div class="offcanvas-header d-block ">
						<div class="nav-align-top mb-4 offcanvas-title infohistorybottom border-primary " id="offcanvasBottomLabel">
							<ul class="nav nav-pills mb-3" role="tablist">
								<li>
										
									<div class="d-flex align-self-center align-items-center">
										<c:if test="${empty authEmp.empImg}">
					                     	<img
					                         src="${cPath}/resources/images/basicProfile.png"
					                         alt="기본프로필"
					                         class="empListimgradius emplistimgsize"
					                       >
							                 </c:if>
							                <c:if test="${not empty authEmp.empImg }">
							                  <img
							                     src="${cPath}/resources/empImages/${authEmp.empImg }"
							                     alt="${authEmp.empImg}"
							                     class="empListimgradius emplistimgsize"
							                   >
							             </c:if>
										<div class="mx-3 mt-1">
											<strong>${authEmp.empNm}</strong>
										</div>
									</div>
								</li>
								<li class="nav-item me-2 mt-2">
									<button type="button" class="nav-link active infohistorybtn" role="tab" data-bs-toggle="tab" data-bs-target="#navs-pills-top-hr" aria-controls="navs-pills-top-hr" aria-selected="true">인사정보</button>
								</li>
								<li class="nav-item me-2 mt-2">
									<button type="button" id="wkListBtn" class="nav-link infohistorybtn" role="tab" data-bs-toggle="tab" data-bs-target="#navs-pills-top-work" aria-controls="navs-pills-top-work" aria-selected="false" data-empno ="${empVo.empNo }">근로계약</button>
								</li>
								<li class="nav-item me-2 mt-2">
									<button type="button" id="wageListBtn" class="nav-link infohistorybtn" role="tab" data-bs-toggle="tab" data-bs-target="#navs-pills-top-money" aria-controls="navs-pills-top-money" aria-selected="false"  data-empno ="${empVo.empNo }">임금계약</button>
								</li>

								<li class="nav-item me-2 mt-2">
									<button type="button" class="nav-link infohistorybtn" role="tab" data-bs-toggle="tab" data-bs-target="#navs-pills-top-rest" aria-controls="navs-pills-top-rest" aria-selected="false">휴직이력</button>
								</li>
								<li class="empaddbutton">
									<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>

								</li>
							</ul>
						</div>




<!-- 오픈캔버스 내용 부분 -->
						<div class="offcanvas-body p-0 offcanvas-scrollbar hrcutomScroll">
<!-- ####################################################################################################################################################################################### -->

							<!-- 인사 -->
							<div class="tab-content p-0">
								<div class="tab-pane fade show active" id="navs-pills-top-hr" role="tabpanel">
								<div id="hrDataResult">
								

									<!-- 인사발령예정 -->
									<c:forEach items="${asgmtList }" var="asgmt">
										<c:if test="${asgmt.asgmtStat ne '완료'}">
											<div class="d-flex align-self-center align-items-center mb-4 asgmtDiv">
												<span class="badge badge-center rounded-pill bg-primary">!</span> &nbsp; 발령 - ${asgmt.asgmtClf} 예정 &nbsp;
												<div class="transdateborder ms-0">
													<span class="emplistspan"> <i class='bx bx-calendar-alt transcal'></i> ${asgmt.asgmtDate}
													</span>
												</div>
												<div class="ms-auto">
													<div>${asgmt.writerNm}
														<fmt:parseDate value="${asgmt.fwrDate}" var="dateValue" pattern="yyyy-MM-dd HH:mm"/>
														<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm"/>
														<fmt:parseDate value="${date}" var="dateValue" pattern="yyyy-MM-dd HH:mm"/>
														${date} &nbsp;
														<a class="btn btn-sm btn-danger ccstBtn" href="#hrmodal" data-bs-toggle="modal" data-asgmtno="${asgmt.asgmtNo}" data-asgmtpers="${asgmt.asgmtPers}">발령 취소</a>
													</div>
												</div>
											</div>
										</c:if>
									</c:forEach>

									<!-- 인사정보내역 -->
									<div class="card-body p-0">
										<div class="table-responsive text-nowrap offcanvas-scrollbar myscrollheight">
											<table class="table table-hover table-bordered ">
												<thead>
													<tr style="background-color:#f7f7f7">
														<th>발령일</th>
														<th>발령 라벨</th>
														<th>조직·직책</th>
														<th>직무</th>
														<th>직위</th>
														<th>직급</th>
														<th>메모</th>
														<th>변경 정보</th>
													</tr>
												</thead>
												<tbody>
												<c:if test="${not empty asgmtList}">
												
													<c:forEach items="${asgmtList }" var="asgmt">
														<c:if test="${asgmt.asgmtStat ne '예정'}">
															<tr>
																<td>
																	<span> ${asgmt.asgmtDate}</span>
																</td>
																<td>${asgmt.asgmtClf}</td>
																<td>
																	<c:forEach items="${asgmt.deptList}" var="dept" varStatus="status">
																		<span <c:if test="${dept.mainck eq 'Y'}">class="fw-semibold"</c:if> >
																			${dept.dnm}<c:if test="${not empty dept.dtnm }"> · ${dept.dtnm}</c:if>
																			<c:if test="${not empty dept.dno }"> · 조직장</c:if> 
																		</span>
																			 <c:if test="${!status.last}">,</c:if>&nbsp;
																	</c:forEach>
																</td>
																<td>
																		<c:if test="${not empty asgmt.jobList }">
																			<c:forEach items="${asgmt.jobList }" var="job" varStatus="status">
																				<c:if test="${!status.last }">
															                   		 ${job.jnm} ,&nbsp;
														                     	</c:if>
																				<c:if test="${status.last}"> 
														                  			${job.jnm} 
														                    	</c:if>
																			</c:forEach>
																		</c:if>
																</td>
																<td>${asgmt.ptnNm}</td>
																<td>${asgmt.grdNm}</td>
																<td>
																	<button type="button" class="btn btn-light memo shadow-none" data-bs-toggle="tooltip" data-bs-offset="0,4" data-bs-placement="top" data-bs-html="true" 
																	title="<span>
																	<c:choose>
																		<c:when test="${not empty asgmt.asgmtMm}">
																			${asgmt.asgmtMm}
																		</c:when>
																		<c:otherwise>
																			메모 없음
																		</c:otherwise>
																	</c:choose>
																	</span>">메모 보기</button>
																</td>
																<td>
																	<fmt:parseDate value="${asgmt.fwrDate}" var="dateValue" pattern="yyyy-MM-dd HH:mm"/>
																	<fmt:formatDate value="${dateValue}" pattern="yyyy-MM-dd HH:mm"/>
																	<fmt:parseDate value="${date}" var="dateValue" pattern="yyyy-MM-dd HH:mm"/>
																	<span>${date}</span><br> <span>${asgmt.writerNm}</span>
																</td>
															</tr>
														</c:if>
													</c:forEach>
												</c:if>
												<c:if test="${empty asgmtList}">
													<tr><td colspan="8" style="text-align: center;">내용없음</td></tr>
												</c:if>									
												</tbody>
											</table>
										</div>
										</div>
									</div>
								</div>
								
								<!-- 발령 취소 Modal-->
								<div class="modal fade" id="hrmodal" data-bs-backdrop="static" tabindex="-1" >
								  <div class="modal-dialog">
								    <div class="modal-content">
								      <div class="modal-header">
								        <h5 class="modal-title fw-semibold" id="modalToggleLabel">
								        	<span class="text-warning"><i class="bx bx-error"></i></span> 
								        	정말 발령을 취소할까요?
								        </h5>
								      </div>
								      <div class="modal-body">
								        	취소한 발령은 되돌릴 수 없어요.
								      </div>
								      <div class="modal-footer">
								      	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
								        <button id="delAsgmtBtn" class="btn btn-danger" data-bs-dismiss="modal">발령 취소</button>
								      </div>
								    </div>
								  </div>
								</div>
<!-- ####################################################################################################################################################################################### -->
								
								<!-- 근로 계약 -->
								<div class="tab-pane fade offcanvas-scrollbar" id="navs-pills-top-work" role="tabpanel">
									<div class="card-body p-0">
										<div class="table-responsive text-nowrap offcanvas-scrollbar">
											<table class="table table-bordered bg-white-blur">
												<thead>
													<tr>
														<th style="width : 100px;">수정 · 삭제</th>
														<th class="wk-th-width-27">근로 계약 시작일 (적용일)</th>
														<th class="wk-th-width-27">근로 계약 종료일</th>
														<th class="wk-th-width-13">근로 유형</th>
														<th class="wk-th-width-13">변경 메모</th>
														<th class="wk-th-width-13">변경 정보</th>
													</tr>
												</thead>
												<tbody  id="wkHxtbody">
													<tr>
														<td colspan="6" style="text-align: center;">내용없음</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>

								</div>
<!-- ####################################################################################################################################################################################### -->

								<!-- 임금 계약 -->
								<div class="tab-pane fade" id="navs-pills-top-money" role="tabpanel">

									<div class="card-body p-0">
										<div class="table-responsive text-nowrap offcanvas-scrollbar">
											<table class="table table-bordered bg-white-blur">
												<thead>
													<tr>
														<th>수정 · 삭제</th>
														<th>임금 계약 시작일 (적용일)</th>
														<th>임금 계약 종료일</th>
														<th>소득구분</th>
														<th>계약금액</th>
														<th>변경 메모</th>
														<th>변경 정보</th>
													</tr>
												</thead>
												<tbody id="wageHxtbody">
													<tr>
														<td colspan="6" style="text-align: center;">내용없음</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
<!-- ####################################################################################################################################################################################### -->

								<!-- 휴직 이력 -->
								<div class="tab-pane fade offcanvas-scrollbar" id="navs-pills-top-rest" role="tabpanel">


									<div class="card-body p-0">
										<div class="table-responsive text-nowrap offcanvas-scrollbar" id="bkHxList">
											<table class="table table-bordered bg-white-blur">
												<thead>
													<tr>
														<th class ="edit-delete-th">수정 · 삭제</th>
														<th class = "bk-period-th">휴직기간</th>
														<th>휴직종류</th>
														<th>메모</th>

													</tr>
												</thead>
												<tbody id="bkHxtbody">
													<tr>
														<td>
															<button type="button" class="btn btn-icon btn-outline-danger empaddbutton">
																<i class='bx bxs-trash-alt'></i>
															</button>
															<button type="button" class="btn btn-icon btn-outline-secondary empaddbutton">
																<i class='bx bxs-pencil'></i>
															</button>
														</td>

														<td>기록없음</td>

														<td>기록없음</td>

														<td>
															<button type="button" class="btn btn-light memo shadow-none" data-bs-toggle="tooltip" data-bs-offset="0,4" data-bs-placement="top" data-bs-html="true" title=" <span>메모</span>">메모 보기</button>

														</td>

													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
								
<!-- ####################################################################################################################################################################################### -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</nav>
	</div>
</div>


					<!-- 근로계약수정 토글 -->
					<div class="offcanvas offcanvas-end mypagetoggle w-px-500 shadow-lg border-start" data-bs-scroll="true" tabindex="-1" id="offcanvasBothbasicCon3">
						<div class="offcanvas-header">
							<h4 id="offcanvasBothLabel3" class="offcanvas-title">근로계약 추가</h4>
							<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button> <!--창을 닫는 X버튼-->
						</div>

						<!-------------------------------(시작) 등록/수정 버튼을 누르면 좌측에서 나오는 정보입력창------------------------------------------------------------------- -->
						<form name="lbform">
							<div class="offcanvas-body my-auto mx-0 flex-grow-0">
								<div class=" arcodiancheck mb-2">
									<div class="basicnamediv">
										<label for="defaultFormControlInput" class="form-label">근로 계약 시작일</label> 
										<input class="form-control" type="date" value="" id="lbcntSttdate2"/>
									</div>

									<div class="basicenglishname">
										<label for="defaultFormControlInput" class="form-label">근로 계약 종료일</label> 
										<input class="form-control" type="date" value="" id="lbcntEnddate2" />
									</div>
								</div>

								<div class="mb-4">
								
								<!-- DB CMCODE 테이블에서 근로계약유형 조회해서 띄워줌 -->	
								<div class="mb-4">
									<label class="form-label">근로 계약 유형</label>
									<!-- script에서 등록/수정 어느 버튼을 누르냐에 따라서 selected 값 다르게 줌. -->
									<select id="lbCase2" name="LaborCaseList" class="form-select">
<%-- 										<option id="choosedOption" value="${lbCntHxList.blCase}">${lbCntHxList.blCase}</option> --%>
										<option id="bslbcOption2" value="">근로유형</option>	

										<c:forEach items="${LaborCaseList}" var="lbcase">
											<option value="${lbcase.codeNm}">${lbcase.codeNm}</option>
										</c:forEach>
									</select>
									<form:errors path="LaborCaseList" element="span" cssClass="error" />
								</div>
									
									
								</div>

								<div class="  mb-2">
									<div class=" mb-0">
									
										<label for="defaultFormControlInput" class="form-label">수습정보</label>
										<div class="input-group">
											<input class="form-control" type="date" value="" id="prSttdate2" /> 
											<input class="form-control" type="date"	value="" id="prEnddate2" />
										</div>
									</div>
								</div>

								<div class="mb-2">
									<label for="exampleFormControlTextarea1" class="form-label">변경	메모</label>
									<textarea id="cngMm2" class="form-control" rows="3"></textarea>
								</div>
							</div>

							<div class="arcodiancheck">
								<button type="button" class="btn btn-outline-danger mb-2 w-30 ms-4" id="lbcntdeleteBtn2" data-cnthxno="${lbCntHxList.cnthxNo}">삭제</button>
								<button type="button" class="btn btn-outline-secondary mb-2 w-30 empaddbutton" data-bs-dismiss="offcanvas">취소</button>
								<button type="button" class="btn btn-primary mb-2 ms-3 w-40" id="lbcntInsertBtn2">저장하기</button>
								<button type="button" class="btn btn-primary mb-2 ms-3 w-40" id="lbcntUpdateBtn2" data-cnthxno="${lbCntHxList.cnthxNo}">변경하기</button>
								
							</div>
						</form>
						<!-------------------------------(종료) 등록/수정 버튼을 누르면 좌측에서 나오는 정보입력창------------------------------------------------------------------- -->
					</div>




	<!-- 임금계약수정 토글 -->
     <!-------------------------------(시작) 등록/수정 버튼을 누르면 좌측에서 나오는 정보입력창------------------------------------------------------------------- -->
					<div class="offcanvas offcanvas-end mypagetoggle w-px-500 shadow-lg border-start" data-bs-scroll="true" tabindex="-1" id="offcanvasBothbasicCon4" aria-labelledby="offcanvasBothLabel">
						<div class="offcanvas-header">
							<h5 id="offcanvasBothLabel4" class="offcanvas-title">임금계약 추가</h5>
							<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button> <!--창을 닫는 X버튼-->
						</div>


						<form>
							<div class="offcanvas-body my-auto mx-0 flex-grow-0">
								<div class=" arcodiancheck mb-2">
									<div class="basicnamediv">
										<label for="defaultFormControlInput" class="form-label">임금계약 시작일</label> 
										<input class="form-control" type="date" value=""id="wgcntSttdate2" />
									</div>

									<div class="basicenglishname">
										<label for="defaultFormControlInput" class="form-label">임금계약 종료일</label> 
										<input class="form-control" type="date" value="" id="wgcntEnddate2" />
									</div>
								</div>
								
								
								<!-- DB CMCODE 테이블에서 소득구분유형 조회해서 띄워줌 -->	
								<div class="mb-4">
									<label for="defaultFormControlInput" class="form-label">소득구분</label>
									<!-- script에서 등록/수정 어느 버튼을 누르냐에 따라서 selected 값 다르게 줌. -->
									<select id="wgicmclf2" name="incomeCaseList" class="form-select">
										<option id="bsiccOption2" value="">구분선택</option>	

										<c:forEach items="${incomeCaseList}" var="icCase">
											<option value="${icCase.codeNm}">${icCase.codeNm}</option>
										</c:forEach>
									</select>
									<form:errors path="incomeCaseList" element="span" cssClass="error" />
								</div>
								
								
								<div class="mb-4">
									<label for="defaultFormControlInput" class="form-label">계약금액</label>
									<div class="input-group ">
										<input type="text" id="wgcntAmt2" class="form-control" placeholder="계약금액 입력" aria-label="Recipient's username" aria-describedby="basic-addon13" />
										<span class="input-group-text" >원</span>
									</div>
								</div>
								<div class="mb-4">
									<label for="defaultFormControlInput" class="form-label">식비</label>
									<div class="input-group ">
										<input type="text" id="wgcntFex2" class="form-control" placeholder="식비 입력" aria-label="Recipient's username" aria-describedby="basic-addon13" />
										<span class="input-group-text" >원</span>
									</div>
								</div>
								
								<div class="mb-2">
									<label for="exampleFormControlTextarea1" class="form-label" >변경 메모</label>
									<textarea id="wgcngMm2" class="form-control" rows="3"></textarea>
								</div>
							</div>

							<div class="arcodiancheck">
								<button type="button" class="btn btn-outline-secondary mb-2 w-30 empaddbutton" data-bs-dismiss="offcanvas">취소</button>
								<button type="button" class="btn btn-primary mb-2 ms-3 w-40" id="wgcntUpdateBtn2" data-cnthxno="${lbCntHxList.cnthxNo}">변경하기</button>
							</div>
						</form>
					</div>
<!--  -------------------------------(종료) 좌측 위젯버튼--------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->


	<!-- 휴직수정 Modal -->
		<div class="modal fade" id="bkEditModal" tabindex="-1" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel1">휴직</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <hr>
		      <div class="modal-body">
		      	<div class="col mb-3">
		            <label for="nameBasic" class="form-label">휴직종류</label>
		            <select class="form-select" id="editbkSt" title="휴직종류를 선택해주세요">
		            	<option selected="selected">일반휴직</option>
		            	<option>육아휴직</option>
		            	<option>산재휴직</option>
		            	<option>부상/질병휴직</option>
		            	<option>가족돌봄휴직</option>
		            	<option>병역휴직</option>
		            	<option>연수휴직</option>
		            	<option>무급노조전임자휴직</option>
		            </select>
		        </div>
		        <div class="col mb-3">	<!-- row g-2 -->
		            <label for="dobBasic" class="form-label">휴직기간선택</label>
		            <input type="text" name="datefilter" value="" class="form-control" required="required"/>
		        </div>
		        <div class="col mb-3">
		            <label for="nameBasic" class="form-label">메모</label>
		            <textarea id="EditbkMemo" name="noteCont"
							class="form-control hrnotewrite" onfocus="this.value='';"
							rows="10" cols="20" wrap="hard" placeholder="내용을 입력해주세요."></textarea>
		          </div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">취소</button>
		        <button type="button" class="btn btn-primary" id="bkEditBtn">수정하기</button>
		      </div>
		    </div>
		  </div>
		</div>



<script src="${cPath}/resources/js/cysHeaderMenu.js"></script>
<script type="text/javascript" defer="defer">
$(function() {
	
//#####################################################################################################################################################################
// 인사정보 발령예정 취소 

	// 인사발령 번호
	let asgmtNo;
	// 인사발령 대상
	let asgmtPers;
	// 인사발령 취소객체 div
	let asgmtDiv;
	
	//인사발령 취소 확인버튼
	$(document).on('click', '.ccstBtn', function() {
		asgmtDiv = $(this).closest(".asgmtDiv");
		asgmtNo = $(this).data('asgmtno');
		asgmtPers = $(this).data('asgmtpers');
	});
	// 인사발령 취소 비동기
	$(document).on('click','#delAsgmtBtn', function() {
		$.ajax({
			url : CONTEXTPATH+"/mypage/hrInfoCancel.do",
			method : "post",
			data : { asgmtNo : asgmtNo
					, asgmtPers : asgmtPers },
			dataType : "json",
			success : function(resp) {
				console.log("갔다왔슴");
				if(resp.status == 'success'){
		            toastr.success('발령예정을 취소했습니다.');
		            asgmtDiv.remove();
		        }else if(resp.status == 'fail'){ 
		            toastr.error('취소 중 오류가 발생 했습니다.');
		        }
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	});
//#####################################################################################################################################################################
	
})

//퇴직, 휴직 처리 관련 스크립트===========================================================================


//전역변수=====================================================================================================
var outdate =""
var std = "";
var end = "";
var user = ${authEmp.empNo};
var empNo = $('span[id="empNm-No"]').data("empno");
var empSt = $('span[id="empNm-No"]').data("empst");

//오늘 날짜와, 휴직/퇴직일자를 비교하기 위한 날짜변수 생성
var date = new Date();   
var today2 = date.toLocaleString('ko-kr');
const year = date.getFullYear();
const month = ('0' + (date.getMonth() + 1)).slice(-2);
const day = ('0' + date.getDate()).slice(-2);
const dateStr = year + '-' + month + '-' + day;

console.log("바깥에서outdate : "+ outdate);
console.log("바깥에서 startDate : "+std);
console.log("바깥에서 EndDate : "+end);
console.log("date : " + date);
console.log("today2 : " + today2);
console.log("dateStr : " + dateStr);

bkHxSelect();
stTagSet();

//휴직, 퇴직 처리=================================================================================================
//퇴직처리-------------------------------------------------------------------------------------------------------
$("#outBtn").on("click",function(){
	console.log("퇴직버튼누름")
	console.log("버튼누름 outdate : "+outdate);
	console.log("버튼누름 empNo : "+empNo);
	console.log("버튼누름 empSt : "+empSt);
	
	let outSt = $('#outSt').val();
	let outMemo = $("#outMemo").val().replace(/(?:\r\n|\r|\n)/g,'<br/>');
	//===================================================================================================
	$.ajax({
		url : "OutStInsert.do",
		data : {
			empNo : empNo,
			otDate : outdate,
			stClf : outSt,
			stMemo : outMemo
		},
		type : "POST",
		success : function(resp) {
			console.log(resp);
			
			if(resp == "SUCCESS"){
				toastr.success('퇴직처리가 완료되었습니다.');
				$("#outModal").modal('hide');
				console.log("out-if문 실행");
				
				//오늘 날짜가 퇴직 기간 이후에 포함이 된다면 상태를 퇴직으로 바꿔주고, 그렇지 않다면 그대로 둔다. 
				if(dateStr >= outdate){
					$("#stBtn").attr('class','btn btn-danger dropdown-toggle dropdown-toggle-split empstat-toggle-padding').text("퇴직");
					console.log("오늘이크다")
				}else{
					console.log("오늘이작다")
				};
				stTagChange();
				
			}else{
				toastr.error('퇴직처리에 실패하였습니다');	
			}
		},
		error : function(errorResp) {
			console.log(errorResp.status);
			toastr.error('퇴직처리에 실패하였습니다');
		}
	});
	//===================================================================================================
});

//휴직처리-------------------------------------------------------------------------------------------------------
$("#bkBtn").on("click",function(){
	console.log("휴직버튼누름")
	console.log("버튼누름 startDate : "+std);
    console.log("버튼누름 vEndDate : "+end);
    console.log("버튼누름 empNo : "+empNo);
    console.log("버튼누름 empSt : "+empSt);
    
	let bkSt = $('#bkSt').val();
	let bkMemo = $("#bkMemo").val().replace(/(?:\r\n|\r|\n)/g,'<br/>');
    
    $.ajax({
		url : "BkStInsert.do",
		data : {
			empNo : empNo,
			bkSdate : std,
			bkEdate : end,
			stClf : bkSt,
			stMemo : bkMemo
		},
		type : "POST",
		success : function(resp) {
			console.log(resp);
			
			if(resp == "SUCCESS"){
				toastr.success('휴직처리가 완료되었습니다.');
				bkHxSelect();
				$("#breakModal").modal('hide');
				
				//오늘 날짜가 휴직 기간 이내에 포함이 된다면 상태를 휴직으로 바꿔주고, 그렇지 않다면 그대로 둔다. 
				if(dateStr >= std && dateStr <= end){
					$("#stBtn").attr('class','btn btn-warning dropdown-toggle dropdown-toggle-split empstat-toggle-padding').text("휴직");
					console.log("휴직기간에포함된다")
				}else{
					console.log("휴직기간에 포함되지 않는다")
				};
					
				stTagChange();
				
				console.log("bk-if문 실행");
			}else{
				toastr.error('휴직처리에 실패하였습니다');	
			}
		},
		error : function(errorResp) {
			console.log(errorResp.status);
			toastr.error('휴직처리에 실패하였습니다');
		}
    });
    
});

//=============================================================================================================

//휴직, 퇴직일자 선택하는 date range picker===========================================================================
$(function() {
	
//------------------퇴직일자 선택----------------------------------------------------------------------------------
	  $('input[name="outdate"]').daterangepicker({
	    singleDatePicker: true,
	    showDropdowns: true,
	    minYear: 1901,
	    maxYear: parseInt(moment().format('YYYY'),10)
	  }, function(start, end, label, picker) {
	    var years = moment().diff(start, 'years');
	    
	    console.log("You are " + years + " years old!");
		console.log("start : " + start);
		console.log("picker : "+picker);
		console.log("end : " + end);
		console.log("label : " + label);
	  });
	
	  $('input[name="outdate"]').on('apply.daterangepicker', function(ev, picker) {
		outdate = picker.startDate.format('YYYY-MM-DD');
		console.log("outdate : "+outdate);
	});
	  
//------------------휴직기간 선택----------------------------------------------------------------------------------
	  $('input[name="datefilter"]').daterangepicker({
	      autoUpdateInput: false,
	      locale: {
	          cancelLabel: 'Clear'
	      }
	  });

	  $('input[name="datefilter"]').on('apply.daterangepicker', function(ev, picker) {
		  std = picker.startDate.format('YYYY-MM-DD');
		  end = picker.endDate.format('YYYY-MM-DD');
		  
	      $(this).val(picker.startDate.format('MM/DD/YYYY') + ' - ' + picker.endDate.format('MM/DD/YYYY'));
	      
	      console.log("vstartDate : "+std);
	      console.log("vEndDate : "+end);
	      
	  });
	  
	  console.log("두번쨰 바깥에서 vstartDate : "+std);
      console.log("두번쨰 바깥에서 vEndDate : "+end);

	  $('input[name="datefilter"]').on('cancel.daterangepicker', function(ev, picker) {
	      $(this).val('');
	  });

	});

//--------------------------------------------------------------------------------------------------------------

	//근로계약목록조회
	$.ajax({
		url : CONTEXTPATH+"/mypage/WorkCntRetrieve.do", 
		data : { empNo : empNo },
		dataType : "json",
		success : function(resp) { 
			console.log("WorkCntRetrieve",resp);
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});

	//임금계약목록조회
	$.ajax({
		url : CONTEXTPATH+"/mypage/WageCntRetrieve.do", 
		data : { empNo : empNo },
		dataType : "json",
		success : function(resp) { 
			console.log("WageCntRetrieve",resp);
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});

	
//================================================================================================================
	//계약목록 수정--------------------------------------------------------
	//기본 폼 오른쪽에서 꺼내오는 함수
	function showEditWindow(){
		$('#lbcntdeleteBtn2').hide();	//삭제버튼 보여주기
		$('#lbcntInsertBtn2').hide();	//신규 작성 버튼 숨기기
		$('#lbcntUpdateBtn2').hide();	//기존 정보 수정 버튼 보여주기
		$('#lbcntUpdateBtn2').show();	//정보 수정 버튼 보여주기
		console.log("폼을꺼냅니당");
}
	
	//근로계약 수정시 사용하는 함수
	function lbhxEdit(cnthxNo){
		let empNo = ${empVo.empNo};
		let cntEditor = ${authEmp.empNo};
		let blctSdate = $("#lbcntSttdate2").val();
		let blctEdate = $("#lbcntEnddate2").val();
		let blCase = $("#lbCase2").val();
		let prSdate = $("#prSttdate2").val();
		let prEdate = $("#prEnddate2").val();
		let cngMm = $("#cngMm2").val().replace(/(?:\r\n|\r|\n)/g, '<br/>');
		
		//입력창
		let lbcseprint = $("#lbcseprint");
		let lbCntperoidprint = $("#lbCntperoidprint");
		let lbPrperiodprint = $("#lbPrperiodprint");
		
		console.log("cnthxNo"+cnthxNo);
		console.log("cntEditor" + cntEditor);
		console.log("blctSdate" + blctSdate);
		console.log("blctEdate" + blctEdate);
		console.log("blCase" + blCase);
		console.log("prSdate" + prSdate);
		console.log("prEdate" + prEdate);
		console.log("cngMm" + cngMm);
		
		$.ajax({
			url : "LaborCntInfoUpdate.do",
			data : {
				cnthxNo : cnthxNo,
				cntEditor : cntEditor,
				blctSdate : blctSdate,
				blctEdate : blctEdate,
				blCase : blCase,
				prSdate : prSdate,
				prEdate : prEdate,
				cngMm : cngMm
			},
			type : "POST",
			success : function(resp) {
				console.log(resp);
				
				if(resp == "SUCCESS"){
					toastr.success('인사정보를 수정하였습니다');
					wkListPrint(vEmpNo);
				}else{
					toastr.error('인사정보 수정에 실패하였습니다');	
				}
			},
			error : function(errorResp) {
				console.log(errorResp.status);
				toastr.error('인사정보 수정에 실패하였습니다');
			}
		});
		//저장하기 하면 다시 입력창을 닫아준다
		$('#offcanvasBothbasicCon3').offcanvas('hide');

	};
	
	
	//임금계약 수정시 사용하는 함수
	function wagehxEdit(cnthxNo){
		let cntEditor = ${authEmp.empNo};
		let bwctSdate = $("#wgcntSttdate2").val();
		let bwctEdate = $("#wgcntEnddate2").val();
		let bincClf = $("#wgicmclf2").val();
		let bcntAmt = $("#wgcntAmt2").val();
		let bfex = $("#wgcntFex2").val();
		let cngMm = $("#wgcngMm2").val().replace(/(?:\r\n|\r|\n)/g, '<br/>');
		
		//입력창
		let wgicmclfprint = $("#wgicmclfprint");
		let wgPeriodprint = $("#wgPeriodprint");
		let wgAmtprint = $("#wgAmtprint");
		let wgfexprint = $("#wgfexprint");
		
		console.log("cnthxNo"+cnthxNo);
		console.log("cntEditor" + cntEditor);
		console.log("bwctSdate" + bwctSdate);
		console.log("bwctEdate" + bwctEdate);
		console.log("bincClf" + bincClf);
		console.log("bcntAmt" + bcntAmt);
		console.log("bfex" + bfex);
		console.log("cngMm" + cngMm);

		$.ajax({
			url : "WageCntInfoUpdate.do",
			data : {
				cnthxNo : cnthxNo,
				cntEditor : cntEditor,
				bwctSdate : bwctSdate,
				bwctEdate : bwctEdate,
				bincClf : bincClf,
				bcntAmt : bcntAmt,
				bfex :bfex,
				cngMm : cngMm
			},
			type : "POST",
			success : function(resp) {
				console.log(resp);
				
				if(resp == "SUCCESS"){
					toastr.success('인사정보를 수정하였습니다');
					wageListPrint(vEmpNo);
					
					//입력한 내용으로 화면 바꿔주기
					wgicmclfprint.html(bincClf);
					wgPeriodprint.html(bwctSdate + " ~ " + bwctEdate);
					wgAmtprint.html(bcntAmt);
					wgfexprint.html(bfex);
				}else{
					toastr.error('인사정보 수정에 실패하였습니다');	
				}
			},
			error : function(errorResp) {
				console.log(errorResp.status);
				toastr.error('인사정보 수정에 실패하였습니다');
			}
		});
		//저장하기 하면 다시 입력창을 닫아준다
		$('#offcanvasBothbasicCon4').offcanvas('hide');

	};
	

//=======================전화번호, 이메일 복사 =====================================
function empPhoneCopy(origin){
	
	
	 toastr.options = {
  "closeButton": true,

  "positionClass": "toast-top-center",
 }
	 const textArea = document.createElement('textarea');
	 document.body.appendChild(textArea);
	 textArea.value = origin;
	 textArea.select();
	 document.execCommand('copy');
	 toastr.success(origin + ' 가 복사되었습니다.').css("width","400px");
	 

 }	
	



function imgUpdate(){
	
	 	let form = $('#empImgForm'); 	
	 	form.submit();
	 }
	 
 
 
 
//프로필 이미지 삭제  ============================================================================================
function delProfile(img){
	let empNo = $('#empNm-No').data('empno');

	console.log(empNo);
	console.log(img);
	
	$.ajax({

		url : CONTEXTPATH+"/mypage/deleteEmpImg.do", 
		method : "POST", 
		data : {empNo : empNo}, 
		dataType : "json",
		success : function(resp) { 
			console.log(resp)
			
			if(resp == 1){				
				$img = document.querySelector("#uploadedemp");
				$img.src = `${pageContext.request.contextPath}/resources/images/기본프로필.jpg`;
			}else{
				toastr.error('프로필 사진 변경을 실패했습니다.');
			}
		},
		error : function(errorResp) {

			console.log(errorResp.status);
		}

	});
} 

	
	
</script>