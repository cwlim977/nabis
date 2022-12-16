<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<style>
.pdtoast{
    left: 50%;
    position: fixed;
    transform: translate(-50%, 0px);
    z-index: 9999;
	top : 10px;
}
</style>    
    
<c:if test="${not empty tcmd }">   
  <div class="bs-toast toast fade show bg-primary pdtoast" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="true">
    <div class="toast-header ">
      <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body mb-2">
      ${tcmd }
    </div>
  </div>    
</c:if>     
    
    
<nav class="navbar navbar-light bg-white flex-md-nowrap w-100 p-0 ">
	<ul id="menuList" class="nav px-4 col fs-3 fw-bold py-3">
		<li id="menu${status.count }" class="nav-item text-nowrap headerMenu">
			<i class='nav-link active bx bx-chevron-left bx-md' style='float:left;' onclick="location.href='${cPath}/pay/payHome.do'"></i>
			<a class="nav-link active" href="#" style='float:left;'>정산템플릿 설정</a>
		</li>
	</ul>
</nav>


 <div class="border-bottom border-dark">
	<div class="ms-3 ">
		<ul id="subMenuList" class="nav nav-tabs pb-3 fs-5 fw-bold ">
			<li id="subMenu${status.count }" class="nav-item text-nowrap headerSubMenu">
				<a class="nav-link fs-big active" aria-current="page" 
						<c:choose>
						<c:when test="${not empty tmp.ptNo}">
							href="${cPath }/pay/tmpUpdate.do?ptNo=${tmp.ptNo}"
						</c:when>
						<c:otherwise>
							href="${cPath }/pay/tmpInsert.do"
						</c:otherwise>
						</c:choose>
				>기본 설정</a>
			</li>
			<li class="nav-item"><a class="nav-link fs-big active"
						aria-current="page" href="${cPath }/pay/payList.do?ptNo=${tmp.ptNo}">지급 항목</a></li>
			<li class="nav-item"><a class="nav-link fs-big active"
						aria-current="page" href="${cPath }/pay/dedList.do?ptNo=${tmp.ptNo}">공제 항목</a></li>
		</ul>

	</div>
</div>


<script>
$(".pdtoast").delay(2500).slideUp(800);

</script>