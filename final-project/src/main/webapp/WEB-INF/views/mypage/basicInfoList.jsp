<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>   
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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

   <div class="empFormheader"> 
   	<div class="mypagetablewidth">
		<div class="card shadow-none ">
		<div class="arcodiancheck" id="hraddDiv">
          <h5 class="card-header pt-2 ps-3 fs-4 fw-bold">개인 정보</h5>
    		 <div class="dropdown p-4 py-0 empaddbutton">
                            
                            
                           
                    <c:if test="${empRole eq 'admin' || empRole eq 'manager' ||  authEmp.empNo eq empVo.empNo}">
                      	<div class="mt-3">
                            <button type="button" class="btn p-0 " data-bs-toggle="offcanvas"  data-bs-target="#offcanvasBoth"
                          		aria-controls="offcanvasBoth" id="basicInfoBtn" data-empno="${empVo.empNo }">
                             <i class='bx bxs-pencil' ></i>
                            </button>

                        <div
                          class="offcanvas offcanvas-end mypagetoggle w-px-600"
                          data-bs-scroll="true"
                          tabindex="-1"
                          id="offcanvasBoth"
                          aria-labelledby="offcanvasBothLabel"
                        >
                          <div class="offcanvas-header">
	                            <h4 id="offcanvasBothLabel" class="offcanvas-title">개인 정보 수정</h4>
	                            <button
	                              type="button"
	                              class="btn-close text-reset"
	                              data-bs-dismiss="offcanvas"
	                              aria-label="Close"
	                            ></button>
                          </div>
                          
                          
                          
                          
                          <!-- 수정 토글 -->
                          <div class="offcanvas-body my-3 mx-0 flex-grow-0">
                          <form:form  modelAttribute="emp"  action="${cPath}/mypage/basicInfoUpdate.do"  method="post">
                          
             
                            <div class=" arcodiancheck mb-2"> 
                            <div class="basicnamediv">
		                        <label for="basicInfoName" class="form-label">이름</label>
		                        <input
		                          type="text"
		                          class="form-control"
		                          id="basicInfoName"
		                          placeholder="John Doe"
		                          aria-describedby="defaultFormControlHelp"
		                          name="empNm"
		                         
		                        />
		       
                            </div>  
							
                            <div class="basicenglishname mb-4">
		                        <label for="basicInfoEnName" class="form-label">영문이름</label>
		                        <input
		                          type="text"
		                          class="form-control"
		                          id="basicInfoEnName"
		                          placeholder="John Doe"
		                          aria-describedby="defaultFormControlHelp"
		                          name="engNm"
		                       
		                        />
		       
                            </div>  
							</div> 

                            
                            <div class=" mb-4">
		                        <label for="basicInfoIntro" class="form-label">내 소개</label>
		                        <textarea class="form-control" id="basicInfoIntro" rows="3" name="empMm"></textarea>
                     		 </div>
                     		 <!-- 주민등록번호 update가 안될 때 EmpVO에서 jsonIgnore인지 확인 -->
                     		 <div class="mb-4">
		                        <label for="defaultInput" class="form-label">주민등록번호</label>		                        
		                        <div class="input-group">
		                        <input id="basicInfoRegno1" class="form-control" type="text" name="regno1" placeholder="앞자리 입력" maxlength="6" />
		                        
		                        <input id="basicInfoRegno2" class="form-control" type="text"  name="regno2" placeholder="뒷자리 입력" maxlength="7" />
		                        </div>
                      		</div>
                      		
                 <!--      		
                      		 <div class="mb-4 ">
		                        <label for="basicInfoBir" class="form-label">생년월일</label>
		                       
		                          <input class="form-control" type="date" value="2021-06-18" id="basicInfoBir" />
		                   
                      		</div> -->
                      		
                      		
                      		 <div class="mb-4">
		                        <label for="basicInfoHp" class="form-label">휴대전화번호</label>
		                        <input id="basicInfoHp" name="cpNo" class="form-control tel" type="text" placeholder="Default input" size="13" />
                      		</div>
                              
                      		 <div class="mb-4">
		                        <label for="sample6_postcode" class="form-label">집 주소</label>
		                        <input  name="empAddr" class="form-control" type="text" id="sample6_postcode" onclick="sample6_execDaumPostcode()" placeholder="주소 입력" />
                      		</div>
                      		
                      		
                      		
                      		<div class="mb-4 ">
                      		<label for="basicInfobank"  class="form-label ">급여 계좌</label>
                      		<div class="d-flex">
							
		                        
                            <form:select path="bank" id="basicInfobank" data-live-search="true"  data-width="27%" data-size="6" 
		                  				class=" selectpicker selectlabel show-tick"  data-style="border" >		
			                    <c:forEach items="${bankList }" var="bank" >	
			                    	<form:option value="${bank.codeNm}" ></form:option>
			                    </c:forEach>
		                    </form:select>
		                        
		                       

                        	<input type="text" class="form-control" id="basicInfoAcct" name="acctNo" placeholder="계좌번호 입력" aria-label="Text input with 2 dropdown buttons" style="width:73%;"/>
                        	
                        	

		<!--                    계좌 실명인증 나중에 시간이 되면 하기    
								<button
		                          class="btn btn-outline-primary dropdown-toggle"
		                          type="button"
		                          data-bs-toggle="dropdown"
		                          aria-expanded="false">
		                          	인증 건너뜀
		                        </button>
		                        <ul class="dropdown-menu dropdown-menu-end">
			                          <li><a class="dropdown-item" href="javascript:void(0);">인증 재시도</a></li>
	
		                        </ul> -->
	                        
	                        
	                        
                      	</div>
                              
                       </div>
                       <input type="hidden" value="${empVo.empNo}" name="empNo"/>	
                       <div class="arcodiancheck">
                       		<button id="autoBtn" type="button" class="btn btn-icon mb-2  btn-label-primary" onclick="dataAutoInput2();">
		                       		 <span class="tf-icons bx bx bxs-edit-alt"></span>
		                       </button>
                            <button
                              type="reset"
                              class="btn btn-outline-secondary mb-2 w-30 empaddbutton"
                              data-bs-dismiss="offcanvas"
                            >
                          		    취소		
                            </button>
                            <button type="submit" class="btn btn-primary mb-2 ms-3 w-40">저장하기</button>
                       </div>     
                            </form:form>
                          </div>
                        </div>
                      </div>
          </c:if>

              		</div>
            	</div>
            	
