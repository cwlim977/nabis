<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<style>
	.card:hover{
		background-color : #f7f7f7;
	}
	.ded{
		border: 1px solid  rgba(67,89,113, 0.1);
	}
	.div-box{
		clear: both;
	}
	.dedset{
		display: inline-block;
	}
	.dedsetbtn{
		float: right;
	}
	.tgbtn{
		margin-left: 10px;
	}

</style>

<button type="button" class="workBtn btn border" style="float: right;" >
	 <i class='bx bx-plus bx-sm text-success' ></i>추가하기
</button>
<div class="div-box">
	<div class="divider text-start">
		<div class="divider-text fw-semibold fs-large">근무정책</div>
	</div>
</div>


<div class="container-xl flex-grow-1 container-p-y">
	<div id ='workListBody' class="row">
		   <div class="workBtn card col-md-2 m-2 cursor-pointer shadow-lg ded" data-wkcode="WK2">
		  		<div class="card-header"> <h5 class="card-title fw-semibold"><span class="badge badge-dot bg-primary me-1"></span>근무</h5></div>
		  		<div class="card-body"><br></div>
			</div>
	 
	
		<div class="workBtn card col-md-2 m-2 cursor-pointer shadow-lg ded" >
	  		<div class="card-header">  <h5 class="card-title fw-semibold"><span class="badge badge-dot bg-primary me-1"></span>외근</h5></div>
	  		<div class="card-body"><br></div>
		</div>
		
		<div class="workBtn card col-md-2 m-2 cursor-pointer shadow-lg ded" >
	  		<div class="card-header">  <h5 class="card-title fw-semibold"><span class="badge badge-dot bg-primary me-1"></span>원격근무</h5></div>
	  		<div class="card-body"><br></div>
		</div>
		
		<div class="workBtn card col-md-2 m-2 cursor-pointer shadow-lg ded">
	  		<div class="card-header">  <h5 class="card-title fw-semibold"><span class="badge badge-dot bg-primary me-1"></span>출장</h5></div>
	  		<div class="card-body"><br></div>
		</div>
	
	</div>
	
</div>
<!-- <div class="div-box"> -->
<!-- 	<div class="divider text-start"> -->
<!-- 		<div class="divider-text fw-semibold fs-large">근무 승인</div> -->
<!-- 	</div> -->
<!-- </div> -->
<!-- <div class="container-xl flex-grow-1 container-p-y"> -->
<!-- 	<div class="row"> -->
	 
<!-- 	   <div class="card col-md-2 m-2 shadow-lg ded"> -->
<!-- 	  		<div class="card-header">  -->
<!-- 	  		<h5 class="card-title fw-semibold dedset">연장 근무</h5> -->
<!-- 	  		<div class="form-check form-switch mb-2 dedset align-middle tgbtn"> -->
<!-- 	           <input class="form-check-input" type="checkbox" checked /> -->
<!-- 	         </div> -->
<!-- 	  		</div> -->
<!-- 	  		<div class="card-body"> -->
		   
<!-- 		    	<p class="card-text text-warning">승인설정됨</p> -->
<!-- 	 		</div> -->
<!-- 		</div> -->
	
<!--  		<div class="card col-md-2 m-2 shadow-lg ded"> -->
<!-- 	  		<div class="card-header">  -->
<!-- 	  		<h5 class="card-title fw-semibold dedset">야간 근무</h5> -->
<!-- 	  		<div class="form-check form-switch mb-2 dedset align-middle tgbtn"> -->
<!-- 	           <input class="form-check-input" type="checkbox" checked /> -->
<!-- 	         </div> -->
<!-- 	  		</div> -->
<!-- 	  		<div class="card-body"> -->
<!-- 		    	<p class="card-text text-secondary">승인없음</p> -->
<!-- 	 		</div> -->
<!-- 		</div> -->
		
