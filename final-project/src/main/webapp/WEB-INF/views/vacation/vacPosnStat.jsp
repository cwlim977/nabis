<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<script>

	$('.headerMenu, .headerSubMenu').each(function(){
		switch($(this).attr('id')){
			case 'menu1':
				break;
			case 'menu2':
				$(this).find('span').addClass('text-dark');
				break;
			case 'subMenu3':
				$(this).find('span').addClass('text-dark');
				break;
			case 'subMenu4':
				break;
			default:
				$(this).hide();
		}
	});
	
	$(function(){
		
		let deptDropContainer = $('#deptDropContainer');
		let vacDropContainer = $('#vacDropContainer');
		let deptList = deptDropContainer.find('#deptList');
		let vacList = vacDropContainer.find('#vacList');
		let deptCheckBoxList = deptList.find('.deptCheckBox');
		let vacCheckBoxList = vacList.find('.vacCheckBox');
		$('#deptCntTag').text(deptList.children().length);
		$('#vacCntTag').text(vacList.children().length);
		let deptCheckBoxAll = deptDropContainer.find('#deptCheckBoxAll').click(function(){
			if(deptCheckBoxAll.is(":checked")) deptCheckBoxList.prop("checked", true);
			else deptCheckBoxList.prop("checked", false);
		});
		let vacCheckBoxAll = vacDropContainer.find('#vacCheckBoxAll').click(function(){
			if(vacCheckBoxAll.is(":checked")) vacCheckBoxList.prop("checked", true);
			else vacCheckBoxList.prop("checked", false);
		});
		
		/* 비 동 기 */
		
		let table = $('table');
		let tbody = table.find('tbody');
		let columnList = [];
		table.find('th').each(function(i, e){columnList.push($(e).attr('id'));});
		
		function realTimeSearch(obj){
			console.log(obj);
			let jsonData = JSON.stringify(obj);
			$.ajax({
				url : "${cPath}/memberVacation/vacPosnStatSearch.do",
				method : "post",
				data : jsonData,
				contentType : 'application/json; charset=utf-8',
				dataType : "json",
				success : function(resp) {
					if(resp['status'] == 'success'){
						tbody.empty();
						let totalTrTag = [];
						let searchList = resp.pagingVO.dataList;
						console.log(searchList);
						searchList.forEach(function(e, i){
							let trTag = ['<tr class="cell-fit">', ['<td>', e['empNm'], '</td>'].join(''), ['<td>', e['empNo'], '</td>'].join('')];
							let vacPosnList = e['vacPosnList'];
							columnList.forEach(function(e, i){
								if(i > 1){
										let tdTag = null;
										let colListEle = e;
										vacPosnList.forEach(function(e, i){
											let vpListEle = e;
											if(colListEle == vpListEle['vclfCode']) tdTag = ['<td>', vpListEle['vpDays'], '</td>'].join('');			
										});
										if(tdTag == null) tdTag = '<td>0</td>';
										trTag.push(tdTag);
								}
							});
							trTag.push('</tr>');
							totalTrTag.push(trTag.join(''));
						});
						tbody.append(totalTrTag.join(''));
						pagingArea.html(resp.pagingVO.pagingHtml);
					}
				},
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			}); 
		};
		
		let searchObj = {
			deptList : [],
			vacList : [],
			empNm : '',
			page : 1
		};
		
		$('.deptCheckBox').on('change', function(){
			let deptList = [];
			deptCheckBoxList.each(function(i, e){
				let chkBox = $(e);
				if(chkBox.is(":checked")) deptList.push(chkBox.val());
			});
			searchObj['deptList'] = deptList;
			searchObj['page'] = 1;
			realTimeSearch(searchObj);
		});
		
		$('.vacCheckBox').on('change', function(){
			let vacList = [];
			vacCheckBoxList.each(function(i, e){
				let chkBox = $(e);
				if(chkBox.is(":checked")) vacList.push(chkBox.val());
			});
			searchObj['vacList'] = vacList;
			searchObj['page'] = 1;
			realTimeSearch(searchObj);
		});
		
		$('#searchInput').on('keyup', function(){
			searchObj['empNm'] = $(this).val();
			searchObj['page'] = 1;
			realTimeSearch(searchObj);
		});
		
		let pagingArea = $(".pagingArea").on("click", "a", function(event) {
			event.preventDefault();
			let page = $(this).data('page');
			if(!page) return false;
			searchObj['page'] =  page;
			realTimeSearch(searchObj);
			return false;
		});
		
		/* 비 동 기 */		
		
		realTimeSearch(searchObj);
		
	});
	
