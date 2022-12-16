<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html
  lang="en"
  class="light-style customizer-hide"
  dir="ltr"
  data-theme="theme-default"
  data-assets-path="${cPath}/resources/assets/"
  data-template="vertical-menu-template-free"
>
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
    />

    <title>NABIS</title>

    <meta name="description" content="" />
	
	<link href="${cPath }/resources/css/jhy.css" rel="stylesheet" type="text/css" />
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.6.1.min.js"></script>
	
	<!-- ajax csrf confiuration -->
	<script type="text/javascript">
		let token = $("meta[name='_csrf']").attr("content");
		let header = $("meta[name='_csrf_header']").attr("content");
		function csrfSafeMethod(method){
			return (/^(GET|HEAD|OPTIONS)$/.test(method));
		}
		$.ajaxSetup({
			beforeSend : function(xhr, settings){
				if (!csrfSafeMethod(settings.type) && !this.crossDomain){
					xhr.setRequestHeader(header, token);
				}
			}
		});
		function getContextPath() {
		    let hostIndex = location.href.indexOf( location.host ) + location.host.length;
		    return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
		};
		const CONTEXTPATH = getContextPath(); 
	</script>
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
      rel="stylesheet"
    />

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="${cPath}/resources/assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="${cPath}/resources/assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="${cPath}/resources/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="${cPath}/resources/assets/css/demo.css" />
    
    <!-- Vendors CSS -->
    <link rel="stylesheet" href="${cPath}/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

	<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
	<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <!-- Page CSS -->
    <!-- Page -->
    <link rel="stylesheet" href="${cPath}/resources/assets/vendor/css/pages/page-auth.css" />
    <!-- Helpers -->
    <script src="${cPath}/resources/assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="${cPath}/resources/assets/js/config.js"></script>
	<c:if test="${not empty message }">
		<script type="text/javascript">
			alert("${message}");
		</script>
	</c:if>
</head>
<body>

