<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link href="${cPath }/resources/css/jhy.css" rel="stylesheet" type="text/css" />
<style>
#deptDiv{
/* 	position: sticky; */
/*     top: 100px; */
/*     left: 1605px; */
    
    width: 340px;
    height: 780px;
    z-index: 100;
    box-shadow: rgba(50, 50, 93, 0.25) 0px 13px 27px -5px, rgba(0, 0, 0, 0.3) 0px 8px 16px -8px;
}
</style>

<!-- 툴팁 확대 효과 data-bs-toggle="tooltip" data-popup="tooltip-custom"
 -->
<div id="gridDiv" class="d-flex">
	<div class="flex" style=" width: -webkit-fill-available;">
	<div class="card-body px-0 py-0 filterdiv" style="height: 55px;">
		<div class="filterinsidediv d-flex">
		<div class="btn-group filterbtn">
		
		<!-- 필터 추가하기 -->
			<button type="button" class="btn btn-outline-primary dropdown-toggle btn-sm"
				data-bs-toggle="dropdown" aria-expanded="false">
				<i class="fa-solid fa-filter"></i>필터 추가하기</button>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="javascript:void(0);">직위</a></li>
				<li><a class="dropdown-item" href="javascript:void(0);">직무</a></li>
				<li><a class="dropdown-item" href="javascript:void(0);">직급</a></li>
				<li>
					<hr class="dropdown-divider" />
				</li>
				<li><a class="dropdown-item" href="javascript:void(0);">직책</a></li>
			</ul>
		</div>
	
		<div class="ms-auto">
			<span id="totalRecord"></span>명
			<button id="filterResetBtn"type="reset" class="btn btn-outline-primary btn-sm"> 필터 초기화 </button>
		</div>
		</div>
	</div>
	<div class="col-lg">	
		<div class=" ">
			<ul id="listBody" class="list-group ligroup">
	
			</ul>
		</div>
	</div>
	<div class="pagingArea mt-3"></div>
	
	</div>
	<div class="flex" id="deptDiv" style="display:none; ">
			
			
	</div>
	
	
	
</div>
<form id="searchForm">
	<input type="hidden" name="page" value="1"/>
	<input type="hidden" name="searchType" value=""/>
	<input type="hidden" name="searchWord" value=""/>
	<input type="hidden" name="dcode" value=""/>
</form>

<%-- 조직도 설정 --%>
<div id="set_originTree" style="display: none"></div>
<script id="set_wrapScript" type="text/javascript" defer="defer"></script>
<%-- /조직도 설정 --%>

<script type="text/javascript" defer="defer">
//메인 컨테이너 클래스 삭제
$('#gridDiv').closest('.container-xxl').removeClass( 'container-xxl flex-grow-1 container-p-y' );
// 조직도 트리
let $deptTree = null;
let $filterResetBtn = $('#filterResetBtn').on('click', function() {
	// 조직도 선택 해제
	$deptTree.jstree("deselect_all");
	
	searchForm.find(':input[name=page]').val(1);
	searchForm.find(':input[name=dcode]').val('');
	searchForm.submit();
});

//###############################################################################################################################

let searchForm = $('#searchForm');

