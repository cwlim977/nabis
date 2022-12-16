<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<form:form modelAttribute="ded" method="post">
	<h2 class="paybg">공제 항목 설정</h2> <span class="paybg badge bg-label-success">근로소득</span><br>
	<button type="submit" class="btn btn-success pdbtn" id="paysave"><i class='bx bx-check' ></i> 저장하기</button>
	<button type="button" class="btn btn-outline-secondary pdbtn" id="dedcancel" onclick="history.back();">취소</button>
<!-- Basic Layout & Basic with Icons -->
	<div class="row w-px-800 pd-div mx-auto">
		<!-- Basic with Icons -->
		<div class="col-xxl ">
			<div class="card mb-4">
				<div
					class="card-header d-flex align-items-center justify-content-between">
					<h5 class="mb-0">항목 정보</h5>
					<small class="text-muted float-end">공제 항목 정보를 입력해주세요</small>
				</div>
				<hr>
				<div class="card-body">
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label"
								for="ddNm">이름</label>
							<div class="col-sm-10">
								<div class="input-group input-group-merge">
									<span id="basic-icon-default-fullname2"
										class="input-group-text"> <i class='bx bxs-edit-alt'></i></span>
									<form:input path="ddNm" class="form-control" id="ddNm" placeholder="ex) 사내동호회비"/>
								</div>
							</div>
						</div>

						<div class="row mb-3">
							<label class="col-sm-2 col-form-label"
								for="ddamount">공제 금액</label>
							<div class="col-sm-10">
								<div class="input-group input-group-merge">
									<span class="input-group-text"><i class='bx bx-won' ></i></span>
									<form:input path="ddAmt" id="ddamount" class="form-control" placeholder="ex) 10,000"/>
									<span id="ddamount2" class="input-group-text">원</span>
								</div>
							</div>
						</div>

						<div class="row mb-3">
							<label class="col-sm-2 col-form-label"
								for="ddAbstract">설명</label>
							<div class="col-sm-10">
								<div class="input-group input-group-merge">
									<span id="basic-icon-default-company2" class="input-group-text">
										<i class="bx bx-comment"></i>
									</span> 
									<form:input path="ddAbst" id="ddAbstract" class="form-control" placeholder="사내 동호회비 공제"/>
								</div>
							</div>
						</div>
						
<!-- 						<div class="mb-3 row mt-4"> -->
<!-- 							<div class="col-md"> -->
<!-- 								<label for="html5-search-input" -->
<!-- 									class="col-md-2 col-form-label form-check-inline fline">법정필수 여부</label> -->
<!-- 								<div class="col-md-10"> -->
<!-- 									<div class="form-check form-check-inline fline"> -->
<%-- 										<form:radiobutton path="ddLyn" value="Y" id="ddrad1" class="form-check-input"/> --%>
<!-- 										<label class="form-check-label" for="ddrad1">여</label> -->
<!-- 									</div> -->
<!-- 									<div class="form-check form-check-inline fline"> -->
<%-- 										<form:radiobutton path="ddLyn" value="N" id="ddrad2" class="form-check-input" checked="checked"/> --%>
<!-- 										<label class="form-check-label" for="ddrad2">부</label> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
				</div>
			</div>
		</div>
	</div>
</form:form>	
	