<!-- ################################################################################################################################################################################ -->
           <!-- 기본 정보 테이블 -->
			<div class="table-responsive text-nowrap">
                  <table class="table table-borderless">
                    <thead>
              
            
                    </thead>
                    <tbody>
                      <tr>
                      	<td class="tdwidth" >이메일</td>
                      	<td>${empVo.empMail }</td>
                      </tr>
                      <tr>
                      	<td class="tdwidth" >이름</td>
                      	<td>${empVo.empNm }</td>
                      </tr>
                      <tr>
                      	<td class="tdwidth" >영문 이름</td>
                      	<td>
                      	<c:if test="${empty empVo.engNm }">
                      		정보 미입력
                      	</c:if>
                      	<c:if test="${not empty empVo.engNm }">
                      	${empVo.engNm }
                      	
                      	</c:if>
                      	
                      	</td>
                      </tr>
                      <tr>
                      	<td class="tdwidth" >내 소개</td>
                      	<td>
                      	<c:if test="${empty empVo.empMm }">
                      		정보 미입력
                      	</c:if>
                      	<c:if test="${not empty empVo.empMm }">
                      	${empVo.empMm }
                      	
                      	</c:if>
          
                      	
                      	</td>
                      	
                      </tr>
                      
                      
<%--                       <tr>
                      	<td class="tdwidth" >생년월일</td>  
                      	<td>${empVo.entDate }</td>
                      </tr> --%>
                      <c:if test="${empRole eq 'admin' || empRole eq 'manager' ||  authEmp.empNo eq empVo.empNo}">
                      <tr>
                      	<td class="tdwidth" >주민등록번호</td>
                      	<td>${empVo.regno1 }-${empVo.regno2 }</td>
                      </tr>
                      </c:if>
                      <tr>
                      	<td class="tdwidth" >휴대전화번호</td>
                      	<td>
                      	<c:if test="${empty empVo.cpNo }">
                      		정보 미입력
                      	</c:if>
                      	<c:if test="${not empty empVo.cpNo }">
                      	${empVo.cpNo }
                      	</c:if>
                      	</td>
                      	
                      </tr>
                      <c:if test="${empRole eq 'admin' || empRole eq 'manager' ||  authEmp.empNo eq empVo.empNo}">
                      <tr>
                      	<td class="tdwidth" >집주소</td>
                      	<td>
                      	<c:if test="${empty empVo.empAddr }">
                      		정보 미입력
                      	</c:if>
                      	<c:if test="${not empty empVo.empAddr }">
                      		${empVo.empAddr }
                      	</c:if>
                      	
                      </td>
                      </tr>
                      <tr>
                      	<td class="tdwidth" >급여계좌</td>
                      	<td>
                      	<c:choose>
	                      	<c:when test="${not empty empVo.bank and not empty empVo.acctNo }">
	                      		${empVo.bank } &nbsp; ${empVo.acctNo }
	                      	</c:when>
	                      	<c:otherwise>
		                      	<c:if test="${empty empVo.bank and not empty empVo.acctNo }">
		                      		정보 미입력  &nbsp; ${empVo.acctNo }
		                      	</c:if>	
		                      	<c:if test="${not empty empVo.bank and empty empVo.acctNo }">
		                      		${empVo.bank} &nbsp; 정보 미입력
		                      	</c:if>
		                      	<c:if test="${empty empVo.bank and empty empVO.acctNo }">
		                      		정보 미입력
		                      	</c:if>
	                      	</c:otherwise>
                      	</c:choose>
                      	
                      	</td>
                      </tr>
                      </c:if>
                    </tbody>
                  </table>
               
                
               
                  </div> 
            </div>      
