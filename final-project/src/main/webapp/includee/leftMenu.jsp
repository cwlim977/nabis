<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<link href="${cPath }/resources/css/jhy.css" rel="stylesheet" type="text/css" />
<style>
ul{
	list-style:none;
}
#fix{
	position: fixed !important;
	transform: translate(240px, 115px) !important;
	border-radius: 15px;
}
</style>    
    
<aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme" style="z-index : 1;  background-color: #f5f5f9 !important;">
          

	<div class="menu-inner-shadow"></div>

	<ul class="menu-inner py-1">
	 <!-- Dashboard -->
		<!-- 미니프로필 Hidden Arrow Dropdowns --> 
		<li class="menu-item">
			<div class="btn-group">
				<a href="#" class="menu-link dropdown-toggle hide-arrow" data-bs-toggle="dropdown" aria-expanded="false">
				<c:if test="${empty authEmp.empImg}">
                     	<img
                         src="${cPath}/resources/images/basicProfile.png"
                         alt="기본프로필"
                         class="empListimgradius emplistimgsize"
                       >
                 </c:if>
                <c:if test="${not empty authEmp.empImg }">
                  <img
                     src="${cPath}/resources/empImages/${authEmp.empImg }"
                     alt="${authEmp.empImg}"
                     class="empListimgradius emplistimgsize"
                   >
                </c:if>
					<div class="mx-3 mt-1">
							<strong>${authEmp.empNm}</strong><br> 
							<span class="fs-tiny">
								<c:choose>
										<c:when test="${not empty authEmp.jobList }">
											<c:forEach items="${authEmp.jobList }" var="job" varStatus="status">
												<c:if test="${status.first }">
							                   		 ${job.jnm}
						                     	</c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
				                   		</c:otherwise>
								</c:choose>
							</span>
					</div>
				</a>
				
				<ul class="dropdown-menu" style="width:225px">
					<li>
						<a class="dropdown-item" href="${cPath }/mypage/hrInfoRetrieve.do?empNo=${authEmp.empNo}">
							<div>
								<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="flex-shrink: 0;"><path d="M9.06742 10.9888C9.06742 9.36914 10.3804 8.05618 12 8.05618C13.6196 8.05618 14.9326 9.36914 14.9326 10.9888C14.9326 12.6084 13.6196 13.9213 12 13.9213C10.3804 13.9213 9.06742 12.6084 9.06742 10.9888ZM12 9.8764C11.3857 9.8764 10.8876 10.3744 10.8876 10.9888C10.8876 11.6031 11.3857 12.1011 12 12.1011C12.6143 12.1011 13.1124 11.6031 13.1124 10.9888C13.1124 10.3744 12.6143 9.8764 12 9.8764Z" fill="#556372" fill-rule="evenodd" clip-rule="evenodd"></path><path d="M3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12C21 16.9706 16.9706 21 12 21C7.02944 21 3 16.9706 3 12ZM12 4.82022C8.03472 4.82022 4.82022 8.03472 4.82022 12C4.82022 13.824 5.50041 15.4892 6.62098 16.7557C7.74882 15.9865 9.63542 15.1348 12 15.1348C14.3646 15.1348 16.2512 15.9865 17.379 16.7557C18.4996 15.4892 19.1798 13.824 19.1798 12C19.1798 8.03472 15.9653 4.82022 12 4.82022ZM15.9427 18.0013C15.0532 17.4873 13.684 16.9551 12 16.9551C10.316 16.9551 8.94683 17.4873 8.05725 18.0013C9.18891 18.7463 10.5438 19.1798 12 19.1798C13.4562 19.1798 14.8111 18.7463 15.9427 18.0013Z" fill="#556372" fill-rule="evenodd" clip-rule="evenodd"></path></svg>
								<span class="ms-1">내 프로필</span>
							</div>
							<small><small class="text-muted mb-0">${authEmp.empMail}</small></small>
							<span>	</span><!-- 소프트웨어 개발자 -->
						</a>
					</li>
					<li><div class="dropdown-divider"></div></li>
					
					<!-- 내 설정 modal -->
					<li>
						<a href="#" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#pwResetModal" >
							<svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="width: 20px; height: 20px; flex-shrink: 0;"><path d="M15.3179 3.0221C16.7776 3.14545 18.1465 3.78005 19.1823 4.8136C20.2182 5.84714 20.8542 7.21299 20.9778 8.66942C21.1015 10.1259 20.7047 11.579 19.8579 12.7716C19.011 13.9643 17.7685 14.8195 16.3504 15.1861C15.1269 15.5023 13.8533 15.4638 12.6649 15.0275L12.238 15.4536V17.4134L11.45 18.1995L9.26 18.1995L8.52789 18.93V20.2138L7.73996 21H3.78793L3 20.2138V17.6387L3.23078 17.0828L8.97711 11.3493C8.53609 10.1655 8.46691 8.8705 8.7866 7.63918C9.15397 6.22424 10.0112 4.98458 11.2065 4.13958C12.4018 3.29459 13.8582 2.89875 15.3179 3.0221ZM14.5925 9.39318C15.2607 10.0598 16.344 10.0598 17.0121 9.39318C17.6803 8.72652 17.6803 7.64565 17.0121 6.97898C16.344 6.31232 15.2607 6.31232 14.5925 6.97898C13.9244 7.64565 13.9244 8.72652 14.5925 9.39318Z" fill="currentColor" fill-rule="evenodd" clip-rule="evenodd"></path></svg>
							<span class="ms-1">비밀번호 설정</span>
						</a>
					</li>
					<li>
			            <a href="javascript:void(0);" class="dropdown-item layout-menu-toggle">
			              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-chevron-left" viewBox="0 0 24 20"><path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/></svg>
			              <span class="ms-1">줄이기</span>
