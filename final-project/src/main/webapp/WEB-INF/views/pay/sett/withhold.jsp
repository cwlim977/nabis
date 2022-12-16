<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row">
	<!-- Basic Layout -->
	<div class="col-xxl">
		<div class="card mb-4">
			<div class="card-header d-flex align-items-center justify-content-between">
				<h5 class="mb-0 me-auto p-2 bd-highlight">원천징수의무자 정보</h5>
				<button type="button" id="autoData" class="btn btn-outline-secondary ms-2 p-2 bd-highlight" id="refresh"><i class='bx bx-refresh'></i>  회사정보 가져오기</button>
				<button type="button" class="btn btn-success ms-2 p-2 bd-highlight" id="whsave"><i class='bx bx-check' ></i> 저장하기</button>
			</div>
			<hr>
			<div class="card-body">
				<form id="withholdForm">
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label" for="basic-default-name">법인명(상호)</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="comNm"/>
						</div>
					</div>
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label" for="basic-default-name">대표자 이름</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="comRep"/>
						</div>
					</div>
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label" for="basic-default-name">사업자 등록번호</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="comRegNo"/>
						</div>
					</div>
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label" for="basic-default-name">법인 등록번호</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="corRegNo"/>
						</div>
					</div>
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label" for="basic-default-name">회사 주소</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="comAddr"/>
						</div>
					</div>
					
					
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label" for="basic-default-phone">
							회사 전화번호
						</label>
						<div class="col-sm-10">
							<input type="text" id="comTel"
								class="form-control phone-mask" aria-describedby="basic-default-phone" />
						</div>
					</div>
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label" for="basic-default-name">관할 세무서</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="comTax"/>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
$('#autoData').on("click", function(){
	let withholdForm = $('#withholdForm');
	withholdForm.find('#comNm').val('NABIS');
	withholdForm.find('#comRep').val('강동원');
	withholdForm.find('#comRegNo').val('116-81-19948');
	withholdForm.find('#corRegNo').val('1101111659519');
	withholdForm.find('#comAddr').val('대전 유성구 대덕대로 593 (도룡동) 대덕테크 비즈센터');
	withholdForm.find('#comTel').val('042-480-6082');
	withholdForm.find('#comTax').val('북대전세무서');
});
</script>