<!-- ################################################################################################################################################################################ -->
            
            <c:if test="${empRole eq 'admin' || empRole eq 'manager' ||  authEmp.empNo eq empVo.empNo}">
		<div class="card shadow-none ">
		<div class="arcodiancheck">
          <h5 class="card-header pt-4 ps-3 fs-4 fw-bold">가족 정보</h5>
          
         
                         

						 <!-- 추가(+)버튼  -->
						<div class="mt-3 p-4 py-0 pt-1 empaddbutton">
                            <button type="button" class="btn p-0 " data-bs-toggle="offcanvas"  data-bs-target="#offcanvasBothbasic2"
                          		aria-controls="offcanvasBoth">
                            <i class='bx bx-plus' ></i>
                            </button>
                            
                            
                            

                          <!-- 가족정보 추가 토글 -->
                        <div
                          class="offcanvas offcanvas-end mypagetoggle w-px-600"
                          data-bs-scroll="true"
                          tabindex="-1"
                          id="offcanvasBothbasic2"
                          aria-labelledby="offcanvasBothLabel"
                        >
                          <div class="offcanvas-header">
	                            <h4 id="offcanvasBothLabel" class="offcanvas-title">가족 정보 추가</h4>
	                            <button
	                              type="button"
	                              class="btn-close text-reset"
	                              data-bs-dismiss="offcanvas"
	                              aria-label="Close"
	                            ></button>
                          </div>
                          
                          <form:form modelAttribute="fam"  action="${cPath}/mypage/empFamInsert.do" method="post" class="validatedAge" onsubmit="return false">
                        	
                          <div class="offcanvas-body my-auto mx-0 flex-grow-0">
                          <div class="mb-4">
		                        <label for="basinInfoFamNm" class="form-label">이름</label>
		                        <input
		                          type="text"
		                          class="form-control"
		                          id="basinInfoFamNm"
		                          placeholder="이름 입력"
		                          aria-describedby="defaultFormControlHelp"
		                          name="famNm"
		                          required="required"
		                        />
		       
                            </div>  
                            
         		   		 <div class="mb-4">
		                        <label for="defaultInput" class="form-label">주민등록번호</label>		                        
		                        <div class="input-group">
		                        <input id="basicInfoFamRegno1" class="form-control "  type="text" name="famRegno1" placeholder="앞자리 입력" maxlength="6" required="required"/>
		                        
		                        <input id="basicInfoFamRegno2" class="form-control" type="text"  name="famRegno2" placeholder="뒷자리 입력" maxlength="7" required="required" />
		                        </div>
                      		</div>
                     		 
                     		 
                     	<div class="divider divider-dashed text-start">
                        	<div class="divider-text">공제정보</div>
                      	</div>	 
                     		 
                     		 
                     	 <div class=" arcodiancheck mb-4"> 
                            <div style="width:100%">
		                        <label for="basicInfoFamRln" class="form-label">기본공제 대상</label>
		                        <select class="form-select" id="basicInfoFamRln" aria-label="Default select example" name="famRln" required="required">
			                          <option selected disabled="disabled" hidden="" >소득공제 관계 선택</option>
			                          <option class="parentAge" value="부모·조무보">부모·조무보</option>
			                          <option class="parentAge" value="배우자의 부모·조부모">배우자의 부모·조부모</option>
			                          <option value="배우자">배우자</option>
			                          <option class="childAge" value="자녀·손자녀(자녀 세액공제 해당)">자녀·손자녀(자녀 세액공제 해당)</option>
			                          <option class="childAge" value="자녀·손자녀(자녀 세액공제 미해당)">자녀·손자녀(자녀 세액공제 미해당)</option>
			                          <option class="siblAge" value="형제자매">형제자매</option>
			                          <option value="친인척이 아니지만 생계를 같이하는 수급자">친인척이 아니지만 생계를 같이하는 수급자</option>
			                          <option class="trustChildAge" value="위탁아동">위탁아동</option>
			                        </select>
		       
                            </div>                     
							</div>          
                       <input type="hidden" value="${empVo.empNo }" name="efamEmpno"/>
                       
                       <div class="arcodiancheck">
		                       <button id="autoBtn" type="button" class="btn btn-icon mb-2  btn-label-primary" onclick="dataAutoInput();">
		                       		 <span class="tf-icons bx bx bxs-edit-alt"></span>
		                       </button>
		                            <button
		                              type="reset"
		                              class="btn btn-outline-secondary mb-2 w-30 empaddbutton"
		                              data-bs-dismiss="offcanvas"
		                            >
		                          		    취소		
		                            </button>
                            		<!-- <button type="submit" class="btn btn-primary mb-2 ms-3 w-40" id="famInsertBtn">저장하기</button> -->
                            		<input value="저장하기" type="submit" class="btn btn-primary mb-2 ms-3 w-40" id="famInsertBtn" />
                      			 </div>     
                      		 </div>
                            </form:form>
                          </div>
                        </div>
            
                
                      </div>








					<div class="arcodiancheck">
       
						 <!-- 수정버튼  -->
						<div class="mt-3 p-4 py-0 pt-1 empaddbutton">
                    

                          <!-- 가족정보 수정 토글 -->
                        <div
                          class="offcanvas offcanvas-end mypagetoggle"
                          data-bs-scroll="true"
                          tabindex="-1"
                          id="offcanvasBothbasic3"
                          aria-labelledby="offcanvasBothLabelbasic"
                        >
                          <div class="offcanvas-header">
	                            <h5 id="offcanvasBothLabelbasic" class="offcanvas-title">가족 정보 수정</h5>
	                            <button
	                              type="button"
	                              class="btn-close text-reset"
	                              data-bs-dismiss="offcanvas"
	                              aria-label="Close"></button>
                          </div>
                          
                          <form:form modelAttribute="fam"  id="updateFamForm">
                        	
                          <div class="offcanvas-body my-auto mx-0 flex-grow-0">
                          <div class="mb-4">
		                        <label for="basinInfoFamNm" class="form-label">이름</label>
		                        <input
		                          type="text"
		                          class="form-control"
		                          id="updateFamNm"
		                          placeholder="John Doe"
		                          aria-describedby="defaultFormControlHelp"
		                          name="famNm"
		                        />
		       
                            </div>  
                            
         		   		 <div class="mb-4">
		                        <label for="defaultInput" class="form-label">주민등록번호</label>		                        
		                        <div class="input-group">
		                        <input id="updateFamRegno1" class="form-control checkRegno" type="text" name="famRegno1" placeholder="앞자리 입력" maxlength="6" />
		                        
		                        <input id="updateFamRegno2" class="form-control" type="text"  name="famRegno2" placeholder="뒷자리 입력" maxlength="7" />
		                        </div>
                      		</div>
                     		 
                     		 
                     	<div class="divider divider-dashed text-start">
                        	<div class="divider-text">공제정보</div>
                      	</div>	 
                     		 
                     		 
                     	 <div class=" arcodiancheck mb-4"> 
                            <div style="width:100%">
		                        <label for="basicInfoFamRln" class="form-label">기본공제 대상</label>
		                        <select class="form-select" id="updateFamRln" aria-label="Default select example" name="famRln">
       								  <option selected>소득공제 관계 선택</option>
			                          <option class="parentAge" value="부모·조무보">부모·조무보</option>
			                          <option class="parentAge" value="배우자의 부모·조부모">배우자의 부모·조부모</option>
			                          <option value="배우자">배우자</option>
			                          <option class="childAge" value="자녀·손자녀(자녀 세액공제 해당)">자녀·손자녀(자녀 세액공제 해당)</option>
			                          <option class="childAge" value="자녀·손자녀(자녀 세액공제 미해당)">자녀·손자녀(자녀 세액공제 미해당)</option>
			                          <option class="siblAge" value="형제자매">형제자매</option>
			                          <option value="친인척이 아니지만 생계를 같이하는 수급자">친인척이 아니지만 생계를 같이하는 수급자</option>
			                          <option class="trustChildAge" value="위탁아동">위탁아동</option>
			                     </select>
		       
                            </div>                     
							</div>          
                       <input type="hidden"  name="efamNo" id="updateEfamNo"/>
                 
                       
                       <div class="arcodiancheck">
		                            <button
		                              type="reset"
		                              class="btn btn-outline-secondary mb-2 w-30 empaddbutton"
		                              data-bs-dismiss="offcanvas"
		                            >
		                          		    취소		
		                            </button>
                            		<button type="button" class="btn btn-primary mb-2 ms-3 w-40 famUpdateBtn" data-empno="${empVo.empNo }" >저장하기</button>
                      			 </div>     
                      		 </div>
                            </form:form>
                          </div>
                        </div>
            
                
                      </div>
                
                
                 	<!-- 가족정보 추가한 목록 table -->                 
                  <div class="table-responsive text-nowrap me-4 mb-2">
                  <table class="table table-borderless  famTable table-hover">
             
                    <tbody class="table-border-bottom-0 ">
		                    <c:forEach items="${famList }" var="fam" >
		                      <tr class="mouseover" data-efamno="${fam.efamNo }">
		                      
		                      	<td class="tdwidth"  >${fam.famNm}</td>
		                      	
		                      	<td>${fam.famRegno1}-${fam.famRegno2} 
		                      	
		                      	<c:if test="${not empty fam.famRln }">
		                      	| ${fam.famRln}	                      	
		                      	</c:if>
		                      	</td>	
		                      	<td class="">
		                      	
		                 
		                      	<button type="button" class="btn p-0 dropdown-toggle hide-arrow float-end showBtn" data-bs-toggle="dropdown" >
                             		 <i class='bx bx-dots-horizontal-rounded'></i>
                                 </button>
                                 
	                             <div class="dropdown-menu">
	                              <a class="dropdown-item" href="javascript:void(0);">
		              				<button type="button" class="btn p-0 famInfoBtn " data-bs-toggle="offcanvas"  data-bs-target="#offcanvasBothbasic3"
		                          		aria-controls="offcanvasBoth" data-efamno="${fam.efamNo }" ><i class='bx bxs-pencil'></i>
		                           			수정하기
		                            </button>                  
	                              </a>	                                                            
	                              <a class="dropdown-item" href="javascript:void(0);">
	                              	<button type="button" class="btn p-0 deleteFamBtn" data-bs-toggle="offcanvas"  data-bs-target="#offcanvasBothbasicHr2"
			                          		aria-controls="offcanvasBoth"   data-efamno="${fam.efamNo }" data-efamempno="${fam.efamEmpno}"> <i class='bx bxs-trash-alt'></i> 
			                           		삭제하기
			                        </button>    	
	                               </a>         
			                      </div>	
			                                            	
		                   	  </td> 		                      	
		                      </tr> 
		                      </c:forEach>      
		                    </tbody>
		                    </table>
              			  </div>
                      
                      
                      
                      
                      
                      
              
                			<!-- 공제 인원 수 테이블 -->
							<div class="table-responsive text-nowrap me-4" style="border-top: 1px dashed lightgray">
				                  <table class="table table-borderless">
				                    <thead>				            
				                    </thead>
				                    <tbody>
				                      <tr>
				                      	<td class="tdwidth" >기본 공제</td>
				                      	<td>
				                      	<c:if test="${not empty famVo.normalCount }">
				                      	<span id="normalCount">${famVo.normalCount}</span>명 				                      	
				                      	</c:if>
				                      	<c:if test="${empty famVo.normalCount }">
				                      		<span id="normalCount">0명</span>
				                      	</c:if>
				                      	</td>
				                      </tr>
				                      <tr>
				                      	<td class="tdwidth" >자녀 세액 공제</td>
				                      	<td>
				                      	<c:if test="${not empty famVo.childCount}">
				                      	<span id="childCount">${famVo.childCount}</span>명				                      	
				                      	</c:if>
				                      	<c:if test="${empty famVo.childCount}">
				                      	<span id="childCount">0명</span> 
				                      	</c:if>
				                      	</td>
				                      </tr>
				                      
				                    </tbody>
				                  </table>
				                </div>

		       			</div>
		       			</c:if>
		            </div>
            
               
            	

            <c:if test="${empRole eq 'admin' || empRole eq 'manager' ||  authEmp.empNo eq empVo.empNo}">
             <div class="col-md-6 col-xl-4 mypagerightwidth">
                  <div class="card shadow-none bg-transparent border border-secondary mb-4 mypagecardheigh">
                    <div class="card-body cntcard mt-5 pb-4">
                    <div>
                      <span class="card-title">근무시간</span>
                      <h4 class="card-text">
 						<fmt:parseNumber var="workTime" integerOnly="true" value="${workTime }" />
						<span>${workTime }</span>시간
                      </h4>
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

