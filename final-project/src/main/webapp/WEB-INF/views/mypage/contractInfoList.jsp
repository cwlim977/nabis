<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

   <div class="empFormheader"> 
   <div class="mypagetablewidth">
   	
   		<!-------------------------(시작)'근로계약' 항목  -------------------------------------------------------->
		<div class="card shadow-none ">
		<div class="arcodiancheck">
        	<h5 class="card-header pt-2 ps-3 fs-4 fw-bold">근로계약</h5>
          
 <!--  -------------------------------근로계약 변경 버튼--------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->
				<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')">
				<div class="dropdown p-4 py-0 pt-2 empaddbutton">

					<!-- 근로계약 등록/수정/삭제를 위한 연필 버튼 -->
					<button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
						<i class='bx bxs-pencil'></i>
					</button>

					<!------------------------------- (시작) 상단의 버튼을 누르면 나오는 메뉴, 추가/변경(수정,삭제)을 할 수 있음 -------------------------------------------------------->
					<div class="dropdown-menu">
						<a class="dropdown-item" href="javascript:void(0);"> 
							<i class='bx bx-plus'></i>
							<button type="button" class="btn p-0 basicdeletbtnHide" data-bs-toggle="offcanvas" data-bs-target="#offcanvasBothbasicCon1" aria-controls="offcanvasBoth" id="lbAdd">
								새로 추가하기
							</button>
						</a>
						<a class="dropdown-item" href="javascript:void(0);"> 
							<i class='bx bxs-edit'></i>
							<button type="button" class="btn p-0 basicdeletebtnShow" data-bs-toggle="offcanvas" data-bs-target="#offcanvasBothbasicCon1" aria-controls="offcanvasBoth" id="lbEdit">
								기본 정보 변경하기
							</button>
						</a>
					</div>
					
					<!-- 수정 토글 -->
					<div class="offcanvas offcanvas-end mypagetoggle w-px-600" data-bs-scroll="true" tabindex="-1" id="offcanvasBothbasicCon1" aria-labelledby="offcanvasBothLabel">
						<div class="offcanvas-header">
							<h4 id="offcanvasBothLabel" class="offcanvas-title">근로계약 추가</h4>
							<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button> <!--창을 닫는 X버튼-->
						</div>

						<!-------------------------------(시작) 등록/수정 버튼을 누르면 좌측에서 나오는 정보입력창------------------------------------------------------------------- -->
						<form name="lbform">
							<div class="offcanvas-body my-auto mx-0 flex-grow-0">
								<div class=" arcodiancheck mb-2">
									<div class="basicnamediv">
										<label for="defaultFormControlInput" class="form-label">근로 계약 시작일</label> 
										<input class="form-control" type="date" value="" id="lbcntSttdate"/>
									</div>

									<div class="basicenglishname">
										<label for="defaultFormControlInput" class="form-label">근로 계약 종료일</label> 
										<input class="form-control" type="date" value="" id="lbcntEnddate" />
									</div>
								</div>
								<div class="mb-4">
								<!-- DB CMCODE 테이블에서 근로계약유형 조회해서 띄워줌 -->	
								<div class="mb-4">
									<label class="form-label">근로 계약 유형</label>
									<!-- script에서 등록/수정 어느 버튼을 누르냐에 따라서 selected 값 다르게 줌. -->
									<select id="lbCase" name="LaborCaseList" class="form-select">
