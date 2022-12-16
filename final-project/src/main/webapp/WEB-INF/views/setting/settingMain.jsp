<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css">

<!-- dropzone CDN -->
<!-- <script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css"/> -->

<style type="text/css">
 .companySet-btn{
 	margin-left: 250px;
 }
</style>

 <script type="text/javascript" defer="defer">
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = addr +extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_postcode").focus();
            }
        }).open();
    }
</script>

<div class="row p-3">
	<div class="col-4 h-px-250 p-3 border border-secondary border-top-0 border-start-0 ">
		<h5 class="fw-semibold"><i class="menu-icon tf-icons bx bx-buildings"></i>회사기본정보</h5>
		<span class="fw-semibold cursor-pointer text-primary" data-bs-toggle="offcanvas" data-bs-target="#companySet" id="companyFormBtn">회사  정보</span><br>
<!-- 		<span class="fw-semibold cursor-pointer text-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">회사  직인 설정</span><br> -->
<!-- 		<span class="fw-semibold cursor-pointer text-primary" data-bs-toggle="offcanvas" data-bs-target="#holidaySet">쉬는 날</span><br> -->
		
	</div>
	<div class="col-4 h-px-250 p-3 border border-secondary border-top-0 border-start-0">
		<h5 class="fw-semibold"><i class="menu-icon tf-icons bx bx-detail"></i>인사 정보 설정</h5>
		<span id="sp_dept" data-bs-toggle="offcanvas" class="fw-semibold cursor-pointer text-primary spDeptEvent">조직도 설정</span><br>
		<span id="sp_pstn" data-bs-toggle="offcanvas" class="fw-semibold cursor-pointer text-primary spPstnEvent">직위 설정</span><br>
		<span id="sp_duty" data-bs-toggle="offcanvas" class="fw-semibold cursor-pointer text-primary spDutyEvent">직책 설정</span><br>
		<span id="sp_job" data-bs-toggle="offcanvas" class="fw-semibold cursor-pointer text-primary spJobEvent">직무 설정</span><br>
		<span id="sp_grd" data-bs-toggle="offcanvas" class="fw-semibold cursor-pointer text-primary spGrdEvent">직급 설정</span><br>

	</div>
	<div class="col-4 h-px-250 p-3 border border-secondary border-top-0 border-start-0 border-end-0">
		<h5 class="fw-semibold"><i class="menu-icon tf-icons bx bx-briefcase-alt"></i>근무설정</h5>
		<a href="${cPath}/setting/workSet.do" class="fw-semibold">근무 설정</a>
	</div>
	
	<div class="col-4 h-px-250 p-3 border border-secondary border-top-0 border-start-0" id="vacationConfig">
		<h5 class="fw-semibold"><i class="menu-icon tf-icons bx bx-sun"></i>휴가설정</h5>
		<a href="${cPath }/vacationConfig/vacConfigView.do" class="fw-semibold">휴가 설정</a>
	</div>
	<div class="col-4 h-px-250 p-3 border border-secondary border-top-0 border-start-0 ">
		<h5 class="fw-semibold"><i class="menu-icon tf-icons bx bx-calculator"></i>급여정산 설정</h5>
		<a href="#" class="fw-semibold">원천징수의무자 정보</a>
	</div>
	<div class="col-4 h-px-250 p-3 border border-secondary border-top-0 border-bottom-0 border-start-0 border-end-0" id="securityConfig">
<!-- 		<h5 class="fw-semibold"><i class='bx bxs-lock-alt'></i> 보안설정</h5> -->
<!-- 		<span class="fw-semibold cursor-pointer text-primary" data-bs-toggle="offcanvas" data-bs-target="#accessAllowedSet">접근 허용 IP 설정</span><br> -->
<%-- 		<a href="${cPath}/setting/loginHistroy.do" class="fw-semibold">로그인 이력</a> --%>
	</div>

	<div class="col-4 h-px-250 p-3" >
<!-- 		<h5 class="fw-semibold"><i class='bx bxs-key'></i>권한설정</h5> -->
<!-- 		<a href="#" class="fw-semibold">권한 설정</a> -->
	</div>
	<div class="col-4 h-px-250 p-3">
	</div>
	<div class="col-4 h-px-250 p-3">
	</div>
