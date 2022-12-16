<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<link rel="stylesheet" href="${cPath }/resources/css/ijs.css" />

<div class="my-5 d-block">
	<div class="col-md-2 float-start">
		<input type="text" class="yearpicker form-control" name="yearpicker" id="yearpicker" value=""/>
	</div>

<!-- 	<div class="float-end"> -->
<!-- 		<button type="button" class="btn btn-outline-secondary"><i class='bx bxs-download'></i> 다운로드</button> -->
<!-- 	</div> -->
</div>
<br><br><br>



<div class="accordion" id="pastProllArea">
	<!-- 지난 정산 내역 목록 출력되는 곳  -->
</div>

<!-- 정산 삭제버튼 클릭 시 확인 모달 창 -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content w-75">
      <div class="modal-header">
      
        <h5 class="modal-title fw-semibold" id="exampleModalLabel"><i class='bx bxs-error crimson bx-sm'></i>
          '<span id="prollName"></span>' 정산을 삭제할까요?</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          </button>
      </div>
      <div class="modal-body">
        <p class="m-0 p-0 ms-3">정산을 삭제하면, 입력된 정산 데이터가 삭제됩니다.</p>
        <p class="m-0 pt-1 ms-3">계속하려면 아래 삭제하기 버튼을 눌러주세요.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-danger" id="mdelete" > 삭제하기</button>
      </div>
    </div>
  </div>
</div>


<form id="resForm" method="post" action="${cPath }/pay/wageRes.do">
   <input type="hidden" name="prNo" value="" />
   <input type="hidden" name="prPtno" value="" />
   <sec:csrfInput/>
</form>


<script>

//정산 귀속연도 선택 via yearPicker
let blgYear = "";
$(document).ready(function(){
      $("#yearpicker").yearpicker({
         year : 2022,
         startYear : 1980,
         endYear : 2050,
         autoclose:true
      });
      
      //최초 접근 시 2022년도 정산 목록 출력
      makePayrollList(2022);

      //연도 클릭하였을 때 실행
      $(document).on("click",".yearpicker-items",function(){
    	  blgYear = $(this).text();
          console.log("blgYear",blgYear);
          makePayrollList(blgYear);
      });
});



let pastProllArea = $('#pastProllArea');
//연도 선택 시 해당 연도에 귀속하는 급여 정산 목록 출력
function makePayrollList(blgYear){
	console.log("========",blgYear);
	$.ajax({
		url : "${cPath}/pay/payrollBelong.do",
		method : "POST",
		data : JSON.stringify({
			blgYear : blgYear
		}),
		dataType : "JSON",
		contentType: "application/json; charset=utf-8",
		success : function(resp) {
			console.log("payrollList 체크 : ", resp);
			
			let htmlCode ="";
			
			if(resp.length==0){
				console.log("출력할 데이터 없음");
				htmlCode += `<h5 class="text-center fw-semibold"><i class='bx bx-error-circle'></i> 해당 귀속연도에 정산 내역이 없습니다.</h5>`;
			}else{
				console.log("출력할 데이터 있음");
			
				$(resp).each(function(i, ProllVO){
					
					htmlCode += `<div class="accordion-item card">
						  <h2 class="accordion-header d-flex align-items-center">
					    <button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#\${ProllVO.prNo}" aria-expanded="false">
					      <i class='bx bx-calendar me-3'></i>
					      \${ProllVO.prBlg}
					    </button>
					  </h2>
					  <div id="\${ProllVO.prNo}" class="accordion-collapse collapse" >
					    <div class="accordion-body pt-2">
							<!-- contents -->
								<span class="border rounded mt-1 p-1">💸</span>
								<span class="badge badge-green ms-3">근로소득</span>
								<span class="ms-3"><strong>\${ProllVO.prNm}</strong></span>
								<div class="vr mx-3"></div>
								<span>\${ProllVO.prBlg} 귀속 · \${ProllVO.prGdate} 지급</span>
								<div class="btn-group float-end">
									<button type="button" class="btn btn-icon rounded-pill dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
										<i class='bx bx-dots-vertical-rounded'></i>
									</button>
									<ul class="dropdown-menu" data-prno="\${ProllVO.prNo}" data-prptno="\${ProllVO.prPtno}" data-prnm="\${ProllVO.prNm}" data-gdate="\${ProllVO.prGdate}">
										<li><a class="dropdown-item resLink" href="javascript:void(0);"><i class='bx bxs-magic-wand' ></i> 정산 결과 보기</a></li>
										<li><a class="dropdown-item downLink" href="javascript:void(0);"><i class='bx bx-spreadsheet'></i>  이체리스트 다운로드</a></li>
										<li><a class="dropdown-item delLink crimson" href="javascript:void(0);"  data-bs-toggle="modal" data-bs-target="#deleteModal">
											<i class='bx bx-trash' ></i> 정산 삭제하기</a>
										</li>
									</ul>
								</div>
							<!-- /contents -->
					    </div>
					  </div>
					</div>`;
					});
					
				}
				pastProllArea.html(htmlCode);
			
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
}
// <li><a class="dropdown-item" href="javascript:void(0);"><i class='bx bx-edit-alt' ></i>  정산 수정하기</a></li>

let prNo
//정산 결과보기 버튼 클릭 시 해당 정산의 wageRes 페이지로 이동한다
$(document).on("click", ".resLink", function(){
	
	prNo = $(this).closest("ul").data('prno');
	let prPtno = $(this).closest("ul").data('prptno');
	
	let resForm = $("#resForm");
	resForm.find('[name=prNo]').val(prNo);
	resForm.find('[name=prPtno]').val(prPtno);
	resForm.submit();
	
})

//정산 다운로드 버튼 클릭 시 해당 정산을 엑셀 다운로드 한다
$(document).on("click", ".downLink", function(){
	prNo = $(this).closest("ul").data('prno'); //정산번호
	let transferDate = $(this).closest("ul").data('gdate'); // 지급일
	
	console.log("prNo",prNo);
	console.log("prGdate",transferDate);
	
	location.href = CONTEXTPATH+"/pay/excelDown.do?prNo="+prNo+"&transferDate="+transferDate;
	
})


//정산 삭제하기 버튼 클릭 시 해당 정산을 삭제한다. (삭제 시 지난 정산 내역에서 조회할 수 없다.)
$(document).on("click", ".delLink", function(){
	let prNm = $(this).closest("ul").data('prnm');
	prNo = $(this).closest("ul").data('prno');
	
	$("#prollName").text(prNm);
	
	$("#mdelete").on("click", function(){
		
		$.ajax({
			url : "${cPath }/pay/prollDelete.do",
			method : "POST",
			data : {
				prNo : prNo
			},
			success : function(resp) {
				if(resp == 'SUCCESS'){
					toastr.success("정산 삭제가 완료되었습니다.");
					setTimeout(makePayrollList(2022),1000);
					$('#deleteModal').modal('hide');
		        }else if(resp == 'FAIL'){ 
		            toastr.error('정산 삭제 중 오류가 발생했습니다.');
		        }
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
		
		
	})
})













</script>