<%-- 										<option id="choosedOption" value="${lbCntHxList.blCase}">${lbCntHxList.blCase}</option> --%>
										<option id="bslbcOption" value="">근로유형</option>	

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
											<input class="form-control" type="date" value="" id="prSttdate" /> 
											<input class="form-control" type="date"	value="" id="prEnddate" />
										</div>
									</div>
								</div>
								<div class="mb-2">
									<label for="exampleFormControlTextarea1" class="form-label">변경	메모</label>
									<textarea id="cngMm" class="form-control" rows="3"></textarea>
								</div>
							</div>
 
							<div class="arcodiancheck">
								<button type="button" class="btn btn-outline-danger mb-2 w-30 ms-4" id="lbcntdeleteBtn" data-cnthxno="${lbCntHxList.cnthxNo}">삭제</button>
								<button id="autoBtn" type="button" class="btn btn-icon mb-2 ms-4 btn-label-primary" onclick="dataAutoInput();">
		                       		 <span class="tf-icons bx bx bxs-edit-alt"></span>
		                       </button>
								<button type="button" class="btn btn-outline-secondary mb-2 w-30 empaddbutton" data-bs-dismiss="offcanvas">취소</button>
								<button type="button" class="btn btn-primary mb-2 ms-3 w-40 me-4" id="lbcntInsertBtn">저장하기</button>
								<button type="button" class="btn btn-primary mb-2 ms-3 w-40" id="lbcntUpdateBtn" data-cnthxno="${lbCntHxList.cnthxNo}">변경하기</button>
							</div>
						</form>
						<!-------------------------------(종료) 등록/수정 버튼을 누르면 좌측에서 나오는 정보입력창------------------------------------------------------------------- -->
					</div>
				
					<!------------------------------- (종료) 상단의 버튼을 누르면 나오는 메뉴, 추가/변경(수정,삭제)을 할 수 있음 -------------------------------------------------------->
				</div>
				</security:authorize>
<!--  -------------------------------근로계약 변경 버튼 종료--------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->

            	</div>
            	
            <!-------------------------(시작)'근로계약' 정보 출력   -------------------------------------------------------->
			<div class="table-responsive text-nowrap">
				<table class="table table-borderless">
					<tbody>
						<tr>
							<td class="tdwidth">근로 유형</td>
							<c:choose>
								<c:when  test="${not empty lbCntHxList.blCase}" >
									<td id="lbcseprint">${lbCntHxList.blCase}</td>
								</c:when>
								<c:otherwise>
									<td id="lbcseprint">미설정</td>	
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<td class="tdwidth">계약 기간</td>
							<td id="lbCntperoidprint">${lbCntHxList.blctSdate} ~ ${lbCntHxList.blctEdate}</td>
						</tr>
						<c:if test="${not empty lbCntHxList.prSdate}">
							<tr>
								<td class="tdwidth">수습기간</td>
								<td id="lbPrperiodprint">${lbCntHxList.prSdate} ~ ${lbCntHxList.prEdate}</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			<!-------------------------(종료)'근로계약' 정보 출력   -------------------------------------------------------->
        </div>      
		<!-------------------------(종료)'근로계약' 항목  -------------------------------------------------------->
            
            
        <!-------------------------(시작)'임금계약' 정보 출력  -------------------------------------------------------->
		<div class="card shadow-none ">
		<div class="arcodiancheck">
          <h5 class="card-header pt-5 ps-3 fs-4 fw-bold">임금계약</h5>
          
