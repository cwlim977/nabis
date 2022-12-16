<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="${cPath }/resources/css/jhy.css" rel="stylesheet" type="text/css" />    
<nav class="navbar navbar-light bg-white flex-md-nowrap w-100 p-0 ">

	<ul class="nav px-3 col">
		<c:if test="${not empty menuList}">
			<c:forEach items="${menuList}" var="menu">
				<li class="nav-item text-nowrap"><a class="nav-link active"
					href="${cPath}${menu.menuURL}">${menu.menuText}</a></li>
			</c:forEach>
		</c:if>
		<button type="button" class="btn btn-primary btnaa" onclick="location.href='${cPath}/workflow/write/templates.do'" >작성하기</button>
	</ul>
</nav>