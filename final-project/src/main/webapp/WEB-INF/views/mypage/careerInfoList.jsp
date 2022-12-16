<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>   
   <div class="empFormheader"> 
   	<div class="mypagetablewidth">
		<div class="card shadow-none ">
		<div class="arcodiancheck">
          <h5 class="card-header pt-2 ps-3 fs-4 fw-bold">경력</h5>
    		 <div class="dropdown p-4 py-0 empaddbutton">
                            
                            
                           
                    
                      	<div class="mt-3">
                            <button type="button" class="btn p-0 " data-bs-toggle="offcanvas"  data-bs-target="#offcanvasBothCareer"
                          		aria-controls="offcanvasBoth" id="careerBtn" data-empno="${empVo.empNo }">
                             <i class='bx bxs-pencil' ></i>
                            </button>

                        <div
                          class="offcanvas offcanvas-end mypagetoggle w-px-600"
                          data-bs-scroll="false"
                      
                          tabindex="-1"
                          id="offcanvasBothCareer"
                          aria-labelledby="offcanvasBothLabel"
                        >
                          <div class="offcanvas-header">
	                            <h4 id="offcanvasBothLabel" class="offcanvas-title">경력 수정</h4>
	                            <button
	                              type="button"
	                              class="btn-close text-reset"
	                              data-bs-dismiss="offcanvas"
	                              aria-label="Close"
	                            ></button>
                          </div>
                          
                          <!-- 경력 수정,추가 토글 -->
                        <div class="offcanvas-body my-0 mx-0 flex-grow-0" >
                      
                          
                          
		                  <div class="accordion mt-3" id="accordionExample">
		                  
		                  <!-- 경력 추가 폼 -->
		                    <div class="card accordion-item active">
		                      <h2 class="accordion-header careerlineh" id="headingOne">
		                        <button
		                          type="button"
		                          class="accordion-button"
		                          data-bs-toggle="collapse"
		                          data-bs-target="#insertAccordion"
		                          aria-expanded="true"
		                          aria-controls="insertAccordion"
		                          id="insertAccordianBtn"
		                        >
		                         <i class='bx-fw bx bxs-plus-circle bx-md careericon'></i>경력 추가하기
		                        </button>
		                      </h2>
								
		                      <div
		                        id="insertAccordion"
		                        class="accordion-collapse collapse show"
		                        data-bs-parent="#accordionExample"
		                        aria-labelledby="panelsStayOpen-headingOne"
		                      >
		                        <div class="accordion-body">
							<form:form  id="careerInsertForm">
		                        
		                        
				                    <div class=" arcodiancheck mb-2 mt-3"> 
			                            <div class="basicnamediv ">
					                        <label for="caNmInput" class="form-label">회사명</label>
					                        <input 
					                          type="text"
					                          class="form-control"
					                          id="caNmInput"
					                          placeholder="회사명 입력"
					                          aria-describedby="defaultFormControlHelp"
					                          value=""
					                          name="caNm"
					                          required="required"
					                        />
					       
			                            </div>  
			
			                           	<div class=" basicnamediv m-0">
				                           <label for="cntSelect" class="form-label">계약 유형</label>
				                           
					                      <!--   <select id="defaultSelect" class="form-select"> -->
					                        <select name="caCntcase" id="cntSelect"  class=" selectpicker form-control "  required="required"  data-style="border" >
					                        <option selected="selected" value="" >--계약 유형 선택--</option>
						                         <c:forEach items="${LaborCaseList}" var="labor">
						                         	<option value="${labor.codeNm }">${labor.codeNm }</option>
							                     </c:forEach>    
					                        	
						                    </select>
					                       
                   						</div>
									</div>

				                    <div class=" arcodiancheck mb-2 mt-3"> 
					                            
			                            <div class="basicnamediv">
					                        <label for="caEtdateInput" class="form-label">입사</label>
					                        <div class="">
					                          <input class="form-control" type="date" value="" id="caEtdateInput" name="caEtdate" required="required" />
					                        </div>
                      					</div>



			                            <div class="basicenglishname mb-4 me-0">
					                        <label for="caEdateInput" class="form-label">퇴사</label>
					                        <div class="">
					                          <input class="form-control" type="date" value="" id="caEdateInput" name="caEdate" required="required"/>
					                        </div>
                      					</div>
			                            
			                        
									</div>
									
									
									<div class="mb-4">
				                        <label for="caJboInput" class="form-label">직무</label>
				                        <input id="caJboInput" class="form-control" type="text" placeholder="직무 입력" name="caJob" />
                      				</div>
                      				
									<div class="mb-4">
				                        <label for="caDeptInput" class="form-label">조직</label>
				                        <input id="caDeptInput" class="form-control" type="text" placeholder="조직 입력" name="caDept"/>
                      				</div>
                      				
									<div class="mb-4">
				                        <label for="caGrdInput" class="form-label">직위</label>
				                        <input id="caGrdInput" class="form-control" type="text" placeholder="직위 입력" name="caGrd" />
                      				</div>
                      				
                      				<input type="hidden" value="${empVo.empNo }" name="empNo" id="empNoInput">
                      				
                      				   <div class="arcodiancheck">

                          			  <button type="button" class="btn btn-primary mb-2  w-40" id="careerInsertBtn" >경력 추가하기</button>
                          			  <button id="autoBtn" type="button" class="btn btn-icon mb-2  btn-label-primary ms-auto" onclick="dataAutoInput1();">
		                       		 <span class="tf-icons bx bx bxs-edit-alt"></span>
		                       </button>
                      				 </div>     
		                      </form:form>

		                        </div>
		                      </div>
		                    </div>
		                    
		                    
		                    
		                    <!-- 작성된 경력 수정폼 -->	
		                    <div id="careerInputDiv">                 
 
			              		</div>
							
			                  </div>
                          
		           
                          </div>
                        </div>
                      </div>
          

              		</div>
            	</div>
            	
            	
            	<!-- 경력 테이블 -->
			<div class="table-responsive text-nowrap">
                  <table class="table table-borderless h-px-150">
                    <thead>
              
            
                    </thead>
                    <tbody id="careerTable">

                    </tbody>
                  </table>
               
                
               
                  </div> 
            </div>      
            
            <!-- 학력  -->
		<div class="card shadow-none ">
		<div class="arcodiancheck">
          <h5 class="card-header pt-5 ps-3 fs-4 fw-bold">학력</h5>
          
         <div class="dropdown p-4 py-0 pt-5 empaddbutton">
                            
                        <div class="mt-3">
                            <button type="button" class="btn p-0 " data-bs-toggle="offcanvas" id="acUpdateBtn" data-bs-target="#offcanvasBoth2"
                          		aria-controls="offcanvasBoth">
                             <i class='bx bxs-pencil' ></i>
                            </button>
                           
                    
                      	 <div
                          class="offcanvas offcanvas-end mypagetoggle w-px-600"
                          data-bs-scroll="false"
                          tabindex="-1"
                          id="offcanvasBoth2"
                          aria-labelledby="offcanvasBothLabel2"
                        >
                          <div class="offcanvas-header">
	                            <h4 id="offcanvasBothLabel2" class="offcanvas-title">학력 수정</h4>
	                            <button
	                              type="button"
	                              class="btn-close text-reset"
	                              data-bs-dismiss="offcanvas"
	                              aria-label="Close"
	                            ></button>
                          </div>
                          
                          <!-- 학력 수정 추가 토글 -->
                          <div class="offcanvas-body h-100 my-0 mx-0 flex-grow-0" >
                       
                          
                          
		                  <div class="accordion mt-3" id="accordionExamplecareer">
		                    <div class="card accordion-item active" id="activeClass">
		                      <h2 class="accordion-header careerlineh" id="headingOne2">
		                        <button
		                          type="button"
		                          class="accordion-button"
		                          data-bs-toggle="collapse"
		                          data-bs-target="#accordionOne2"
		                          aria-expanded="true"
		                          aria-controls="accordionOne2"
		                          id="collBtn"
		                        >
		                         <i class='bx-fw bx bxs-plus-circle bx-md careericon' ></i>학력 추가하기
		                        </button>
		                      </h2>
		
		                      <div
		                        id="accordionOne2"
		                        class="accordion-collapse collapse show"
		                        data-bs-parent="#accordionExamplecareer"
		                        aria-labelledby="panelsStayOpen-headingOne2"
		                      >
		                      
		                      
		                      <div class="accordion-body" >
		                        
		           		 	<form id="acInputForm">
		                        
                 				<label for="school" class="form-label">학교</label>
                     			 <div class="row" id="school">
                     			 	 <div class="col-sm-4 pe-0" >
                     			 	 	<div class="form-group">
									      <select class="selectpicker form-control show-tick"  data-style="border" name="acClf">
									        <option value="" selected="selected"  >구분</option>
							       				 <c:forEach items="${acClfList}" var="ac">
						                         	<option value="${ac.codeNm }">${ac.codeNm }</option>
							                     </c:forEach>  
									     
									      </select>
									      	
									    </div>					 
									  </div>
									  <div class="col-sm-8 ps-0">
									<input type="text" class="form-control " name="acNm" placeholder="학교명 입력"/>
									</div>	
                     			 </div>
		                                    
				                    <div class=" arcodiancheck mb-2 mt-3"> 
			                            <div class="basicnamediv ">
			                             <label for="defaultSelect" class="form-label">졸업구분</label>
					                       <select class="selectpicker form-control show-tick" data-style="border" name="gradClf">
									        <option value="" selected="selected"  >구분 선택</option>
						                         <c:forEach items="${gradeClfList}" var="grade">
						                         	<option value="${grade.codeNm }">${grade.codeNm }</option>
							                     </c:forEach>  
					                        </select>					                       	       
			                            </div>  
			
			                           	<div class=" basicenglishname mb-4 me-0">
				                           <label for="defaultInput" class="form-label">전공</label>
				                       		 <input id="defaultInput" class="form-control" type="text" name="maj" placeholder="전공 입력" />
                   						</div>
									</div>


				                    <div class=" arcodiancheck mb-2 mt-3"> 
					                            
			                            <div class="basicnamediv">
					                        <label for="defaultFormControlInput" class="form-label">입학</label>
					                        <div class="">
					                          <input class="form-control" type="date"  name="acEtdate" value="" id="defaultFormControlInput" />
					                        </div>
                      					</div>



			                            <div class="basicenglishname mb-4 me-0">
					                        <label for="defaultFormControlInput" class="form-label">졸업</label>
					                        <div class="">
					                          <input class="form-control" type="date" value=""  name="acEdate" id="defaultFormControlInput" />
					                        </div>
                      					</div>
			                            
			                        
									</div>
       								<input type="hidden" value="${empVo.empNo}" name="empNo" />
                      				   <div class="arcodiancheck">

                          			  <button type="button" class="btn btn-primary mb-2  w-40 " id="gradeInsertBtn">학력 추가하기</button>
                          			  <button id="autoBtn" type="button" class="btn btn-icon mb-2  btn-label-primary ms-auto" onclick="dataAutoInput2();">
                          			  <span class="tf-icons bx bx bxs-edit-alt"></span>
                          			  </button>
                      				 </div>     
                        
		                     	  </form>
		                        </div>
		                      </div>
		                    </div>
		                    
		                    
		                    
		                    <!-- 작성된 학력 -->
		                    <div id="accaDiv">
		                   
							</div>
		                  </div>
                         
                         </div>
                       </div>
            		</div>				
					</div>	
            
                
                 </div>
                      
                      <!-- 학력  테이블 -->
							<div class="table-responsive text-nowrap">
				                  <table class="table table-borderless h-px-150">
				                    <thead>
				              
				            
				                    </thead>
				                    <tbody id="accaTbody">

				                    </tbody>
				                  </table>
				                </div>

			       			</div>
			            </div>
            
            
               
            	

            <c:if test="${empRole eq 'admin' || empRole eq 'manager' ||  authEmp.empNo eq empVo.empNo}">
             <div class="col-md-6 col-xl-4 mypagerightwidth">
                  <div class="card shadow-none bg-transparent border border-secondary mb-4 mypagecardheigh">
                    <div class="card-body cntcard mt-5 pb-4">
                    <div>
                      <span class="card-title">근무시간</span>
                      <h4 class="card-text"><span>0</span>분</h4>
                    </div>
                    <div class="cnticon">
                    	<i class='bx bxs-user bx-md cnti'></i>
                    </div>
                    </div>
                  </div>

                  <div class="card shadow-none bg-transparent border border-secondary mb-4 mypagecardheigh">
                    <div class="card-body cntcard mt-5 pb-4">
                    <div>
                      <span class="card-title">남은 연차</span>
                      <h4 class="card-text"><span>0</span>일</h4>
                    </div>
                    <div class="cnticon">
                    	<i class='bx bxs-user bx-md cnti'></i>
                    </div>
                    </div>
                  </div>

                  <div class="card shadow-none bg-transparent border border-secondary mb-4 mypagecardheigh">
                    <div class="card-body cntcard mt-5 pb-4">
                    <div>
                      <span class="card-title">급여</span>
                      <h4 class="card-text"><span>11</span>월 급여 명세서</h4>
                    </div>
                    <div class="cnticon">
                    	<i class='bx bxs-user bx-md cnti'></i>
                    </div>
                    </div>
                  </div>
                  
                  
             </div>
             </c:if>
                
   </div>
   
