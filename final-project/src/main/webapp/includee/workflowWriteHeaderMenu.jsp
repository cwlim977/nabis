<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link href="${cPath }/resources/css/jhy.css" rel="stylesheet" type="text/css" />    
<nav class="navbar navbar-light bg-white flex-md-nowrap w-100 p-0 ">

	<ul class="nav px-3 col">
		<c:if test="${not empty menuList}">
			<c:forEach items="${menuList}" var="menu">
				<li class="nav-item text-nowrap">
					<a class="nav-link active" href="${cPath}${menu.menuURL}">${menu.menuText}</a>
				</li>
			</c:forEach>
		</c:if>
		
	</ul>
			<!-- 검색창 -->
	<form class="d-flex searchaa cnthide" >
		<div class="input-group cnthide">
			<span class="input-group-text"><i
				class="tf-icons bx bx-search"></i></span> <input type="text"
				class="form-control" placeholder="양식 검색" />
		</div>
	</form>
		
</nav>