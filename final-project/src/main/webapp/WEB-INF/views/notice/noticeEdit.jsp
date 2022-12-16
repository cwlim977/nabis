<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<style>
input::placeholder {
	font-weight: bold;
	font: 1.2em "Fira Sans", sans-serif;
}

input {
	border: none;
}

textarea {
	resize: none;
	/*  	height: 500px; */
}

</style>


<!-- Button trigger modal -->
<!-- <button type="button" class="btn btn-primary" data-bs-toggle="modal" -->
<!-- 	data-bs-target="#noticeModal">동료에게 전달하기</button> -->

<form:form id="noticeUpdateForm" method="post" modelAttribute="notice"
	enctype="multipart/form-data">
	<%--===========================================--%>
	<form:hidden path="postNo" />
	<%--===========================================--%>
	<!-- controller 의 command object name , 아래 code 메세지 사용하려면 여기랑 일치해야함-->
	<!-- Modal -->
	<!-- 	<div class="modal fade" id="noticeModal" aria-hidden="true" aria-labelledby="modalToggleLabel2" tabindex="-1"> -->
	<!-- 		<div class="modal-dialog modal-dialog-centered"> -->
	<!-- 			<div class="modal-content"> -->

	<div class="modal-header mx-4">

		<form:input path="postTitle" required="true" id="largeInput"
			class="form-control form-control-lg" type="text"
			placeholder="공지사항 제목" style="border:x" />
	</div>

	<div class="modal-body mx-4 pb-0">
		<div class="row">

			<div class="col mb-3">
				<form:textarea path="postCont" class="form-control"
					id="exampleFormControlTextarea1" rows="3"
					placeholder="동료에게 보낼 공지사항 내용을 작성해주세요."
					style=" height:450px; border:x" />
			</div>
			<div>
				<img id="image_section">
			</div>
			<form:input type="hidden" path="wriNo" class="form-control"
				value="${authEmp.empNo}" />
		</div>
		
		<!-- 기존 첨부파일 -->
		<div class="row d-block offcanvas-scrollbar mx-3 " style="overflow:auto; ">
			<table>
				<tr>
					<c:forEach items="${notice.attatchList }" var="attatch" varStatus="vs">
						<td style="white-space: nowrap; " >
							<span class="fileArea"> 
								${attatch.attFilename } 
								<span class="delBtn" data-att-no="${attatch.attNo }">
									<i class='bx bx-x-circle'></i>${not vs.last?" | ":"" }
								</span>
							</span>
						
						</td>
					</c:forEach>
				</tr>
			</table>
		</div>
		
	</div>

	<div class="modal-footer mx-2 ">
	<!-- 신규 첨부파일 -->
		<input class="form-control" type="file" id="noticeFiles"
			name="noticeFiles" multiple="multiple">

		<form:button type="submit" class="btn btn-primary"
			style="width: 100%;">작성하기</form:button>
		<form:button type="reset" class="btn btn-outline-primary"
			style="width: 100%;" data-bs-dismiss="modal">취소</form:button>
	</div>

	<!-- 			</div> -->
	<!-- 		</div> -->
	<!-- 	</div> -->
</form:form>
<form:form id="testForm">

</form:form>

<script>
	var imageFile;

	// 첨부파일을 변경할때 마다 실행되는 이벤트 
	$("#noticeFiles").on("change", function(event) {
		imageFile = event.target.files[0];

		readURL(this);
	});

	var testForm = document.getElementById("testForm");

	var formData = new FormData(testForm);

	formData.append("imageFile", imageFile);

	
	function readURL(input) {
		if (input.files && input.files[0]) {

			var reader = new FileReader();

			reader.onload = function(e) {
				$('#image_section').attr('src', e.target.result);
			}

			reader.readAsDataURL(input.files[0]);
		}
	}

	// 글 수정시 첨부파일 관리
	var noticeUpdateForm = $("#noticeUpdateForm");
	
	$(".delBtn").on("click", function(event) {
		let attNo = $(this).data("attNo");
		let newInput = $("<input>").attr({ //몇번파일을 지우겠다.
			type : "hidden",
			name : "delAttNos"
		}).val(attNo);
		noticeUpdateForm.append(newInput); //form안에 방금 만든 input태그 넣는다
		$(this).parents("span.fileArea").hide();
	});
</script>









