<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>	
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>	

<link rel="stylesheet" href="${cPath }/resources/css/ijs.css" />

<form:form modelAttribute="tmp" method="post">
	<button type="submit" class="btn btn-success pdbtn" id="paysave">
		<i class='bx bx-check' ></i> 저장하기
	</button>
	<button type="button" class="btn btn-outline-secondary pdbtn" id="paycancel">취소</button>
<!-- 템플릿 form -->
	<div class="row w-px-700 pd-div mx-auto">
		<div class="col-xxl ">
			<div class="card mb-4">
				<div
					class="card-header d-flex align-items-center justify-content-between">
					<h5 class="mb-0">템플릿 정보 📝  </h5>
					<small class="text-muted float-end">템플릿 항목 정보를 입력해주세요</small>
				</div>
				<hr>
				<div class="card-body">
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label" for="tmplName">이름</label>
							<div class="col-sm-10">
								<div class="input-group input-group-merge">
									<span id="basic-icon-default-fullname2" class="input-group-text"> 
										<i class='bx bxs-edit-alt'></i>
									</span>
									<form:input path="ptNm"  class="form-control" placeholder="ex) 연차수당 포함 급여"
 										aria-label="pay allowance"/>
								</div>
							</div>
							<form:errors path="ptNm" element="span" cssClass="error text-center" />
						</div>
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label" for="tmplAbst">설명</label>
							<div class="col-sm-10">
								<div class="input-group input-group-merge">
									<span id="basic-icon-default-company2" class="input-group-text">
										<i class="bx bx-comment"></i>
									</span> 
									<form:input path="ptAbst" class="form-control" placeholder="연차수당이 정산되는 달의 급여입니다"
 										aria-label="pay allowance abstract"/>
								</div>
							</div>
						</div>
				</div>
			</div>
		</div>
	</div>
</form:form>	

<script>	

$("#paycancel").on("click", function(){
	history.back();
 });

</script>