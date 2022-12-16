<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${cPath}/resources/js/jspdf.min.js"></script>
<script src="${cPath}/resources/js/html2canvas.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.0.272/jspdf.debug.js"></script>
<script>
	
	let empRole = "${requestScope['empRole']}";
	
	$('.headerMenu, .headerSubMenu').each(function(){
		switch($(this).attr('id')){
			case 'menu1':
				$(this).find('span').addClass('text-dark');
				break;
			case 'subMenu1':
				break;
			case 'subMenu2':
				if(!(empRole == 'admin' || empRole == 'manager')) $(this).hide();
				$(this).find('span').addClass('text-dark');
				break;
		}
	});
</script>
<link rel="stylesheet" href="${cPath }/resources/css/jhy.css" />
<style>
#emppdf {
 overflow: hidden; height: 0; 

}  
</style>  



<div class="card">
				<div class="  px-4">
				<div>
                <h5 class="card-header px-0 pb-3 fw-bold fs-4">구성원 문서</h5>
                </div>
                <div class="d-flex">
                	<div class="py-4" ><span id="empCerfCount" class="fw-bold text-success">0</span>명</div>
                	<div class="ms-auto ">
	                   <form class=" d-flex my-2 my-lg-0  py-3" action="javascript:void(0)" >
					      <input class="form-control me-sm-2" type="text" id="eCerfSearch" placeholder="구성원 이름 검색"  /><!-- onkeyup="empCerfSearch(this)" -->
					      <button class="btn btn-outline-primary my-2 my-sm-0" type="submit">Search</button>
					    </form>
				    </div>
				</div>    
                </div>
                <div class="card-body pt-0">
                  <div class="table-responsive text-nowrap">
                    <table class="table table-bordered" id="cerfEmpTable">
                      <thead>
                        <tr class="empCerfTableTr">
                          <th>이름</th>
                          <th>재직증명서</th>
                          <th>재직증명서 발급내역</th>
                          <th>경력증명서</th>
                          <th>경력증명서 발급내역</th>
                        </tr>
                      </thead>
                      <tbody id="cerfTbody">
                      <c:forEach items="${cerfList}" var="eCerf">
                        <tr>
                          <td>
                            <div class="d-flex align-self-center align-items-center">	                          
                            	<c:if test="${empty eCerf.empImg}">
                            		<img src="${cPath}/resources/images/basicProfile.png"
									alt="기본 프로필" class="empListimgradius emplistimgsize">
                            	</c:if>
                            	<c:if test="${not empty eCerf.empImg}">                          	
								<img src="${cPath}/resources/empImages/${eCerf.empImg}"
									alt="프로필 이미지" class="empListimgradius emplistimgsize">
                            	</c:if>
                            	
								<div class="mx-3 mt-1">
									<strong>${eCerf.empNm }</strong><br> 
									<span class="fs-tiny">
										<c:forEach items="${eCerf.jobList}" var="job" varStatus="status">
			                            	<c:if test="${status.index eq 0}">
												${job.jnm}
											</c:if>
			                            </c:forEach>
		                            </span>
								</div>			
							</div>
                          </td>
                          
                          
                          <td><button class="empWorkCerfBtn empCerfDownBtn p-1" onclick="empNo('${eCerf.empNo}')" data-empno="${eCerf.empNo}" data-bs-toggle="modal" data-bs-target="#empModalWorkCerf">
                          		<i class='bx  bxs-download' ></i>다운로드</button> </td>
                          <td>
            				
	            				<button type="button" class="empCerfHistryBtn p-1" id="" data-empno="${eCerf.empNo}" data-cfnm="재직" data-bs-toggle="modal" data-bs-target="#empModalCerf">
									  발급내역
								</button>					
                          </td>
                          <td>
		                          <button class="empCareeCerfBtn empCerfDownBtn p-1" onclick="empNo('${eCerf.empNo}')" data-empno="${eCerf.empNo}" data-bs-toggle="modal" data-bs-target="#empModalCareeCerf">
		                          <i class='bx  bxs-download'></i>다운로드</button>
						 </td>
                          <td>
                     		
	            				<button type="button" class="empCerfHistryBtn p-1" id="empCareeCerfHistryBtn" data-empno="${eCerf.empNo}" data-cfnm="경력" data-bs-toggle="modal" data-bs-target="#empModalCerf">
									  발급내역
								</button>
							
					
                          </td>
                        </tr>
                        </c:forEach>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>



					
							<!-- 발급내역 모달 -->		
							<div class="modal fade "  id="empModalCerf" tabindex="-1" aria-labelledby="exampleModalLabelempCerfWork" aria-hidden="true">
							  <div class="modal-dialog modal-dialog-scrollable" role="document">
							    <div class="modal-content" style="max-height: 57%;">
							      <div class="modal-header border-bottom pb-3">
							        <h5 class="modal-title" id="exampleModalLabelempCerfWork"></h5>
							        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
							          </button>
							      </div>
							      <div class="modal-body pt-0 offcanvas-scrollbar empCerfScroll">
										<div class="card mt-4 border shadow-none " >
									        <h6 class="card-header border-bottom bg-light  fw-bold"><i class='bx bx-calendar-check'></i>발급 내역</h6>
									        <div class="table-responsive ">
									          <table class="table card-table table-hover " >
									            <thead>
									              <tr>
									                  	<th class="fs-6">파일번호</th>
									                   <th class="fs-6">발급 사유</th>
									                   <th class="fs-6">날짜</th>
									              </tr>
									            </thead>
									            <tbody id="empWorkTbody">									
									            </tbody>
									          </table>
									        </div>
									      </div>
							      </div>
							     
							    </div>
							  </div>
							</div>



						<div id="emppdf">
						       <div id="emppdfDivs" > 
						   			
						      </div>   
						</div>





							<!-- 구성원 재직증명서 modal -->
							<div class="modal fade" id="empModalWorkCerf" tabindex="-1" aria-hidden="true">
								  <div class="modal-dialog" role="document">
								    <div class="modal-content">
								      <div class="modal-header border-bottom pb-3">
								        <h5 class="modal-title " id="exampleModalLabel1">재직 증명서 발급</h5>
								        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								      </div>
								      <div class="modal-body">
								       
								        <div class="">
								         <small class="text-light fw-semibold d-block">선택 항목</small>
										    <div class="form-check form-check-inline mt-3">
										      <input class="form-check-input " type="checkbox" name="workCerfRegCheck" id="WorkRegMarkCheckBox" value="" />
										      <label class="form-check-label" for="WorkRegMarkCheckBox">주민등록번호 표시</label>
										    </div>
								        </div>
								        <div class="mt-4">
								           <small class="text-light fw-semibold d-block">발급 사유<span class="text-danger">*</span></small>
										    <div class="form-check form-check-inline mt-3">
										      <input class="form-check-input" type="radio" name="inlineRadioOptionsMyWorkCerf" id="inlineRadioWorkCerf1" value="금융기관 제출" />
										      <label class="form-check-label" for="inlineRadioWorkCerf1">금융기관 제출</label>
										    </div>
										    <div class="form-check form-check-inline">
										      <input class="form-check-input" type="radio" name="inlineRadioOptionsMyWorkCerf" id="inlineRadioWorkCerf2" value="관공서 제출" />
										      <label class="form-check-label" for="inlineRadioWorkCerf2">관공서 제출</label>
										    </div>
										    <div class="form-check form-check-inline">
										      <input class="form-check-input" type="radio" name="inlineRadioOptionsMyWorkCerf" id="inlineRadioWorkCerf3" value="학교 제출" />
										      <label class="form-check-label" for="inlineRadioWorkCerf3">학교 제출</label>
										    </div>
										    <div class="form-check form-check-inline">
										      <input class="form-check-input" type="radio" name="inlineRadioOptionsMyWorkCerf" id="inlineRadioWorkCerf4" value="기타" />
										      <label class="form-check-label" for="inlineRadioWorkCerf4">기타</label>
										    </div>	
								        </div>
												    					
								        <!-- <textarea id="text" rows="3" class="form-control mt-3 workCerftext"></textarea> -->
								      </div>
								      <div class="modal-footer">
								        <div class="d-grid gap-2 col-12 mx-auto">
										  <button class="btn btn-success btn-md" id="empsaveWorkPdfBtn" type="button" data-empno="${eCerf.cfEmp}"  ><i class='bx  bxs-download' ></i>다운로드</button>				
										</div>
								      </div>
								    </div>
								  </div>
								</div>
								
								
								<!-- 구성원 경력증명서 modal -->
								<div class="modal fade" id="empModalCareeCerf" tabindex="-1" aria-hidden="true">
								  <div class="modal-dialog" role="document">
								    <div class="modal-content">
								      <div class="modal-header border-bottom pb-3">
								        <h5 class="modal-title " id="exampleModalLabel1">경력 증명서 발급</h5>
								        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								      </div>
								      <div class="modal-body">
								       <form:form id="">
								        <div class="">
								         <small class="text-light fw-semibold d-block">선택 항목</small>
										    <div class="form-check form-check-inline mt-3">
										      <input class="form-check-input " type="checkbox" name="careeCerfRegCheck" id="WorkRegMarkCheckBox" value="" />
										      <label class="form-check-label" for="WorkRegMarkCheckBox">주민등록번호 표시</label>
										    </div>
								        </div>
								        <div class="mt-4">
								           <small class="text-light fw-semibold d-block">발급 사유<span class="text-danger">*</span></small>
										    <div class="form-check form-check-inline mt-3">
										      <input class="form-check-input" type="radio" name="inlineRadioOptionsMyWorkCerf" id="inlineRadioWorkCerf1" value="금융기관 제출" />
										      <label class="form-check-label" for="inlineRadioWorkCerf1">금융기관 제출</label>
										    </div>
										    <div class="form-check form-check-inline">
										      <input class="form-check-input" type="radio" name="inlineRadioOptionsMyWorkCerf" id="inlineRadioWorkCerf2" value="관공서 제출" />
										      <label class="form-check-label" for="inlineRadioWorkCerf2">관공서 제출</label>
										    </div>
										    <div class="form-check form-check-inline">
										      <input class="form-check-input" type="radio" name="inlineRadioOptionsMyWorkCerf" id="inlineRadioWorkCerf3" value="학교 제출" />
										      <label class="form-check-label" for="inlineRadioWorkCerf3">학교 제출</label>
										    </div>
										    <div class="form-check form-check-inline">
										      <input class="form-check-input" type="radio" name="inlineRadioOptionsMyWorkCerf" id="inlineRadioWorkCerf4" value="기타" />
										      <label class="form-check-label" for="inlineRadioWorkCerf4">기타</label>
										    </div>	
								        </div>
										</form:form>						    					
								        <!-- <textarea id="text" rows="3" class="form-control mt-3 workCerftext"></textarea> -->
								      </div>
								      <div class="modal-footer">
								        <div class="d-grid gap-2 col-12 mx-auto">
										  <button class="btn btn-success btn-md" id="empsaveCareePdfBtn" type="button" data-empno="${eCerf.cfEmp}"><i class='bx  bxs-download' ></i>다운로드</button>				
										</div>
								      </div>
								    </div>
								  </div>
								</div>
				
	