function dataAutoInput() {
	let efamform = $('.validatedAge');  
	efamform.find('input[name="famNm"]').val('이수경');
	efamform.find('input[name="famRegno1"]').val('100301');
	efamform.find('input[name="famRegno2"]').val('3255669');
	efamform.find('select[name="famRln"]').val('자녀·손자녀(자녀 세액공제 해당)').prop("selected",true);
	
};
function dataAutoInput2() {
	let efamform = $('#hraddDiv');  
	efamform.find('input[name="engNm"]').val('LEE JUWON');
	efamform.find('[name="empMm"]').val('안녕하세요 이주원 입니다.');
	efamform.find('input[name="cpNo"]').val('010-6568-2254');
	efamform.find('input[name="empAddr"]').val('대전 유성구 가정로 174 (가정동) 101동 101호');
	efamform.find('select[name="bank"]').selectpicker('val','KB국민은행');
	efamform.find('input[name="acctNo"]').val('129938-21-99492');
	
};



$('#basicInfoBtn').on("click",function(){
	/* let entCaseSelect = $('#entCaseSelect'); */
	let empNo = $(this).data("empno");
	
	
	console.log(empNo);

	$.ajax({
	
		url : "${pageContext.request.contextPath}/mypage/basicInfoView.do", //어디로
		method : "get", //어떻게
		data : { empNo : empNo },
		dataType : "json",
		success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
		
			
			let bank = resp.bank;

			
	
		 	$("#basicInfobank").selectpicker('val', bank);
//		 	$("#basicInfobank").val(bank).attr("selected", "selected"); 
		 	$("#basicInfoName").val(resp.empNm);
		 	$("#basicInfoEnName").val(resp.engNm);
		 	$("#basicInfoIntro").val(resp.empMm);
		 	$("#basicInfoRegno1").val(resp.regno1);
		 	$("#basicInfoRegno2").val(resp.regno2);
		 	$("#basicInfoHp").val(resp.cpNo);
		 	$("#sample6_postcode").val(resp.empAddr);
		 	$("#basicInfoAcct").val(resp.acctNo); 
		 	
			/* $("input[name=entDatelabel]").val(entDate);  */
			
		
		},
		error : function(errorResp) {
			
			 console.log(errorResp.status); 
		}
	
	});



}); 

