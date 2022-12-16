<%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>	
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>	
<style>
 .paybg{ 
 	display: inline-block; 
 } 
 
.fline{
	display: inline-block;
	float : left;
}

 .pdbtn{ 
 	float : right; 
 	margin-bottom: 20px; 
 	margin-left: 10px; 
 } 

 .pd-div{ 
 	clear: both; 
 } 
</style>

<form:form modelAttribute="pay" method="post" id="payForm">
	<h2 class="paybg">지급 항목 설정</h2> <span class="paybg badge bg-label-success">근로소득</span><br>
	<button type="submit" class="btn btn-success pdbtn" id="paysave"><i class='bx bx-check' ></i> 저장하기</button>
	<button type="button" class="btn btn-outline-secondary pdbtn" id="paycancel" onclick="history.back();">취소</button>
	<button id="autoData" type="button" class="btn btn-label-secondary d-inline">자동 입력</button>
<!-- Basic Layout & Basic with Icons -->
	<div class="row w-px-800 pd-div mx-auto">
		<!-- Basic with Icons -->
		<div class="col-xxl">
			<div class="card mb-4">
				<div
					class="card-header d-flex align-items-center justify-content-between">
					<h5 class="mb-0">항목 정보</h5>
					<small class="text-muted float-end">지급 항목 정보를 입력해주세요</small>
				</div>
				<hr>
 				<div class="card-body">
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label">이름</label>
							<div class="col-sm-10">
								<div class="input-group input-group-merge">
									<span id="basic-icon-default-fullname2" class="input-group-text"> 
									<i class='bx bxs-edit-alt'></i></span>
 									<form:input path="pyNm" class="form-control" id="basic-icon-default-fullname" placeholder="ex) 연구활동비"/>
								</div>
							</div>
						</div>

						<div class="row mb-3">
							<label class="col-sm-2 col-form-label">지급 금액</label>
							<div class="col-sm-10">
								<div class="input-group input-group-merge">
									<span class="input-group-text"><i class='bx bx-won' ></i></span>
									<form:input path="pyAmt" id="payamount" class="form-control" placeholder="ex) 100,000"/>
									<span id="basic-icon-default-email2" class="input-group-text">원</span>
								</div>
							</div>
						</div>

						<div class="row mb-3">
							<label class="col-sm-2 col-form-label"
								for="basic-icon-default-company">설명</label>
							<div class="col-sm-10">
								<div class="input-group input-group-merge">
									<span id="basic-icon-default-company2" class="input-group-text">
										<i class="bx bx-comment"></i>
									</span>
									<form:input path="pyAbst" id="payAbstract" class="form-control" placeholder="연구활동 보조 수당"/>
								</div>
							</div>
						</div>

						<div class="mb-3 row mt-4">
							<div class="col-md">
								<label for="html5-search-input"
									class="col-md-2 col-form-label form-check-inline fline">과세 여부</label>
								<div class="col-md-10">
									<div class="form-check form-check-inline fline">
										<form:radiobutton path="pyTax" value="Y" id="pyrad1" class="form-check-input"/>
										<label class="form-check-label" for="pyrad1">과세</label>
									</div>
									<div class="form-check form-check-inline fline">
										<form:radiobutton path="pyTax" value="N" id="pyrad2" class="form-check-input"/>
										<label class="form-check-label" for="pyrad2">비과세</label>
									</div>
								</div>
							</div>
						</div>
				</div>
			</div>
		</div>
	</div>
</form:form>		

<script>
$('#autoData').on("click", function(){
	let payForm = $('#payForm');
	payForm.find('[name="pyNm"]').val('관리과 성과금');
	payForm.find('[name="pyAmt"]').val(500000);
	payForm.find('[name="pyAbst"]').val('관리과 정기 성과금 항목');
	$('#pyrad1').prop('checked',true);
});
</script>