<script>





let empCerfCount = $('#empCerfCount');
let count = "";
$(document).ready(function(){
	count  = $('#cerfEmpTable > tbody > tr').length;
	empCerfCount.html(count);
})


//구성원 이름 검색 
$('#eCerfSearch').keyup(function(event) {

    var val = $(this).val();
    if (val == "") {
    
    	$('#cerfTbody > tr').show();
    	 count  = $('#cerfEmpTable > tbody > tr').length;
      
        empCerfCount.html(count);  
    }else{
    	
        let searched = $("#cerfEmpTable > tbody > tr > td:contains('"+val+"')");
        $('#cerfEmpTable > tbody > tr').hide();
      	$(searched).parent().show();
    	
  /*     	count  = $('#cerfEmpTable > tbody > tr').length;*/
        console.log("searched",searched.length); 
        empCerfCount.html(searched.length);
    
   //     $('#empCerfCount').html(count+"명");
    }
});




//check box 초기화
$('#workCerfModalBtn').on("click",function(){
	$("input[name=inlineRadioOptionsMyWorkCerf]").prop("checked",false);
	$("input[name=workCerfRegCheck]").prop("checked",false);
	
	
});
$('.empCerfDownBtn').on("click",function(){
	$("input[name=workCerfRegCheck]").prop("checked",false);
	$("input[name=careeCerfRegCheck]").prop("checked",false);
	$("input[name=inlineRadioOptionsMyWorkCerf]").prop("checked",false);
	
	
});
 
 
 