/* 전화번호 입력할 때 '-' 자동으로 넣어주는 함수 */
$('.tel').keydown(function(event) {
      var key = event.charCode || event.keyCode || 0;
      $text = $(this);
      if (key !== 8 && key !== 9) {
          if ($text.val().length === 3) {
              $text.val($text.val() + '-');
          }
          if ($text.val().length === 8) {
              $text.val($text.val() + '-');
          }
      }

      return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));          
  });
  

// 가족정보 수정 데이터 불러오기 ------------------------------------------------------------------------------------------------
$('.famInfoBtn').on("click",function(){
	
	let efamNo = $(this).data("efamno");

	console.log(efamNo);
	$.ajax({
		
		url : "${pageContext.request.contextPath}/mypage/basicFamView.do", //어디로
		method : "get", //어떻게
		data : { efamNo : efamNo },
		dataType : "json",
		success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
			console.log(resp);
			
			

			
			$('#updateFamRln').val(resp.famRln).prop("selected", true);
			$('#updateFamRegno1').val(resp.famRegno1);
			$('#updateFamRegno2').val(resp.famRegno2);
			$('#updateFamNm').val(resp.famNm);
		    $('#updateEfamNo').val(resp.efamNo);
		

		
		},
		error : function(errorResp) {
			
			 console.log(errorResp.status); 
		}
	
	});
	
});





