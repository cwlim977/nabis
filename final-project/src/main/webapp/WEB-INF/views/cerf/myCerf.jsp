<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="${cPath}/resources/js/jspdf.min.js"></script>
<script src="${cPath}/resources/js/html2canvas.js"></script>
<script>
	
	let empRole = "${requestScope['empRole']}";
	
	$('.headerMenu, .headerSubMenu').each(function(){
		switch($(this).attr('id')){
			case 'menu1':
				$(this).find('span').addClass('text-dark');
				break;
			case 'subMenu1':
				$(this).find('span').addClass('text-dark');
				break;
			case 'subMenu2':
				if(!(empRole == 'admin' || empRole == 'manager')) $(this).hide();
				break;
		}
	});
</script>

<link rel="stylesheet" href="${cPath }/resources/css/jhy.css" />

 <style>
 #pdf {
 overflow: hidden; height: 0; 

} 
</style>  


<div class="row">
				  <div class="col-md px-5 pe-3">
				    <div class="card mb-3  border cerfCardHover ">
				      <div class="row g-0">
				        <div class="">
				          <div class="card-body">
				            <h4 class="card-title fw-bold mb-5">재직 증명서</h4>
				            <p class="card-text">
				            <c:set var="today" value="<%=new java.util.Date()%>" />
				            <span class="badge bg-label-primary">재직기간</span><small class="text-muted">${empVO.entDate} ~ <fmt:formatDate value="${today}" pattern="yyyy.MM.dd" /> (${empVO.tneurePeriod}) 재직</small>
				         </p>   
				
				          <button class="btn btn-success" id="workCerfModalBtn" data-bs-toggle="modal" data-bs-target="#basicModalWorkCerf"><i class='bx bx-file'></i>발급 신청하기</button>
				  <!--  savePdfBtn -->
						      <div class="divider text text-success">
						        <div class="divider-text"><i class='bx bx-md bxs-check-circle' ></i></div>
						      </div>
						                
						       <div class="card mt-4 border " style="height: 391px;">
						        <h6 class="card-header border-bottom bg-light  fw-bold"><i class='bx bx-calendar-check'></i>발급 내역</h6>
						        <div class="table-responsive offcanvas-scrollbar myCerfScroll ">
						          <table class="table card-table table-hover ">
						            <thead>
						              <tr>
						              		<th class="fs-6">파일번호</th>
						                   <th class="fs-6">발급 사유</th>
						                   <th class="fs-6">날짜</th>
						                   
						              </tr>
						            </thead>
						            <tbody  id="workCerfListTable">
						            <c:forEach items="${cerfList}" var="cerf" >
						            	<c:if test="${cerf.cfNm eq '재직'}">
							              <tr>
						                      <td>${cerf.cfNo}</td>
						                      <td>${cerf.cfRsn}</td>
						                      <td>${cerf.cfDate}</td>
							              </tr>
						       			</c:if>
									</c:forEach>
						            </tbody>
						          </table>
						        </div>
						      </div>
				          </div>
				        </div>
				      </div>
				    </div>
				  </div>
				  
				  
				  
				  
				  
					
					<!-- 재직 Modal -->
					<div class="modal fade" id="basicModalWorkCerf" tabindex="-1" aria-hidden="true">
					  <div class="modal-dialog" role="document">
					    <div class="modal-content">
					      <div class="modal-header border-bottom pb-3">
					        <h5 class="modal-title " id="exampleModalLabel1">재직 증명서 발급</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					       <form:form id="">
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
							</form:form>						    					
					        <!-- <textarea id="text" rows="3" class="form-control mt-3 workCerftext"></textarea> -->
					      </div>
					      <div class="modal-footer">
					        <div class="d-grid gap-2 col-12 mx-auto">
							  <button class="btn btn-success btn-md" id="saveWorkPdfBtn" type="button" data-empno="${empNo}"  ><i class='bx  bxs-download' ></i>다운로드</button>				
							</div>
					      </div>
					    </div>
					  </div>
					</div>
									  
									  
									  
				  
				  
				  
				  <!-- 경력 증명서  -->
				  <div class="col-md px-5 ps-3">
				    <div class="card mb-3 border cerfCardHover">
				      <div class="row g-0">
				        <div class="">
				          <div class="card-body">
				            <h4 class="card-title fw-bold mb-5">경력 증명서</h4>
				            <p class="card-text">
				            <span class="badge bg-label-primary">재직기간</span><small class="text-muted">${empVO.entDate} ~ <fmt:formatDate value="${today}" pattern="yyyy.MM.dd" /> (${empVO.tneurePeriod}) 재직</small>
				         </p>   
				
				          <button class="btn btn-success" id="CareeCerfModalBtn" data-bs-toggle="modal" data-bs-target="#basicModalCareeCerf"><i class='bx bx-file'></i>발급 신청하기</button>
				   
						      <div class="divider text text-success">
						        <div class="divider-text"><i class='bx bx-md bxs-check-circle' ></i></div>
						      </div>
						                
						       <div class="card mt-4 border " style="height: 391px;">
						        <h6 class="card-header border-bottom bg-light  fw-bold"><i class='bx bx-calendar-check'></i>발급 내역</h6>
						        <div class="table-responsive offcanvas-scrollbar myCerfScroll">
						          <table class="table card-table table-hover ">
						            <thead>
						              <tr>
						                   <th class="fs-6">날짜</th>
						                   <th class="fs-6">발급 사유</th>
						                   <th class="fs-6">파일</th>
						              </tr>
						            </thead>
						            <tbody id="CareeCerfListTable">
						            <c:forEach items="${cerfList}" var="cerf" >
						            	<c:if test="${cerf.cfNm eq '경력'}">
							              <tr>
						                      <td>${cerf.cfNo}</td>
						                      <td>${cerf.cfRsn}</td>
						                      <td>${cerf.cfDate}</td>
							              </tr>
						       			</c:if>
									</c:forEach>
						
						            </tbody>
						          </table>
						        </div>
						      </div>
				          </div>
				        </div>
				      </div>
				    </div>
				  </div>
  				</div>

				
				<!-- 경력 modal -->
				<div class="modal fade" id="basicModalCareeCerf" tabindex="-1" aria-hidden="true">
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
							  <button class="btn btn-success btn-md" id="saveCareePdfBtn" type="button" data-empno="${empNo}"><i class='bx  bxs-download' ></i>다운로드</button>				
							</div>
					      </div>
					    </div>
					  </div>
					</div>
									  
									  




			<div id="pdf">
			       <div id="pdfDivs" > 
			   			
			      </div>   
			</div>