<!-- 			             <label class="switch"> -->
<!-- 					      <input type="checkbox" class="switch-input" /> -->
<!-- 					      <span class="switch-toggle-slider"> -->
<!-- 					        <span class="switch-on"></span> -->
<!-- 					        <span class="switch-off"></span> -->
<!-- 					      </span> -->
<!-- 					    </label> -->
			            </a>
					</li>
					<li><div class="dropdown-divider"></div></li>

					<security:authorize access="isAuthenticated()">
						<li>
							<a class="dropdown-item" href="#" onclick="logoutForm.submit();">
								<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="flex-shrink: 0;"><path d="M7.60182 8.32274L4 12L7.60182 15.6772L8.86251 14.3902L7.50087 13L16 13L16 11L7.50086 11L8.86251 9.60983L7.60182 8.32274ZM19.1086 21L9.20364 21L9.20364 19.1798L18.2171 19.1798L18.2171 4.82022L9.20364 4.82022L9.20364 3L19.1086 3L20 3.91011L20 20.0899L19.1086 21Z" fill="currentColor" fill-rule="evenodd" clip-rule="evenodd"></path></svg>
								<span class="ms-1">로그아웃</span>
							</a>
						</li>
						<form id="logoutForm" action="${cPath }/login/logout.do" method="post">
							<security:csrfInput/>
						</form>
					</security:authorize>
				</ul>
			</div> <!--/ Hidden Arrow Dropdowns -->
		</li>
		
		
		<!-- 빠른검색 modal -->
		<li class="menu-item cursor-pointer " id="quickBtn">
		
			<a  class="menu-link d-flex" data-bs-toggle="modal" data-bs-target="#modalTogglequick"><i class="menu-icon tf-icons bx bx-search"></i>		
				<div data-i18n="Analytics">구성원 검색</div>	
			<span class="badge bg-label-primary  ms-auto">k</span>
			</a>
		</li>
		
		
