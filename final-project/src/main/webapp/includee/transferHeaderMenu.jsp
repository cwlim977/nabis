<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="${cPath }/resources/css/jhy.css" rel="stylesheet" type="text/css" />


<nav class="navbar navbar-light bg-white flex-md-nowrap w-100 p-0 ">

	<ul class="nav px-4 col fs-3 fw-bold py-3">
		<c:if test="${not empty menuList}">
			<c:forEach items="${menuList}" var="menu" varStatus="status">
				<li id="menu${status.count }" class="nav-item text-nowrap headerMenu" >
					<a class="nav-link active" href="${cPath}${menu.menuURL}"><span>${menu.menuText}</span></a>
				</li>
			</c:forEach>
		</c:if>
		<button type="button" class="btn btn-primary btnaa me-2" data-bs-toggle="modal" data-bs-target="#modalScrollable">인사 발령하기</button>

	</ul>
</nav>

<div class="border-bottom border-gray">
	<div class="ms-3 ">
		<ul class="nav nav-tabs pb-3 fs-5 fw-bold " >
			<c:if test="${not empty subMenuList}">
				<c:forEach items="${subMenuList}" var="menu" varStatus="status">
					<li id="menu${status.count }" class="nav-item text-nowrap headerSubMenu"><a class="nav-link active text-dark" aria-current="page" href="${cPath}${menu.menuURL}">${menu.menuText}</a></li>
				</c:forEach>
			</c:if>

			<!-- 정렬 -->
			<div class="btn-group groupaa cnthide sortheader">
				<button type="button" class="btn btn-icon btn-outline-primary dropdown-toggle hide-arrow" data-bs-toggle="dropdown" aria-expanded="false">
					<i class='bx bx-sort'></i>
				</button>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item" href="javascript:void(0);">정렬 조건</a></li>
					<li><a class="dropdown-item" href="javascript:void(0);">정렬 순서</a></li>

				</ul>
			</div>


			<!-- 필터 검색 -->
			<div class="btn-group groupaa cnthide me-4">
				<button type="button" class="btn btn-icon btn-outline-primary dropdown-toggle hide-arrow" data-bs-toggle="dropdown" aria-expanded="false">
					<i class='bx bx-filter'></i>
				</button>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item" href="javascript:void(0);">라벨</a></li>
					<li><a class="dropdown-item" href="javascript:void(0);">상태</a></li>
					<li><a class="dropdown-item" href="javascript:void(0);">기간</a></li>
					<li><a class="dropdown-item" href="javascript:void(0);">담당자</a></li>

				</ul>
			</div>

		</ul>
	</div>
</div>




<!-- 발령하기 모달창  -->
<div class="modal fade" id="modalScrollable" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable" role="document">
		<div class="modal-content">
			<div class="modal-header px-5 mb-4">
				<h5 class="modal-title fs-3 fw-bold" id="modalScrollableTitle">발령</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body py-0 px-5 form-group">

				<div class="mb-3">
					<label class="form-label"><i class='bx bx-user'></i>발령 대상</label>
					<select id="asgmtDept" data-live-search="true" data-width="100%" data-size="6" class=" selectpicker selectlabel show-tick" data-style="border">
						<option value>전체 구성원</option>
						<c:forEach items="${deptList }" var="dept">
							<option value="${dept.dcode }">${dept.dnm }</option>>
						</c:forEach>
					</select>
				</div>

				<div class="mb-3">
					<label class="form-label"><i class='bx bx-label'></i>발령 라벨</label>
					<select id="asgmtClf" data-live-search="true" data-width="100%" data-size="6" class=" selectpicker selectlabel show-tick" data-style="border">
						<option value="">--발령 라벨 선택--</option>
						<c:forEach items="${labelList }" var="label">
							<option value="${label.codeNm }">${label.codeNm }</option>
						</c:forEach>
					</select>
				</div>

				<!-- 발령일 -->
				<div class="mb-3 row transmodal">
					<label class="col-md-2 col-form-label"><i class='bx bx-calendar-check'></i>발령일</label>
					<div class="">
						<input id="asgmtDate" class="form-control" type="date" value="" required/>
					</div>
				</div>

				<!-- 메모 -->
				<div class="mb-5">
					<label  class="form-label"><i class='bx bx-pencil'></i>메모</label>
					<textarea id="asgmtMm" class="form-control" rows="3"></textarea>
				</div>

			</div>
			<div class="modal-footer px-5 ">
				<button type="button" class="btn btn-primary noticebtn m-0" id="transModalBtn" data-bs-dismiss="modal" data-bs-toggle="offcanvas">
					<i class='bx bx-pencil'></i>작성하기
				</button>
			</div>
		</div>
	</div>
