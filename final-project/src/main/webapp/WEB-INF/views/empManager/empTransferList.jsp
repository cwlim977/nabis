<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script src="https://unpkg.com/html2canvas@1.0.0-rc.5/dist/html2canvas.js"></script>

<div class="listdiv translistborder">
	<div class="card-body px-0 py-0 transferdiv">
		<!-- 		<div class="transferpadding" style="border-bottom: 1px solid gray;"> -->
		<!-- 			<div class="tranfertitle">변경내역</div> -->
		<!-- 		</div> -->
		<div class="transferpadding">
			<div class="tranfertitle">변경내역</div>
		</div>
	</div>


	<div class="col-lg">
		<div class=" ">
			<!-- 인사발령 리스트 -->
			<ul id="translistBody" class="list-group ligroup"></ul>
		</div>
	</div>
</div>

<!-- 공지사항 모달창  -->
<div class="modal fade" id="transmodalScrollable" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-scrollable" role="document">
		<div class="modal-content">
			<div class="modal-header px-5">
				<h5 class="modal-title fs-3 fw-bold" id="modalScrollableTitle">발령</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body py-0 px-5">

				<button type="button" class="btn">
					<div>
						<img src="${cPath}/resources/assets/img/avatars/5.png" class="rounded-circle transimg" /> <span>전체</span>
					</div>
				</button>
				<p>1. 발령 대상 (1명)</p>
				<p>송아지</p>

				<p>2. 발령 내용: 입사</p>
				<p>• 송아지</p>
				<p>• 직급: 없음 > 1</p>
				<p>• 직위: 없음 > 대리</p>
				<p>• 직무: 없음 > 디자이너</p>
				<p>• 조직 · 직책 · 조직장: 없음 > 개발팀 · 실장 · 조직장</p>
				<p>3. 발령일: 2022. 11. 4</p>
				<div class="mb-3">
					<input class="form-control" type="file" id="formFileMultiple" multiple />
				</div>

			</div>
			<div class="modal-footer px-5 ">
				<!--            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                Close
                              </button> -->
				<button type="button" class="btn btn-primary noticebtn m-0">
					<i class='bx bx-pencil'></i>작성하기
				</button>
			</div>
		</div>
	</div>
</div>


<!--################################################################################################################################################################################ -->
<!--  발령 정보 상세 조회 모달창 -->
<div class="modal fade" id="fullscreenModaltrans" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-fullscreen" role="document">
		<div class="modal-content">
			<div class="modal-header border-bottom pt-4 pb-3">
				<h5 class="modal-title me-3 fw-bold" id="modalFullTitle">입사</h5>
				<span><i class='bx bx-calendar-alt'></i> &nbsp; <span id="modalAsgmtDate">2022.11.08</span></span>
				<!--발령일  -->
				&nbsp; <span id="modalAsgmtStat"><span class="badge bg-label-success text-dark"> 완료 </span></span>
				<button id="PDFBtn" type="button" class="btn btn-sm btn-primary mx-2">PDF 다운로드</button>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>

			<div class="modal-body p-0">
				<div class="card-body p-0">
					<div class="table-responsive text-nowrap">
						<table class="table table-bordered table-hover">
							<thead>
								<tr>
									<th colspan="3">발령 대상</th>
									<th colspan="4">발령 전</th>
									<th colspan="4">발령 후</th>
								</tr>
								<tr>
									<th>이름</th>
									<th>사번</th>
									<th>상태</th>
									
									<th>직무</th>
									<th>조직·직책·조직장</th>
									<th>직위</th>
									<th>직급</th>
									
									<th>직무</th>
									<th>조직·직책·조직장</th>
									<th>직위</th>
									<th>직급</th>
								</tr>
							</thead>
							<tbody id="transferDtailTbody">
								<tr>
									<td>
										<div class="d-flex align-self-center align-items-center">
											<img src="${cPath}/resources/assets/img/avatars/5.png" alt="Avatar" class="empListimgradius emplistimgsize">
											<div class="mx-3 mt-1">김판다</div>
										</div>
									</td>
									<td>1546841</td>
									<td>
										<span class="badge bg-label-success">변경 완료</span>
									</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="${cPath}/resources/js/empTransferList.js"></script>