<!-- 			<a href="#" class="menu-link" data-bs-toggle="modal" data-bs-target="#quickSearchModal"  onclick="quickSearch();">
				<i class="menu-icon tf-icons bx bx-bell"></i>
				<div data-i18n="Basic">빠른 검색</div>
			</a> -->


<!-- ##################################################################################################################################################################### -->
<!-- 새로운 소식 -->
		<li class="menu-item dropdown-notifications navbar-dropdown dropdown dropend">
		
			<a class="menu-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false"> 
				<span class="badge bg-danger rounded-pill badge-notifications"></span> 
				<i class="menu-icon tf-icons bx bx-bell"></i>
				<div data-i18n="Basic">새로운 소식</div>
			</a>
		
			<ul id="fix" class="dropdown-menu dropdown-menu-end py-0 " style="width: 350px;">
				
				<li class="dropdown-notifications-list scrollable-container" style="height: 600px;">
					<div class="dropdown-header d-flex align-items-center py-3">
						<h5 class="text-body mb-0 me-auto">새로운 소식</h5>
						<a id="allReadBtn" href="javascript:void(0)" class="dropdown-notifications-all text-body" data-bs-toggle="tooltip" data-bs-placement="top" title="모두 읽기">
							<i class="bx fs-4 bx-envelope-open"></i>
						</a>
					</div>
					<ul id="NewArmBody" class="list-group list-group-flush">
						<li class="list-group-item list-group-item-action dropdown-notifications-item marked-as-read">
							<div class="d-flex">
								<div class="flex-shrink-0 me-3">
									<div class="avatar">
										<img src="${cPath}/resources/assets/img/avatars/9.png" alt class="w-px-40 h-auto rounded-circle" />
									</div>
								</div>
								<div class="flex-grow-1">
									<h6 class="mb-1">이부원님이 휴가 사용을 반려 했어요.</h6>
									<small class="text-muted">2 days ago</small>
								</div>
								<div class="flex-shrink-0 dropdown-notifications-actions">
									<a href="javascript:void(0)" class="dropdown-notifications-read"><span class="badge badge-dot"></span></a> <a href="javascript:void(0)" class="dropdown-notifications-archive"><span class="bx bx-x"></span></a>
								</div>
							</div>
						</li>
						<li class="list-group-item list-group-item-action dropdown-notifications-item marked-as-read">
							<div class="d-flex">
								<div class="flex-shrink-0 me-3">
									<div class="avatar">
										<img src="${cPath}/resources/assets/img/avatars/5.png" alt class="w-px-40 h-auto rounded-circle" />
									</div>
								</div>
								<div class="flex-grow-1">
									<h6 class="mb-1">휴가 사용이 승인되었어요.</h6>
									<small class="text-muted">4 days ago</small>
								</div>
								<div class="flex-shrink-0 dropdown-notifications-actions">
									<a href="javascript:void(0)" class="dropdown-notifications-read"><span class="badge badge-dot"></span></a> <a href="javascript:void(0)" class="dropdown-notifications-archive"><span class="bx bx-x"></span></a>
								</div>
							</div>
						</li>
					</ul>
					
					<div class="dropdown-header d-flex align-items-center py-3">
						<h5 class="text-body mb-0 me-auto">지난 알림</h5>
					</div>
					
					<ul id="OldArmBody" class="list-group list-group-flush">
						
					</ul>
				</li>
				<li class="dropdown-menu-footer border-top"><a href="javascript:void(0);" id="armDelAllBtn" class="dropdown-item d-flex justify-content-center p-3"> 모두 삭제하기 </a></li>
			</ul>
		</li>
			