<!--  -------------------------------임금계약 변경 버튼--------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->
       <security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')">
         <div class="dropdown p-4 py-0 pt-5 empaddbutton">
                            
                         <!-- 임금계약 등록/수정/삭제를 위한 연필 버튼 -->
                         <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
                          <i class='bx bxs-pencil'></i>
                        </button>
                    
                    	<!------------------------------- (시작) 상단의 버튼을 누르면 나오는 메뉴, 추가/변경(수정,삭제)을 할 수 있음 -------------------------------------------------------->
					<div class="dropdown-menu">
						<a class="dropdown-item" href="javascript:void(0);"> 
							<i class='bx bx-plus'></i>
							<button type="button" class="btn p-0 basicdeletbtnHide2" data-bs-toggle="offcanvas" data-bs-target="#offcanvasBothbasicCon2" aria-controls="offcanvasBoth"  id="wgAdd">
								새로 추가하기
							</button>
						</a> 
						<a class="dropdown-item" href="javascript:void(0);"> 
							<i class='bx bxs-edit'></i>
							<button type="button" class="btn p-0 basicdeletebtnShow2" data-bs-toggle="offcanvas" data-bs-target="#offcanvasBothbasicCon2" aria-controls="offcanvasBoth" id="wgEdit">
								기본 정보 변경하기
							</button>
						</a>
					</div>
					<!-------------------------------(종료) 상단의 버튼을 누르면 나오는 메뉴, 추가/변경(수정,삭제)을 할 수 있음 -------------------------------------------------------->
                         
                              
                         <!-------------------------------(시작) 등록/수정 버튼을 누르면 좌측에서 나오는 정보입력창------------------------------------------------------------------- -->
					<div class="offcanvas offcanvas-end mypagetoggle w-px-600" data-bs-scroll="true" tabindex="-1" id="offcanvasBothbasicCon2" aria-labelledby="offcanvasBothLabel">
						<div class="offcanvas-header">
							<h4 id="offcanvasBothLabel2" class="offcanvas-title">임금계약 추가</h4>
							<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button> <!--창을 닫는 X버튼-->
						</div>
						<form>
							<div class="offcanvas-body my-auto mx-0 flex-grow-0">
								<div class=" arcodiancheck mb-2">
									<div class="basicnamediv">
										<label for="defaultFormControlInput" class="form-label">임금계약 시작일</label> 
										<input class="form-control" type="date" value=""id="wgcntSttdate" />
									</div>

									<div class="basicenglishname">
										<label for="defaultFormControlInput" class="form-label">임금계약 종료일</label> 
										<input class="form-control" type="date" value="" id="wgcntEnddate" />
									</div>
								</div>
								
								<!-- DB CMCODE 테이블에서 소득구분유형 조회해서 띄워줌 -->	
								<div class="mb-4">
									<label for="defaultFormControlInput" class="form-label">소득구분</label>
									<!-- script에서 등록/수정 어느 버튼을 누르냐에 따라서 selected 값 다르게 줌. -->
									<select id="wgicmclf" name="incomeCaseList" class="form-select">
										<option id="bsiccOption" value="">구분선택</option>	

										<c:forEach items="${incomeCaseList}" var="icCase">
											<option value="${icCase.codeNm}">${icCase.codeNm}</option>
										</c:forEach>
									</select>
									<form:errors path="incomeCaseList" element="span" cssClass="error" />
								</div>
								
								<div class="mb-4">
									<label for="defaultFormControlInput" class="form-label">계약금액</label>
									<div class="input-group ">
										<input type="text" id="wgcntAmt" class="form-control" placeholder="계약금액 입력" aria-label="Recipient's username" aria-describedby="basic-addon13" />
										<span class="input-group-text" >원</span>
									</div>
								</div>
								<div class="mb-4">
									<label for="defaultFormControlInput" class="form-label">식비</label>
									<div class="input-group ">
										<input type="text" id="wgcntFex" class="form-control" placeholder="식비 입력" aria-label="Recipient's username" aria-describedby="basic-addon13" />
										<span class="input-group-text" >원</span>
									</div>
								</div>
								
								<div class="mb-2">
									<label for="exampleFormControlTextarea1" class="form-label" >변경 메모</label>
									<textarea id="wgcngMm" class="form-control" rows="3"></textarea>
								</div>
							</div>

							<div class="arcodiancheck">
								<button type="button" class="btn btn-outline-danger mb-2 w-30 ms-4" id="wgcntdeleteBtn" data-cnthxno="${WgCntHxList.cnthxNo}">삭제</button>
								<button id="autoBtn2" type="button" class="btn btn-icon mb-2 ms-4 btn-label-primary" onclick="dataAutoInput2();">
		                       		 <span class="tf-icons bx bx bxs-edit-alt"></span>
		                       </button>
								<button type="button" class="btn btn-outline-secondary mb-2 w-30 empaddbutton" data-bs-dismiss="offcanvas">취소</button>
								<button type="button" class="btn btn-primary mb-2 ms-3 w-40" id="wgcntInsertBtn">저장하기</button>
								<button type="button" class="btn btn-primary mb-2 ms-3 w-40" id="wgcntUpdateBtn" data-cnthxno="${lbCntHxList.cnthxNo}">변경하기</button>
							</div>
						</form>
					</div>
					<!-------------------------------(종료) 등록/수정 버튼을 누르면 좌측에서 나오는 정보입력창------------------------------------------------------------------- -->
              		</div>
              		</security:authorize>