</script>

<div class="container-xl flex-grow-1 container-p-y">
		<div class="container-lg container-p-y d-flex justify-content-between border border-bottom-0 rounded">
			<div class="container-md d-flex ustify-content-between">
				<div class="btn-group">
					<button class="btn dropdown-toggle border rounded" type="button" data-bs-toggle="dropdown">
						<i class="bx bx-menu"></i> 
							조직 선택 하기
						<span class="text-success" id="deptCntTag"></span>
					</button>
					<div class="dropdown-menu" id="deptDropContainer">
						<div class="form-check mx-3">
						     <input class="form-check-input deptCheckBox chkAll" type="checkbox" id="deptCheckBoxAll"/>
						     <label class="form-check-label" for="deptCheckBoxAll">전체</label>
						</div>
						<hr class="dropdown-divider">
						<div id="deptList">
							<c:forEach items="${listMap['deptList']}" var="deptVo" varStatus="vs">
								<div class="form-check mx-3">
								     <input class="form-check-input deptCheckBox" type="checkbox" id="deptCheckBox${vs.count}" value="${deptVo['dcode']}"/>
								     <label class="form-check-label" for="deptCheckBox${vs.count}">${deptVo['dnm']}</label>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="btn-group w-px-250">
				  <button class="btn dropdown-toggle border rounded" type="button" id="dropdownMenuButtonIcon" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				    <i class="bx bx-menu"></i> 
				    	휴가 선택 하기
				    <span class="text-success" id="vacCntTag"></span>
				  </button>
				  <div class="dropdown-menu" id="vacDropContainer">
					<div class="form-check mx-3">
					     <input class="form-check-input vacCheckBox chkAll" type="checkbox" id="vacCheckBoxAll"/>
					     <label class="form-check-label" for="vacCheckBoxAll">전체</label>
					</div>
					<hr class="dropdown-divider">
					<div id="vacList">
						<c:forEach items="${listMap['vacList']}" var="vacVo" varStatus="vs">
							<div class="form-check mx-3">
							     <input class="form-check-input vacCheckBox" type="checkbox" id="vacCheckBox${vs.count}" value="${vacVo['vclfCode']}"/>
							     <label class="form-check-label" for="vacCheckBox${vs.count}">${vacVo['vcNm']}</label>
							</div>
						</c:forEach>
					</div>
				  </div>
				</div>
			</div>
			<div class="container-md w-px-250">
				<div class="input-group input-group-merge">
					<input type="text" class="form-control text-center" placeholder="이름 검색하기" id="searchInput"/>
					<span class="input-group-text"><i class="bx bx-search"></i></span>
				</div>
			</div>
		</div>
	    <div class="table-responsive">
	        <table class="table table-bordered table-hover fw-semibold text-center">
	          <thead>
	            <tr class="cell-fit">  
	              <th id="empNm">
	              	<h6>
	              		이름
	              	</h6>
	              </th>
	              <th id="empNo">
	              	<h6>
	              		사번
	              	</h6>
	              </th>
	              <c:forEach items="${listMap['vacList']}" var="vacVo" varStatus="vs">
	              	<th id="${vacVo['vclfCode']}">
		              	<h6>
		              		${vacVo['vcNm']}
		              	</h6>
		              		<small>
		              		${vacVo['vcGmtd']} 
		              		(${vacVo['vcGdays']}일)
		              		</small>	
	              	</th>
	              </c:forEach>
	            </tr>
	          </thead>
	          <tbody>
	          </tbody>
	        </table>
	        <div class="pagingArea mt-3"></div>
	   	</div>
</div>
<!-- <script>
	$(function(){
		let content = "<button type='button' class='btn btn-primary'>";
		$('[data-toggle="popover"]').popover({
			triger : 'focus',
			title : '조직도',
			placement : 'bottom',
			offset : '0,14',
			html : true,
			content : content
		}); 
	});
</script> -->