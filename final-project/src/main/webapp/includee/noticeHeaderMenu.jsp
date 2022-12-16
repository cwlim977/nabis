<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<style>
 .btnPass {
	margin-left: auto;
	height: 46px;
}
</style>
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
			<security:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')">
			<button type="button" class="btn btn-primary btnPass" data-bs-toggle="modal" data-bs-target="#passNoticeModal" >공지사항 작성하기</button>
			</security:authorize>
		</c:if>
		
	</ul>
</nav>

<div class="border-bottom border-dark">
	<div class="ms-3">
		<ul id="subMenuList" class="nav nav-tabs  pb-3 fs-6 fw-bold ">
			<c:if test="${not empty subMenuList}">
				<c:forEach items="${subMenuList}" var="menu" varStatus="status">
					<li id="subMenu${status.count }" class="nav-item text-nowrap headerSubMenu">
						<a class="nav-link active fs-large" href="${cPath}${menu.menuURL}">
							<span id="menuText">${menu.menuText}</span>
						</a>
					</li>
				</c:forEach>
			</c:if>
		</ul>
	</div>
</div>



	<!-- Button trigger modal -->


<!-- Modal 0-->
<div class="modal fade" id="passModal" aria-labelledby="modalToggleLabel" tabindex="-1" style="display: none;" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
    
		<div class="modal-header mx-4 d-block">
			<div> <p class="h3">전달내용</p> </div>
			<div> <p class="h6">아래에서 전달하고 싶은 내용을 선택하세요.</p> </div>
		</div>
		
		<div class="modal-body mx-4 pb-0">
			<div class="table-responsive">
				<table class="table table-hover">
				    <tr>
				      <td>
				      	<div data-bs-target="#passNoticeModal" data-bs-toggle="modal" data-bs-dismiss="modal">
				      		<i class='bx bx-pin'></i><strong>공지사항 작성</strong>
				      	</div>
			      	  </td>
				    </tr>
				    <tr>
				      <td>
				        <div data-bs-target="#passTodoModal" data-bs-toggle="modal" data-bs-dismiss="modal">
				        	<i class='bx bx-check-circle' ></i><strong>할 일 보내기</strong>
				        </div> 
				      </td>
				    </tr>
				</table>
			</div>
		</div>
		
		<div class="modal-footer mx-4 ">
			
		</div>
		
    </div>
  </div>
</div>		
			

<div class="modal fade" id="passNoticeModal" aria-hidden="true" aria-labelledby="modalToggleLabel2" tabindex="-1">
	  <div class="modal-dialog modal-dialog-centered">
    	<div class="modal-content">
			<div id="passNoticeCont">
	
			</div>
		</div>
	</div>
</div>

<!-- Todo Modal -->
<div class="modal fade" id="passTodoModal" aria-hidden="true" aria-labelledby="modalToggleLabel3" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
    
      <div class="modal-header">
        <h5 class="modal-title" id="modalToggleLabel2">할 일 보내기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <div class="modal-body">
        Hide this modal and show the first with the button below.
      </div>
      
      <div class="modal-footer">
        <button class="btn btn-primary" data-bs-target="#passModal" data-bs-toggle="modal" data-bs-dismiss="modal">Back to first</button>
      </div>
      
    </div>
  </div>
</div>
	
<script>
$("#passNoticeModal").on("show.bs.modal", function (e){
	
	$.ajax({
		url : "${cPath}/notice/noticeInsert.do",
		method : "GET",
		dataType : "html",
		success : function(resp) {
			$("#passNoticeCont").html( resp ); 
// 			console.log("resp확인", resp);
	        var noticeModalDiv = $("#passNoticeCont");
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
})
</script>