<!--  -------------------------------임금계약 변경 버튼 종료--------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->
					
                      </div>
                      <!-- 임금계약 테이블 -->
							<div class="table-responsive text-nowrap">
				                  <table class="table table-borderless">
				                    <thead>
				                    </thead>
				                    <tbody>
				                      <tr>
				                      	<td class="tdwidth" >소득 구분</td>
				                      	<c:choose>
					                      	<c:when test="${not empty WgCntHxList.bincClf}">
					                      		<td id="wgicmclfprint">${WgCntHxList.bincClf}</td>
					                      	</c:when>
					                      	<c:otherwise>
					                      		<td id="wgicmclfprint">미설정</td>
					                      	</c:otherwise>
				                      	</c:choose>
				                      </tr>
				                      <tr>
				                      	<td class="tdwidth" >임금계약 기간</td>
				                      	<td id="wgPeriodprint" >${WgCntHxList.bwctSdate} ~ ${WgCntHxList.bwctEdate}</td>
				                      </tr>
				                      <tr>
				                      	<td class="tdwidth" >계약 금액</td>
				                      	<c:choose>
					                      	<c:when test="${not empty WgCntHxList.bcntAmt}">
						                      	<td id="wgAmtprint"><fmt:formatNumber value="${WgCntHxList.bcntAmt}" pattern="#,###"/> 원</td>
					                      	</c:when>
					                      	<c:otherwise>
					                      		<td id="wgAmtprint">0 원</td>
					                      	</c:otherwise>
				                      	</c:choose>
				                      </tr>
				                      
				                      <c:if test="${not empty WgCntHxList.bfex}">
					                      <tr>
					                      	<td class="tdwidth" >식비</td>
					                      	<td id="wgfexprint"><fmt:formatNumber value="${WgCntHxList.bfex }" pattern="#,###"/> 원</td>
					                      </tr>
				                      </c:if >
				                    </tbody>
				                  </table>
				                </div>
		       			</div>
		            </div>

<!--  -------------------------------(시작) 좌측 위젯버튼--------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->
			<!-- 근무시간 위젯버튼 -->
			<c:if test="${empRole eq 'admin' || empRole eq 'manager' ||  authEmp.empNo eq empVo.empNo}">
			<div class="col-md-6 col-xl-4 mypagerightwidth">
				<div class="card shadow-none bg-transparent border border-secondary mb-4 mypagecardheigh">
					<div class="card-body cntcard mt-5 pb-4">
						<div>
							<span class="card-title">근무시간</span>
							<h4 class="card-text">
								<span>0</span>분
							</h4>
						</div>
						<div class="cnticon">
							<i class='bx bxs-user bx-md cnti'></i>
						</div>
					</div>
				</div>
				
				<!-- 남은연차 위젯버튼 -->
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
				
				<!-- 급여명세서 위젯버튼 -->
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
<!--  -------------------------------(종료) 좌측 위젯버튼--------------------------------------------------------------------------------------------------------------------------------------------------------------------- -->
</div>
   
<script>