//가족정보 수정하기==================================================================================

$('.famUpdateBtn').on("click",function(){
	
	let empNo = $(this).data("empno");
	console.log(empNo);
	
	var efamNo = $('#updateEfamNo').val();
	console.log("update efamNo",efamNo);
	
	$.ajax({

		url : "${pageContext.request.contextPath}/mypage/empFamUpdate.do", //어디로
		method : "post", //어떻게
		data : $('#updateFamForm').serialize(), //form에 있는거 전부 보내기
		dataType : "json",
		success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함

			console.log(resp);
		
		if(resp == 1){
			
 			toastr.info('수정이 완료 되었습니다.');   
 			$('#offcanvasBothbasic3').offcanvas('hide');
 			
 			
 			
 					// 바뀐정보 select 해오기 
		 			$.ajax({
		
		 				url : "${pageContext.request.contextPath}/mypage/basicFamView.do", //어디로
		 				method : "get", //어떻게
		 				data : { efamNo : efamNo },
		 				dataType : "json",
		 				success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
		 			
							
						console.log("수정한 후 가져온 data resp값", resp);
						
				
						let tabletr1 = $('tr[data-efamno='+efamNo+']').find('td:eq(0)');
						let tabletr2 = $('tr[data-efamno='+efamNo+']').find('td:eq(1)');
						
				
						
						let tr1 = resp.famNm;
						let tr2 = '';
						
						
						if(!resp.famRln){
							tr2 = resp.famRegno1+'-'+resp.famRegno2;
						}else{
							tr2 =  resp.famRegno1+'-'+resp.famRegno2 + '\u00a0|\u00a0' + resp.famRln;
						}
						
						tabletr1.text(tr1);
						tabletr2.text(tr2);	
	
								
						},
						error : function(errorResp) {
		
							console.log(errorResp.status);
						}
		
					});
	
		  	}
		},
		error : function(errorResp) {
			
			console.log(errorResp.status);
			
			
		}

	});
	
})
	
	