<script>

function dataAutoInput1() {

	$('input[name=caNm]').val('NABIS 유한회사');	
	$('select[name=caCntcase]').selectpicker('val','정규직근로자');
	$('input[name=caEtdate]').val('2007-03-23');	
	$('input[name=caEdate]').val('2010-06-17');	
	$('input[name=caJob]').val('대표이사');	
	$('input[name=caDept]').val('이사회');	
	$('input[name=caGrd]').val('이사회 ');	
	
};
function dataAutoInput2() {

	$('select[name=acClf]').selectpicker('val','대학원(석사)');
	$('input[name=acNm]').val('서울대학교 대학원');	
	$('select[name=gradClf]').selectpicker('val','졸업');
	$('input[name=maj]').val('컴퓨터공학과');	
	$('input[name=acEtdate]').val('2015-03-23');	
	$('input[name=acEdate]').val('2020-02-17');	
		
	
};



$(function() { // script를 제일 마지막에 읽어라 
	

//console.log(laborList);
let empNo = ${empVo.empNo};
selectCareerList(empNo);
selectAccaList(empNo);

let careerForm = $('#careerInsertForm');
let careerTable = $('#careerTable');
let acInputForm = $('#acInputForm');


let cntCaseList;
let gradeClfList;
let acClfList;

$.ajax({

	url : "${pageContext.request.contextPath}/mypage/careerList.do", //어디로
	method : "GET", //어떻게
	dataType : "json",
	success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
		console.log("careerList resp : ", resp);
	
	    cntCaseList = resp.cntCaseList;
	    gradeClfList = resp.gradeClfList;
	    acClfList = resp.acClfList
		
	    console.log(cntCaseList);
	    console.log(gradeClfList);
	    console.log(acClfList);
	},
	error : function(errorResp) {

		console.log(errorResp.status);
	}

});


//경력 수정, 추가 버튼 (초기화 )
$('#careerBtn').on("click",function(){
	careerForm[0].reset();
	$('#cntSelect').selectpicker('val','')
	selectInputView(empNo);


})


// 학력 수정, 추가 버튼(초기화)
$('#acUpdateBtn').on("click",function(){
	acInputForm[0].reset();
	$('select[name=acClf]').selectpicker('val','');
	$('select[name=gradClf]').selectpicker('val','');
	
/* 	let div = $('#activeClass');
	if(!div.hasClass('active')){
		$('#collBtn').removeClass('collapsed');
		div.addClass('active');
	} */
	updateAccaFrom();
})

$('.basicdeletbtnHide').on("click",function(){
	$('#deleteBtn').hide();
})

$('.basicdeletebtnShow').on("click",function(){
	$('#deleteBtn').show();
})


$('.basicdeletbtnHide2').on("click",function(){
	$('#deleteBtn2').hide();
})

$('.basicdeletebtnShow2').on("click",function(){
	$('#deleteBtn2').show();
})


//careerList ajax ====================================================================================================
function selectCareerList(){

	
	
	$.ajax({

		url : "${pageContext.request.contextPath}/mypage/selectCareerList.do", //어디로
		method : "GET", //어떻게
		data : {empNo:empNo}, //무엇을
		dataType : "json",
		success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
			let careerTable = $('#careerTable');
			let careerListHtml = ``;
			console.log(resp)
			
			if(resp.length == 0){
				
				 careerListHtml = `
					<tr>
             		<td></td>
             		<td style="text-align: center"><i class='bx bx-info-circle bx-sm' ></i><br> 경력 정보가 없습니다.</td>
             		</tr>

             		
             		`;
             		
				 careerTable.append(careerListHtml); 		
			}
			
		
			$.each(resp,function(index,car){
				
				
				 careerListHtml +=  `		
				
	                    <tr>
		                  	<td class="tdwidth" >\${car.caCntcase} </td> 
		                  	<td>
		                  	
			                  	<span>\${car.caNm }</span> | <span>\${car.caEtdate } ~ \${car.caEdate } `;
			                  	
			                  		console.log(car.caPeriod);
			                  		if(car.caPeriod != null){
			                  			 careerListHtml += `(\${car.caPeriod})`
			                  			 
			                  		}
			
			                  	 careerListHtml += `</span><br>`;
			                  	 
			                  	if(car.caJob != null && car.caGrd != null && car.caDept == null){
			                  		
			       					 careerListHtml += `<span class="badge bg-label-dark me-1">\${car.caJob }</span>
			       										<span class="badge bg-label-dark">\${car.caGrd }</span><br>`;
			       										
			                  	}else if(car.caGrd != null && car.caGrd == null && car.caDept == null){
                 					careerListHtml += `<span class="badge bg-label-dark me-1">\${car.caJob }</span>`;
                 					
			                  	}else if( car.caGrd == null && car.caGrd != null && car.caDept != null){
			                  		careerListHtml += `<span class="badge bg-label-dark">\${car.caGrd }</span><br>
			                  							<span>\${car.caDept}</span>`;
			                  							
			                  	}else if( car.caGrd == null && car.caGrd == null && car.caDept != null){
			                  		careerListHtml += `<span>\${car.caDept}</span>`;
			                  		
			                  	}else if(car.caGrd != null && car.caGrd == null && car.caDept != null){
			                  		 careerListHtml += `<span class="badge bg-label-dark me-1">\${car.caJob }</span><br>
    													<span>\${car.caDept}</span>`;
			                  	}
			                  	careerListHtml += `     	</td>
	                 	</tr>
		                
		          `;
		           
		          
		         console.log(car.caNm) ;
			           	          
				})
		         careerTable.html(careerListHtml); 		
				
		},
		error : function(errorResp) {

			console.log(errorResp.status);
		}

	});
	
} 



