<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>

<div id="root" >
	<div class="modal-content">
		<div style="visibility:hidden; opacity: 1; transform: translateX(0px) translateY(-100%) translateZ(0px);">
			<kbd class="c-PCfGg" >빠른 검색</kbd>
		</div>
		<div class="modal-header">
			<form id="searchForm" class="">
				<i class='bx bxs-bolt' ></i>
				<input type="text" name="" placeholder="검색어 입력">
			</form>
		</div>
		
		<div class="modal-body">
			<ul class="">
				<li class="menu-item">
	            	<a href="#" class="menu-link" onclick="tabEmp();">
		                <i class="menu-icon tf-icons bx bx-calculator"></i>
		                <div data-i18n="Basic">구성원 검색</div>
	            	</a>
	            </li>
	            
				<li class="menu-item">
					<a href="#" class="menu-link" onclick="tabWorkflow();"> 
						<i class='menu-icon tf-icons bx bx-file-find'></i>
						<div data-i18n="Analytics">워크플로우 검색</div>
					</a>
				</li>
				
				<li class="menu-item">
					<a href="#" class="menu-link" onclick="tabWork();"> 
						<i class='menu-icon tf-icons bx bx-alarm'></i>
						<div data-i18n="Analytics">근무 기록</div>
					</a>
				</li>
				
				<li class="menu-item">
					<a href="#" class="menu-link" onclick="tabWorkflowWrite();"> 
						<i class='menu-icon tf-icons bx bx-edit' ></i>
						<div data-i18n="Analytics">워크플로우 작성</div>
					</a>
				</li>
			</ul>
		</div>
		
		<div class="modal-footer">
			<button type="button" class="btn btn-secondary"
				data-bs-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		</div>
	</div>
</div>


<!-- 구성원 검색Modal -->
<div id="empModal" class="modal-content">
	<div style="opacity: 1; transform: translateX(0px) translateY(-100%) translateZ(0px);">
		<kbd class="c-PCfGg">구성원 검색</kbd>
	</div>
	
   	<div class="modal-header">
		<a id="backBtn" class="menu-link" onclick="back();">
			<i class='bx bx-chevron-left' ></i>
			<input type="text" name="" placeholder="검색어 입력">
		</a>
	</div>
</div>


<!-- 워크플로우 검색Modal -->
<div id="workflowModal" class="modal-content">
	<div style="opacity: 1; transform: translateX(0px) translateY(-100%) translateZ(0px);"
			class="c-dhzjXW c-dhzjXW-irEjuD-align-stretch c-dhzjXW-awKDG-justify-start c-dhzjXW-ejCoEP-direction-row c-dhzjXW-kVNAnR-wrap-noWrap c-dhzjXW-idXuYwI-css">
		<kbd class="c-PCfGg">워크플로우 검색</kbd>
	</div>
	
   	<div class="modal-header">
   		<a id="backBtn" class="menu-link" onclick="back();">
			<i class='bx bx-chevron-left' ></i>
			<input type="text" placeholder="검색어 입력">
		</a>
	</div>
</div>


<!-- 근무 기록 -->



<!-- 워크플로우 검색Modal -->
<div id="workflowWriteModal" class="modal-content">
	<div style="opacity: 1; transform: translateX(0px) translateY(-100%) translateZ(0px);"
			class="c-dhzjXW c-dhzjXW-irEjuD-align-stretch c-dhzjXW-awKDG-justify-start c-dhzjXW-ejCoEP-direction-row c-dhzjXW-kVNAnR-wrap-noWrap c-dhzjXW-idXuYwI-css">
		<kbd class="c-PCfGg">워크플로우 작성하기</kbd>
	</div>
	
   	<div class="modal-header">
   		<a id="backBtn" class="menu-link" onclick="back();">
			<i class='bx bx-chevron-left' ></i>
			<input type="text" placeholder="검색어 입력">
		</a>
	</div>
	
	<div class="modal-body">
		<ul class="">
			<li class="menu-item">
				전체
			</li>
			<li class="menu-item">
				구매 신청
			</li>
			<li class="menu-item">
				복리 후생
			</li>
			<li class="menu-item">
				비용 처리
			</li>
			<li class="menu-item">
				계약
			</li>
			<li class="menu-item">
				업무 신청
			</li>
		</ul>
		<hr>
	</div>
	
</div>




<script>

	function tabEmp(){
		$(".modal-content").load("${cPath}/quickSearch.do?quick_search_tab=Root #empModal");
	}
	
	function tabWorkflow(){
		$(".modal-content").load("${cPath}/quickSearch.do?quick_search_tab=Root #workflowModal");
	}
	
	function tabWork(){
		//근무 탭으로 이동
	}
	
	function tabWorkflowWrite(){
		$(".modal-content").load("${cPath}/quickSearch.do?quick_search_tab=Root #workflowWriteModal");
	}
	
	function back(){
		console.log("back")
		$(".modal-content").load("${cPath}/quickSearch.do?quick_search_tab=Root #root" );
	}
</script>