<!--/ 새로운 소식 -->
<!-- ##################################################################################################################################################################### -->


		<!-- Components -->
		<li class="menu-header small text-uppercase"><span
			class="menu-header-text"></span>
		</li>

		<li class="menu-item" data-menu="home">
			<a href="${cPath }/home/feed.do" class="menu-link"> 
				<i class="menu-icon tf-icons bx bx-home-circle"></i>
				<div data-i18n="Analytics">홈 피드</div>
			</a>
		</li>
            
            <li class="menu-item" data-menu="emp">
              <a href="${cPath }/emp/empList.do" class="menu-link">
                <i class="menu-icon tf-icons bx bx-user"></i>
                <div data-i18n="Basic">구성원</div>
              </a>
            </li>
            <li class="menu-item" data-menu="work">
              <a href="${cPath }/work/myWork.do" class="menu-link">
                <i class="menu-icon tf-icons bx bx-time-five"></i>
                <div data-i18n="Basic">근무</div>
              </a>
            </li>
            <li class="menu-item" data-menu="vac">
              <a href="${cPath }/myVacation/vacOutlineView.do" class="menu-link">
                <i class="menu-icon tf-icons bx bx-coffee"></i>
                <div data-i18n="Basic">휴가</div>
              </a>
            </li>
            <li class="menu-item" data-menu="payStub">
              <a href="${cPath }/pay/paystub.do" class="menu-link">
                <i class="menu-icon tf-icons bx bx-won"></i>
                <div data-i18n="Basic">급여</div>
              </a>
            </li>
            <security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')">
            <li class="menu-item" data-menu="payHome">
              <a href="${cPath }/pay/payHome.do" class="menu-link">
                <i class="menu-icon tf-icons bx bx-calculator"></i>
                <div data-i18n="Basic">급여정산</div>
              </a>
            </li>
            </security:authorize>
            <security:authorize access="hasRole('ROLE_ADMIN')">
            <li class="menu-item" data-menu="insight">
              <a href="${cPath }/insight/main.do" class="menu-link">
                <i class="menu-icon tf-icons bx bxs-bar-chart-alt-2"></i>
                <div data-i18n="Basic">인사이트</div>
              </a>
            </li>
            </security:authorize>
            <li class="menu-item" data-menu="cerf">
              <a href="${cPath }/cerf/myCerf.do" class="menu-link">
                <i class="menu-icon tf-icons bx bx-book-content"></i>
                <div data-i18n="Basic">문서증명서</div>
              </a>
            </li>
            <security:authorize access="hasRole('ROLE_ADMIN')">
            <li class="menu-item" data-menu="setting">
              <a href="${cPath}/setting/main.do" class="menu-link">
                <i class="menu-icon tf-icons bx bx-cog"></i>
                <div data-i18n="Basic">설정</div>
              </a>
            </li>
			</security:authorize>
          </ul>
            
          <!-- 회사  -->
          <div class="app-brand demo px-4" style="border-top:1px solid">
            <a href="index.html" class="app-brand-link">
              <span class="app-brand-logo demo"> 
              	<img width="35" viewBox="0 0 25 42" version="1.1" src="${cPath}/resources/images/nabiMark.png" xmlns:xlink="${cPath}/resources/images/nabiMark.png" >
                  <defs>
                    <path d="M13.7918663,0.358365126 L3.39788168,7.44174259 C0.566865006,9.69408886 -0.379795268,12.4788597 0.557900856,15.7960551 C0.68998853,16.2305145 1.09562888,17.7872135 3.12357076,19.2293357 C3.8146334,19.7207684 5.32369333,20.3834223 7.65075054,21.2172976 L7.59773219,21.2525164 L2.63468769,24.5493413 C0.445452254,26.3002124 0.0884951797,28.5083815 1.56381646,31.1738486 C2.83770406,32.8170431 5.20850219,33.2640127 7.09180128,32.5391577 C8.347334,32.0559211 11.4559176,30.0011079 16.4175519,26.3747182 C18.0338572,24.4997857 18.6973423,22.4544883 18.4080071,20.2388261 C17.963753,17.5346866 16.1776345,15.5799961 13.0496516,14.3747546 L10.9194936,13.4715819 L18.6192054,7.984237 L13.7918663,0.358365126 Z" id="path-1"></path>
                    <path d="M5.47320593,6.00457225 C4.05321814,8.216144 4.36334763,10.0722806 6.40359441,11.5729822 C8.61520715,12.571656 10.0999176,13.2171421 10.8577257,13.5094407 L15.5088241,14.433041 L18.6192054,7.984237 C15.5364148,3.11535317 13.9273018,0.573395879 13.7918663,0.358365126 C13.5790555,0.511491653 10.8061687,2.3935607 5.47320593,6.00457225 Z" id="path-3"></path>
                    <path d="M7.50063644,21.2294429 L12.3234468,23.3159332 C14.1688022,24.7579751 14.397098,26.4880487 13.008334,28.506154 C11.6195701,30.5242593 10.3099883,31.790241 9.07958868,32.3040991 C5.78142938,33.4346997 4.13234973,34 4.13234973,34 C4.13234973,34 2.75489982,33.0538207 2.37032616e-14,31.1614621 C-0.55822714,27.8186216 -0.55822714,26.0572515 -4.05231404e-15,25.8773518 C0.83734071,25.6075023 2.77988457,22.8248993 3.3049379,22.52991 C3.65497346,22.3332504 5.05353963,21.8997614 7.50063644,21.2294429 Z" id="path-4"></path>
                    <path d="M20.6,7.13333333 L25.6,13.8 C26.2627417,14.6836556 26.0836556,15.9372583 25.2,16.6 C24.8538077,16.8596443 24.4327404,17 24,17 L14,17 C12.8954305,17 12,16.1045695 12,15 C12,14.5672596 12.1403557,14.1461923 12.4,13.8 L17.4,7.13333333 C18.0627417,6.24967773 19.3163444,6.07059163 20.2,6.73333333 C20.3516113,6.84704183 20.4862915,6.981722 20.6,7.13333333 Z" id="path-5"></path>
                  </defs>
                  <g id="g-app-brand" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                    <g id="Brand-Logo" transform="translate(-27.000000, -15.000000)">
                      <g id="Icon" transform="translate(27.000000, 15.000000)">
                        <g id="Mask" transform="translate(0.000000, 8.000000)">
                          <mask id="mask-2" fill="white">
                            <use xlink:href="#path-1"></use>
                          </mask>
                          <use fill="#696cff" xlink:href="#path-1"></use>
                          <g id="Path-3" mask="url(#mask-2)">
                            <use fill="#696cff" xlink:href="#path-3"></use>
                            <use fill-opacity="0.2" fill="#FFFFFF" xlink:href="#path-3"></use>
                          </g>
                          <g id="Path-4" mask="url(#mask-2)">
                            <use fill="#696cff" xlink:href="#path-4"></use>
                            <use fill-opacity="0.2" fill="#FFFFFF" xlink:href="#path-4"></use>
                          </g>
                        </g>
                        <g id="Triangle" transform="translate(19.000000, 11.000000) rotate(-300.000000) translate(-19.000000, -11.000000) ">
                          <use fill="#696cff" xlink:href="#path-5"></use>
                          <use fill-opacity="0.2" fill="#FFFFFF" xlink:href="#path-5"></use>
                        </g>
                      </g>
                    </g>
                  </g>
                </>
		</span>
              <span class="app-brand-text  menu-text fw-bolder ms-1 fw-bold fs-4 mt-2">NABIS</span>
            </a>

          </div>
          
