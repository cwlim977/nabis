<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href="${cPath }/resources/css/jhy.css" rel="stylesheet" type="text/css" />
<style>
#deptDiv{
    position: fixed;
    top: 207px;
    right: 0px;
    width: 340px;
    height: 780px;
    z-index: 100;
    box-shadow: rgba(50, 50, 93, 0.25) 0px 13px 27px -5px, rgba(0, 0, 0, 0.3) 0px 8px 16px -8px;
}
</style>
<div class="card-body px-0 py-0 filterdiv" style="height: 55px;">
	<div class="filterinsidediv d-flex">
		<div class="btn-group filterbtn">
			<button type="button" class="btn btn-outline-primary dropdown-toggle btn-sm" data-bs-toggle="dropdown" aria-expanded="false">
				<i class="fa-solid fa-filter"></i>필터 추가하기
			</button>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="javascript:void(0);">Action</a></li>
				<li><a class="dropdown-item" href="javascript:void(0);">Another action</a></li>
				<li><a class="dropdown-item" href="javascript:void(0);">Something else here</a></li>
				<li>
					<hr class="dropdown-divider" />
				</li>
				<li><a class="dropdown-item" href="javascript:void(0);">Separated link</a></li>
			</ul>
		</div>

		<div class="ms-auto">
			<span id="totalRecord"></span>명
			<button type="reset" class="btn btn-outline-primary btn-sm">필터 초기화</button>
		</div>
	</div>

</div>


<div class="card-body px-0 py-0">
	<div class="table-responsive text-nowrap ">
		<table class="table table-bordered table-hover emptable">
			<thead>
				<tr>
					<th rowspan="2">이름</th>
					<th colspan="6">기본 정보</th>
					<th colspan="4">인사 정보</th>
					<th colspan="3">개인 정보</th>
				</tr>
				<tr>
					<th>상태</th>
					<th>사번</th>
					<th>입사일</th>
					<th>퇴직일</th>
					<th>근속 기간</th>
					<th>입사 유형</th>
					<th>직급</th>
					<th>직위</th>
					<th>조직</th>
					<th>주조직·직책</th>
					<th>이메일</th>
					<th>법적 성별</th>
					<th>휴대전화</th>
				</tr>
			</thead>
			<tbody id="listBody">

			</tbody>
		</table>
	</div>
	<div class="pagingArea mt-3"></div>
	<div class="flex" id="deptDiv" style="display:none; background-color:white" >
			
			
	</div>
</div>

<%-- 조직도 설정 --%>
<div id="set_originTree" style="display: none"></div>
<div id="set_offcanvasEnd" ></div>
<script id="set_wrapScript" type="text/javascript" defer="defer"></script>
<%-- /조직도 설정 --%>

<script type="text/javascript" defer="defer">
//메인 컨테이너 클래스 삭제
$('.filterdiv').closest('.container-xxl').removeClass( 'container-xxl flex-grow-1 container-p-y' );

let $listBody = $('#listBody');
let $totalRecord = $('#totalRecord');
let page = 1;
let $pagingArea = $(".pagingArea").on("click", "a", function(event) {
	event.preventDefault();
	page = $(this).data('page');
	if(!page) return false;
	dataObject.page = page;
	getEmpList();
	return false;
});

let dataObject = {
		page : 1,
		searchWord : ""
	}
	
//사원리스트 호출
getEmpList();

//###############################################################################################################################
// 사원 리스트 비동기 갱신
function getEmpList(){
	$pagingArea.empty();
	let form = this;
	let url = this.action;
	let data = dataObject;
	
	$.ajax({
		url : url,
		data : data,
		dataType : "json",
		success : function(resp) {
			console.log(resp);
			let pagingVO = resp;
			let empList = pagingVO.dataList;
			
			let htmlCode ="";
			if(empList.length <= 0){
				htmlCode = `<td colspan="13">구성원이 없습니다.</td>`;
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
					// 사원 조직 추출
					let deptFlow = "";
					let deptHtml = "";
					$(emp.deptList).each(function(deptIndex, dept) {
						if(dept.mainck == 'Y'){
							deptFlow = dept.deptFlow;
							deptHtml = dept.dnm;
							if(!(!dept.dtnm))
								deptHtml += `· \${dept.dtnm}`;
						}
					});
					
					if(!emp.outDate) emp.outDate ='';
					if(!emp.tneurePeriod) emp.tneurePeriod ='';
					if(!emp.grdNm) emp.grdNm ='';
					if(!emp.ptnNm) emp.ptnNm ='';
					if(!emp.cpNo) emp.cpNo ='';
					if(!emp.empMail) emp.empMail ='';
					
					htmlCode +=`<tr onclick="location.href='\${CONTEXTPATH}/mypage/hrInfoRetrieve.do?empNo=\${emp.empNo}' ">
						<td>
							<div class="d-flex align-self-center align-items-center">
								<img src="\${empImg}" alt="Avatar" class="empListimgradius emplistimgsize">
								<div class="mx-3 mt-1">
									<strong>\${emp.empNm }</strong><br> <span class="fs-tiny"> 
										\${jobName}
									</span>
								</div>
							</div>
						</td>
						<td>
							<span class="badge bg-label-primary me-1">\${emp.empSt}</span>
						</td>
						<td>\${emp.empNo}</td>
						<td>\${emp.entDate}</td>
						<td>\${emp.outDate}</td>
						<td>\${emp.tneurePeriod}</td>
						<td>\${emp.entCase}</td>
						<td>\${emp.grdNm}</td>
						<td>\${emp.ptnNm}</td>
						<td>\${deptFlow}</td>
						<td>\${deptHtml}</td>
						<td>\${emp.empMail}</td>
						<td>\${emp.empGen}</td>
						<td>\${emp.cpNo}</td>
					</tr>`;
				});
			}
			$pagingArea.html(pagingVO.pagingHtml);
			// 현재페이지 버튼 활성화 
			$pagingArea.find('a').each(function (index, a){
				let curnPage = $(a).data('page');
				if(curnPage == page) $(a).closest('li').addClass('active');
			});
			$listBody.html(htmlCode);
			$totalRecord.html(pagingVO.totalRecord); 
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	});
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
	dataObject.searchWord = searchText;
	getEmpList();
}, 200));

</script>
<script type="text/javascript" defer="defer">
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
		   	     
		   	    // 조직도 수정폼 div
		   	    var offcanvasEnd = $(resp).find('#offcanvasEnd');
		   	    $("#set_offcanvasEnd").html(offcanvasEnd);
		   	     
		   	    // 스크립트
		   	    var wrapScript = $(resp).find('#wrapScript');
		   	    $("#set_wrapScript").html(wrapScript);
					
		   	    
// 		   	    $("#offcanvasScrollDept").html(offcanvasEnd)
				// offcanvas 열기 버튼
// 		        $("#sp_"+param).attr("data-bs-target", "#offcanvasEnd");
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	}

jojicCall("dept");
	
})

</script>