// 하나의 career 레코드 출력 ==================================================================================== 
 function selectCareer(caNo){
	
	
	$.ajax({

		url : "${pageContext.request.contextPath}/mypage/selectCareerView.do", //어디로
		method : "GET", //어떻게
		data : {caNo : caNo}, //무엇을
		dataType : "json",
		success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
			console.log("selectCareer함수 resp 값", resp);
		
			let newCareer = `
				    <tr>
		              	<td class="tdwidth" >\${resp.caCntcase} </td> 
		              	<td>		              	
		                  	<span>\${resp.caNm }</span> | <span>\${resp.caEtdate } ~ \${resp.caEdate } (\${resp.caPeriod })</span><br>
		                  	<span class="badge bg-label-dark me-1">\${resp.caJob }</span> <span class="badge bg-label-dark">\${resp.caGrd }</span><br>
		                  	<span>\${resp.caDept}</span>
		              	</td>
         			</tr>
			 
			 ` ;
			
			careerTable.prepend(newCareer);
			
			
		},
		error : function(errorResp) {

			console.log(errorResp.status);
		 }

	 });
	
}

//경력
function selectInputView(){
	

	let careerInputDiv = $('#careerInputDiv');
	console.log("cntCaseList가 잘 담겨 왔는지 확인 : ",cntCaseList)
	
	$.ajax({

		url : "${pageContext.request.contextPath}/mypage/selectCareerList.do", //어디로
		method : "GET", //어떻게
		data : {empNo : empNo}, //무엇을
		dataType : "json",
		success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
			
			console.log("selectInputView resp값 :", resp);
		//	let cntCase = resp.caCntcase;
		 
		//	console.log("cntCase 값", cntCase);
			let i = 1;
			let careerInput = ``;
			$.each(resp,function(index,car){
				
			careerInput +=  `
			
				<div class="card accordion-item mb-2">
                <h2 class="accordion-header" id="careerHeading\${i}">
                  <button
                    type="button"
                    class="accordion-button  collapsed"
                    data-bs-toggle="collapse"
                    data-bs-target="#careerAccordion\${i}"
                    aria-expanded="false"
                    aria-controls="careerAccordion\${i}"
                    
                  >
                     
                    <div class="d-flex align-self-center align-items-center">
						<img src="${cPath}/resources/images/company.png" /*  */
							alt="Avatar" class="empListimgradius mypagecareerimgsize">
						<div class="mx-3 ">
							<div>\${car.caNm}</div> 
							<div><span class="fs-tiny">\${car.caEtdate} ~ \${car.caEdate}`
							
							if(car.caPeriod != null){
								
				careerInput +=  `(\${car.caPeriod})`
								
							}
			careerInput +=  `</span></div>
						</div>	
																	
					</div>         
                  </button>
                </h2>
                <div
                  id="careerAccordion\${i}"
                  class="accordion-collapse collapse"
                  aria-labelledby="careerHeading\${i}"
                  data-bs-parent="#accordionExample1"
                >
                <form>
                  <div class="accordion-body">
                  <div class=" arcodiancheck mb-2 mt-3"> 
                      <div class="basicnamediv ">
	                        <label for="defaultFormControlInput" class="form-label">회사명</label>
	                        <input
	                          type="text"
	                          class="form-control"
	                          id="defaultFormControlInput"
	                          placeholder="이름"
	                          aria-describedby="defaultFormControlHelp"
	                          value="\${car.caNm}"
	                          name="caNm"
	                        />
	       
                      </div>  

                         	<div class=" basicenglishname mb-4 me-0">
	                       
     						 <label for="cntSelect" class="form-label">계약 유형</label>
		                    
		                        <select name="caCntcase"   class="  form-control "  data-style="border" >
		                        <option value="" >--계약 유형 선택--</option>
			                    `  ;
			                         
			                         $.each(cntCaseList,function(index,labor){
			                       
			                        	 console.log(car.caCntcase);
			                        	 
			                        	if(labor.codeNm == car.caCntcase){
			                        		
			                        	 careerInput += `<option selected="selected" value="\${labor.codeNm }">\${labor.codeNm }</option> `;
			                        		
			                        	}else{
			                        		
			                        	 careerInput += `<option value="\${labor.codeNm }">\${labor.codeNm }</option> `;
			                        		
			                        	}
			                        	 
			                        	 
			                         })
			                        	
			                                           
			                         
				                   
		                careerInput += `	
			                    </select>
     						</div>
     										
	                           
						</div>

	                    <div class=" arcodiancheck mb-2 mt-3"> 
		                            
                          <div class="basicnamediv">
		                        <label for="defaultFormControlInput" class="form-label">입사</label>
		                        <div class="">
		                          <input class="form-control" type="date" value="\${car.caEtdate}" name="caEtdate" id="defaultFormControlInput" />
		                        </div>
        					</div>



                          <div class="basicenglishname mb-4 me-0">
		                        <label for="defaultFormControlInput" class="form-label">퇴사</label>
		                        <div class="">
		                          <input class="form-control" type="date" value="\${car.caEdate}" name="caEdate" id="defaultFormControlInput" />
		                        </div>
        					</div>
                          
                      
						</div>
						<div class="mb-4">
	                        <label for="defaultInput" class="form-label">직무</label>
	                        <input id="defaultInput" class="form-control" type="text" name="caJob" value=" `;
	                        if(car.caJob != null){
	                        	careerInput	+= car.caJob;
	                        }
	                       
	        careerInput	+= `" placeholder="직무 입력" />
        				</div>
        				
						<div class="mb-4">
	                        <label for="defaultInput" class="form-label">조직</label>
	                        <input id="defaultInput" class="form-control" type="text" name="caDept" value=" `;
	                        if(car.caDept != null){	                        	
	                        	careerInput += car.caDept
	                        }
	    	careerInput +=	`" placeholder="조직 입력" />
        				</div>
        				
						<div class="mb-4">
	                        <label for="defaultInput" class="form-label">직위</label>
	                        <input id="defaultInput" class="form-control" type="text" name="caGrd" value="`;                      
	                        if(car.caGrd != null){	                        	
	                        	careerInput += car.caDept
	                        }
	    	careerInput +=	` " placeholder="직위 입력" />
        				</div>
        				
        				<input type="hidden" value="\${car.caNo}" name="caNo" />
        				
        				   <div class="arcodiancheck">

            			  <button type="button" class="btn btn-primary mb-2  w-40 careerUpdateBtn " >수정하기</button>
            			  <button type="button" class="btn btn-icon btn-outline-danger empaddbutton careerDeleteBtn" data-cano="\${car.caNo}">
                           <i class='bx bxs-trash-alt'></i>
                  	 </button>
        				 </div> 
        				 
        				 
                      </div>
                      </form>
                    </div>
                  </div>
			
	
			
			`;
				
				
			i++;
			
			})
			
			careerInputDiv.html(careerInput);
			$('select').selectpicker();
			
			
			
		
			
			
		},
		error : function(errorResp) {

			console.log(errorResp.status);
		}

	});
	
} 