</aside> <!-- / Menu -->

		<!-- Vertically Centered Modal -->
		<div class="mt-3">
		
			<!-- Modal -->
			<div class="modal fade" id="modalCenter" tabindex="-1"
				aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">
						
					</div>
				</div>
			</div>
		</div>



<!-- 내 설정 Modal -->
<div class="modal fade" id="mySettingModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-contentSetting">
		
		</div>
	</div>
</div>

<!-- 빠른 검색 Modal -->

<div class="modal fade" id="quickSearchModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-contentSearch">
		
		</div>
	</div>
</div>




<!-- <h5 class="modal-title" id="modalToggleLabel">  </h5> -->


            
                        
                        <div class="modal modal-transparent fade" id="modalTogglequick" tabindex="-1">
							  <div class="modal-dialog">
							    <div class="modal-content " style="margin-top : 10rem">
							      <a href="javascript:void(0);" class="btn-close text-white" data-bs-dismiss="modal" aria-label="Close"></a>
							      <div class="modal-body">
							        <p class="text-white text-large fw-light mb-3">구성원 검색</p>
							        <div class="input-group input-group-lg mb-3">
							          <input type="text"  oninput="empQuickSearch()" id="empSearch" name="empSearchname" class="form-control bg-white border-0" placeholder="구성원 검색" aria-describedby="subscribe">
							          
							        </div>
								     <div class="list-group px-2" id="quickEmpList">
	                              			
	                              	</div>
							      </div>
							    </div>
							  </div>
							</div>

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
<!-- 	<div class="alert alert-primary" role="alert"> -->
<!-- 	  비밀번호가 변경되었습니다. -->
<!-- 	</div> -->
<script type="text/javascript" defer="defer">