let clickEmpNo = "";  
function empNo(empno){
	console.log( empno);
	clickEmpNo = empno;
} 
 
let regCheck = ""; 
 // 재직 증명서 발급 
$('#empsaveWorkPdfBtn').click(function() {
	  
	
	//	let empNo = $(this).data("empno");
		let empNo = clickEmpNo;
		console.log(empNo);
		let cfNm = "재직";
		
		if($('input[name=workCerfRegCheck]').prop("checked") ){
	
			regCheck = "Y";
		}else{
			regCheck = "N";
		}
		console.log("empNo",empNo);
		
		 // 발급 신청 할  때 필요한 정보가 있는지 select 
		$.ajax({

			url : "${pageContext.request.contextPath}/cerf/selectCerfInfo.do", //어디로
			method : "GET", //어떻게
			data : {empNo : empNo}, //무엇을
			dataType : "json",
			success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함

				console.log(resp.empVo);
				let message = "";
			   let empvo = resp.empVo;
			   
			  
			   
				if( empvo == null){
					
		 			
					  Swal.fire({
					    title: '<div class="text-danger"><i class="bx bx-lg bx-danger bx-error-circle"></i></div><div>증명서 발급에 필요한 정보 중 입력되지 않은 정보가 있어요.</div>',
					    type: 'error',
					    html:'<p>구성원 정보 : 주조직</p>',
						    customClass: {
						      confirmButton: 'btn btn-primary'
						    },
						    buttonsStyling: false
						  }); 

						$("input[name=inlineRadioOptionsMyWorkCerf]").prop("checked",false);
						$("input[name=workCerfRegCheck]").prop("checked",false);
					
				}else if(empvo != null && empvo.empAddr == null){		
					 Swal.fire({
						    title: '<div class="text-danger"><i class="bx bx-lg bx-danger bx-error-circle"></i></div><div>증명서 발급에 필요한 정보 중 입력되지 않은 정보가 있어요.</div>',
						    type: 'error',
						    html:'<p>구성원 정보 :주소 </p>',
							    customClass: {
							      confirmButton: 'btn btn-primary'
							    },
							    buttonsStyling: false
							  }); 
					
				}else if(empvo != null && empvo.jobList[0].jnm == null){						
						
							 Swal.fire({
								    title: '<div class="text-danger"><i class="bx bx-lg bx-danger bx-error-circle"></i></div><div>증명서 발급에 필요한 정보 중 입력되지 않은 정보가 있어요.</div>',
								    type: 'error',
								    html:'<p>구성원 정보 :직무 </p>',
									    customClass: {
									      confirmButton: 'btn btn-primary'
									    },
									    buttonsStyling: false
									  }); 
				}else if(empvo != null && empvo.jobList[0].jnm == null && empvo.empAddr == null){
					 Swal.fire({
						    title: '<div class="text-danger"><i class="bx bx-lg bx-danger bx-error-circle"></i></div><div>증명서 발급에 필요한 정보 중 입력되지 않은 정보가 있어요.</div>',
						    type: 'error',
						    html:'<p>구성원 정보 :주소 , 직무</p>',
							    customClass: {
							      confirmButton: 'btn btn-primary'
							    },
							    buttonsStyling: false
							  }); 
				}else{
					
					issuanceOfPDF(empNo,cfNm);				
				}
				
				
			},
			error : function(errorResp) {

				console.log(errorResp.status);
			}

		});
		
  })



  
  
  
  
  
  
  
  


  // 경력 증명서 다운로드 버튼  