// 경력 수정
$(document).on("click",".careerUpdateBtn",function(){
	
	

		
		let caNo = $(this).data("cano");
		
		let updateForm = $(this).closest('form');
		

		
		$.ajax({
	
			url : "${pageContext.request.contextPath}/mypage/careerInfoUpdate.do", //어디로
			method : "POST", //어떻게
			data : updateForm.serialize(), //무엇을
			dataType : "json",
			success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
				console.log("careerupdate결과 ",resp);
				selectInputView();
				selectCareerList();
				toastr.success('경력이 수정되었습니다.');
				
			},
			error : function(errorResp) {
				toastr.error('다시 입력해주세요.');
				console.log(errorResp.status);
			}
	
		});
		
});









// 경력 추가하기 ==========================================================================
$('#careerInsertBtn').on("click",function(){

	

	var empNo = $('input[name=empNo]').val(); 
	
	

	
	$.ajax({

		url : "${pageContext.request.contextPath}/mypage/careerInfoInsert.do", //어디로
		method : "POST", //어떻게
		data : careerForm.serialize(),//무엇을
		dataType : "json",
		success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
			
			
			//console.log("career insert resp 값 :",resp);
					
			let caNo = resp.caNo;
			let res = resp.result;
			
			if(res == 1){
				careerForm[0].reset();		
				selectCareerList(empNo);
				selectInputView(empNo);
				
			}
		},
		error : function(errorResp) {

			console.log(errorResp.status);
		}

	})
	
 })