<!-- 		<div class="card col-md-2 m-2 shadow-lg ded"> -->
<!-- 	  		<div class="card-header">  -->
<!-- 	  		<h5 class="card-title fw-semibold dedset">휴일 근무</h5> -->
<!-- 	  		<div class="form-check form-switch mb-2 dedset align-middle tgbtn"> -->
<!-- 	           <input class="form-check-input" type="checkbox" checked /> -->
<!-- 	         </div> -->
<!-- 	  		</div> -->
<!-- 	  		<div class="card-body"> -->
<!-- 		    	<p class="card-text text-warning">승인설정됨</p> -->
<!-- 	 		</div> -->
<!-- 		</div> -->
	
<!-- 	</div> -->
	
<!-- </div> -->

<div id="workApply" class="offcanvas offcanvas-end w-px-500" tabindex="-1">
  <div class="offcanvas-header border-bottom border-secondary sticky-top">
    <h5 id="workApplyTitle" class="offcanvas-title fw-semibold">
    	근무 정책 수정/추가
    </h5>
    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"></button>
  </div>
  <form id="workApplyForm">
  <div class="offcanvas-body mx-0 flex-grow-0">
	<section>
		<div class="divider text-start my-3">
		 	<div class="divider-text fw-semibold">
			  	<i class='bx bx-edit-alt bx-sm me-1' ></i>
			  	기본 정보 입력
			</div>
		</div>
		<div class="input-group input-group-merge my-3">
			<input name="wkNm" type="text" class="form-control" placeholder="근무 이름 입력"/>
		</div>
		<div class="input-group input-group-merge my-3">
    		<textarea name="wkDescr" class="form-control" placeholder="근무에 대한 설명을 입력해 주세요.(최대 500자)"></textarea>
		</div>
	</section>
	<section>
		<div class="divider text-start my-3">
		 	<div class="divider-text fw-semibold my-3">
			  	<i class='bx bx-cog bx-sm me-1'></i>
			  	상세 설정
			</div>
			<div class="card border">
				  	<div class="card-body">
				  		<div class="d-flex justify-content-between my-sm-3">
				  			<span class="py-1 fw-semibold">일정 공유</span>
				  			<div class="btn-group w-75" role="group">
							  <input type="radio" class="btn-check" name="wkScd" id="wkScd1" value="N"  autocomplete="off" >
							  <label class="btn btn-outline-dark btn-sm" for="wkScd1">없음</label>
							  <input type="radio" class="btn-check" name="wkScd" id="wkScd2" value="Y" autocomplete="off" checked>
							  <label class="btn btn-outline-dark btn-sm" for="wkScd2">팀 내 공유</label>
							</div>
						</div>
				  		<div class="d-flex my-sm-3">
				  			<span class="py-1 fw-semibold">야간 근무 등록 허용</span>
				  			<div class="form-check form-switch dedset align-middle tgbtn">
					           <input class="form-check-input" name="wkNight" value="Y" type="checkbox"/>
					        </div>
				  			오후 10:00 ~ 익일 새벽 03:00
						</div>
				  		<div class="d-flex">
				  			<span class="py-1 fw-semibold">휴일 근무 등록 허용</span>
				  			<div class="form-check form-switch dedset align-middle tgbtn">
					           <input class="form-check-input" name="wkHd" value="Y" type="checkbox" />
					        </div>
					        공휴일, 주휴일
						</div>
					</div>
				</div>
		</div>
	</section>
  </div>
  <input type="hidden" name="wkCode"/>
  </form>
  <div class="border-top border-secondary p-2">
  <button id="workDelBtn" type="button" class="btn btn-danger">삭제하기</button>
	<div class="d-flex justify-content-between" style="float: right;">
		<button type="button" class="btn btn-secondary" data-bs-dismiss="offcanvas">취소</button>
		<button id="workSetBtn" type="button" class="btn btn-success ms-2"><i class='bx bx-check me-1'></i>저장하기</button>
		<button id="workAddBtn" type="button" class="btn btn-success ms-2"><i class='bx bx-check me-1'></i>저장하기</button>
	</div>
  </div>
