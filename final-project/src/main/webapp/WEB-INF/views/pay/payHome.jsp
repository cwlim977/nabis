<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>	
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>	
    
<link rel="stylesheet" href="${cPath }/resources/css/ijs.css" />


<style>
.seticon, .seticon:hover{
	 background-color : #fbfcfe;
	 border : none;
	 box-shadow : none;
}
</style>

<div class="mt-5 hmdiv p-4 rounded">
	<div class="fs-4 fw-bold mb-4 text-dark ">
		<i class='bx bxs-compass bx-md' style='color:#07b419'></i>
		우리 회사 급여정산 준비를 시작해볼까요? 
	</div>
	<button type="button" class="btn rounded-pill me-2 btn-outline-secondary bg-white" onclick="location.href='${cPath}/pay/withhold.do'">원천징수의무자 정보 확인하기</button>
	<button type="button" class="btn rounded-pill me-2 btn-outline-secondary  bg-white" onclick="location.href='${cPath}/pay/tmpList.do'">정산템플릿 수정하기</button>
</div>

<div class="clearfix mb-4">
	<div class="fs-4 fw-bold text-dark mt-5 mb-4 float-start">
		정산을 시작해볼까요?
	</div>

<!-- Dropdown with icon -->
<div class="col-lg-3 col-sm-6 col-12 mt-5 mb-4 float-end">
    <div class="btn-group" id="dropdown-icon-demo">
      <button
        type="button"
        class="btn btn-primary dropdown-toggle"
        data-bs-toggle="dropdown"
        aria-expanded="false"
      >
        <i class='bx bxs-magic-wand'></i> 정산 시작하기
      </button>
      <ul class="dropdown-menu">
      	<li>
           <h6 class="dropdown-header text-uppercase">정산 템플릿 목록</h6>
         </li>
	       <c:choose>
	       	<c:when test="${not empty tmpList }">
	        	<c:forEach var="tmp" items="${tmpList}">
			        <li>
			          <a href="javascript:void(0);" class="dropdown-item d-flex align-items-center ptKey" 
			          	data-bs-toggle="modal" data-bs-target="#exampleModal" data-ptno="${tmp.ptNo }">
			          	<i class="bx bx-chevron-right scaleX-n1-rtl me-1"></i>${tmp.ptNm }
			          </a>
			        </li>
	       		</c:forEach>
	       	</c:when>
	       	<c:otherwise>
			  <li>
	          <a href="javascript:void(0);" class="dropdown-item d-flex align-items-center">
	          	<i class="bx bx-chevron-right scaleX-n1-rtl me-1"></i>템플릿 데이터 없음
	          </a>
	         </li>
			</c:otherwise>
	       </c:choose>
        <li>
          <hr class="dropdown-divider" />
        </li>
        <li>
          <a href="${cPath}/pay/tmpInsert.do" class="dropdown-item d-flex align-items-center">
          	<i class='bx bx-plus me-1'></i>템플릿 추가하기</a>
        </li>
      </ul>
    </div>
</div>
<!-- Dropdown with icon -->
</div>

<!-- 북마크 추가한 템플릿 리스트 조회 -->
<c:choose>
	<c:when test="${not empty tmpList }">
		<c:forEach var="tmp" items="${tmpList }">
			<c:if test="${tmp.ptBmk eq 'Y'}">
				<div class="col-md-6 col-xl-4 float-start me-4 mt-3" >
					<div class="card shadow-none bg-transparent border border-secondary mb-3" style="height: 14rem" >
						<div class="card-body d-inline-block p-3 pb-0">
							<span class="badge badge-green float-start mt-3">근로소득</span> 
							<button type="button"
								class=" btn btn-primary btn-icon rounded-pill float-end seticon"
								onclick="location.href='${cPath }/pay/tmpUpdate.do?ptNo=${tmp.ptNo}'">
								<i class='bx bxs-cog float-end ' style='color:#595959;'></i>
							</button>
							<button type="button" class="btn rounded-pill btn-icon me-2 float-end">
                              <span class="tf-icons bx bxs-bookmark markspan" style="color:#f04785;">
                              </span>
                            </button>
						</div>
						<div class="d-inline-block p-3">
							<h5 class="card-title mt-1 fw-bold">${tmp.ptNm }</h5>
							<p class="card-text">${tmp.ptAbst }</p>
						</div>
						<div class="p-3">
							<button type="button" class="btn btn-primary ptKey"
								data-bs-toggle="modal" data-bs-target="#exampleModal" data-ptno="${tmp.ptNo }" >
								정산하기</button>
						</div>
					</div>
				</div>
			</c:if>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<p>북마크한 템플릿 리스트 없음</p>
	</c:otherwise>
</c:choose>