// 경력 Delete ======================================================================================== 
$(document).on("click",".careerDeleteBtn",function(){
	
	let caNo = $(this).data("cano");
	console.log(caNo);
	
	let deleteDiv = $(this).closest(".card");
	
	$.ajax({

		url : "${pageContext.request.contextPath}/mypage/careerInfoDelete.do", //어디로
		method : "POST", //어떻
		data : {caNo : caNo}, //무엇을
		dataType : "json",
		success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
			
			if (resp == 1){
				deleteDiv.remove();
				selectCareerList(empNo);
				selectInputView(empNo);
				toastr.success('경력이 삭제되었습니다.')
			}
			
		},
		error : function(errorResp) {

			console.log(errorResp.status);
		}

	});
		
}) 







// 학력 수정 폼 

function updateAccaFrom(){
	
	
	 $.ajax({

		url : "${pageContext.request.contextPath}/mypage/selectAccaList.do", //어디로
		method : "GET", //어떻게
		data : {empNo : empNo}, //무엇을
		dataType : "json",
		success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
		console.log
	 
	let i = 0;
	let accaViewHtml = ``;
	
	$.each(resp,function(index,ac){
	accaViewHtml +=`
		
		<div class="card accordion-item mb-2">
          <h2 class="accordion-header" id="accHeading\${i}">
            <button
              type="button"
              class="accordion-button collapsed"
              data-bs-toggle="collapse"
              data-bs-target="#acAccordion\${i}"
              aria-expanded="false"
              aria-controls="acAccordion\${i}"
              
            >
               
              <div class="d-flex align-self-center align-items-center">
				<img src="${cPath}/resources/images/company.png"
					alt="Avatar" class="empListimgradius mypagecareerimgsize">
				<div class="mx-3 ">
					<div>\${ac.acNm}</div> 
					<div><span class="fs-tiny">\${ac.gradClf }</span> | <span class="fs-tiny"> \${ac.acEtdate } ~ `;
				          					
						if(ac.acEdate != null){
														
							accaViewHtml += ac.acEdate;
						}
				          			
          			accaViewHtml += ` (\${ac.accPeriod}) </span>
          			
					</div>         
				</div>	
															
			</div>		
             <!--  	 -->
            </button>
          </h2>
          <div
            id="acAccordion\${i}"
            class="accordion-collapse collapse"
            aria-labelledby="accHeading\${i}"
            data-bs-parent="#accordionExample"
          >
            <div class="accordion-body">
            <form class="accaForm" >
            
			<label for="school" class="form-label">학교</label>
 			 <div class="row school" id="">
 			 	 <div class="col-sm-4 pe-0" >
 			 		<div class="form-group">
                    <select class=" form-control show-tick"  data-style="border" name="acClf">
			        <option value="" selected="selected"  >구분</option>`;
	       				
			        $.each(acClfList,function(index,clf){
			        	
			        	
			 			if(ac.acClf == clf.codeNm){
			 				
			        	accaViewHtml += `<option selected="selected" value="\${clf.codeNm }">\${clf.codeNm }</option>`
			 				
			 			}else{
			 				
			        	accaViewHtml += `<option value="\${clf.codeNm }">\${clf.codeNm }</option>`
			 				
			 			}
			        	
			        })
			   accaViewHtml += `  </select>
		        			</div>					 
						</div>
			  	 	<div class="col-sm-8 ps-0">
					<input type="text" class="form-control " value="\${ac.acNm}" name="acNm" placeholder="학교명 입력"/>
				</div>	
			 </div>
	            
	             <div class=" arcodiancheck mb-2 mt-3"> 
	             <div class="basicnamediv ">
	              <label for="defaultSelect" class="form-label">졸업구분</label>
	                <select class=" form-control show-tick" data-style="border" name="gradClf">
				        <option value="" selected="selected"  >구분 선택</option>`;
	                      $.each(gradeClfList,function(index,grade){
	                    	  
	                    	if(grade.codeNm == ac.gradClf) { 
	                    	accaViewHtml += `<option selected="selected" value="\${grade.codeNm }">\${grade.codeNm }</option>`
	                    	}else{
	                    	accaViewHtml += `<option value="\${grade.codeNm }">\${grade.codeNm }</option>`
	                    		
	                    	}  
	                      })
                   
	            accaViewHtml += `   
	            	</select>					                       	       
	             	</div>  
	
	            	<div class=" basicenglishname mb-4 me-0">
	                <label for="defaultInput" class="form-label">전공</label>
	            		 <input id="defaultInput" class="form-control" value="\${ac.maj}" type="text" name="maj" placeholder="전공 입력" />
					</div>
				</div>



                <div class=" arcodiancheck mb-2 mt-3"> 
                            
                    <div class="basicnamediv">
                        <label for="defaultFormControlInput" class="form-label">입학</label>
                        <div class="">
                        <input class="form-control" type="date"  name="acEtdate" value="\${ac.acEtdate}" id="defaultFormControlInput" />
                        </div>
					</div>



                    <div class="basicenglishname mb-4 me-0">
                        <label for="defaultFormControlInput" class="form-label">졸업</label>
                        <div class="">
                        <input class="form-control" type="date" value="\${ac.acEdate}" name="acEdate" id="defaultFormControlInput" />
                        </div>
					</div>
                    
                
				</div>
				
					<input type="hidden" value="\${ac.accaNo}" name="accaNo" />
					<input type="hidden" value="\${ac.empNo}" name="empNo"/>
					
				   <div class="arcodiancheck">

    			  <button type="button" class="btn btn-primary mb-2  w-40 accaUpdateBtn">수정하기</button>
    			  <button type="button" class="btn btn-icon btn-outline-danger empaddbutton accaDeleteBtn"  data-accano="\${ac.accaNo}">
                     <i class='bx bxs-trash-alt'></i>
            	 </button>
				 </div> 
				 
				 
        		</form>
                </div>
              </div>
             </div>
	
	` 
	
			i++;
		})
		
		$('#accaDiv').html(accaViewHtml);
		$('select').selectpicker();		

		
		},
		error : function(errorResp) {

			console.log(errorResp.status);
		}

	});
	
	
}