let pageTag = $("[name=page]");
let pagingArea = $(".pagingArea").on("click", "a", function(event) {
	event.preventDefault();
	let page = $(this).data('page');
	if(!page) return false;
	pageTag.val(page);
	searchForm.submit();
	return false;
});
//사원리스트 호출
getEmpList(searchForm, pagingArea);
//###############################################################################################################################
// 사원 리스트 비동기 갱신
function getEmpList(searchForm, pagingArea){

	let listBody = $('#listBody');
	let totalRecord = $('#totalRecord');
	
	searchForm.on("submit", function(event) {
		event.preventDefault();
		pagingArea.empty();
		
		let form = this;
		let url = this.action;
		let data = $(this).serialize();
		
		$.ajax({
			url : url,
			data : data,
			dataType : "json",
			success : function(resp) {
				
				let pagingVO = resp;
				let empList = pagingVO.dataList;
				
				let htmlCode ="";
				if(empList.length <= 0){
					htmlCode = `<li class="my-3"><h5>구성원이 없습니다.</h5></li>`;
				}else{
					$.each(empList, function(index, emp) {
						
						// 프로필 유무로 이미지주소설정
						let empImg = `\${CONTEXTPATH}/resources/empImages/\${emp.empImg}`;
						if(!emp.empImg)
							empImg =`\${CONTEXTPATH}/resources/images/basicProfile.png`;
							
						// 사원 직무 추출
						let jobName = "";
						$(emp.jobList).each(function(jobIndex, job) {
							if(jobIndex == 0)
								jobName = job.jnm;
						});
						
						let deptLength = emp.deptList.length;
						let depts ="";
						let conten = "";
						console.log(deptLength, emp.ptnNm)
						if(deptLength > 0 || !(!emp.ptnNm)){
							depts = `<div class="emplistdiv"><span class="emplistspan"><span>`;
								
								let ptnNm ="";
								let orSign ="";
								$(emp.deptList).each(function(deptIndex, dept) {
									let mainDept = "";
									let dtnm = "";
									let nbsp ="";
									
									if(dept.mainck == 'Y')
										mainDept = `class="fw-semibold"`;
									if(!(!dept.dtnm))
										dtnm = ` · \${dept.dtnm}`;
									if(!(deptIndex == (deptLength - 1)))
										nbsp = ",&nbsp;";
									conten += `<span \${mainDept}> \${dept.dnm} \${dtnm} \${nbsp}</span>`;
									
								});
								depts +=`\${conten}`;
								if(!(!emp.ptnNm)) ptnNm = `<span> \${emp.ptnNm }</span>`;
								if(deptLength > 0 && !(!emp.ptnNm))	orSign = "|";
							depts +=`</span>\${orSign}\${ptnNm}</span></div>`;
						}
						htmlCode += `<li id="test" onclick="location.href='\${CONTEXTPATH}/mypage/hrInfoRetrieve.do?empNo=\${emp.empNo}' "
											class="list-group-item list-group-item-action d-flex justify-content-between align-items-center listhover">
												<div class="d-flex align-self-center align-items-center">
													<img src="\${empImg}" alt="emp" class="empListimgradius emplistimgsize">
													<div class="mx-3 mt-1">
														<strong> \${emp.empNm } </strong><br> 
														<span class="fs-tiny"> \${jobName} </span>
													</div>			
												</div>
												\${depts}
										</li>`;
					});
				}
				pagingArea.html(pagingVO.pagingHtml);
				listBody.html(htmlCode);
				// 현재페이지 버튼 활성화 
				pagingArea.find('a').each(function (index, a){
					let curnPage = $(a).data('page');
					if(curnPage == pageTag.val()) $(a).closest('li').addClass('active');
				});
				totalRecord.html(pagingVO.totalRecord);
				pageTag.val('');
				
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
		return false;
	}).trigger("submit");
}
//#############################################################################################################################################################
//	사원 검색 기능 
		
	//keyup 이벤트 딜레이
	function delay(callback, ms) {
		  var timer = 0;
		  return function() {
		    var context = this, args = arguments;
		    clearTimeout(timer);
		    timer = setTimeout(function () {
		      callback.apply(context, args);
		    }, ms || 0);
		  };
		}
	// 사원이름 검색
	$('#empNameSearchText').keyup(delay(function (e) {
		let searchText = $(this).val();
		searchForm.find(':input[name=searchWord]').val(searchText);
		searchForm.submit();
	}, 200));
//#############################################################################################################################################################
// 조직도 불러오기 
$(document).ready(function() {
	jojicCall = function(param){
		console.log("param확인", param)
		$.ajax({
			url : "${cPath }/" + param + "/" + param + "List.do",
			method : "GET",
			dataType : "html",
			async: false,
			success : function(resp) {
			    $("#set_originTree").empty();
				$("#set_offcanvasEnd").empty();
			    $("#set_wrapScript").empty();

			    //원본 트리
		   	    var originTree = $(resp).find('#wrapOriginTree');
		   	    $("#deptDiv").html(originTree);

		   	    // 스크립트
		   	    var wrapScript = $(resp).find('#wrapScript');
		   	    $("#set_wrapScript").html(wrapScript);

			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
		$deptTree = $('#originTree')
		//원본트리 현재 선택된 노드 정보 가져오기
		$deptTree.on('select_node.jstree', function(e,data){
			
			let $selONode = $deptTree.jstree("get_selected", true);

			let dcode = $selONode[0].id;
			console.log("dcode", dcode );
			
			searchForm.find(':input[name=dcode]').val(dcode);
			searchForm.submit();
		 });
	}

jojicCall("dept");
 
})


</script>