</div>


<%-- 회사 정보 수정 --%>
<div id="companySet" class="offcanvas offcanvas-end w-px-500" tabindex="-1">
  <div class="offcanvas-header border-bottom border-secondary sticky-top">
    <h5 class="offcanvas-title fw-semibold">회사 정보 수정</h5>
    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
   <div class="offcanvas-body mx-0 flex-grow-0">

     <form:form id="companyForm">
   <div class="mb-3">
     <label class="form-label">회사명</label>
     <input type="text" class="form-control" name="comNm" placeholder="회사명" value=""/>
   </div>
   <div class="mb-3">
     <label class="form-label">대표자</label>
     <input type="text" class="form-control" name="comRep" placeholder="대상입력" value=""/>
   </div>
   <div class="mb-3">
     <label class="form-label">회사 전화번호</label>
     <input type="text" class="form-control" name="comTelno" placeholder="회사 전화번호" value=""/>
   </div>
   <div class="mb-3">
     <label for="flatpickr-date" class="form-label">설립일</label>
     <input type="date" class="form-control" name="estdDate" value="" placeholder="YYYY-MM-DD" id="flatpickr-date" />
   </div>
   <div class="mb-3">
     <label class="form-label">회사주소</label>
     <input type="text" class="form-control" name="comAddr" value="" id="sample6_postcode" onclick="sample6_execDaumPostcode()"/>
   </div>
   <div class="mb-3">
     <label class="form-label">사업자등록번호</label>
     <input type="text" class="form-control" name="comRegno" value=""/>
   </div>
   <div class="mb-3">
     <label class="form-label">법인등록번호</label>
     <input type="text" class="form-control" name="corRegno" value=""/>
   </div>
   <input type="hidden" value="" name="comCd">
     </form:form>
    <div class="companySet-btn">
       <button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas">취소</button>
      <button type="button" class="btn btn-success" id="updateCompanyBtn">저장하기</button>
   </div>
  </div>
</div>

  
<%-- 회사 정보 수정 --%>

<%-- 쉬는 날 설정 --%>
<div id="holidaySet" class="offcanvas offcanvas-end w-px-500" tabindex="-1">
  <div class="offcanvas-header border-bottom border-secondary sticky-top">
    <h5 class="offcanvas-title fw-semibold">쉬는 날 설정</h5>
    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body mx-0 flex-grow-0">
  	
	<div class="list-group">
		<div class="list-group-item list-group-item-action d-flex justify-content-between">
			<div class="input-group input-group-merge w-px-250">
		        <input type="text" class="form-control h-px-30" id="datepicker" style="text-align : center;"/>
		        <span class="input-group-text h-px-30"><i class="bx bx-chevron-down"></i></span>
		        <button type="button" class="btn btn-icon btn-outline-primary h-px-30 mx-2">
		             <span class="tf-icon bx bx-chevron-left"></span>
		        </button>
		        <button type="button" class="btn btn-icon btn-outline-primary h-px-30">
		             <span class="tf-icon bx bx-chevron-right"></span>
		        </button>
	    	</div>
	    	<button type="button" class="btn btn-sm btn-outline-success">+ 쉬는 날 추가</button>
		</div>
		
		<a href="javascript:void(0);" class="list-group-item list-group-item-action">
			<span class="fw-semibold">토요일</span>
			2022-11-05
			<button type="button" class="btn btn-icon btn-sm me-2 btn-outline-danger">
				<span class="tf-icons bx bxs-trash-alt"></span>
			</button>
		</a>
		<a href="javascript:void(0);" class="list-group-item list-group-item-action">
			<span class="fw-semibold">일요일</span>
			2022-11-06
			<button type="button" class="btn btn-icon btn-sm me-2 btn-outline-danger">
				<span class="tf-icons bx bxs-trash-alt"></span>
			</button>
		</a>
		<a href="javascript:void(0);" class="list-group-item list-group-item-action">
			<span class="fw-semibold">토요일</span>
			2022-11-12
			<button type="button" class="btn btn-icon btn-sm me-2 btn-outline-danger">
				<span class="tf-icons bx bxs-trash-alt"></span>
			</button>
		</a>
		<%-- 여기까지  --%>
	</div>
  	
  </div>