// 사원에 대한 학력List들 조회 ======================================================================================
function selectAccaList(empNo){
	
	
	$.ajax({

		url : "${pageContext.request.contextPath}/mypage/selectAccaList.do", //어디로
		method : "GET", //어떻게
		data : {empNo : empNo}, //무엇을
		dataType : "json",
		success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
		
			console.log( "selectAccaList " ,resp)
			let	accaListTable = ``;

			if(resp.length == 0 ){
				
					accaListTable += `	
						    <tr>
				         		<td></td> 
				         		<td style="text-align: center"><i class='bx bx-info-circle bx-sm' ></i><br> 학력 정보가 없습니다.</td>
				         	</tr>			
						`
						
						
			}else{
				
					$.each(resp,function(index,ac){
						
					accaListTable += `
									
					  <tr>
                      	<td class="tdwidth" >\${ac.acClf }</td>
                      	<td>
                      		<span>\${ac.acNm }</span> <span class="badge bg-label-dark me-1">\${ac.gradClf }</span> | <span>\${ac.acEtdate } ~` ;
                      			
                      			if(ac.acEdate != null){
                      				
                      				
                      				accaListTable += ac.acEdate;
                      			}
                      			
                      			accaListTable += ` (\${ac.accPeriod}) </span><br>
      						 <span>\${ac.maj }</span>
                      	</td>
                      </tr>
					
					`	
				
					
						
		
						
					})
					
					

			}
			
			$('#accaTbody').html(accaListTable);
			
		},
		error : function(errorResp) {

			console.log(errorResp.status);
		}

	});
	
}