// k누르면 자동으로 빠른검색 모달창 띄어짐 
$(document).ready(function(){

	$(document).keydown(function(e){
		// input이나 textarea에 커서가 없을 경우 눌리게 
		if( !($("input").is(":focus")) && !($("textarea").is(":focus")) ) {

			if(e.which == 75 ){			
				$('#modalTogglequick').modal('show');
			}  
		}
	});
	
});

$(".modal").on("shown.bs.modal", function () {		
	$('input[name=empSearchname]').focus();
});	



$('#quickBtn').on("click",function(){
	
	let empSearch = $('input[name=empSearchname]');

	empSearch.val('');
	$('#quickEmpList').empty();
	//$('.empHeader').removeClass('border-bottom');	
})

function empQuickSearch(){
	
    let empNm = document.getElementById('empSearch').value;
	console.log("empSearch : ",empNm);
	let quickEmpList = $('#quickEmpList');
	$.ajax({

		url : "${cPath}/quickSearch.do", //어디로
		method : "POST", //어떻게
		data : {empNm : empNm}, //무엇을
		dataType : "json",
		success : function(resp) { //콜백 함수=>응답데이터를 갖고놀아야함
			
			console.log("quickSearch resp로 넘어옴");		
			console.log("empresp : ", resp);
			
			
			let quickEmp = ``;
			
			// 검색어를 지웠을 때  내용 초기화, 헤더 아래 테두리를 지움 
		
			
			// 입력한 검색 결과가 없을  때 
			 if(empNm != "" && resp.length < 1){
		
				quickEmp += `
							<div class="p-5 text-center">
							<div class="fw-bold mb-3 text-white">"\${empNm}"에 대한 검색 결과가 없습니다 .</div>
							<div class="mb-3 text-secondary text-white">잘못 입력한 정보가 있는지 확인해보세요.</div>
							</div>
				`;		
			}else if(resp.length > 0){									
			quickEmp += `<a class= "list-group-item border-0 pt-3 pb-0 text-white " id="empListTm">구성원</a>`;
						
			$.each(resp,function(index,emp){
				let jnm = ""; // 직무명
	               // 직무명 리스트에서 꺼내기
	               $(emp.jobList).each(function(jobIndex, job) {
	                  if(jobIndex == 0) jnm = job.jnm;
	               });
				quickEmp += `
				
					<a href="${cPath}/mypage/hrInfoRetrieve.do?empNo=\${emp.empNo}" class="list-group-item list-group-item-action d-flex align-items-center cursor-pointer border-0 rounded  mb-1">`;
					
					if(emp.empImg == null){
						
						quickEmp += `						
							 <img
		                      src="${cPath}/resources/images/basicProfile.png"
		                      alt="basic Image"
		                      class="empListimgradius emplistimgsize"/>`;
					}else{
						
						quickEmp += `
							 <img
		                      src="${cPath}/resources/empImages/\${emp.empImg}"
		                      alt="emp Image"
		                      class="empListimgradius emplistimgsize "/> `;
						
					}		
						
				 
		          quickEmp +=`<div class="w-100">
                              <div class="d-flex justify-content-between">
                                <div class="user-info">`;                          	
                               
                                quickEmp +=` <h6 class="mb-1 quickEmpNm text-white" style="letter-spacing: 2px;">\${emp.empNm}</h6>
                                  <small class="text-white" >\${jnm} </small>
                         		 </div>   
                              </div>                    			
                            </div>
						</a>`;
								
			})
	
			}else{
						quickEmp += ``;
				
			}
		
			quickEmpList.html(quickEmp);
		
		},
		error : function(errorResp) {

			console.log(errorResp.status);
		}

	});
}	


