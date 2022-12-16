<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>	

<link rel="stylesheet" href="${cPath }/resources/css/ijs.css" />

<!-- LEFT NAV(STEP) START -->
<nav class="stepnav d-flex" style="float:left; font-size: 10px;">
	<section>
	<header id="stepHeader" class="mb-4 mt-2" data-prno="${proll.prNo }" data-prptno="${proll.prPtno }">
		${proll.ptNm }<br>
		지급일 ${proll.prGdate }<br>
		<span class="badge badge-green mt-1">근로소득</span>	
	</header>
	<ol class="nav flex-column">
		<li class="nav-item">
			<button class="stepbtn" data-step="step1">
				<div id="step1">
					<span style="float: left;"><i id="icon1" class='bx bxs-group mt-1'></i></span>
					<div style="float: left;" class="ms-3">
						<div class="text-start stepnum">Step 1</div>
						<div class="text-start">정산대상자</div>
					</div>
				</div>
			</button>
			<div class="d-flex my-2 ms-3"
				style="height: 20px; color: lightgray;">
				<div class="vr"></div>
			</div>
		</li>
		<li class="nav-item">
			<button class="stepbtn" data-step="step2">
				<div id="step2">
					<span style="float: left;"><i id="icon2" class='bx bx-money mt-1'></i></span>
					<div style="float: left;" class="ms-3">
						<div class="text-start stepnum">Step 2</div>
						<div class="text-start">지급 항목</div>
					</div>
				</div>
			</button>
			<div class="d-flex my-2 ms-3"
				style="height: 20px; color: lightgray;">
				<div class="vr"></div>
			</div>
		</li>
		<li class="nav-item">
			<button class="stepbtn" data-step="step3">
				<div id="step3">
					<span style="float: left;"><i id="icon3" class='bx bx-bookmark-alt-minus mt-1'></i></span>
					<div style="float: left;" class="ms-3">
						<div class="text-start stepnum">Step 3</div>
						<div class="text-start">공제 항목</div>
					</div>
				</div>
			</button>
			<div class="d-flex my-2 ms-3"
				style="height: 20px; color: lightgray;">
				<div class="vr"></div>
			</div>
		</li>
		<li class="nav-item">
			<button class="stepbtn" data-step="step4">
				<div id="step4">
					<span style="float: left;"><i id="icon4" class='bx bx-copy-alt mt-1'></i></span>
					<div style="float: left;" class="ms-3">
						<div class="text-start stepnum">Step 4</div>
						<div class="text-start">결과 미리보기</div>
					</div>
				</div>
			</button>
			<div class="d-flex my-2 ms-3"
				style="height: 20px; color: lightgray;">
				<div class="vr"></div>
			</div>
		</li>
		<li class="nav-item">
			<button class="stepbtn" data-step="step5">
				<div id="step5">
					<span style="float: left;"><i id="icon5" class='bx bxs-flag-alt mt-1'></i></span>
					<div style="float: left;" class="ms-3">
						<div class="text-start stepnum">Step 5</div>
						<div class="text-start">정산 완료</div>
					</div>
				</div>
			</button>
		</li>
	</ol>
		<footer class="position-absolute bottom-0">
			<div class="d-flex flex-column bd-highlight mb-3">
				<button id="wout" type="button" class="btn btn-outline-secondary px-4 bd-highlight mb-2 wibtn"><i class='bx bx-exit d-inline' style='color:#636163'></i><p class="mx-2 d-inline">정산에서 나가기</p></button>
			  	<button id="wdelete" type="button" class="btn btn-outline-danger px-4 bd-highlight wibtn" data-bs-toggle="modal" data-bs-target="#exampleModal"><i class='bx bxs-trash d-inline'></i><p class="mx-2 d-inline">정산 삭제하기</p></button>
			</div>
		</footer>
</section>
</nav>



<!-- 정산 삭제버튼 클릭 시 확인 모달 창 -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content w-75">
      <div class="modal-header">
      
        <h5 class="modal-title fw-semibold" id="exampleModalLabel"><i class='bx bxs-error crimson bx-sm'></i>  '${proll.prNm }' 정산을 삭제할까요?</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          </button>
      </div>
      <div class="modal-body">
        <p class="m-0 p-0 ms-3">정산을 삭제하면, 입력된 정산 데이터가 삭제됩니다.</p>
        <p class="m-0 pt-1 ms-3">계속하려면 아래 삭제하기 버튼을 눌러주세요.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-danger" id="mdelete">삭제하기</button>
      </div>
    </div>
  </div>
</div>





<!-- 
<form id="stepForm">
   <input type="hidden" name="prNo" id="prNo" value="${proll.prNo}"/>
   <input type="hidden" name="prPtno" id="prPtno" value="${proll.prPtno}"/>
</form>
 -->



<script>
/*
let prPtno = $("#stepHeader").data("prptno");
//let stepForm = $("#stepForm");


$(".stepbtn").on("click", function(){
	//let stepForm = $("#stepForm");
	//let url;
	//let data = stepForm.serialize();
	
	$step = $(this).data("step");
	
	switch ($step){
	case "step1" :
		url = "${cPath }/pay/wageEmp.do";
		break;
	case "step2" :
		url = "${cPath }/pay/wagePay.do";
		break;
	case "step3" :
		url = "${cPath }/pay/wageDed.do";
		break;
	case "step4" :
		url = "${cPath }/pay/wagePrev.do";
		break;
	case "step5" :
		url = "${cPath }/pay/wageRes.do";
		break;
	default :
		break;
	}
	
	$.ajax({
		url : url,
		method : "POST",
		data : {
			prNo : prNo,
			prPtno : prPtno
		},
		success : function(resp) {
			console.log(resp);
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
})

	*/


$('#wout').on('click', function(){
 	location.href = '${cPath }/pay/payHome.do';
 });
 
function moveHome(){
	location.href = '${cPath}/pay/payHome.do';
}

$('#mdelete').on('click', function(){
	$.ajax({
		url : 'prollDelete.do',
		method : 'POST',
		data : {
			prNo : prNo
		},
		success : function(resp) {
			if(resp == 'SUCCESS'){
				setTimeout(moveHome,1000); //1초 뒤 급여정산 홈으로 이동
	        }else if(resp == 'FAIL'){ 
	            toastr.error('정산 삭제 중 오류가 발생했습니다.');
	        }
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});

})
 
 
</script>