$('#empsaveCareePdfBtn').on("click",function(){

	
	
	
	if($('input[name=careeCerfRegCheck]').prop("checked") ){

		regCheck = "Y";
	}else{
		regCheck = "N";
	}
	
	let empNo = clickEmpNo;
//	let empNo = $(this).data("empno");
	let cfNm = "경력";
	console.log("empNo",empNo);
	$.ajax({

		url : "${pageContext.request.contextPath}/cerf/selectCerfInfo.do", //어디로
		method : "GET", //어떻게
		data : {empNo : empNo}, //무엇을
		dataType : "json",
		success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함

			console.log(resp.empVo);
			let message = "";
		   let empvo = resp.empVo;
		
			if( empvo == null){
				
	 			
				  Swal.fire({
				    title: '<div class="text-danger"><i class="bx bx-lg bx-danger bx-error-circle"></i></div><div>증명서 발급에 필요한 정보 중 입력되지 않은 정보가 있어요.</div>',
				    type: 'error',
				    html:'<p>구성원 정보 : 주조직</p>',
					    customClass: {
					      confirmButton: 'btn btn-primary'
					    },
					    buttonsStyling: false
					  }); 

					$("input[name=inlineRadioOptionsMyWorkCerf]").prop("checked",false);
					$("input[name=workCerfRegCheck]").prop("checked",false);
				
			}else if(empvo != null && empvo.empAddr == null){		
				 Swal.fire({
					    title: '<div class="text-danger"><i class="bx bx-lg bx-danger bx-error-circle"></i></div><div>증명서 발급에 필요한 정보 중 입력되지 않은 정보가 있어요.</div>',
					    type: 'error',
					    html:'<p>구성원 정보 :주소 </p>',
						    customClass: {
						      confirmButton: 'btn btn-primary'
						    },
						    buttonsStyling: false
						  }); 
				
			}else if(empvo != null && empvo.jobList[0].jnm == null){						
					
						 Swal.fire({
							    title: '<div class="text-danger"><i class="bx bx-lg bx-danger bx-error-circle"></i></div><div>증명서 발급에 필요한 정보 중 입력되지 않은 정보가 있어요.</div>',
							    type: 'error',
							    html:'<p>구성원 정보 :직무 </p>',
								    customClass: {
								      confirmButton: 'btn btn-primary'
								    },
								    buttonsStyling: false
								  }); 
			}else if(empvo != null && empvo.jobList[0].jnm == null && empvo.empAddr == null){
				 Swal.fire({
					    title: '<div class="text-danger"><i class="bx bx-lg bx-danger bx-error-circle"></i></div><div>증명서 발급에 필요한 정보 중 입력되지 않은 정보가 있어요.</div>',
					    type: 'error',
					    html:'<p>구성원 정보 :주소 , 직무</p>',
						    customClass: {
						      confirmButton: 'btn btn-primary'
						    },
						    buttonsStyling: false
						  }); 
			}else{
				
				issuanceOfPDF(empNo,cfNm,regCheck);				
			}
			
			
		},
		error : function(errorResp) {

			console.log(errorResp.status);
		}

	});
})