// 학력 수정하기 =======================================================================
$(document).on("click",".accaUpdateBtn",function(){
	
    
	let acUpForm = $(this).closest('form');
	let btn = $(this).closest('.accordion-button');
	
	let acNm = $(".accaForm input[name='acNm']").val();
	let acClf = $(".accaForm input[name='acClf']").val();
	let acEtdate = $(".accaForm input[name='acEtdate']").val();
	let acEdate = $(".accaForm input[name='acEdate']").val();
	let gradClf = $(".accaForm input[name='gradClf']").val();
	let maj = $(".accaForm input[name='maj']").val();
	
	console.log("수정폼 acNm 값 :",acNm);
	let accordion = $(this).closest('accordion');
	$.ajax({

		url : "${pageContext.request.contextPath}/mypage/updateAccaInfo.do", //어디로
		method : "POST", //어떻게
		data : acUpForm.serialize() , //무엇을
		dataType : "json",
		success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
			
			if(resp == 1){
				
				selectAccaList(empNo);			 
				updateAccaFrom();
				//	acUpForm.removeClass('collapsed');

			/* 	acUpForm.addClass('active');
				btn.removeClass('collapsed');
			 	btn.attr('aria-expanded=false');
				btn.attr('.aria-expanded=true');  */
				
				 toastr.success('학력을 수정했습니다.');
				 
				 
			}
			
		},
		error : function(errorResp) {

			console.log(errorResp.status);
		}

	});
	
})