// 가족정보 삭제하기==========================================================================
$('.deleteFamBtn').on("click",function(){
	toastr.options.positionClass = "toast-top-center";	 
	 
	 
	var efamNo = $(this).data("efamno");
	var efamEmpno = $(this).data("efamempno");
	var tr = $(this).closest('tr');
	console.log("efamNo = ",efamNo);
	console.log("efamEmpno = ", efamEmpno);
	
	
	$.ajax({

		url : "${pageContext.request.contextPath}/mypage/deleteEmpFam.do", //어디로
		method : "POST", //어떻게
		data : {efamNo : efamNo ,
			efamEmpno :	efamEmpno
		}, //무엇을
		dataType : "json",
		success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
			console.log("famDelete resp : ",resp);
		
			let deleteResult = resp.deleteResult;
			let efam = resp.efam;
			
			if(deleteResult==1){
				let normal = efam.normalCount;
				console.log(normal);
				let child = efam.childCount;
				console.log(child);
				
				toastr.info('삭제가 완료 되었습니다.').css({"width":"auto","max-width":"20em"});  
				tr.remove();
				$('#normalCount').text(normal);
				$('#childCount').text(child);
			}else{
				toastr.errors('삭제 실패하였습니다.');
			}
		},
		error : function(errorResp) {

			console.log(errorResp.status);
		}

	});
	
	
})