// pdf 생성
function issuanceOfPDF(empNo,cfNm,regCheck){
	
	console.log("cfNm",cfNm); 
	 
	
	let cfEmp = empNo; 
	
	let cfRsn = $("input[name=inlineRadioOptionsMyWorkCerf]:checked").val();	
	

	
	console.log("regCheck",regCheck);
	 
    $.ajax({

      url : "${pageContext.request.contextPath}/cerf/myWorkPDF.do", //어디로
      method : "GET", //어떻게
       data : {
    	 	 cfNm : cfNm,
			cfEmp : cfEmp,	
			cfRsn : cfRsn 
    	  
      },  //무엇을
      dataType : "json",
      success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
         
    	  let today = new Date();

    	  var year = today.getFullYear();
    	  var month = ('0' + (today.getMonth() + 1)).slice(-2);
    	  var day = ('0' + today.getDate()).slice(-2);

    	  let reToday = year + '년 ' + month  + '월 ' + day + '일';
    	  let PDFDownDate = year + '-' + month  + '-' + day ;
    	  
            console.log("cfNo",resp.cfNo);
            console.log("empVo",resp.empVo);
            console.log("result",resp.result);
            
			let empVo = resp.empVo;
      		let cerfpdf = ``;
      
      		let myName = empVo.empNm;
      		
      		
      		if(resp.result <= 0){
      			
      			toastr.errors('발급 내역 저장을 실패하였습니다. 다시 시도해 주세요 ')
      			
      		}else{
      		
      		// pdf 양식 	
      		cerfpdf = `
      			<div class="px-4  fw-bold text-dark" style="" >
      			   <div class="" >
      			   
      			  	
      			      <div class="cerfTitle" >\${cfNm}증명서</div>
      			      <div >
      			         
      			         <div class="table-responsive cerftablemargin"  >
      			         <div class="cerfTableTitle">기본정보</div>
      			              <table class="table text-dark cerfTableCss" >
      			                <tbody>
      			                  <tr class="cerfTableTr">
      			                    <td class="col-sm-3 cerfrightborder ">이름</td>
      			                    <td >\${empVo.empNm}</td>

      			                  </tr>
      			                  <tr class="cerfTableTr">
      			                    <td class="col-sm-3 cerfrightborder">생년월일</td>
      			                    <td >\${empVo.empBir}</td>

      			                  </tr> `;
      			                  
      			                  if(regCheck == 'Y'){
      			                	        			           
      			                	cerfpdf += `<tr class="cerfTableTr">
      				                    <td class="col-sm-3 cerfrightborder" >주민등록번호</td>
      				                    <td >\${empVo.regno1} - \${empVo.regno2}</td>
      				
      				               </tr>`;
      			                  }
      			                  
      			                  
      			                cerfpdf += ` 
      			                  <tr class="cerfTableTr">
      			                    <td class="col-sm-3 cerfrightborder">주소</td>
      			                    <td >\${empVo.empAddr }</td>

      			                  </tr>
      			                 
      			             </tbody>
      			           </table>
      			         </div>
      			       <div class="table-responsive cerftablemargin">
      			         <div class="cerfTableTitle" >재직정보</div>
      			              <table class="table text-dark cerfTableCss">
      			                <tbody>
      			                  <tr class="cerfTableTr">
      			                    <td class="col-sm-3 cerfrightborder">재직기간</td>
      			                    <td >\${empVo.entDate} ~ `; 
      			                    
      			                    if(cfNm == "재직"){
      			                    	if(empVo.outDate == null){
      			                      		cerfpdf += `현재`;      			                    		
      			                    	}else{
      			                      		cerfpdf += `\${empVo.outDate}`;
      			                    	}
      			                    }else if(cfNm == "경력"){
      			                    	if(empVo.outDate == null){      	      			                    		
      			                    		cerfpdf +=`\${reToday}`
      			                    	}else {      			                    		
      			                    		cerfpdf += `\${empVo.outDate}`;
      			                    	}
      			                    }
      			                    
      			                  cerfpdf += `  
      			                    	</td>
      			                  </tr>
      			                  <tr class="cerfTableTr">
      			                    <td class="col-sm-3 cerfrightborder">소속 및 직위</td>
      			                    <td >`
      			                    
      			                    $.each(empVo.deptList,function(index,dept){
      			                    	 cerfpdf += `\${dept.dnm}`
      			                    })
      			                    
      			                    
      			                  cerfpdf += `              
      			                     · \${empVo.ptnNm }</td>

      			                  </tr>
      			                  <tr class="cerfTableTr">
      			                    <td class="col-sm-3 cerfrightborder">직무</td>
      			                    <td >`;
      			                    
      			                    $.each(empVo.jobList,function(index,job){
      			                    	cerfpdf += ` \${job.jnm }`;
      			                    })
      			                    
      			                    
      			                  cerfpdf += `       			               
      			                    </td>
      			                  </tr>
      			             </tbody>
      			           </table>
      			         </div>
      			       <div class="table-responsive cerftablemargin">
      			         <div class="cerfTableTitle">회사정보</div>
      			              <table class="table text-dark cerfTableCss">
      			                <tbody>
      			                  <tr class="cerfTableTr">
      			                    <td class="col-sm-3 cerfrightborder">회사명</td>
      			                    <td >NABIS</td>

      			                  </tr>
      			                  <tr class="cerfTableTr">
      			                    <td class="col-sm-3 cerfrightborder">사업자등록번호</td>
      			                    <td >116-81-19948</td>

      			                  </tr>
      			                </tbody>
      			           </table>
      			         </div>
      			         <div class="table-responsive cerftablemargin">
      			         <div class="cerfTableTitle">발급용도</div>
      			              <table class="table text-dark cerfTableCss">
      			                <tbody>
      			                  <tr class="cerfTableTr">
      			                    <td class="" >\${cfRsn}</td>                
      			                  </tr>

      			                </tbody>
      			           </table>
      			         </div>
      			      </div>
      			         <div class="d-flex cerfTableCss cerfFooter">
      			         <div style="font-size: 1.2em">
      			            <div>위와 같이 재직 중임을 증명합니다.</div>
      			            <div>\${empVo.cfDate}</div>   
      			         </div>
      			         <div class="ms-auto d-flex ">
      			            <div class="fw-normal cerfComNm ">
      			               <div class="">회사명</div>
      			               <div class="">대표이사</div>
      			            </div>
      			            <div class="cerfComNm">
      			               <div class="">NABIS</div>
      			               <div class="">나비스</div>
      			            </div>
      			         </div>
      			      </div> 
      			      <div class="d-flex fw-bold position-relative stampmargin" >
      			      
      			         <img class="cerfStamp" alt="도장" src="${cPath}/resources/images/stamp.png">
      			         <div class="ms-auto cerfComNm cerfTableCss cerfFooter mb-5">(서명 인)</div>
      			      </div> 
      			   </div>   
      			</div>`;
      
      		$('#emppdfDivs').html(cerfpdf);
      	
           			 		
      		
      		
      	    html2canvas($('#emppdfDivs')[0], {
      	        onrendered: function (canvas) {
      	          let imgData = canvas.toDataURL('image/png');

                  let margin = 10; // 출력 페이지 여백설정
                  let imgWidth = 210 - (10 * 2); // 이미지 가로 길이(mm) A4 기준
                  let pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
                  let imgHeight = canvas.height * imgWidth / canvas.width;
                  let heightLeft = imgHeight;

                  let doc = new jsPDF('p', 'mm');
                  let position = margin;
                  
                  doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
      	       
      	         heightLeft -= pageHeight;
      	         while (heightLeft >= 20) {
      	            position = heightLeft - imgHeight;
      	            doc.addPage();
      	            doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
      	            heightLeft -= pageHeight;
      	           }
      	       doc.save('NABIS_'+cfNm+'증명서_'+myName+'_'+PDFDownDate+'.pdf');
      	     }
      	});
           
			          
			             
	      	  if(cfNm == '재직'){
		         	$('#empModalWorkCerf').modal("hide");    
		        	
		        }else if(cfNm == '경력'){
		         	$('#empModalCareeCerf').modal("hide");    
		        	
		        }	  
				              
                
      		}   
      
      },
      error : function(errorResp) {

         console.log(errorResp.status);
      }

   });  
          
	
	
}

  
  
  
  
  
//발급내역    
$('.empCerfHistryBtn').on("click",function(){
	
	let cfEmp =  $(this).data("empno");
	
	let cfNm =  $(this).data("cfnm");
	
	$.ajax({

		url : "${pageContext.request.contextPath}/cerf/empCerfSelect.do", //어디로
		method : "GET", //어떻게
		data : {cfEmp : cfEmp}, //무엇을
		dataType : "json",
		success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함

		  	let workCerfList = ``;       
			console.log(resp)
			 
			if(resp.length > 0){
			
		        $.each(resp,function(index,cerf){
	        		if(cerf.cfNm == cfNm){
	        			
				        workCerfList += `					        			
				        	     <tr>
				                      <td>\${cerf.cfNo}</td>
				                      <td>\${cerf.cfRsn}</td>
				                      <td>\${cerf.cfDate}</td>
					              </tr>
				    	   `;
	        			
	        		}	    
		  		        		
		          });    
			
			}else{
				 workCerfList += `	
				 
			
				 <tr class="px-5">
					 <td colspan="3" class="py-5 my-5 text-secondary" ><div class="text-center pt-4 pb-2"><i class="bx bx-error-circle bx-md"></i></div>
					 					<div class="pb-5 text-center">발급 내역이 없습니다.</div>
					 </td>
				 </tr>
				 
		
				 `;
			}
	        

			$('#exampleModalLabelempCerfWork').text( cfNm+"증명서");
			$('#empWorkTbody').html(workCerfList); 
			
			
		},
		error : function(errorResp) {

			console.log(errorResp.status);
		}

	});
	
	
})  
  
  
  
  


</script>


