<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="${cPath }/resources/css/jhy.css" rel="stylesheet" type="text/css" />
<nav class="navbar navbar-light bg-white flex-md-nowrap w-100 p-0 ">
	<ul id="menuList" class="nav px-4 col fs-3 fw-bold py-3">
		<li class="nav-item text-nowrap headerMenu">
			<a class="nav-link active" href="${cPath}/work/members.do">
				&lt; &nbsp; 
				<img src="${cPath}/resources/images/basicProfile.png" alt="Avatar" class="empListimgradius emplistimgsize">
				&nbsp; <span>${empVO.empNm}님의 근무</span>
			</a>
		</li>
	</ul>
</nav>