// 	function mySetting(){
// 		$("#mySettingModal .modal-contentSetting").load("${cPath}/mySetting.do?my_setting_tab=Root",
// 			function (){
// 				$(".modal-contentSetting").load("${cPath}/mySetting.do?my_setting_tab=Root #root");
// 			})
// 	}
	
	function quickSearch(){
		$("#quickSearchModal .modal-contentSearch").load("${cPath}/quickSearch.do?quick_search_tab=Root",
				function (){
					$(".modal-contentSearch").load("${cPath}/quickSearch.do?quick_search_tab=Root #root");
				})
	}
	
	
//###################################################################################################################################################	
getArmList();
// 새로운 소식 목록
let NewArmBody = $('#NewArmBody');
// 지난 알림 목록
let OldArmBody = $('#OldArmBody');

// 알람 모두 읽기 버튼	
let allReadBtn = $('#allReadBtn').on('click', function() {
	$.ajax({
		url : CONTEXTPATH+"/arm/armAllRead.do",
		method : "get",
		dataType : "json",
		success : function(resp) {
			if(resp == 'OK'){
	            toastr.success('새로운 알림을 모두 읽음 처리 했습니다.');
	            getArmList();
	        }else if(resp == 'FAIL'){ 
	            toastr.error('새로운 알림을 모두 읽음 처리 중 오류가 발생 했습니다.');
	        }
		},
		error : function(errorResp) {
			console.log(errorResp.status);
			toastr.error('새로운 알림을 모두 읽음 처리 중 오류가 발생 했습니다.');
		}
	});
});