// 공제대상 나이 검사
var validatedAge = document.querySelector('.validatedAge'); 
validatedAge.addEventListener("submit",function(){
	

	
	 toastr.options.positionClass = "toast-top-center";	
	 
	/* 	toastr.options.positionClass = "toast-top-full-width";
	toastr.options.positionClass = "toast-width"; */	
/* 	
	toastr.options = {
			  "closeButton": false,
			  "debug": false,
			  "newestOnTop": false,
			  "progressBar": true,
			  "positionClass": "toast-top-center",
			  "preventDuplicates": false,
			  "onclick": null,
			  "showDuration": "100",
			  "hideDuration": "1000",
			  "timeOut": "1500",
			  "extendedTimeOut": "1000",
			  "showEasing": "swing",
			  "hideEasing": "linear",
			  "showMethod": "fadeIn",
			  "hideMethod": "fadeOut",
			  "toast-width" : "700"
			}
	 */
	


	// 주민번호 앞자리
	var regno = document.getElementById('basicInfoFamRegno1').value;
	// 주민번호 뒷자리
	var regno2 = document.getElementById('basicInfoFamRegno2').value;
	    regno2 = regno2.substr(0,1);

	    console.log(regno2)
	    
	    
	    //뒷자리 첫번째 숫자 확인
	 	if(regno2 == 1 || regno2 == 2){
			regno = 19 + regno;
		}else if(regno2 == 3 || regno2 == 4){
			regno = 20 + regno;
			
		}else{
            toastr.error('주민번호 뒷자리를 다시 입력해주세요').css({"width":"500px"});   
            return false;
		}
	   
		console.log(regno);
		

 	
		var regnoYear =parseInt(regno.substr(0,4));
	  	var regnoMonth = parseInt(regno.substr(4,2));
	 	var regnoDay = parseInt(regno.substr(6,2)); 
	 	
		
	

	
	
	
	// select한 value 값
	var select = document.getElementById('basicInfoFamRln');
	select = select.options[select.selectedIndex].value;
	console.log(select); 
	

	// 오늘 날짜 검색
	var today = new Date();
	console.log(today);
	
	var year = today.getFullYear();
	console.log(year);
	
	var month = (today.getMonth() + 1);
	console.log(month);
	
	var day = today.getDate();
	console.log(day);

	var ymd = ""+year+month+day;
	
	console.log(ymd);
	
	
	//주민번호가 오늘날짜를 넘었을 때 
	if(regno > ymd ){
		toastr.error('주민번호를 잘못 입력했습니다. 다시 입력하세요');   
        return false;
	}
	
	

	//option별 나이 제한
	if(select == "부모·조무보" || select == "배우자의 부모·조부모" ){
		
		if(year-regnoYear < 60 ){
			toastr.error('만 59세 이하의 대상은 '+select+' 공제 대상으로 등록할 수 없어요. &nbsp; 등록하려는 대상의 나이가 만 60세가 넘는다면, 주민등록번호를 다시 확인해주세요.').css({"width":"auto","max-width":"35em"});
			
			return false;
		}
	}else if(select == "자녀·손자녀(자녀 세액공제 해당)" ){
		
		if(year-regnoYear > 20){
			toastr.error('만 21세 이상의 대상은 '+select+' 공제 대상으로 등록할 수 없어요. 등록하려는 대상의 나이가 만 21세 이하라면, 주민등록번호를 다시 확인해주세요.');
			return false;
		}
	}else if(select == "형제자매"){
		
		if(year-regnoYear < 60 || year-regnoYear > 20){
			toastr.error('만 21세 이상 만 59세 이하의 대상은 '+select+' 공제 대상으로 등록할 수 없어요. 등록하려는 대상의 나이가 만 21세 이상 만 59세 이하라면, 주민등록번호를 다시 확인해주세요.');
			return false;
		}
	}else if(select == "위탁아동"){
		if(year-regnoYear > 18 ){
			toastr.error('만 18세 이상의 대상은 '+select+' 공제 대상으로 등록할 수 없어요. 등록하려는 대상의 나이가 만 18세 이하라면, 주민등록번호를 다시 확인해주세요.');
			return false;
		}
	}
		
	validatedAge.submit();
		
 		
});
 

 



</script>