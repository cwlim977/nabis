<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- css -->
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
 
<!-- js -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>


<div class="d-flex align-self-center align-items-center">

	<div class="btn-group" role="group"
		aria-label="Basic checkbox toggle button group">
		<button type="button" class="btn btn-sm btn-outline-info">&#60;</button>

		<button type="button" class="btn btn-sm btn-outline-info">현재주기</button>

		<button type="button" class="btn btn-sm btn-outline-info">&#62;</button>
	</div>
	
	<span class="badge bg-label-primary me-1 mx-2">조회</span> 
	<span>2022.10.31 - 2022.11.6 </span>
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
		        <th>사번</th>
		        <th>근무</th>
		        <th>초과</th>
		        <th>휴가</th>
		        <th>합계</th>
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
		        
		        <!-- 사번 -->
		        <td>E44465</td>
		        
		        <!-- 근무 -->
		        <td>
		          46시간
		        </td>
		        
		        <!-- 초과 -->
		        <td data-bs-toggle="tooltip" data-bs-offset="0,4" data-bs-placement="top" data-bs-html="true" title="
		        	<span>연장 : 4시간</span><br>
		        	<span>야간 : 2시간</span><br>
		        	<span>휴일 : 4시간</span>">
					10시간
				</td>
		        
		        <!-- 휴가 -->
		        <td>
		        	8시간
		        </td>
		        
		        <!-- 합계 -->
		        <td>
		         	64시간
		        </td>
		      </tr>
		      <%-- /사원 --%>
		      
		      <tr>
		      	<td class="d-flex">
		        	<img src="${cPath}/resources/assets/img/avatars/6.png" alt="Avatar" class="rounded-circle w-px-50 h-px-50">
		        	<div class="mx-3 mt-1">
		        	<strong>곰젤리</strong><br>
		        	<span class="fs-tiny">개발자</span>
		        	</div>
		        </td>
		        
		        <!-- 사번 -->
		        <td>E44465</td>
		        
		        <!-- 근무 -->
		        <td>
		          46시간
		        </td>
		        
		        <!-- 초과 -->
		        <td>
					10시간
				</td>
		        
		        <!-- 휴가 -->
		        <td>
		        	8시간
		        </td>
		        
		        <!-- 합계 -->
		        <td>
		         	64시간
		        </td>
		      </tr>
		      
		      
		      
		      <tr>
		        <td class="d-flex">
		        	<img src="${cPath}/resources/assets/img/avatars/7.png" alt="Avatar" class="rounded-circle w-px-50 h-px-50">
		        	<div class="mx-3 mt-1">
		        	<strong>임사원</strong><br>
		        	<span class="fs-tiny">인사담당자</span>
		        	</div>
		        </td>
		        <!-- 사번 -->
		        <td>E44465</td>
		        
		        <!-- 근무 -->
		        <td>
		          46시간
		        </td>
		        
		        <!-- 초과 -->
		        <td>
					10시간
				</td>
		        
		        <!-- 휴가 -->
		        <td>
		        	8시간
		        </td>
		        
		        <!-- 합계 -->
		        <td>
		         	64시간
		        </td>
		      </tr>
		      <tr>
		        <td class="d-flex">
		        	<img src="${cPath}/resources/assets/img/avatars/7.png" alt="Avatar" class="rounded-circle w-px-50 h-px-50">
		        	<div class="mx-3 mt-1">
		        	<strong>임사원</strong><br>
		        	<span class="fs-tiny">인사담당자</span>
		        	</div>
		        </td>
		        <!-- 사번 -->
		        <td>E44465</td>
		        
		        <!-- 근무 -->
		        <td>
		          46시간
		        </td>
		        
		        <!-- 초과 -->
		        <td>
					10시간
				</td>
		        
		        <!-- 휴가 -->
		        <td>
		        	8시간
		        </td>
		        
		        <!-- 합계 -->
		        <td>
		         	64시간
		        </td>
		      </tr>
		      
		          <%-- 사원 --%>
		      <tr>
		        <td class="d-flex">
		        	<img src="${cPath}/resources/assets/img/avatars/5.png" alt="Avatar" class="rounded-circle w-px-50 h-px-50">
		        	<div class="mx-3 mt-1">
		        	<strong>김판다</strong><br>
		        	<span class="fs-tiny">마케터</span>
		        	</div>
		        </td>
		        
		        <!-- 사번 -->
		        <td>E44465</td>
		        
		        <!-- 근무 -->
		        <td>
		          46시간
		        </td>
		        
		        <!-- 초과 -->
		        <td data-bs-toggle="tooltip" data-bs-offset="0,4" data-bs-placement="top" data-bs-html="true" title="
		        	<span>연장 : 4시간</span><br>
		        	<span>야간 : 2시간</span><br>
		        	<span>휴일 : 4시간</span>">
					10시간
				</td>
		        
		        <!-- 휴가 -->
		        <td>
		        	8시간
		        </td>
		        
		        <!-- 합계 -->
		        <td>
		         	64시간
		        </td>
		      </tr>
		      <%-- /사원 --%>
		      
		          <%-- 사원 --%>
		      <tr>
		        <td class="d-flex">
		        	<img src="${cPath}/resources/assets/img/avatars/5.png" alt="Avatar" class="rounded-circle w-px-50 h-px-50">
		        	<div class="mx-3 mt-1">
		        	<strong>김판다</strong><br>
		        	<span class="fs-tiny">마케터</span>
		        	</div>
		        </td>
		        
		        <!-- 사번 -->
		        <td>E44465</td>
		        
		        <!-- 근무 -->
		        <td>
		          46시간
		        </td>
		        
		        <!-- 초과 -->
		        <td data-bs-toggle="tooltip" data-bs-offset="0,4" data-bs-placement="top" data-bs-html="true" title="
		        	<span>연장 : 4시간</span><br>
		        	<span>야간 : 2시간</span><br>
		        	<span>휴일 : 4시간</span>">
					10시간
				</td>
		        
		        <!-- 휴가 -->
		        <td>
		        	8시간
		        </td>
		        
		        <!-- 합계 -->
		        <td>
		         	64시간
		        </td>
		      </tr>
		      <%-- /사원 --%>
		    </tbody>
		  </table>
		<div class="d-flex">
			<button type="button" class="btn btn-sm btn-outline-secondary ms-auto" data-bs-toggle="modal" data-bs-target="#exampleModal">
			<i class='bx bx-download'></i> 기간별 근무시간 다운로드
			</button>
		</div>
		 <nav aria-label="Page navigation">
			  <ul class="pagination justify-content-center">
				    <li class="page-item prev">
				      <a class="page-link" href="#"><i class="tf-icon bx bx-chevrons-left"></i></a>
				    </li>
				    <li class="page-item">
				      <a class="page-link" href="#">1</a>
				    </li>
				    <li class="page-item">
				      <a class="page-link" href="#">2</a>
				    </li>
				    <li class="page-item active">
				      <a class="page-link" href="#">3</a>
				    </li>
				    <li class="page-item">
				      <a class="page-link" href="#">4</a>
				    </li>
				    <li class="page-item">
				      <a class="page-link" href="#">5</a>
				    </li>
				    <li class="page-item next">
				      <a class="page-link" href="#"><i class="tf-icon bx bx-chevrons-right"></i></a>
				    </li>
			  </ul>
		</nav>
	</div>
</div>

<!-- 대체일 변경 Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw-semibold" id="modalToggleLabel2">기간별 근무시간</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          </button>
      </div>
      <div class="modal-body">
      	<div class="card">
        	<div class="card-body">
        		  <div class="row">
				    <label class="col-md-3 col-form-label fs-big">조회기간</label>
				    <div class="col-md-9">
				      <input type="text" class="form-control w-px-250" id="demo2" name="daterange" />
				    </div>
				  </div>
        	</div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-success"><i class='bx bx-download'></i> 다운로드</button>
      </div>
    </div>
  </div>
</div>

<script>

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
</script>