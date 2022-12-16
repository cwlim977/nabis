<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>

<div id="root" >
	<div class="modal-content">
		<div class="modal-header">
			<h3 class="modal-title" id="modalCenterTitle">계정 및 환경 설정</h3>
			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		</div>
		<div class="modal-body">
			<div class="row mt-3">
				<div class="d-grid gap-2 col-lg-12 mx-auto">
					<button type="button" class="btn btn-primary btn-lg" onclick="tabAccount();">
						<i class='menu-icon tf-icons bx bxs-envelope'></i>
						<div data-i18n="Analytics">이메일 변경</div>
					</button>
				</div>
			</div>
			<div class="row mt-3">
				<div class="d-grid gap-2 col-lg-12 mx-auto">
					<button type="button" class="btn btn-primary btn-lg" onclick="tabPassword();">
						<i class='menu-icon tf-icons bx bxs-key'></i>
						<div data-i18n="Analytics">비밀번호 변경</div>
					</button>
				</div>
			</div>
		</div>
		<div class="modal-footer">
		</div>
	</div>
</div>




		
		
<!-- 이메일 변경 Modal -->		
<div id="account" class="modal-content">
	<div class="modal-header">
		<div>
			<button id="backBtn" type="button" class="btn btn-icon btn-outline-secondary" onclick="back();">
				<i class='bx bx-chevron-left'></i>
			</button>
		 	<span class="modal-title" id="modalCenterTitle">이메일 변경</span>
		</div>
	</div>
	<div class="modal-body">
		<div class="row">
			<div class="col mb-3">
				<label for="nameWithTitle" class="form-label">이메일</label> 
				<label  class="form-label">변경할 이메일을 입력하세요</label> 
				<input type="text" id="nameWithTitle" class="form-control"
					placeholder="" />
			</div>
		</div>
	
	</div>

	<div class="modal-footer">
		<button type="button" class="btn btn-primary">변경하기</button>
	</div>
</div>

<!-- 비밀번호 변경 Modal -->		
<div id="password" class="modal-content">
	<div class="modal-header">
		<div>
			<button id="backBtn" type="button" class="btn btn-icon btn-outline-secondary" onclick="back();">
				<i class='bx bx-chevron-left'></i>
			</button>
		 	<span class="modal-title" id="modalCenterTitle">비밀번호 변경</span>
		</div>
	</div>
	
	<div class="modal-body">
		<div class="row">
			<div class="col mb-3">
				<label for="nameWithTitle" class="form-label">비밀번호</label> 
				<label class="form-label">현재 비밀번호를 입력하세요</label> 
				<input type="text" id="nameWithTitle" class="form-control" 
					placeholder="현재 비밀번호" />
			</div>
		</div>
		<div class="row">
			<div class="col mb-3">
				<label for="nameWithTitle" class="form-label">새 비밀번호</label> 
				<label class="form-label">변경할 비밀번호를 입력하세요</label> 
				<input type="text" id="nameWithTitle" class="form-control" placeholder="새 비밀번호" />
				<input type="text" id="nameWithTitle" class="form-control" placeholder="새 비밀번호 확인" />
			</div>
		</div>
	</div>
	
	<div class="modal-footer">
		<button type="button" class="btn btn-primary">변경하기</button>
	</div>
</div>



<script>

	function tabAccount(){
		$(".modal-content").load("${cPath}/mySetting.do?my_setting_tab=Root #account");
		
	}
	
	function tabPassword(){
		$(".modal-content").load("${cPath}/mySetting.do?my_setting_tab=Root #password");
		$(".modal-content").html(data);
		
	}
	
	function back(){
		console.log("back")
		$(".modal-content").load("${cPath}/mySetting.do?my_setting_tab=Root #root" );
	}
</script>