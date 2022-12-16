<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<!-- js -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

<div class="mt-2 h-px-800">
	<div class="table-responsive">
	  <table class="table card-table table-bordered">
		    <thead>
		      <tr>
		        <th>일시</th>
		        <th>사번</th>
		        <th>IP</th>
		        <th>상태</th>
		      </tr>
		    </thead>
		    <tbody>
		    
		    <%-- 접속 기록 --%>
		      <tr>
		        <!-- 일시 -->
		        <td>2022-11-07 9:44:57</td>
		        <!-- 사번 -->
		        <td>E44465</td>
		        
		        <!-- IP -->
		        <td>
		        	221.44.4.22
		        </td>
		        
		        <!-- 상태 -->
		        <td>
		        	성공
		        </td>
		        
		      </tr>
		      <%-- /접속 기록 --%>
		    <%-- 접속 기록 --%>
		      <tr>
		        <!-- 일시 -->
		        <td>2022-11-07 9:44:57</td>
		        <!-- 사번 -->
		        <td>E44465</td>
		        
		        <!-- IP -->
		        <td>
		        	221.44.4.22
		        </td>
		        
		        <!-- 상태 -->
		        <td>
		        	실패
		        </td>
		        
		      </tr>
		      <%-- /접속 기록 --%>
		    <%-- 접속 기록 --%>
		      <tr>
		        <!-- 일시 -->
		        <td>2022-11-07 9:42:37</td>
		        <!-- 사번 -->
		        <td>E44465</td>
		        
		        <!-- IP -->
		        <td>
		        	221.44.4.22
		        </td>
		        
		        <!-- 상태 -->
		        <td>
		        	실패
		        </td>
		        
		      </tr>
		      <%-- /접속 기록 --%>
		    <%-- 접속 기록 --%>
		      <tr>
		        <!-- 일시 -->
		        <td>2022-11-06 8:40:20</td>
		        <!-- 사번 -->
		        <td>E34464</td>
		        
		        <!-- IP -->
		        <td>
		        	200.11.4.22
		        </td>
		        
		        <!-- 상태 -->
		        <td>
		        	성공
		        </td>
		        
		      </tr>
		      <%-- /접속 기록 --%>
		    <%-- 접속 기록 --%>
		      <tr>
		        <!-- 일시 -->
		        <td>2022-11-05 9:01:01</td>
		        <!-- 사번 -->
		        <td>E34464</td>
		        
		        <!-- IP -->
		        <td>
		        	200.11.4.22
		        </td>
		        
		        <!-- 상태 -->
		        <td>
		        	성공
		        </td>
		        
		      </tr>
		      <%-- /접속 기록 --%>
		      
		    </tbody>
		  </table>
		<div class="d-flex">
			<button type="button" class="btn btn-sm btn-outline-secondary ms-auto" data-bs-toggle="modal" data-bs-target="#exampleModal">
			<i class='bx bx-download'></i> 접속 기록 다운로드
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
        <h5 class="modal-title fw-semibold" id="modalToggleLabel2">접속 기록 다운로드</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          </button>
      </div>
      <div class="modal-body">
      	<div class="card">
        	<div class="card-body">
        		  <div class="row">
				    <label class="col-md-3 col-form-label fs-big">조회기간</label>
				    <div class="col-md-9">
				      <input type="text" class="form-control w-px-250" id="demo" name="daterange" />
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

<script type="text/javascript" defer="defer">

$('#demo').daterangepicker({
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