function dataAutoInput() {
	$('#lbcntEnddate').val('2023-12-15');
	$('select[name="LaborCaseList"]').find('option[value="정규직근로자"]').prop("selected",true);
	$('#prSttdate').val('2022-12-15');
	$('#prEnddate').val('2023-03-15');
	$('#cngMm').val('근로계약 정보');	
};
 function dataAutoInput2() {	
	$('#wgcntEnddate').val('2023-12-15');
	$('select[name="incomeCaseList"]').find('option[value="근로소득"]').prop("selected",true);
	$('#wgcntAmt').val('300000');
	$('#wgcntFex').val('10000');
	$('#wgcngMm').val('임금계약 추가');
	
}; 
//--------------------------------[공통기능]---------------------------------------------------------------------
//각 추가, 수정 버튼 누를때 나타나는 ui변화
		//근로계약 추가 버튼 누를 시
	$('.basicdeletbtnHide').on("click", function() {
		$('#offcanvasBothLabel').text("근로계약 추가");
		$('#autoBtn').show();
		$('#lbcntdeleteBtn').hide();	//삭제버튼 없애기
		$('#lbcntInsertBtn').show();	//신규 작성 버튼 보여주가
		$('#lbcntUpdateBtn').hide();	//기존 정보 수정 버튼 숨기기
// 		$('select[name="LaborCaseList"]').find('option[id="bslbcOption"]').attr("selected",true);	//'근로유형' 항목이 기본 선택항목으로
		$('select[name="LaborCaseList"]').find('option[id="bslbcOption"]').prop("selected",true);	//'근로유형' 항목이 기본 선택항목으로
																		//속성에서 true/false 쓰는건 prop 하고, 그냥 속성명 주거나 값 주는건 attr로 하고, 약간 버그있대 jquery
																		//누를때마다 selected 되려면 prop 해야, 안그러면 한번만 동작하고 동작을 안함.
	});
	
		//근로계약 수정 버튼 누를시
	$('.basicdeletebtnShow').on("click", function() {
		$('#offcanvasBothLabel').text("근로계약 수정");
		$('#autoBtn').hide();
		$('#lbcntdeleteBtn').show();	//삭제버튼 보여주기
		$('#lbcntInsertBtn').hide();	//신규 작성 버튼 숨기기
		$('#lbcntUpdateBtn').show();	//기존 정보 수정 버튼 보여주기
	});

	// 임금계약 추가 버튼 누를 시
	$('.basicdeletbtnHide2').on("click", function() {
		$('#offcanvasBothLabel2').text("임금계약 추가");
		$('#autoBtn2').show();
		$('#wgcntdeleteBtn').hide();	//삭제버튼 없애기
		$('#wgcntInsertBtn').show();	//신규 작성 버튼 보여주가
		$('#wgcntUpdateBtn').hide();	//기존 정보 수정 버튼 숨기기
		$('option[id="bsiccOption"]').prop("selected",true);	//'소득유형선택' 항목이 기본 선택항목으로
	});

	// 임금계약 수정 버튼 누를 시
	$('.basicdeletebtnShow2').on("click", function() {
		$('#offcanvasBothLabel2').text("임금계약 수정");
		$('#autoBtn2').hide();
		$('#wgcntdeleteBtn').show();
		$('#wgcntInsertBtn').hide();	//신규 작성 버튼 숨기기
		$('#wgcntUpdateBtn').show();	//기존 정보 수정 버튼 보여주기
	});
	
/* error빨강, warning노랑, succeess초록, info파랑 */
// 		toastr.success('인사정보를 수정하였습니다');
	//toast 알림창 옵션 설정
	
	toastr.options = {
	  "closeButton": false,
	  "debug": false,
	  "newestOnTop": false,
	  "progressBar": false,
	  "positionClass": "toast-top-center",		// 위치설정 : 중앙 가운데
	  "preventDuplicates": false,
	  "onclick": null,
	  "showDuration": "100",					//나타나는 시간 : 100ms
	  "hideDuration": "1000",					//사라지는 시간 : 1000ms
	  "timeOut": "1000",						//유지시간 : 1000ms
	  "extendedTimeOut": "1000",
	  "showEasing": "swing",
	  "hideEasing": "linear",
	  "showMethod": "fadeIn",
	  "hideMethod": "fadeOut"
	};
	
	//새로고침 기능
	function refreshNoteList() {
		location.reload();
	};

	//근로/임금계약 신규추가 누를 때 빈 칸으로 설정
	window.onload = function() {
		let lbAddClick = document.getElementById("lbAdd");	
		let wgAddClick = document.getElementById("wgAdd");	

		lbAddClick.onclick = function(){
			console.log("살려주세요")
			today = new Date();
			today = today.toISOString().slice(0, 10);
			
			//근로계약기간 새로 작성시 시작일은 오늘, 종료일은 빈 칸으로 보여주기
			document.getElementById("lbcntSttdate").value = today;
			document.getElementById("lbcntEnddate").value = "";
			
			//수습기간 빈칸으로 보여주기
			document.getElementById("prSttdate").value ="";
			document.getElementById("prEnddate").value ="";
			
			//메모 빈칸으로 보여주기
			document.getElementById("cngMm").value = "";
		};

		wgAddClick.onclick = function(){
			console.log("살려주세요")
			today = new Date();
			today = today.toISOString().slice(0, 10);
			//임금계약기간 새로 작성시 시작일은 오늘, 종료일은 빈 칸으로 보여주기
			document.getElementById("wgcntSttdate").value = today;
			document.getElementById("wgcntEnddate").value = "";
			document.getElementById("wgcntAmt").value="";	//계약금액
			document.getElementById("wgcntFex").value="";	//식비
			document.getElementById("wgcngMm").value = "";	//메모
		};
	};
	
