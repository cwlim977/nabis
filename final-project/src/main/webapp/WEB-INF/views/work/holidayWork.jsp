<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<div class="d-flex align-self-center align-items-center">

	
	<input type="text" class="form-control w-px-250" id="demo2" name="daterange" />
	
	<select id="defaultSelect"
		class="form-select w-px-300 ms-auto">
		<option value>조직을 선택해주세요</option>
		<option value="name">전체</option>
		<option value="address">인사2팀</option>
		<option value="address">개발1팀</option>
		<option value="address">마케팅팀</option>
		<option value="address">연구개발부서</option>
	</select>

</div>


<div class="mt-2 h-px-800">
<div class="table-responsive">
  <table class="table card-table table-bordered">
    <thead>
      <tr>
        <th class="w-px-300">이름</th>
        <th>휴일</th>
        <th>휴일근무 시간</th>
        <th>대체일</th>
        <th class="text-end">휴일 대체</th>
      </tr>
    </thead>
    <tbody>
    
    <%-- 사원 --%>
      <tr>
        <td class="d-flex">
        	<img src="${cPath}/resources/assets/img/avatars/5.png" alt="Avatar" class="rounded-circle w-px-50 h-px-50">
        	<div class="mx-3 mt-1">
        	<strong>김판다</strong><br>
        	<span class="fs-tiny">마케터</span>
        	</div>
        </td>
        <!-- 휴일 -->
        <td class="text-danger">
        	2022.11.06(일)
        </td>
        
        <!-- 휴일근무 시간 -->
        <td>
			없음
		</td>
        
        <!-- 대체일 -->
        <td>
        	미정
        </td>
        
        <!-- 휴일 대체 -->
        <td class="text-end">
         	<input type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#modalToggle" value="대체하기" />
        </td>
      </tr>
      <%-- 사원 --%>
    <%-- 사원 --%>
      <tr>
        <td class="d-flex">
        	<img src="${cPath}/resources/assets/img/avatars/5.png" alt="Avatar" class="rounded-circle w-px-50 h-px-50">
        	<div class="mx-3 mt-1">
        	<strong>김판다</strong><br>
        	<span class="fs-tiny">마케터</span>
        	</div>
        </td>
        <!-- 휴일 -->
        <td class="text-danger">
        	2022.11.13(일)
        </td>
        
        <!-- 휴일근무 시간 -->
        <td>
			8시간
		</td>
        
        <!-- 대체일 -->
        <td>
        	2022.11.16(수)
        </td>
        
        <!-- 휴일 대체 -->
        <td class="text-end">
         	<input type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#exampleModal" value="변경하기" />
        </td>
      </tr>
      <%-- 사원 --%>
    </tbody>
  </table>

</div>
</div>

<!-- Modal 1-->
<div class="modal fade" id="modalToggle" data-bs-backdrop="static" tabindex="-1" style="display: none;">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw-semibold" id="modalToggleLabel"><span class="text-warning"><i class="bx bx-error"></i></span> 휴일 대체 전에 확인해주세요.</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        	주휴일 또는 약정 휴일의 근무 대체는 적어도 24시간 전에 근로자에게 대체 사실 및 사유를 전달해야 하며, 공휴일의 근무 대체는 근로자 대표와 사전에 서면 합의가 필요합니다.<br>
			[근로기준법 제55조 제2항]
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button class="btn btn-primary" data-bs-target="#modalToggle2" data-bs-toggle="modal" data-bs-dismiss="modal">확인했습니다.</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal 2-->
<div class="modal fade" id="modalToggle2" aria-hidden="true" aria-labelledby="modalToggleLabel2" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw-semibold" id="modalToggleLabel2">휴일 대체하기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="card">
        	<div class="card-body">
	        	<div class="d-flex">
		        	<img src="${cPath}/resources/assets/img/avatars/5.png" alt="Avatar" class="rounded-circle w-px-50 h-px-50">
		        	<div class="mx-3 mt-1">
		        	<strong>김판다</strong><br>
		        	<span class="fs-tiny">마케터</span>
		        	</div>
	        	</div>
	        	<hr></hr>
	        	<div class="row">
	        		<div class="col-4">휴일</div>
	        		<div class="col-8">2022.11.6 (일)</div>
	        	</div>
	        	<div class="row">
	        		<div class="col-4">대체일</div>
	        		<div class="col-8"><input type="date" placeholder="대체일을 선택하세요"></input></div>
	        	</div>
        	</div>
        </div>
      </div>
      <div class="modal-footer">
        <button class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button class="btn btn-primary" data-bs-dismiss="modal">대체하기</button>
      </div>
    </div>
  </div>
</div>


<!-- 대체일 변경 Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw-semibold" id="modalToggleLabel2">대체일 변경</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          </button>
      </div>
      <div class="modal-body">
      	<div class="card">
        	<div class="card-body">
	        	<div class="d-flex">
		        	<img src="${cPath}/resources/assets/img/avatars/5.png" alt="Avatar" class="rounded-circle w-px-50 h-px-50">
		        	<div class="mx-3 mt-1">
		        	<strong>김판다</strong><br>
		        	<span class="fs-tiny">마케터</span>
		        	</div>
	        	</div>
	        	<hr></hr>
	        	<div class="row">
	        		<div class="col-4">휴일</div>
	        		<div class="col-8">2022.11.13 (일)</div>
	        	</div>
	        	<div class="row">
	        		<div class="col-4">대체일</div>
	        		<div class="col-8"><input type="date" value="2022.11.16(수)"></input></div>
	        	</div>
        	</div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-danger me-auto" data-bs-dismiss="modal">휴일 대체 취소</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary">수정하기</button>
      </div>
    </div>
  </div>
</div>
<script>
$(function() {
	$('#demo2').daterangepicker({
	    "locale": {
	        "format": "YYYY-MM-DD",
	        "separator": " → ",
	        "applyLabel": "확인",
	        "cancelLabel": "취소",
	        "fromLabel": "From",
	        "toLabel": "To",
	        "customRangeLabel": "Custom",
	        "weekLabel": "W",
	        "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
	        "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
	    },
	    "startDate": new Date(),
	    "endDate": new Date(),
	    "drops": "auto"
	}, function (start, end, label) {
	    console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
	});
});

</script>