//알림 삭제
$(document).on('click','.armDelBtn',function(event){
	event.stopPropagation(); 
	let armNo = $(this).data("armno");
	
	$.ajax({
		url : CONTEXTPATH+"/arm/armDelete.do",
		method : "post",
 		data : {armNo : armNo},
		dataType : "json",
		success : function(resp) {
			if(resp == 'OK'){
	        }else if(resp == 'FAIL'){ 
	            toastr.error('알림 삭제 중 오류가 발생 했습니다.');
	        }
		},
		error : function(errorResp) {
			console.log(errorResp.status);
			toastr.error('알림 삭제 중 오류가 발생 했습니다.');
		}
	});
	return false;
});
// 알람 모두 삭제 버튼
let armDelAllBtn = $('#armDelAllBtn').on('click', function() {
	$.ajax({
		url : CONTEXTPATH+"/arm/armAllDelete.do",
		method : "post",
		dataType : "json",
		success : function(resp) {
			if(resp == 'OK'){
	            toastr.success('알림을 모두 삭제했습니다.');
	            getArmList();
	        }else if(resp == 'FAIL'){ 
	            toastr.error('알림 삭제 중 오류가 발생 했습니다.');
	        }
		},
		error : function(errorResp) {
			console.log(errorResp.status);
			toastr.error('알림 삭제 중 오류가 발생 했습니다.');
		}
	});
});
//알림 클릭
$(document).on('click','.readArm',function(){
	let armNo = $(this).data("armno");
	let url = $(this).data("url");
	$.ajax({
		url : CONTEXTPATH+"/arm/armRead.do",
		method : "post",
		data : {"armNo" : armNo},
		dataType : "json",
		success : function(res) {
			location.href= CONTEXTPATH+url;
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
	
});
// 새로운 소식 알림 숫자
let armCnt = $('.badge-notifications');

//#######################################################################################################################################
//알림목록 갱신 함수
function getArmList(){
	$.ajax({
		
		url : CONTEXTPATH+"/arm/armList.do",
		method : "get",
		dataType : "json",
		success : function(resp) {
			let newCnt = 0;
			let newCode ='';
			let oldCode ='';
			$(resp).each(function (i, arm) {
				// 프로필 유무로 이미지주소설정
				let empImg = `\${CONTEXTPATH}/resources/empImages/\${arm.empImg}`;
				if(!arm.empImg)
					empImg =`\${CONTEXTPATH}/resources/images/basicProfile.png`;
				// 읽음여부 표시	
				let readBadge = `<a href="javascript:void(0)" class="dropdown-notifications-read"><span class="badge badge-dot"></span></a>`;
				if(arm.armStat == 'Y')
					readBadge = '';
				
				let listCode = `<li class="d-flex list-group-item list-group-item-action dropdown-notifications-item readArm" data-armno="\${arm.armNo}" data-url="\${arm.armUrl}"
										<div class="flex-shrink-0 me-3">
											<div class="avatar">
												<img src="\${empImg}" alt class=" empListimgradius emplistimgsize" />
											</div>
										</div>
										<div class="flex-grow-1 mx-2">
											<p class="mb-0">\${arm.armCont}</p>
											<small class="text-muted">\${elapsedTimeA(arm.armTime)}</small>
										</div>
										<div class="flex-shrink-0 dropdown-notifications-actions">
											\${readBadge} 
											<a href="javascript:void(0)" class="dropdown-notifications-archive armDelBtn" data-armno="\${arm.armNo}"><span class="bx bx-x"></span></a>
										</div>
								</li>`;
								
				// 새로운 소식
				if(arm.armStat == 'N'){
					newCnt++;
					newCode += listCode;
					
				// 지난 알림
				}else{
					oldCode += listCode;
					
				}
				
			});
			if(newCnt == 0){
				armCnt.removeClass('badge badge-dot').html("");
			}else{
				armCnt.addClass('badge badge-dot').html(newCnt);
			}
			NewArmBody.html(newCode).trigger("create");
			OldArmBody.html(oldCode).trigger("create");

			
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
}
//#######################################################################################################################################
//경과시간 표현 함수
function elapsedTimeA(date) {
let start = new Date(date);
let end = new Date();

let diff = (end - start) / 1000;

let times = [
 { name: '년', milliSeconds: 60 * 60 * 24 * 365 },
 { name: '개월', milliSeconds: 60 * 60 * 24 * 30 },
 { name: '일', milliSeconds: 60 * 60 * 24 },
 { name: '시간', milliSeconds: 60 * 60 },
 { name: '분', milliSeconds: 60 },
];

for (let value of times) {
 let betweenTime = Math.floor(diff / value.milliSeconds);

 if (betweenTime > 0) {
   return `\${betweenTime}\${value.name} 전`;
 }
}
return '방금 전';
}
//#######################################################################################################################################
</script>

<!-- pwReset  -->
<script>
$(function() {

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

    
    
        $("#btn_pwSave").on("click", function(){
			var $newPass = $("#newPass"); 
			var $newPassConfirm = $("#newPassConfirm");

			console.log("pass confirm 확인", $newPass.val(), $newPassConfirm.val() )
			$("#hiddenEmpNo").val( ${authEmp.empNo} );
			$("#hiddenEmpPass").val($newPass.val() );
// 			console.log("empNo확인", $("#hiddenEmpNo").val() )
			
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
})  
</script> 

<script src="${cPath}/resources/js/leftMenuActive.js"></script>

