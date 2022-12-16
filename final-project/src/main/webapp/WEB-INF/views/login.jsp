<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>

<!-- =========================================================
* Sneat - Bootstrap 5 HTML Admin Template - Pro | v1.0.0
==============================================================

* Product Page: https://themeselection.com/products/sneat-bootstrap-html-admin-template/
* Created by: ThemeSelection
* License: You must have a valid license purchased in order to legally use the theme for your project.
* Copyright ThemeSelection (https://themeselection.com)

=========================================================
 -->
<!-- beautify ignore:start -->
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
    <meta name="description" content="" />
    
    <title>NABIS-Login</title>
    
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="${cPath}/resources/assets/img/favicon/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com"/>
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

    <!-- Page CSS -->
    <!-- Page -->
    <link rel="stylesheet" href="${cPath}/resources/assets/vendor/css/pages/page-auth.css" />
    <!-- FORM VALIDATE -->
    <link rel="stylesheet" href="${cPath }/resources/assets/vendor/libs/formvalidation/dist/css/formValidation.min.css" />
    <link rel="stylesheet" href="${cPath }/resources/assets/vendor/libs/formvalidation/dist/css/formValidation.css" />
    <!-- Helpers -->
    <script src="${cPath}/resources/assets/vendor/js/helpers.js"></script>
    
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="${cPath}/resources/assets/js/config.js"></script>

    <!-- FORM VALIDATE -->
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="${cPath }/resources/assets/vendor/libs/formvalidation/dist/js/FormValidation.min.js"></script>
	<script src="${cPath }/resources/assets/vendor/libs/formvalidation/dist/js/plugins/Bootstrap5.min.js"></script>
	<!-- AutoFocus plugin, automatically focus on the first invalid input  -->
	<script src="${cPath }/resources/assets/vendor/libs/formvalidation/dist/js/plugins/AutoFocus.min.js"></script>
	<link rel="stylesheet" href="${cPath }/resources/assets/vendor/libs/animate-css/animate.css" />
	<link rel="stylesheet" href="${cPath }/resources/assets/vendor/libs/sweetalert2/sweetalert2.css" />
	<script src="${cPath }/resources/assets/vendor/libs/sweetalert2/sweetalert2.js" ></script>
	<link rel="stylesheet" href="${cPath}/resources/css/jhy.css" />
	
  </head>

  <body class="" style="background-color: #EFEBFF">
    <!-- Content -->

    <div class="">
  		<img alt="" src="${cPath}/resources/images/login3.png"  class="loginBack" />
   
      <div class="authentication-wrapper authentication-basic container-p-y" >
     
    	<img alt="" src="${cPath}/resources/images/Profiling.gif" style="height: 33rem; margin-right:3rem; "/>	 
        <div class="">
          <!-- Register -->
          <div class="card loginCard ms-3">
			<img alt="" src="${cPath}/resources/images/nabi2.png" />	  
            <div class="card-body">
              <!-- Logo -->
              <div class="app-brand justify-content-center">
                <a href="index.html" class="app-brand-link gap-2">
                 
                 
                </a>
              </div>
              <!-- /Logo -->
           
              <form:form id="formAuthentication" class="mb-3" action="${cPath }/login/loginCheck.do" method="post">
                <div class="mb-3">
                  <label for="empNo" class="form-label fs-6">사번</label>
                  <input
                    type="text"
                    class="form-control"
                    id="empNo"
                    name="empNo"
                    placeholder="사번"
                    autofocus
                  />
                </div>
                <div class="mb-3 form-password-toggle">
                  <div class="d-flex justify-content-between">
                    <label class="form-label fs-6" for="empPass">비밀번호</label>
                    <a data-bs-toggle="modal" data-bs-target="#regFindModal">
                      <small>비밀번호를 잊으셨나요?</small>
                    </a>
                  </div>
                  <div class="input-group input-group-merge">
                    <input
                      type="password"
                      class="form-control"
                      id="empPass"
                      name="empPass"
                      placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;"
                      aria-describedby="password"
                    />
                    <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
                  </div>
                </div>
                <div class="mb-3">
                  <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="remember-me" />
                    <label class="form-check-label" for="remember-me"> 사번 기억하기 </label>
                  </div>
                </div>
                <div class="mb-3">
                  <button class="btn btn-primary d-grid w-100" type="submit">로그인하기</button>
                </div>
			  	<div class="d-flex">
	                <button id="adminBtn" type="button" class="btn btn-label-primary bg-transparent fw-bold">최고관리자</button>
	                <button id="manegerBtn" type="button" class="btn btn-label-primary bg-transparent fw-bold">중간관리자</button>
	                <button id="userBtn" type="button" class="btn btn-label-primary bg-transparent fw-bold">일반사원</button>
                </div> 
                
              </form:form>

            </div>
          </div>
          <!-- /Register -->
        </div>
     <%--    <img alt="" src="${cPath}/resources/images/wave.png" />	  --%>
    
      </div>
    </div>
    <!-- / Content -->
<form:form id="regFindForm" action="${cPath }/login/regCheck.do" method="GET" class="needs-validation" novalidate="ture">
	<div class="modal fade" id="regFindModal" tabindex="-1" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel1">비밀번호 찾기</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <div class="row">
	        
	          <div class="col mb-3">
	            <label class="form-label" for="empNoBasic">사번</label>
	            <input 
	            	type="text" 
	            	id="empNoBasic" 
	            	name="empNo" 
	            	class="form-control" 
	            	placeholder="사번"
	            	required
	            />
	            <div class="valid-feedback"></div>
				<div class="invalid-feedback"> 필수 입력 데이터 입니다. </div>
	          </div>
	          
	        </div>
	        <div class="row g-2">
	          <div class="col mb-0">
				<label class="form-label" for="regno1Basic">주민등록 번호</label>
	            <input 
	            	type="text" 
	            	id="regno1Basic" 
	            	class="form-control" 
	            	placeholder="주민번호 앞자리"
	            	required
	            />
				<div class="valid-feedback"></div>
				<div class="invalid-feedback"> 필수 입력 데이터 입니다. </div>
	          </div>
	          
	          <div class="col mb-0 form-password-toggle">
			    <label class="form-label" for="regno2Basic">&nbsp;</label>
			    <div class="input-group input-group-merge">
			      <input 
		      		type="password" 
		      		class="form-control" 
		      		id="regno2Basic" 
		      		placeholder="주민번호 뒷자리" 
		      		aria-describedby="basic-default-password2" 
		      		required
		      	  />
			      <span id="basic-default-password2" class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
			      <div class="valid-feedback"></div>
				  <div class="invalid-feedback"> 필수 입력 데이터 입니다. </div>
			    </div>
			  </div>

	        </div>
	      </div>
	      <div class="modal-footer">
	      	<input class="form-control mgsError " type="hidden" value="필수 데이터 누락" style="color:red" readonly>
	        <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="submit" class="btn btn-primary" id="btn_regFind">비밀번호 찾기</button>
	      </div>
	    </div>
	  </div>
	</div>
	</form:form>
	
<!-- fwReset Modal -->
	
	<div class="modal fade" id="pwResetModal" tabindex="-1" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	<form:form id="demoForm" method="POST" action="${cPath }/login/passwordReset.do">
		
		<div class="modal-header">
	        <h5 class="modal-title" >비밀번호 재설정</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		</div>
		
		<div class="modal-body">
			<input type="hidden" id="hiddenEmpNo" name="empNo"/>
			<input type="hidden" id="hiddenEmpPass" name="empPass"/>
			
				<div class="form-group row">
					<div class="col mb-3 form-password-toggle">
						<label class="form-label" >새 비밀번호</label>
						<input id="newPass" type="password" class="form-control" name="password" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;"/>
		            </div>
		        </div>
		
				<div class="form-group row">
					<div class="col mb-3 form-password-toggle">
						<label class="col-sm-3 col-form-label">새 비밀번호 확인</label>
						<input id="newPassConfirm" type="password" class="form-control" name="confirmPassword" />
					</div>
				</div>
		</div>
            
		<div class="modal-footer">
			<div class="form-group row">
			<div class="col mb-3 form-password-toggle">
		        <button type="button" class="btn btn-label-secondary" data-bs-dismiss="modal">취소</button>
				<button type="submit" class="btn btn-primary" id="btn_pwSave">변경 완료</button>
			</div>
			</div>
		</div>
		
	</form:form>
	    </div>
	  </div>
	</div>
	
	<!-- Alert -->
	

<script src="https://cdnjs.cloudflare.com/ajax/libs/es6-shim/0.35.3/es6-shim.min.js"></script>
<script src="${cPath}/resources/assets/vendor/libs/formvalidation/dist/js/FormValidation.min.js"></script>
<script src="${cPath}/resources/assets/vendor/libs/formvalidation/dist/js/plugins/Bootstrap.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function (e) {
        const form = document.getElementById('demoForm');
        const fv = FormValidation.formValidation(form, {
            fields: {
                password: {
                    validators: {
                        notEmpty: {
                            message: '필수 입력 데이터 입니다.',
                        },
                    },
                },
                confirmPassword: {
                    validators: {
                        identical: {
                            compare: function () {
                                return form.querySelector('[name="password"]').value;
                            },
                            message: '비밀번호가 일치하지 않습니다.',
                        },
                    },
                },
            },
            plugins: {
                trigger: new FormValidation.plugins.Trigger(),
                bootstrap: new FormValidation.plugins.Bootstrap(),
                submitButton: new FormValidation.plugins.SubmitButton(),
                icon: new FormValidation.plugins.Icon({
                    valid: 'fa fa-check',
                    invalid: 'fa fa-times',
                    validating: 'fa fa-refresh',
                }),
            },
        });

        // Revalidate the confirmation password when changing the password
        form.querySelector('[name="password"]').addEventListener('input', function () {
            fv.revalidateField('confirmPassword');
        });
    });