<!-- 급여대장 생성 모달 -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
     <form:form method="post" modelAttribute="proll" id="prollForm">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">정산 시작하기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          </button>
      </div><!-- modal-header end -->
      <div class="modal-body">
        
            <div class="row mb-3">
              <label class="col-sm-2 col-form-label" for="prNm">이름</label>
              <div class="col-sm-10">
                <form:input path="prNm" class="form-control" placeholder="1월 정기 급여"/>
              </div>
            </div>
            <div class="row mb-3">
              <label class="col-sm-2 col-form-label" for="prBng">귀속월</label>
              <div class="col-md-10">
              	<input class="form-control" type="month" value="2022-12" id="prBlg" />
              </div>
              <div class="form-text text-center">기본근무 정산기간은 1일 ~ 30일 입니다.</div>
            </div>
            <div class="mb-3 row">
             <label for="prGdate" class="col-md-2 col-form-label">지급일</label>
             <div class="col-md-10">
               <input class="form-control" type="date" value="2022-01-05" id="prGdate" />
             </div>
  	        </div>
			<div class="mb-3 row">
				<label for="html5-date-input" class="col-md-2 col-form-label">정산기간</label>
				<div class="col-md-10">
					<input type="text" class="form-control" id="prollPeriod" name="daterange" />
				</div>
				<span id="rangeAlert" class="fw-semibold crimson text-center mt-1"></span>
			</div>
       </div><!-- modal-body end -->
      <div class="modal-footer">
        <div class="d-grid gap-2 col-6 mx-auto d-inline">
			<button id="mvbtn" class="btn btn-primary btn-lg d-inline" type="submit">정산 시작하기 <i class='bx bx-right-arrow-alt'></i></button>
			<button id="autoData" type="button" class="btn btn-label-secondary d-inline">자동 입력</button>
		</div>
      </div><!-- modal-footer end -->
     </form:form>
    </div><!-- modal-content end -->
  </div>
</div>

<form:form modelAttribute="proll" id="moveForm" method="post" action="${cPath }/pay/wageEmp.do">
   <form:hidden path="prNo"/>
   <form:hidden path="prPtno"/>
   <form:hidden path="prSdate"/>
   <form:hidden path="prEdate"/>
</form:form>


<script defer="defer">

$(function(){
	
	$('#prollPeriod').daterangepicker({
	    "locale": {
	        "format": "YYYY-MM-DD",
	        "separator": " → ",
	        "applyLabel": "확인",
	        "cancelLabel": "취소",
	        "fromLabel": "From",
	        "toLabel": "To",
	        "customRangeLabel": "Custom",
	        "weekLabel": "W",
	        "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
	        "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
	    },
	    "startDate": '2022-12-01',
	    "endDate": '2022-12-31',
	    "drops": "auto"
	}, function (start, end, label) {
	    console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');

	});
	
});




let std; //date rangepicker 시작일 (정산시작일)
let end; //date rangepicker 종료일 (정산종료일)
let ptNo;//템플릿 번호

$('#prollPeriod').on('apply.daterangepicker', function(ev, picker) {
	std = picker.startDate.format('YYYY-MM-DD');
	end = picker.endDate.format('YYYY-MM-DD');
	$('#rangeAlert').text("");
});

$('.ptKey').on("click", function(){
	ptNo = $(this).data("ptno");
});

let moveForm = $("#moveForm");

$("#prollForm").on("submit", function(event){
	event.preventDefault();
	
	let method = this.method;
	let prr =  ${authEmp.empNo}; 		   //정산작성자
	let prGdate = $("#prGdate").val();     //급여지급일
	let prNm = $("#prNm").val();           //급여정산이름
	let prBlg = $("#prBlg").val(); 	 	   //급여정산귀속연월
	
	if(std==null || end==null) 
		$('#rangeAlert').text("정산 기간을 선택해주세요 !");	
	
	$.ajax({
		url : "${cPath}/pay/payrollInsert.do",
		method : method,
		data : {
			 prPtno : ptNo
			,prr : prr
			,prSdate : std
			,prEdate : end
			,prGdate : prGdate
			,prNm : prNm
			,prBlg : prBlg
			
		},
		dataType : "JSON",
		success : function(resp) {
			//window.location.href="${cPath }/pay/wageEmp.do?prNo="+prNo+"&prPtno="+ptNo; 
			console.log("debug:",resp);
			console.log("debug2",std,end);
			console.log("debug3",moveForm.attr("method"));
	         moveForm.find('[name=prNo]').val(resp.prNo);
	         moveForm.find('[name=prPtno]').val(resp.prPtno);
	         moveForm.find('[name=prSdate]').val(std);
	         moveForm.find('[name=prEdate]').val(end);
	         moveForm.submit();
		},
		error : function(errorResp){
			console.log(errorResp.status);
		}
	});
	return false; 
});



$('#autoData').on("click", function(){
	$('#prollForm').find('[name="prNm"]').val('관리과 12월 정기 급여');
});


</script>