</div>
<script type="text/javascript" defer="defer">
$(function() {
getWorkList();


let $workApply = $('#workApply');		//근무정책 오픈캔버스
let $workApplyTitle = $('#workApplyTitle');		//근무정책 오픈캔버스 제목
let $workApplyForm = $('#workApplyForm'); //근무정책 폼
let $workDelBtn = $('#workDelBtn');		//근무정책 오픈캔버스 삭제버튼
let $workAddBtn = $('#workAddBtn')		//근무정책 오픈캔버스 추가버튼
let $workSetBtn = $('#workSetBtn')		//근무정책 오픈캔버스 수정버튼

$(document).on('click', '.workBtn', function() {
	let wkCode = $(this).data('wkcode');
	let wkNm = $(this).data('wknm');
	let wkDescr = $(this).data('wkdescr');
	let wkScd = $(this).data('wkscd');
	let wkNight = $(this).data('wknight');
	let wkHd = $(this).data('wkhd');
	
	if(!wkCode){
		$workApplyTitle.html('근무 정책 추가');
		$workDelBtn.hide();
		$workSetBtn.hide();
		$workAddBtn.show();
		$workApplyForm.find('[name="wkCode"]').val('');
		$workApplyForm.find('[name="wkNm"]').val('');
		$workApplyForm.find('[name="wkDescr"]').val('');
		$workApplyForm.find('[name="wkScd"]').radioSelect('N');
		$workApplyForm.find('[name="wkNight"]').prop("checked", false);
		$workApplyForm.find('[name="wkHd"]').prop("checked", false);
	}else{
		$workApplyTitle.html('근무 정책 수정');
		$workSetBtn.show();
		$workAddBtn.hide();
		if(wkCode != "WK2"){
			$workDelBtn.show();
		}else{
			$workDelBtn.hide();
		}
		$workApplyForm.find('[name="wkCode"]').val(wkCode);
		$workApplyForm.find('[name="wkNm"]').val(wkNm);
		$workApplyForm.find('[name="wkDescr"]').val(wkDescr);
		$workApplyForm.find('[name="wkScd"]').radioSelect(wkScd);
		if(wkNight == 'Y'){
			$workApplyForm.find('[name="wkNight"]').prop("checked", true);
		}else{
			$workApplyForm.find('[name="wkNight"]').prop("checked", false);
		}
			
		if(wkHd == 'Y'){
			$workApplyForm.find('[name="wkHd"]').prop("checked", true);
		}else{
			$workApplyForm.find('[name="wkHd"]').prop("checked", false);
		}
	}
	$workApply.offcanvas('show');
});

// ############################################################################
// 근무추가
$workAddBtn.on('click', function() {
	let data = $workApplyForm.serializeObject();
	$.ajax({
		url : CONTEXTPATH+"/setting/createWork.do",
		method : "post",
		dataType : "json",
		data : JSON.stringify(data),
		contentType: "application/json; charset=utf-8",
		success : function(resp) {
			if(resp.status == 'success'){
	            toastr.success('근무를 추가 했습니다.');
	            getWorkList();
	            $workApply.offcanvas('hide');
	        }else if(resp.status == 'fail'){ 
	            toastr.error('근무를 추가 중 오류가 발생 했습니다.');
	        }
			
		},
		error : function(errorResp) {
			console.log(errorResp.status);
			toastr.error('근무를 추가 중 오류가 발생 했습니다.');
			$workApply.offcanvas('hide');
		}
	});
});

// ############################################################################
// 근무수정
$workSetBtn.on('click', function() {
	let data = $workApplyForm.serializeObject();
	$.ajax({
		url : CONTEXTPATH+"/setting/modifyWork.do",
		method : "post",
		dataType : "json",
		data : JSON.stringify(data),
		contentType: "application/json; charset=utf-8",
		success : function(resp) {
			if(resp.status == 'success'){
	            toastr.success('변경사항을 저장했습니다.');
	            getWorkList();
	            $workApply.offcanvas('hide');
	        }else if(resp.status == 'fail'){ 
	            toastr.error('변경사항 저장 중 오류가 발생 했습니다.');
	        }
			
		},
		error : function(errorResp) {
			console.log(errorResp.status);
			toastr.error('변경사항 저장 중 오류가 발생 했습니다.');
			$workApply.offcanvas('hide');
		}
	});
});

// ############################################################################
// 근무삭제
$workDelBtn.on('click', function() {
	let data = $workApplyForm.find('[name="wkCode"]').val();
	$.ajax({
		url : CONTEXTPATH+"/setting/deleteWork.do",
		method : "post",
		dataType : "json",
		data : { wkCode : data},
		success : function(resp) {
			if(resp.status == 'success'){
	            toastr.success('변경사항을 저장했습니다.');
	            getWorkList();
	            $workApply.offcanvas('hide');
	        }else if(resp.status == 'fail'){ 
	            toastr.error('변경사항 저장 중 오류가 발생 했습니다.');
	        }
			
		},
		error : function(errorResp) {
			console.log(errorResp.status);
			toastr.error('변경사항 저장 중 오류가 발생 했습니다.');
			$workApply.offcanvas('hide');
		}
	});
});
// ############################################################################
// 근무목록 갱신 함수
$workListBody = $('#workListBody');
function getWorkList() {
	$.ajax({
		url : CONTEXTPATH+"/setting/getWorkList.do",
		dataType : "json",
		success : function(resp) {
			console.log('근무리스트 :',resp);
			let htmlCode='';
			$(resp).each(function(i, work) {
				if(work.wkCode !='WK1' && work.wkCode !='WK6' && work.wkCode !='WK7'){
					htmlCode += `<div class="workBtn card col-md-2 m-2 cursor-pointer shadow-lg ded" 
									data-wkcode="\${work.wkCode}"	data-wknm="\${work.wkNm}" 
									data-wkdescr="\${work.wkDescr}" data-wkscd="\${work.wkScd}" 
									data-wknight="\${work.wkNight}" data-wkhd="\${work.wkHd}">
							  		<div class="card-header"> <h5 class="card-title fw-semibold">
							  			<span class="badge badge-dot bg-primary me-1"></span>\${work.wkNm}</h5>
							  		</div>
							  		<div class="card-body"><br></div>
								</div>`;
				}
			})
			$workListBody.html(htmlCode);
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
}


$("[type=checkbox]").on("change", function(){
	if($(this).is(":checked")){
		let ptNo = '${tmp.ptNo}';
		let ddCode = $(this).data("ddcode");
		let pddAmt = $(this).data("pddamt");
		
// 		$.ajax({
// 			url : "${cPath}/pay/ptmakeInsert.do",
// 			data : {
// 				ptNo : ptNo
// 				,ddCode : ddCode
// 				,pddAmt : pddAmt
// 			},
// 			success : function(resp) {
// 				console.log(resp);
// 			},
// 			error : function(errorResp) {
// 				console.log(errorResp.status);
// 			}
// 		});
	}else{
		let ptNo = '${tmp.ptNo}';
		let ddCode = $(this).data("ddcode");
		
// 		$.ajax({
// 			url : "${cPath}/pay/ptmakeDelete.do",
// 			data : {
// 				ptNo : ptNo
// 				,ddCode : ddCode
// 			},
// 			success : function(resp) {
// 				console.log(resp);
// 			},
// 			error : function(errorResp) {
// 				console.log(errorResp.status);
// 			}
// 		});
		
	}
});


})
$.fn.radioSelect = function(val) {
  this.each(function() {
    var $this = $(this);
    if($this.val() == val)
      $this.prop('checked', true);
  });
  return this;
};
</script>


