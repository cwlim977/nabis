<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav class="navbar navbar-light bg-white flex-md-nowrap w-100 p-0 ">
	<ul id="menuList" class="nav px-4 col fs-3 fw-bold py-3">
		<c:if test="${not empty menuList}">
			<c:forEach items="${menuList}" var="menu" varStatus="status">
				<li id="menu${status.count }" class="nav-item text-nowrap headerMenu">
					<a class="nav-link active" href="${cPath}${menu.menuURL}">
						<span>${menu.menuText}</span>
					</a>
				</li>
			</c:forEach>
		</c:if>
	</ul>
</nav>

<div class="bg-white border-bottom border-gray px-2">
	<div class="ms-3">
		<ul id="subMenuList" class="nav nav-tabs pb-3 fs-5 fw-bold ">
			<c:if test="${not empty subMenuList}">
				<c:forEach items="${subMenuList}" var="menu" varStatus="status">
					<li id="subMenu${status.count }" class="nav-item text-nowrap headerSubMenu">
						<a class="nav-link active text-secondary" href="${cPath}${menu.menuURL}">
							<span>${menu.menuText}</span>
						</a>
					</li>
				</c:forEach>
			</c:if>
		</ul>
	</div>
</div>