</div>
<%-- 쉬는 날 설정 --%>

<%-- 회사직인 Modal --%>
<div class="modal fade" id="exampleModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw-semibold" id="modalToggleLabel2">회사 직인 설정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          </button>
      </div>
      <div class="modal-body">
      	<div class="card">
        	<div class="card-body">
        	  <form action="/target" class="dropzone" id="myDropzone"></form>
        	
        	</div>
        </div>
      </div>
      <div class="modal-footer">
 		<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		<button type="button" class="btn btn-success">저장하기</button>
      </div>
    </div>
  </div>
</div>
<%-- /회사직인 Modal --%>

<%-- 접근 허용 IP 설정 --%>
<div id="accessAllowedSet" class="offcanvas offcanvas-end w-px-500" tabindex="-1">
  <div class="offcanvas-header border-bottom border-secondary sticky-top">
    <h5 class="offcanvas-title fw-semibold">접근 허용 IP 설정</h5>
    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body mx-0 flex-grow-0">
  <hr></hr>
	<div class="text-center">
	 <h6 class="fw-semibold">
	 	<span class="text-warning"><i class="bx bx-error"></i></span> 최고 관리자는 설정과 관계없이 모든 접근이 허용됩니다.
	 </h6>
	</div>
  <hr></hr>
    <div class="d-flex align-items-center">
     	<div>
      		<i class='bx bxs-server bx-border text-danger'></i>
      	</div>
      	
      	<div class="mx-2">
      		<span class="fw-semibold">특정 IP에서만 접근 허용</span><br>
      		허용된 IP에서만 NABIS를 사용할 수 있습니다.
      	</div>
		<div class="form-check form-switch ms-auto">
			<input class="form-check-input" type="checkbox" role="switch">
		</div>
	</div>
	<div class="list-group">
		<div class="list-group-item list-group-item-action d-flex justify-content-between">
			<div class="input-group input-group-merge">
		        <input type="text" class="form-control h-px-30"/>
		    	<button type="button" class="btn btn-sm btn-outline-success">+ 접근 허용 IP 추가</button>
	    	</div>
		</div>
		
		<a href="javascript:void(0);" class="list-group-item list-group-item-action">
			1.123.123.123
			<button type="button" class="btn btn-icon btn-sm me-2 btn-outline-danger">
				<span class="tf-icons bx bxs-trash-alt"></span>
			</button>
		</a>
		<a href="javascript:void(0);" class="list-group-item list-group-item-action">
			2.200.200.200
			<button type="button" class="btn btn-icon btn-sm me-2 btn-outline-danger">
				<span class="tf-icons bx bxs-trash-alt"></span>
			</button>
		</a>
		<a href="javascript:void(0);" class="list-group-item list-group-item-action">
			1.252.252.252
			<button type="button" class="btn btn-icon btn-sm me-2 btn-outline-danger">
				<span class="tf-icons bx bxs-trash-alt"></span>
			</button>
		</a>
	</div>
  </div>
    <div class="companySet-btn">
 		<button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas">취소</button>
		<button type="button" class="btn btn-success">저장하기</button>
	</div>
</div>
<%-- /접근 허용 IP 설정 --%>

<%-- 조직도 설정 --%>
<div id="set_originTree" style="display: none"></div>
<div id="set_offcanvasEnd" ></div>
<script id="set_wrapScript" type="text/javascript" defer="defer"></script>
<%-- /조직도 설정 --%>