$(document).on("click",".accaDeleteBtn",function(){
	
	let accaNo = $(this).data("accano");
	let card = $(this).closest(".card");
	
	$.ajax({

		url : "${pageContext.request.contextPath}/mypage/deleteAccaInfo.do", //어디로
		method : "POST", //어떻게
		data : {accaNo : accaNo}, //무엇을
		dataType : "json",
		success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함

			if(resp == 1 ){
				updateAccaFrom();		
				selectAccaList(empNo)
				// accordion.show();
				 toastr.success('학력이 삭제되었습니다.');
			}
		},
		error : function(errorResp) {

			console.log(errorResp.status);
		}

	});
})
	
$('#gradeInsertBtn').on("click",function(){	

	

	
	$.ajax({

		url : "${pageContext.request.contextPath}/mypage/accInfoInsert.do", //어디로
		method : "POST", //어떻게
		data : acInputForm.serialize(), //무엇을
		dataType : "json",
		success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함

			console.log(resp);
		
			if(resp == 1 ){
				acInputForm[0].reset();
				$('select[name=acClf]').selectpicker('val','');
				$('select[name=gradClf]').selectpicker('val','');
				updateAccaFrom();
				selectAccaList(empNo);
				toastr.success('학력을 추가했습니다.');
			}
		},
		error : function(errorResp) {

			console.log(errorResp.status);
		}

	});
	
})



  
 
});
</script>