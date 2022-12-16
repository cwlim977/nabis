<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<link href="${cPath }/resources/css/jhy.css" rel="stylesheet" type="text/css" />
<script src="https://kit.fontawesome.com/6ef361a288.js"
	crossorigin="anonymous"></script>
<nav class="navbar navbar-light bg-white flex-md-nowrap w-100 p-0 ">

	<ul class="nav px-4 col fs-3 fw-bold py-3">
		<c:if test="${not empty menuList}">
			<c:forEach items="${menuList}" var="menu" varStatus="status">
				<li id="menu${status.count }" class="nav-item text-nowrap headerMenu">
				<a class="nav-link active" href="${cPath}${menu.menuURL}"><span>${menu.menuText}</span></a></li>
			</c:forEach>
		</c:if>
		<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')">
			<button type="button" class="btn btn-primary btnaa" onclick="location.href='${cPath}/emp/empForm.do'" >구성원 추가하기</button>
		</security:authorize>
	</ul>
</nav>

<div class="border-bottom border-gray px-2">
	<div class="ms-3 ">
		<ul class="nav nav-tabs pb-3 fs-5 fw-bold">
			<c:if test="${not empty subMenuList}">
				<c:forEach items="${subMenuList}" var="menu" varStatus="status">
					<li id="subMenu${status.count }"class="nav-item text-nowrap headerSubMenu">
						<a class="nav-link fs-big active text-secondary"
							aria-current="page" href="${cPath}${menu.menuURL}"><span>${menu.menuText}</span></a></li>
				</c:forEach>
			</c:if>
			
		
			<!-- 검색창 -->
			<form class="d-flex searchaa cnthide" >
				<div class="input-group cnthide">
					<span class="input-group-text"><i
						class="tf-icons bx bx-search"></i></span> 
					<input id="empNameSearchText" type="text" class="form-control" placeholder="Search..." />
				</div>
			</form>

			<!-- 정렬 -->
			<div class="btn-group groupaa cnthide" >
				<button type="button"
					class="btn btn-icon btn-outline-primary dropdown-toggle hide-arrow"
					data-bs-toggle="dropdown" aria-expanded="false">
					<i class='bx bx-sort'></i>
				</button>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item" href="javascript:void(0);">정렬
							조건</a></li>
					<li><a class="dropdown-item" href="javascript:void(0);">정렬
							순서</a></li>

				</ul>
			</div>
			
			<!-- 조직도  -->
			<button type="button" id="deptBtn" data-on="off" class="btn btn-icon btn-outline-primary treebtn cnthide">
				<i class="fa-solid fa-folder-tree"></i>
			</button>
			<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')">
			<!-- 다운로드 -->
			<button type="button"  class="btn btn-icon btn-outline-primary downloadbtn cnthide" onclick="location.href='${cPath}/emp/excelDown.do' ">
				<i class='bx bxs-download'></i>
			</button>

			<!-- 화면 선택 -->
			<div class="btn-group gridbtn cnthide"  role="group"
				aria-label="Basic radio toggle button group">
				<input type="radio" class="btn-check" name="btnradio" id="btnradio1"
					  onclick="location.href='${cPath}/emp/empList.do'" /> 
					<label class="btn btn-icon btn-outline-primary" for="btnradio1"  ><i class="fa-solid fa-table-list"></i></label> 
					<input type="radio"class="btn-check" name="btnradio" id="btnradio3" onclick="location.href='${cPath}/emp/empTable.do'" />
				    <label class="btn btn-icon btn-outline-primary" for="btnradio3"><i class="fa-solid fa-table"></i></label>
			</div>
		  	</security:authorize>
		</ul>
	</div>
</div>


<script type="text/javascript" defer="defer">
let empRole = "${requestScope['empRole']}";

$('.headerMenu, .headerSubMenu').each(function(){
	switch($(this).attr('id')){
		case 'menu1':
			$(this).find('span').addClass('text-dark');
			break;
		case 'menu2':
			if(!(empRole == 'admin' || empRole == 'manager') ) $(this).hide();
			break;
		case 'subMenu1':
			if(menuUrl == '/emp/empList.do') $(this).find('span').addClass('text-dark');
			if(menuUrl == '/emp/empTable.do') $(this).find('span').addClass('text-dark');
			break;
		case 'subMenu2':
			if(menuUrl == '/emp/cntStatusList.do') $(this).find('span').addClass('text-dark');
			if(!(empRole == 'admin' || empRole == 'manager')) $(this).hide();
			break;
		default:
			$(this).hide();
	}
});

//조직도 열기 버튼
$('#deptBtn').on('click', function() {
	if($(this).data('on') == 'off'){
		$('#deptDiv').show();
		$(this).data('on','on');
		
	}else{
		$('#deptDiv').hide();
		$(this).data('on','off');
		
	}

});
</script>