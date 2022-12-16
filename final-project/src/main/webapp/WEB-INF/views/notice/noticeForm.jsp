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

<!-- <script src="https://cdn.ckeditor.com/4.20.0/standard/ckeditor.js"></script> -->

<!-- Button trigger modal -->
<!-- <button type="button" class="btn btn-primary" data-bs-toggle="modal" -->
<!-- 	data-bs-target="#noticeModal">동료에게 전달하기</button> -->

<form:form method="post" modelAttribute="notice" 
	enctype="multipart/form-data">
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
								style=" height:450px; " />
						</div>
						<div style="width:490px;height:100px;overflow:hidden">
							<img id="image_section">
						</div>
						<form:input type="hidden" path="wriNo" class="form-control"
							value="${authEmp.empNo}" />
					</div>
				</div>

				<div class="modal-footer mx-4 ">
					<input class="form-control" type="file" id="noticeFiles" name="noticeFiles"
						multiple="multiple">
						
					<form:button type="submit" class="btn btn-primary"
						style="width: 100%;">작성하기</form:button>
				</div>
				
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
</form:form>
<form:form id="testForm" >

</form:form>

<script>
	var imageFile;
	
	var testForm = document.getElementById("testForm");

	var formData = new FormData(testForm);

	formData.append("file", imageFile);
	formData.append("type", "file");


// 	$.ajax({
// 	    url: "${cPath}/notice/imageUpload.do",
// 	    async: true,
// 	    type: "POST",
// 	    data: formData,
// 	    processData: false,
// 	    contentType: false,
// 	    dataType: "json",
// 	    beforeSend: function( xhr ) {
// 	    	 xhr.setRequestHeader( "${_csrf.parameterName}", "${_csrf.token}" );
// 		},
// 	    success: function(response) {
// 	    	// 전송이 성공한 경우 받는 응답 처리
// 	    },
// 	    error: function(error) {
// 	    	// 전송이 실패한 경우 받는 응답 처리
// 	    }
// 	    ,complete: function(){
	    	
// 			console.log("확인")
// 	    }
// 	});

	
	// 첨부파일을 변경할때 마다 실행되는 이벤트 
	$("#noticeFiles").on("change", function(event){
		imageFile = event.target.files[0];
		readURL(this);
	});
		
	function readURL(input) {
		if (input.files && input.files[0]) {
		
			var reader = new FileReader();
		  
			reader.onload = function (e) {
				$('#image_section').attr('src', e.target.result);  
			}
		  
			reader.readAsDataURL(input.files[0]);
		}
	}
	
</script>

<script>
// 	var imageFile;

// 	// 첨부파일을 변경할때 마다 실행되는 이벤트 
// 	$("#noticeFiles").on("change", function(event){
// 		imageFile = event.target.files[0];
		
// 		  readURL(this);
// 	});

// 	var testForm = document.getElementById("testForm");

// 	var formData = new FormData(testForm);

// 	formData.append("imageFile", imageFile);

// 	$.ajax({
// 	    url: "${cPath}/notice/imageUpload.do?type=image&${_csrf.parameterName}=${_csrf.token}",
// 	    async: true,
// 	    type: "POST",
// 	    data: formData,
// 	    processData: false,
// 	    contentType: false,
// 	    dataType: "json",
// 	    success: function(response) {
// 	    	// 전송이 성공한 경우 받는 응답 처리
// 	    },
// 	    error: function(error) {
// 	    	// 전송이 실패한 경우 받는 응답 처리
// 	    }
// 	});
	
// 	function readURL(input) {
// 		 if (input.files && input.files[0]) {
			 
// 		  var reader = new FileReader();
		  
// 		  reader.onload = function (e) {
// 		   $('#image_section').attr('src', e.target.result);  
// 		  }
		  
// 		  reader.readAsDataURL(input.files[0]);
// 		  }
// 		}
</script>