</div>


<!-- 캔버스창 -->
<div class="offcanvas offcanvas-bottom" tabindex="-1" id="offcanvasBottom" style="height: 100vh;">
	<button type="button" class="btn-close text-reset m-0" data-bs-dismiss="offcanvas" aria-label="Close"></button>
	<div class="offcanvas-header border-bottom py-3">
		<h5 class="offcanvas-title mx-3 fw-bold">인사발령하기</h5>
		<button id="addAsgmtBtn" type="button" class="btn btn-primary ms-auto me-2 me-2">
			발령하기 <i class='bx bx-check mb-1'></i>
		</button>
	</div>
	<div class="offcanvas-body p-0" >


		<div class="card-body p-0">
			<div class="text-nowrap">
				<table id="tableTarget" class="table table-bordered table-hover" >
					<thead>
						<tr>
							<th class="w-px-30">
								<input id="chkAll" class="form-check-input align-middle w-px-20 h-px-20 border-2 transTableth" type="checkbox" value="">
							</th>

							<th class="transTableth2">이름</th>
							<th>사번</th>
							<th>직무</th>
							<th class="transTableth3">조직·직책·조직장</th>
							<th>직위</th>
							<th>직급</th>

						</tr>
						<tr class="inputoutline">
							<th>구분</th>
							<th><input id="empNameSearchText" placeholder="검색" class="border-0" /></th>
							<th><input id="empNoSearchText" placeholder="검색" class="border-0" /></th>
							<th><input id="jobSearchText" placeholder="검색" class="border-0" /></th>
							<th><input id="deptSearchText" placeholder="검색" class="border-0" /></th>
							<th><input id="pstnSearchText" placeholder="검색" class="border-0" /></th>
							<th><input id="grdSearchText" placeholder="검색" class="border-0" /></th>
						</tr>
					</thead>
					<tbody id="tbodyResult">

					</tbody>
				</table>

			</div>
		</div>


	</div>
</div>






<!-- 조직 직책 선택 모달창 -->
<div class="modal fade" id="basicModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel1">입력하기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<label class="form-label">조직 / 직책</label> <br>
				<form id="modalForm">
					<div id="deptBody">
					
						<div class="mb-2 mainDeptCheck">
							<div class=" mb-4 ">
								<div class="d-flex ">
									<div class="form-check pt-2">
										<input name="deptList[][mainck]" class="form-check-input" type="radio" value="Y" checked />
									</div>
	
									<div class="input-group">
										<select name="deptList[][dcode]" class="form-select selectDept">
											<option value>조직</option>
											<c:forEach items="${deptList}" var="dept">
												<option value="${dept.dcode}" label="${dept.dnm}" />
											</c:forEach>
										</select>
										<select name="deptList[][dtcode]" class="form-select">
											<option value>직책(선택)</option>
											<c:forEach items="${dutyList}" var="duty">
												<option value="${duty.dtcode}" label="${duty.dtnm}" />
											</c:forEach>
										</select>
	
										<div class="input-group-text">
											<div class="form-check mt-0">
												<input name="deptList[][dno]" class="form-check-input dnoList" type="checkbox" value="1" /> <label class="form-check-label"> 조직장 </label>
											</div>
										</div>
									</div>
									<button type="button" class="btn btn-icon btn-outline-danger ms-2" name="deptRemoveBtn" id="hideBtn">
										<i class='bx bx-x'></i>
									</button>
								</div>
							</div>
						</div>
	
					</div>
				</form>
				<!-- 조직 추가 버튼 -->
				<button type="button" class="btn btn-outline-primary mb-4" id="deptAddBtn">
					<span class="bx-plus bx bx-pie-chart-alt"></span>&nbsp; 조직 추가
				</button>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
				<button id="saveDeptBtn" type="button" class="btn btn-primary">입력하기</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" defer="defer">
let empRole = "${requestScope['empRole']}";

$('.headerMenu, .headerSubMenu').each(function(){
	switch($(this).attr('id')){
		case 'menu1':
			break;
		case 'menu2':
			if(!(empRole == 'admin' || empRole == 'manager') ) $(this).hide();
			$(this).find('span').addClass('text-dark');
			break;
		case 'subMenu1':
			if(menuUrl == '/emp/empList.do') $(this).find('span').addClass('text-dark');
			break;
		default:
			$(this).hide();
	}
});
</script>
<script src="${cPath}/resources/js/transferHeaderMenu.js"></script>
<!-- <script src="https://kit.fontawesome.com/6ef361a288.js" crossorigin="anonymous"></script> -->
