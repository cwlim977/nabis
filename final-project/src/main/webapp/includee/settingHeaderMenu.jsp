<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-light bg-white flex-md-nowrap w-100 p-0 ">

	<ul class="nav px-4 col fs-3 fw-bold py-3">
			<li class="nav-item text-nowrap headerMenu">
				<a class="nav-link active" href="#">설정</a>
			</li>
	</ul>
</nav>

<div class="border-bottom border-dark">
	<div class="ms-3 ">
		<ul class="nav nav-tabs pb-3 fs-5 fw-bold">
			<c:if test="${not empty subMenuList}">
				<c:forEach items="${subMenuList}" var="menu">
					<li class="nav-item text-nowrap headerSubMenu">
						<a class="nav-link active text-secondary"
						aria-current="page" href="${cPath}${menu.menuURL}">${menu.menuText}</a></li>
				</c:forEach>
			</c:if>
		</ul>

	</div>
</div>