</script> 
<script type="text/javascript" defer>
//==============================================================================	
// 시연용 자동입력 버튼
$empNo = $('#empNo');
$empPass = $('#empPass');
$adminBtn = $('#adminBtn').on('click', function name() {
	$empNo.val('199701001');
	$empPass.val('1234');
});
$manegerBtn =$('#manegerBtn').on('click', function name() {
	$empNo.val('200103006');
	$empPass.val('1234');
});;
$userBtn = $('#userBtn').on('click', function name() {
	$empNo.val('202101001');
	$empPass.val('1234');
});;
//==============================================================================	
window.onload = function(){
	
	//==============================================================================	
		// Flat pickr
		const flatPickrEL = $(".flatpickr-validation");
		if (flatPickrEL.length) {
		  flatPickrEL.flatpickr({
		    allowInput: true,
		    monthSelectorType: "static"
		  });
		}

		// Fetch all the forms we want to apply custom Bootstrap validation styles to
		var bsValidationForms = document.querySelectorAll(".needs-validation");

		// Loop over them and prevent submission
		Array.prototype.slice.call(bsValidationForms).forEach(function(form) {
		  form.addEventListener(
		    "submit",
		    function(event) {
		      if (!form.checkValidity()) {
		        event.preventDefault();
		        event.stopPropagation();
		      } else {
//	 	        // Submit your form
//	 	        alert("Submitted!!!");
		      }

		      form.classList.add("was-validated");
		    },
		    false
		  );
		});	
		
	//==============================================================================

		var empNoBasic;
		$("#regFindForm").submit(function(){	//submit이 발생하면
			event.preventDefault();
			console.log("submit확인")
			
			 empNoBasic = $("#empNoBasic").val();
			let regno1Basic = $("#regno1Basic").val();
			let regno2Basic = $("#regno2Basic").val();
			
				$.ajax({
					url : "${cPath}/login/regCheck.do",
					method : "GET",
					data : {
						empNo:empNoBasic
		 				, regno1:regno1Basic
		 				, regno2:regno2Basic
					},
					dataType : "JSON",
					success : function(resp) {
						console.log("resp확인",resp);
						console.log("reg1Basic", regno1Basic );
						console.log("reg1", resp.regno1);
						console.log("reg2Basic", regno2Basic );
						console.log("reg2", resp.regno2);
						
						if(regno1Basic==resp.regno1 && regno2Basic==resp.regno2){
							console.log("reg같다");
							$('#regFindModal').modal('hide'); 
							$('#pwResetModal').modal('show');
							$('#hiddenEmpNo').val(empNo);
							
						}else{
							console.log("reg1다르다")
						    Swal.fire({
								  title: '사원 정보가 일치하지 않습니다',
// 								  showDenyButton: true,
								  confirmButtonText: '확인',
								}).then((result) => {
								  if (result.isConfirmed) {
									  
									  $('form').each(function() {
									      this.reset();
									      $(".mgsError").attr("type", "hidden");
									  });
									  
										console.log("확인>?")
								  }
								})	
						}
						
					},
					error : function(errorResp) {
						console.log(errorResp.status);
						console.log(errorResp.status);
						console.log("일치하지 않음. 필수 정보 누락")
					}
				});
			
			return false;						// 기본 submit의 동작을 막아 페이지 reload를 막는다
		});
		
		$("#demoForm").submit(function(){			
		})
		
		$("#btn_pwSave").on("click", function(){
			var $newPass = $("#newPass"); 
			var $newPassConfirm = $("#newPassConfirm");

			console.log("pass confirm 확인", $newPass.val(), $newPassConfirm.val() )
			$("#hiddenEmpNo").val(empNoBasic);
			$("#hiddenEmpPass").val($newPass.val() );
			
			if($newPass.val() == $newPassConfirm.val() ){
				    Swal.fire({
					  title: '비밀번호를 변경하시겠습니까?',
					  showDenyButton: true,
					  confirmButtonText: '확인',
					}).then((result) => {
					  if (result.isConfirmed) {
							$("#demoForm").submit()
					  }
					})	
			}
			
		})
		
	// modal 닫히면 모든 form 초기화
	$(".modal").on('hidden.bs.modal', function () {
		$('form').each(function() {
		      this.reset();
		      $(".mgsError").attr("type", "hidden");
		  });
	})




}
</script>
         
    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="${cPath}/resources/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="${cPath}/resources/assets/vendor/libs/popper/popper.js"></script>
    <script src="${cPath}/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="${cPath}/resources/assets/vendor/js/bootstrap.js"></script>
    <script src="${cPath}/resources/assets/vendor/js/menu.js"></script>
    
    <!-- Main JS -->
    <script src="${cPath}/resources/assets/js/main.js"></script>

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    
  </body>
  
</html>