<script>
/* 	Dropzone.autoDiscover = false; // deprecated 된 옵션. false로 해놓는걸 공식문서에서 명시
	const dropzone = new Dropzone(".dropzone", {
	    url: "https://httpbin.org/post", // 파일을 업로드할 서버 주소 url. 
	    method: "post", // 기본 post로 request 감. put으로도 할수있음
	    maxFiles: 1, // 업로드 파일수
	    maxFilesize: 25, // 최대업로드용량 : 100MB
	    paramName: 'image', // 서버에서 사용할 formdata 이름 설정 (default는 file)
	    uploadMultiple: false, // 다중업로드 기능
	    timeout: 300000
	}); */
	


	$('#companyFormBtn').on("click",function(){

	   console.log("들어옴")

		//let comTax = $('input[name=comTax]');
		let comCd = $('input[name=comCd]');
		let comNm = $('input[name=comNm]');
		let comRep = $('input[name=comRep]');
		let comTelno = $('input[name=comTelno]');
		let estdDate = $('input[name=estdDate]');
		let comAddr = $('input[name=comAddr]');
		let comRegno = $('input[name=comRegno]');
		let corRegno = $('input[name=corRegno]');
		
	   $.ajax({

	      url : "${cPath}/setting/selectCompany.do", //어디로
	      method : "GET", //어떻게
	      dataType : "json",
	      success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
	         console.log("resp",resp);
	         
	       //  comTax.val(resp.comTax);
	         comCd.val(resp.comCd);
	         comNm.val(resp.comNm);
	         comRep.val(resp.comRep);
	         comTelno.val(resp.comTelno);
	        /*  $( "#flatpickr-date" ).datepicker( "setDate",resp.estdDate);
	         flatpickrDate.flatpickr("setDate",resp.estdDate) */
	         estdDate.val(resp.estdDate);
	         comAddr.val(resp.comAddr);
	         comRegno.val(resp.comRegno);
	         corRegno.val(resp.corRegno);
	        
	         

	      },
	      error : function(errorResp) {

	         console.log(errorResp.status);
	      }

	   });
	   
	})



	$('#updateCompanyBtn').on("click",function(){
	   
		console.log("update ajax 들어옴");
	   let form = $('#companyForm');
	   
	   $.ajax({

	      url : "${cPath}/setting/updateCompany.do", //어디로
	      method : "POST", //어떻게
	      data : form.serialize(), 
	      dataType : "json",
	      success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
	         console.log("resp",resp);
	      
	         if(resp == 1){
	            toastr.success("수정이 완료되었습니다.");
	            $('#companySet').offcanvas("hide");
	         }else{
	            toastr.errors("수정이 실패되었습니다.");
	         }
	         
	      },
	      error : function(errorResp) {

	         console.log(errorResp.status);
	      }

	   });
	})
	
</script>

<script type="text/javascript" defer="defer">
$(document).ready(function() {
	jojicCall = function(param){
		console.log("param확인", param)
		$.ajax({
			url : "${cPath }/" + param + "/" + param + "List.do",
			method : "GET",
			dataType : "html",
			async: false,
			success : function(resp) {
			    $("#set_originTree").empty();
				$("#set_offcanvasEnd").empty();
			    $("#set_wrapScript").empty();

			    //원본 트리
		   	    var originTree = $(resp).find('#originTree');
		   	    $("#set_originTree").html(originTree);
		   	     
		   	    // 조직도 수정폼 div
		   	    var offcanvasEnd = $(resp).find('#offcanvasEnd');
		   	    $("#set_offcanvasEnd").html(offcanvasEnd);
		   	     
		   	    // 스크립트
		   	    var wrapScript = $(resp).find('#wrapScript');
		   	    $("#set_wrapScript").html(wrapScript);
					
				// offcanvas 열기 버튼
		        $("#sp_"+param).attr("data-bs-target", "#offcanvasEnd");
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	}

	$('.spDeptEvent').on('mouseenter', function() { jojicCall("dept") })
	$('.spPstnEvent').on('mouseenter', function() { jojicCall("pstn") })
	$('.spDutyEvent').on('mouseenter', function() { jojicCall("duty") })
	$('.spJobEvent').on('mouseenter', function() {  jojicCall("job") })
	$('.spGrdEvent').on('mouseenter', function() { jojicCall("grd") })

})

</script>
<!-- 다음API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- hgk -->
<script>
 	let empRole = "${requestScope['empRole']}";
 	if(empRole != 'admin') {
 		$('#vacationConfig').hide();
 		let lastConfig = $('#securityConfig');
 		lastConfig.removeClass('border-start-0');
 		lastConfig.removeClass('border-bottom-0');
 		lastConfig.addClass('border-end-0');
 	}
</script>
<!-- hgk -->