//--------------------------------[근로계약기능]---------------------------------------------------------------------
	
	// 인사정보 변경 폼의 기존정보 가져오기
	$('#lbEdit').on("click", function() {
		let empNo = ${empVo.empNo};
		console.log("lbEditForm");
		
		$.ajax({
			url : CONTEXTPATH+"/mypage/contractInfoRetrieve.do", 
			data : { empNo : empNo },
			dataType : "json",
			success : function(resp) { 
				console.log(resp);
				$("#lbcntSttdate").val(resp.blctSdate);
				$("#lbcntEnddate").val(resp.blctEdate);
				$('select[id="lbCase"]').val(resp.blCase).attr("selected",true);
				$("#prSttdate").val(resp.prSdate);
				$("#prEnddate").val(resp.prEdate);
				$("#cngMm").val(resp.cngMm);
				
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	});

	
	//근로계약 추가시 사용하는 script
	$("#lbcntInsertBtn").on("click", function() {
		//입력값 변수에 담아주기
		let cntCngr = ${empVo.empNo};
		let cntWriter = ${authEmp.empNo};
		let blctSdate = $("#lbcntSttdate").val();
		let blctEdate = $("#lbcntEnddate").val();
		let blCase = $("#lbCase").val();
		let prSdate = $("#prSttdate").val();
		let prEdate = $("#prEnddate").val();
		let cngMm = $("#cngMm").val().replace(/(?:\r\n|\r|\n)/g, '<br/>');	//textarea의 엔터를 db에도 엔터로 저장위해 <br>로 변환
		
		let lbcseprint = $("#lbcseprint");
		let lbCntperoidprint = $("#lbCntperoidprint");
		let lbPrperiodprint = $("#lbPrperiodprint");
		
		
		console.log("cntCngr" + cntCngr);
		console.log("cntWriter" + cntWriter);
		console.log("blctSdate" + blctSdate);
		console.log("blctEdate" + blctEdate);
		console.log("blCase" + blCase);
		console.log("prSdate" + prSdate);
		console.log("prEdate" + prEdate);
		console.log("cngMm" + cngMm);

		$.ajax({
			url : "LaborCntInfoInsert.do",
			data : {
				cntCngr : cntCngr,
				cntWriter : cntWriter,
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
					toastr.success('인사정보를 등록하였습니다');
					
					//입력한 내용으로 화면 바꿔주기
					lbcseprint.html(blCase);
					lbCntperoidprint.html(blctSdate +" ~ "+ blctEdate);
					lbPrperiodprint.html(prSdate +" ~ "+ prEdate);
							
				}else{
					toastr.error('인사정보 등록에 실패하였습니다');	
				}
			},
			error : function(errorResp) {
				console.log(errorResp.status);
				toastr.error('인사정보 등록에 실패하였습니다');
			}
		});
		//저장하기 하면 다시 입력창을 닫아준다
		$('.offcanvas').offcanvas('hide');
	});
	
	
	//근로계약 수정시 사용하는 script
	$("#lbcntUpdateBtn").on("click", function() {
		let cnthxNo = $(this).data('cnthxno');
		let cntEditor = ${authEmp.empNo};
		let blctSdate = $("#lbcntSttdate").val();
		let blctEdate = $("#lbcntEnddate").val();
		let blCase = $("#lbCase").val();
		let prSdate = $("#prSttdate").val();
		let prEdate = $("#prEnddate").val();
		let cngMm = $("#cngMm").val().replace(/(?:\r\n|\r|\n)/g, '<br/>');

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
					
					//입력한 내용으로 화면 바꿔주기
					lbcseprint.html(blCase);
					lbCntperoidprint.html(blctSdate +" ~ "+ blctEdate);
					lbPrperiodprint.html(prSdate +" ~ "+ prEdate);
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
		$('.offcanvas').offcanvas('hide');
	});
	
	
	//근로계약 삭제시 사용하는 script
	$("#lbcntdeleteBtn").on("click", function(){
		let cnthxNo = $(this).data("cnthxno");
		console.log("cnthxNo "+cnthxNo);
		
		$.ajax({
			url : "LaborCntInfoDelete.do",
			data : {
				cnthxNo : cnthxNo
			},
			type : "POST",
			success : function(resp) {
				console.log(resp);
				
				if(resp == "SUCCESS"){
					toastr.success('인사정보를 성공적으로 삭제하였습니다');
					
						let empNo = ${empVo.empNo};
						console.log("하라랼ㄹㄹ랄ㄹ랴할");
						
						$.ajax({
							url : CONTEXTPATH+"/mypage/contractInfoRetrieve.do", 
							data : { empNo : empNo },
							dataType : "json",
							success : function(resp) { 
								console.log(resp);
								$("#lbcseprint").text(resp.blCase);
								$("#lbCntperoidprint").text(resp.blctSdate + " ~ " + resp.blctEdate);
								$("#lbPrperiodprint").text(resp.prSdate + " ~ " + resp.prEdate);
								$("#lbcntdeleteBtn").data("cnthxno", resp.cnthxNo);
								
								console.log("ㅇ아암ㅇㄹㄴㄴㄹ꺄가아아아ㅏ")
							},
							error : function(errorResp) {
								console.log(errorResp.status);
								
								$("#lbcseprint").text("미설정");
								$("#lbCntperoidprint").text(" ~ ");
								$("#lbcntdeleteBtn").data("cnthxno", resp.cnthxNo);
								
							}
						});
				}else{
					toastr.error('인사정보 삭제에 실패하였습니다');	
				}
			},
			error : function(errorResp) {
				console.log(errorResp.status);
				toastr.error('인사정보 삭제에 실패하였습니다');
			}
		});
		//저장하기 하면 다시 입력창을 닫아준다
		$('.offcanvas').offcanvas('hide');
	});
	
	
	
//--------------------------------[임금계약기능]---------------------------------------------------------------------
	
	// 임금계약 변경 폼의 기존정보 가져오기
	$('#wgEdit').on("click", function() {
		let empNo = ${empVo.empNo};
		console.log("wageEditform");
		
		$.ajax({
			url : CONTEXTPATH+"/mypage/wgcontractInfoRetrieve.do", 
			data : { empNo : empNo },
			dataType : "json",
			success : function(resp) { 
				console.log(resp);
				$('select[name="incomeCaseList"]').val(resp.bincClf).attr("selected",true);
				$("#wgcntSttdate").val(resp.bwctSdate);
				$("#wgcntEnddate").val(resp.bwctEdate);
				$("#wgicmclf").val(resp.bincClf);
				$("#wgcntAmt").val(resp.bcntAmt);
				$("#wgcntFex").val(resp.bfex);
				$("#wgcngMm").val(resp.cngMm);
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	});
	
	
	//임금계약 추가시 사용하는 script
	$("#wgcntInsertBtn").on("click", function() {
		//입력값 변수에 담아주기
		let cntCngr = ${empVo.empNo};
		let cntWriter = ${authEmp.empNo};
		let bwctSdate = $("#wgcntSttdate").val();
		let bwctEdate = $("#wgcntEnddate").val();
		let bincClf = $("#wgicmclf").val();
		let bcntAmt = $("#wgcntAmt").val();
		let bfex = $("#wgcntFex").val();
		let cngMm = $("#wgcngMm").val().replace(/(?:\r\n|\r|\n)/g, '<br/>');	//textarea의 엔터를 db에도 엔터로 저장위해 <br>로 변환
		
		let wgicmclfprint = $("#wgicmclfprint");
		let wgPeriodprint = $("#wgPeriodprint");
		let wgAmtprint = $("#wgAmtprint");
		let wgfexprint = $("#wgfexprint");
		
		console.log("cntCngr" + cntCngr);
		console.log("cntWriter" + cntWriter);
		console.log("bwctSdate" + bwctSdate);
		console.log("bwctEdate" + bwctEdate);
		console.log("bincClf" + bincClf);
		console.log("bcntAmt" + bcntAmt);
		console.log("bfex" + bfex);
		console.log("cngMm" + cngMm);

		$.ajax({
			url : "WageCntInfoInsert.do",
			data : {
				cntCngr : cntCngr,
				cntWriter : cntWriter,
				bwctSdate :bwctSdate,
				bwctEdate : bwctEdate,
				bincClf : bincClf,
				bcntAmt : bcntAmt,
				bfex : bfex,
				cngMm : cngMm
			},
			type : "POST",
			success : function(resp) {
				console.log(resp);
				
				if(resp == "SUCCESS"){
					toastr.success('인사정보를 등록하였습니다');
					
					//입력한 내용으로 화면 바꿔주기
					wgicmclfprint.html(bincClf);
					wgPeriodprint.html(bwctSdate + " ~ " + bwctEdate);
					wgAmtprint.html(bcntAmt);
					wgfexprint.html(bfex);
				}else{
					toastr.error('인사정보 등록에 실패하였습니다');	
				}
			},
			error : function(errorResp) {
				console.log(errorResp.status);
				toastr.error('인사정보 등록에 실패하였습니다');
			}
		});
		//저장하기 하면 다시 입력창을 닫아준다
		$('.offcanvas').offcanvas('hide');
	});
	
	
	//임금계약 수정시 사용하는 script
	$("#wgcntUpdateBtn").on("click", function() {
		let cnthxNo = $(this).data("cnthxno");
		let cntEditor = ${authEmp.empNo};
		let bwctSdate = $("#wgcntSttdate").val();
		let bwctEdate = $("#wgcntEnddate").val();
		let bincClf = $("#wgicmclf").val();
		let bcntAmt = $("#wgcntAmt").val();
		let bfex = $("#wgcntFex").val();
		let cngMm = $("#wgcngMm").val().replace(/(?:\r\n|\r|\n)/g, '<br/>');
		
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
		$('.offcanvas').offcanvas('hide');
	});
	
	
	//임금계약 삭제시 사용하는 script
	$("#wgcntdeleteBtn").on("click", function() {
		let cnthxNo = $(this).data("cnthxno");
		console.log("cnthxNo "+cnthxNo);
		
		$.ajax({
			url : "LaborCntInfoDelete.do",
			data : {
				cnthxNo : cnthxNo
			},
			type : "POST",
			success : function(resp) {
				console.log(resp);
				
				if(resp == "SUCCESS"){
					toastr.success('인사정보를 성공적으로 삭제하였습니다');
					
						let empNo = ${empVo.empNo};
						console.log("홓ㄹㄹ룧효롷ㄹ롤롤로ㅗ로홀홓");
						
						$.ajax({
							url : CONTEXTPATH+"/mypage/wgcontractInfoRetrieve.do", 
							data : { empNo : empNo },
							dataType : "json",
							success : function(resp) { 
								console.log(resp);
								
								$("#wgicmclfprint").text(resp.bincClf);
								$("#wgPeriodprint").text(resp.bwctSdate + " ~ " + resp.bwctEdate);
								$("#wgAmtprint").text(resp.bcntAmt);
								$("#wgfexprint").text(resp.wgfexprint);
								
								$("#wgcntdeleteBtn").data("cnthxno", resp.cnthxNo);
								
								console.log("꺄아라랄ㄹㄹㄹ아나핳ㄹㄹㄹ라하핳")
							},
							error : function(errorResp) {
								console.log(errorResp.status);
								
								$("#wgicmclfprint").text("미설정");
								$("#wgPeriodprint").text(" ~ ");
								$("#wgAmtprint").text("미설정");
								$("#wgfexprint").text("미설정");
								
								$("#wgcntdeleteBtn").data("cnthxno", resp.cnthxNo);
							}
						});
				}else{
					toastr.error('인사정보 삭제에 실패하였습니다');	
				}
			},
			error : function(errorResp) {
				console.log(errorResp.status);
				toastr.error('인사정보 삭제에 실패하였습니다');
			}
		});
		//저장하기 하면 다시 입력창을 닫아준다
		$('.offcanvas').offcanvas('hide');
	});
	
	
</script>