<script>

 
$('.cerfCardHover').hover(function(){
     $(this).addClass('shadow');
     $(this).addClass('border-primary');
 }, function() {
     $(this).removeClass('shadow');
     $(this).removeClass('border-primary');
}); 

  //check box 초기화
$('#workCerfModalBtn').on("click",function(){
	$("input[name=inlineRadioOptionsMyWorkCerf]").prop("checked",false);
	$("input[name=workCerfRegCheck]").prop("checked",false);
	
	
});
$('#CareeCerfModalBtn').on("click",function(){
	$("input[name=inlineRadioOptionsMyWorkCerf]").prop("checked",false);
	$("input[name=careeCerfRegCheck]").prop("checked",false);
	
	
});
 
 
 // 재직 증명서 발급 
$('#saveWorkPdfBtn').click(function() {
	  
	
		let empNo = $(this).data("empno");
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
 let regCheck = "";
$('#saveCareePdfBtn').on("click",function(){

	
	
	
	if($('input[name=careeCerfRegCheck]').prop("checked") ){

		regCheck = "Y";
	}else{
		regCheck = "N";
	}
	
	let empNo = $(this).data("empno");
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
      			                    <td class="col-sm-3 cerfrightborder">이름</td>
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
      			</div>
      		
      		
      		`;
      
      		$('#pdfDivs').html(cerfpdf);
      	
           			 		
           
			             html2canvas($('#pdfDivs')[0]).then(function(canvas) {
                          // 캔버스를 이미지로 변환
                          let imgData = canvas.toDataURL('image/png');

                          let margin = 10; // 출력 페이지 여백설정
                          let imgWidth = 210 - (10 * 2); // 이미지 가로 길이(mm) A4 기준
                          let pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
                          let imgHeight = canvas.height * imgWidth / canvas.width;
                          let heightLeft = imgHeight;

                          let doc = new jsPDF('p', 'mm');
                          let position = margin;

                          // 첫 페이지 출력
                          doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
                          heightLeft -= pageHeight;

                          // 한 페이지 이상일 경우 루프 돌면서 출력
                          while (heightLeft >= 20) {
                              position = heightLeft - imgHeight;
                              doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                              doc.addPage();
                              heightLeft -= pageHeight;
                          }

                          // 파일 저장
                          doc.save('NABIS_'+cfNm+'증명서_'+myName+'_'+PDFDownDate+'.pdf');
                      });    
			             
			             
			       	let workCerfList = ``;       
			        $.each(resp.cerfList,function(index,cerf){
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
			        
			         
			        if(cfNm == '재직'){
			         	$('#basicModalWorkCerf').modal("hide");    
			        	 $('#workCerfListTable').html(workCerfList);  
			        }else if(cfNm == '경력'){
			         	$('#basicModalCareeCerf').modal("hide");    
			        	 $('#CareeCerfListTable').html(workCerfList);  
			        }	 
			               
                
      		}   
      
      },
      error : function(errorResp) {

         console.log(errorResp.status);
      }

   });  
          
	
	
}
</script>