<!-- Content -->
<form:form id="empform" modelAttribute="emp" method="post" >
     		<div class="empFormheader m-4">
     			<div class="">
	     			<button type="button" class="btn btn-outline-secondary" onclick="location.href='${cPath}/emp/empList.do'" >
	                    <span class="tf-icons bx bx-bell"></span>&nbsp; 나가기
	                </button>
                </div>
                
				<div class="empaddbutton">
					<button id="autoBtn" type="button" class="btn btn-info" onclick="dataAutoInput();">자동 입력</button>
					<button id="subBtn" type="button" class="btn btn-primary">
	                    <span class="tf-icons bx bx-pie-chart-alt"></span>&nbsp; 입력 완료
	                </button>
				</div>                
     		</div>
		<div class="container ">
			<div class="accordion mt-3 " id="accordionExample" style="margin: 23%;">
				<div class="card accordion-item active">
					<h2 class="accordion-header" id="headingOne">
						<button type="button" class="accordion-button"
							data-bs-toggle="collapse" data-bs-target="#accordionOne"
							aria-expanded="true" aria-controls="accordionOne">
							기본정보 입력</button>
					</h2>

					<div id="accordionOne" class="accordion-collapse collapse show">
						<div class="accordion-body">

							<!-- 사번 -->
							<div class="mb-3">
								<label class="form-label">사번</label>
								<form:input path="empNo" class="form-control" required="true"
									placeholder="사번 입력 ex)202003001" />
								<form:errors path="empNo" element="span" cssClass="error" />
							</div>

							<!-- 비밀번호 -->
							<div class="mb-3">
								<label class="form-label">비밀번호</label> 
								<input type="password" name="empPass" class="form-control" required="true"
									placeholder="비밀번호 입력" />
								<form:errors path="empPass" element="span" cssClass="error" />
							</div>

							<!-- 이름 -->
							<div class="mb-3">
								<label class="form-label">이름</label>
								<form:input path="empNm" class="form-control" required="true"
									placeholder="이름" />
								<form:errors path="empNm" element="span" cssClass="error" />
							</div>

							<!-- 주민번호1 -->
							<div class="mb-3">
								<label class="form-label">주민번호 앞자리</label>
								<form:input path="regno1" class="form-control" required="true"
									placeholder="주민번호 앞자리" />
								<form:errors path="regno1" element="span" cssClass="error" />
							</div>
							<!-- 주민번호2 -->
							<div class="mb-3">
								<label class="form-label">주민번호 뒷자리</label> 
								<input type="password" name="regno2" class="form-control"
									required="true" placeholder="주민번호 뒷자리" />
								<form:errors path="regno2" element="span" cssClass="error" />
							</div>

							<!--  이메일 -->
							<div class="mb-3">
								<label class="form-label">이메일 address</label>
								<form:input path="empMail" class="form-control" required="true"
									placeholder="name@example.com" />
								<form:errors path="empMail" element="span" cssClass="error" />
							</div>

							<!-- 입사일  -->
							<div class="mb-3 row">
								<label class="col-md-2 col-form-label">입사일</label>
								<div class="">
									<form:input type="date" path="entDate" class="form-control"
										required="true" value="2022-12-15"/>
									<form:errors path="entDate" element="span" cssClass="error" />
								</div>
							</div>

							<!-- 입사 유형 -->
							<div class="mb-3">
								<label class="form-label">입사 유형 </label>
								<form:select path="entCase" class="form-select" required="true">
									<form:option value="신입" label="신입" />
									<form:option value="경력" label="경력" />
								</form:select>
							</div>


						</div>
					</div>
				</div>
				<div class="card accordion-item">
					<h2 class="accordion-header" id="headingTwo">
						<button type="button" class="accordion-button collapsed"
							data-bs-toggle="collapse" data-bs-target="#accordionTwo"
							aria-expanded="false" aria-controls="accordionTwo">
							인사정보 입력</button>
					</h2>
					<div id="accordionTwo" class="accordion-collapse collapse"
						aria-labelledby="headingTwo">
						<div class="accordion-body">
							<!-- 직무 -->
							<div class="mb-3">
								<label class="form-label">직무</label><br> 
								<select
									name="jcodeList"
									class="js-multiple form-control formTwo w-px-500"
									multiple="multiple">
									<c:forEach items="${jobList}" var="job">
										<option value="${job.jcode}">${job.jnm}</option>
									</c:forEach>
								</select>
							</div>

							<!-- 직위 -->
							<div class="mb-3">
								<label class="form-label">직위</label>
								<form:select path="ptnCode" class="form-select formTwo">
									<option value>직위선택</option>
									<c:forEach items="${pstnList}" var="pstn">
										<form:option value="${pstn.ptnCode}" label="${pstn.ptnNm}" />
									</c:forEach>
								</form:select>
								<form:errors path="ptnCode" element="span" cssClass="error" />
							</div>


							<!-- 직급 -->
							<div class="mb-3">
								<label class="form-label">직급</label>
								<form:select path="grdCode" class="form-select formTwo">
									<option value>직급선택</option>
									<c:forEach items="${grdList}" var="grd">
										<form:option value="${grd.grdCode}" label="${grd.grdNm}" />
									</c:forEach>
								</form:select>
								<form:errors path="grdCode" element="span" cssClass="error" />
							</div>

							<!-- 조직/직책 -->
							<div class="mb-2">
								<div class="mb-4">
								
									<label class="form-label formTwo">조직 / 직책</label>
									<div class="mb-2 mainDeptCheck">
										<div class="mb-4">

											<div class="d-flex">
												<div class="form-check pt-2">
													<input name="deptList[].mainck" class="form-check-input formTwo mainckList" type="radio" value="Y" checked />
												</div>

												<div class="input-group">
													<select name="deptList[].dcode" class="form-select formTwo dcodeList">
														<option value>조직</option>
														<c:forEach items="${deptList}" var="dept">
															<option value="${dept.dcode}" label="${dept.dnm}" />
														</c:forEach>
													</select> 
													<select name="deptList[].dtcode" class="form-select formTwo dtcodeList">
														<option value>직책(선택)</option>
														<c:forEach items="${dutyList}" var="duty">
															<option value="${duty.dtcode}" label="${duty.dtnm}" />
														</c:forEach>
													</select> 


													<div class="input-group-text">
														<div class="form-check mt-0">
															<input name="deptList[].dno" class="form-check-input formTwo dnoList" type="checkbox" value="1"/> 
															<label class="form-check-label"> 조직장 </label>
														</div>
													</div>

												</div>
												<button type="button" class="btn btn-icon btn-outline-danger ms-2" name="deptRemoveBtn">
													<i class='bx bx-x'></i>
												</button>
											</div>
										</div>
									</div>

									<!-- 조직 추가 버튼 -->
									<button type="button" class="btn btn-outline-primary mb-4" id="deptAddBtn">
										<span class="bx-plus bx bx-pie-chart-alt"></span>&nbsp; 조직 추가
									</button>
									
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="card accordion-item">
					<h2 class="accordion-header" id="headingThree">
						<button type="button" class="accordion-button collapsed"
							data-bs-toggle="collapse" data-bs-target="#accordionThree"
							aria-expanded="false" aria-controls="accordionThree">
							근로계약 정보 입력</button>
					</h2>
					<div id="accordionThree" class="accordion-collapse collapse"
						aria-labelledby="headingThree">
						<div class="accordion-body">


							<!-- 근로 계약 시작일 -->
							<div class="mb-3 row">
								<label class="col-md-2 col-form-label">근로 계약 시작일(적용일)</label>
								<div class="col-md-10">
									<input name="cnthxList[0].blctSdate" class="form-control formThree" type="date"
										value="2022-12-15" />
								</div>
							</div>



							<!-- 근로 계약 종료일 -->
							<div class="mb-3 row">
								<label class="col-md-2 col-form-label">근로 계약 종료일</label>
								<div class="col-md-10">
									<input name="cnthxList[0].blctEdate" class="form-control formThree" type="date"
										value="2023-12-15" />
								</div>
							</div>

							<!-- 근로 유형  -->
							<div class="mb-3">
								<label class="form-label">근로 유형</label> 
								<select name="cnthxList[0].blCase" class="form-select formThree">
									<option value="">근로유형</option>	
										<c:forEach items="${LaborCaseList}" var="lbcase">
											<option value="${lbcase.codeNm}">${lbcase.codeNm}</option>
										</c:forEach>
								</select>
							</div>


							<!-- 수습 정보  -->
							<div class="mb-3 row">
								<label class="col-md-2 col-form-label">수습정보</label>
								<div class="col-md-10">
									<input name="cnthxList[0].prSdate" class="form-control formThree" type="date"
										value="수습 기간 시작일 선택" placeholder="" /> 
										
									<input name="cnthxList[0].prEdate" class="form-control formThree" type="date"
										value="수습 기간 종료일 선택" placeholder="" />
										 
								</div>
							</div>




						</div>
					</div>
				</div>
				<div class="card accordion-item">
					<h2 class="accordion-header" id="headingFour">
						<button type="button" class="accordion-button collapsed"
							data-bs-toggle="collapse" data-bs-target="#accordionFour"
							aria-expanded="false" aria-controls="accordionFour">
							임금계약 정보 입력
						</button>
					</h2>
					<div id="accordionFour" class="accordion-collapse collapse"
						aria-labelledby="headingFour">
						<div class="accordion-body">


							<!-- 임금 계약 시작일 -->
							<div class="mb-3 row">
								<label class="col-md-2 col-form-label">임금 계약 시작일 (적용일)</label>
								<div class="col-md-10">
									<input name="cnthxList[1].bwctSdate" class="form-control formFour" type="date" value="2022-12-15" />
								</div>
							</div>



							<!-- 임금 계약 종료일 -->
							<div class="mb-3 row">
								<label class="col-md-2 col-form-label">임금 계약 종료일</label>
								<div class="col-md-10">
									<input name="cnthxList[1].bwctEdate" class="form-control formFour" type="date" value="2023-12-15" />
								</div>
							</div>


							<div class="input-group">
								<label class="col-md-2 col-form-label">계약금액</label> 
								<input type="text" name="cnthxList[1].bcntAmt" class="form-control formFour" placeholder="계약금액 입력" />
								<span class="input-group-text" >원</span>
							</div>


							<!-- 소득구분 -->
							<div class="mb-3">
								<label class="form-label">소득구분</label> 
								<select name="cnthxList[1].bincClf"class="form-select formFour">
									<option value="">구분선택</option>	
									<c:forEach items="${incomeCaseList}" var="icCase">
										<option value="${icCase.codeNm}">${icCase.codeNm}</option>
									</c:forEach>
								</select>
							</div>





						</div>
					</div>
				</div>
			</div>
		</div>
	</form:form>

    
    <!-- / Content -->
    
	<script type="text/javascript" defer="defer">	
		function dataAutoInput() {
			empform.find('[name="empNo"]').val('202205003');
			empform.find('[name="empPass"]').val('1234');
			empform.find('[name="empNm"]').val('이주원');
			empform.find('[name="regno1"]').val('931017');
			empform.find('[name="regno2"]').val('1526544');
			empform.find('[name="empMail"]').val('result500@gmail.com');
		};
		
		$(document).ready(function() {
		    $('.js-multiple').select2();
		});
		
		let accordionTwo = document.getElementById("accordionTwo");
		let accordionThree = document.getElementById("accordionThree");
		let accordionFour = document.getElementById("accordionFour");
		
		$(".formTwo").attr("disabled",true); 
		$(".formThree").attr("disabled",true);
		$(".formFour").attr("disabled",true); 
		
		accordionTwo.addEventListener("show.bs.collapse", function () {
		  $(".formTwo").removeAttr("disabled");
		});
		accordionTwo.addEventListener("hide.bs.collapse", function () {
		  $(".formTwo").attr("disabled",true); 
		});

		accordionThree.addEventListener("show.bs.collapse", function () {
		  $(".formThree").removeAttr("disabled");
		});
		accordionThree.addEventListener("hide.bs.collapse", function () {
		  $(".formThree").attr("disabled",true); 
		});

		accordionFour.addEventListener("show.bs.collapse", function () {
		  $(".formFour").removeAttr("disabled");
		});
		accordionFour.addEventListener("hide.bs.collapse", function () {
		  $(".formFour").attr("disabled",true); 
		});
		
		$('#deptAddBtn').on("click",function(){
			
			var deptform = 	'	<div class="  mb-2 mainDeptCheck">' 
			 	    		+'<div class=" mb-4 " >'
							+	' <div class="d-flex " >'
				    		+'	<div class="form-check pt-2">      '
							+'	    <input                         '
							+'	      name="deptList[].mainck"       '
							+'	      class="form-check-input formTwo mainckList"     '
							+'	      type="radio"                 '
							+'	      value="Y"                     '
							+'	       /> </div>					'
							+'	<div class="input-group">		   '
							+'	<select name="deptList[].dcode" class="form-select formTwo dcodeList"> '
						    +'      <option value>조직</option>                                               '
						    <c:forEach items="${deptList}" var="dept">
						    +'      <option value="${dept.dcode}">${dept.dnm}</option>                                           '
						    </c:forEach>
						    +'    </select>			                                                                              '
							+'	<select name="deptList[].dtcode" class="form-select formTwo dtcodeList">                                              '
							+'	<option value>직책(선택)</option>                                                              '
							<c:forEach items="${dutyList}" var="duty">
							+'	<option value="${duty.dtcode}">${duty.dtnm}</option>                                                                    '
							</c:forEach>
							+'	</select>								                                                          '
							+'	<div class="input-group-text">                                                                    '
							+'	<div class="form-check mt-0">                                                                     '
							+'	<input name="deptList[].dno" class="form-check-input formTwo dnoList" type="checkbox" value="1"/>                    '
							+'	<label class="form-check-label"> 조직장 </label>                              '
							+'	</div>                                                                                            '
							+'	</div>      				                                                                      '
							+'	</div>                                                                                            '
							+' <button type="button" class="btn btn-icon btn-outline-danger ms-2 " name="deptRemoveBtn" ><i class="bx bx-x"></i></button> '
							+'	</div>   '                                                                                       
							+' </div>' 
							+'</div>';
							
				
					
							$('#deptAddBtn').before(deptform);
							$('#hideBtn').show();
							var length = $(".mainDeptCheck").length;
							if (length >= 2) {
								$('button[name=deptRemoveBtn]').show();
							}
					
			});
			// 조직 / 직책  지우기 버튼 
			$('body').on("click",'[name=deptRemoveBtn]',function(event){
			 	$(this).closest(".mainDeptCheck").remove();
				var length = $(".mainDeptCheck").length;
				if (length == 1) {
					$('button[name=deptRemoveBtn]').hide();
				}
			})
			
			let empform = $("#empform");
			$("#subBtn").on("click", function(event){
				
				$(".mainckList").each(function(i, elements) {
					$(elements).attr("name","deptList["+i+"].mainck");
				});
				$(".dcodeList").each(function(i, elements) {
					$(elements).attr("name","deptList["+i+"].dcode");
				});
				$(".dtcodeList").each(function(i, elements) {
					$(elements).attr("name","deptList["+i+"].dtcode");
				});
				$(".dnoList").each(function(i, elements) {
					$(elements).attr("name","deptList["+i+"].dno");
				});
				
				$(empform).submit();
			})
	</script>

    

    <!-- Core JS -->
    <script src="${cPath}/resources/assets/vendor/libs/popper/popper.js"></script>
    <script src="${cPath}/resources/assets/vendor/js/bootstrap.js"></script>
    <script src="${cPath}/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

    <script src="${cPath}/resources/assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->

    <!-- Main JS -->
    <script src="${cPath}/resources/assets/js/main.js"></script>

    <!-- Page JS -->

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
  </body>
</html>
