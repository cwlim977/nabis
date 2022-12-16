<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<style>
ul{
	list-style:none;
}
.content-wrapper .container-xxl{
	padding:0px;
	margin:0px
}
</style>

<!-- <figure class="text-center mt-2"> -->
<!-- 	<blockquote class="blockquote"> -->
<!-- 		<i class='bx bx-edit-alt'></i> -->
<!-- 		<p class="mb-0">공지사항을 작성해볼까요?</p> -->
<!-- 	</blockquote> -->
<!-- 	<figcaption class="blockquote-P"> -->
<!-- 		우리 회사 구성원들에게 알려주고 싶은 내용을 공지사항으로 작성해보세요! -->
<!-- 	</figcaption> -->
<!-- </figure> -->
<div id="wrapNoticeList">

	<div id="listBody" class="list-group list-group-flush">
	</div>
<!-- 	attatchListHtml += ` -->
<!-- 							<li> -->
<%-- 								<c:url value="/notice/download.do" var="downloadURL"> --%>
<%-- 									<c:param name="what" value="\${attatch.attNo }" /> --%>
<%-- 								</c:url> --%>
<!-- 							</li> -->
<%-- 							<a href="\${downloadURL}">\${attatch.attFilename }</a>(\${attatch.attFancysize }) --%>
<!-- 					`; -->

	<div class="modal fade" id="noticeUpdateModal" data-bs-backdrop="static" aria-hidden="true" aria-labelledby="modalToggleLabel2" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered">
	    	<div class="modal-content">
				<div id="updateNoticeCont">
		
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="modal fade" id="backDropModal" data-bs-backdrop="static" tabindex="-1">
	
	</div>
	
	
	<div class="modal fade" id="noticeDeleteModal" aria-hidden="true" data-bs-backdrop="static" aria-labelledby="modalToggleLabel3" tabindex="-1">
		 
		<div class="modal-dialog">
	    <form class="modal-content" style="width:380px">
	      <div class="modal-header d-block "align="center">
		      <div> <p class="h4">공지사항 삭제</p> </div>
		      <div> <p class="h6">공지사항을 삭제할까요? 삭제된 공지사항은 받은 사람 소식에서도 삭제됩니다.</p> </div>
	      </div>
	      
	      <div class="modal-footer">
			<button type="button" class="btn btn-danger" style="width: 100%" onclick="delSubmit()">삭제하기</button>
	        <button type="button" class="btn btn-label-secondary" style="width: 100%;" data-bs-dismiss="modal">취소</button>
	      </div>
	    </form>
	  </div>
					
	</div>
</div>

<script id="wrapNoticeScript" type="text/javascript">
	var noticeView;
	var noticeList;
	
	 function fn_noticeView(what){
		 
// 		console.log("-----fn_noticeView 호출-----");
		$.ajax({
			url : "${cPath }/notice/noticeView.do?what="+what,
// 			data : {what:28},		
			method : "GET",
			dataType : "json",
			contentType: "application/json; charset=utf-8",
			success : function(resp) {
				noticeView=resp;
// 				console.log("resp -> noticeView확인", noticeView)
// 				console.log("noticeView.attatchList확인", noticeView.attatchList)
				
				if(noticeView != null && noticeView.attatchList.length>0){ //게시글 있음

					$( "#attatchNum"+what ).html(noticeView.attatchList.length+"개 첨부파일");

// 					console.log("attNo확인", noticeView.attatchList[0].attNo )
					
					let noticeViewBody = $( "#collapseExample"+what );	// 전체 넣을 곳
					noticeViewBody.empty(); //페이지 변경시 비워줘야함22
					
					let attatchListHtml = ``;
						attatchListHtml += `<ul>`;
						$.each(noticeView.attatchList, function(index, attatch){
							attatchListHtml += `
							
								<li>
									<div>
										<a>
											<div>
												<img id="image_section" src="">
											</div>
											<div>
												<div>
													<div>
													<a href="${cPath}/notice/download.do?what=\${attatch.attNo }">\${attatch.attFilename }</a>(\${attatch.attFancysize })
													</div>
												</div>
											</div>
										</a>
									</div>
								</li>
								
							`;
						})
								
					attatchListHtml += `</ul>`;
// 					console.log("success attatchListHtml 확인", attatchListHtml)
					
					noticeViewBody.html(attatchListHtml);
				}else{ //게시글없음
// 					let noticeViewBody = $( "#collapseExample"+what );	// 전체 넣을 곳
// 					noticeViewBody.html( $("<span>").html("조건에 맞는 게시글이 없음.") );
					$( "#attatchNum"+what ).html("첨부파일 없음");
				}
				
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
			
		})
	}
	 
$(document).ready(function() {
	$("#menuText").html("공지사항( ${noticeCnt} )")
	let listBody = $("#listBody");
	
		$.ajax({
			url : "${cPath }/notice/noticeList.do",
			method : "GET",
			dataType : "json",
			async:false,
			success : function(resp) { //controller에서 마샬링 해온 애
				
// 				console.log("ajax resp확1인", resp)
				listBody.empty(); //페이지 변경시 비워줘야함22
				
				noticeList = resp;
				let noticeListHtml = ``;
				let attatchListHtml =``;
				
				if(noticeList.length > 0){ //게시글 있음
					
					$.each(noticeList, function(index, notice){
						let empImg = notice.empImg;
						// 프로필 유무로 이미지주소설정
						if(!empImg){
							empImg =`\${CONTEXTPATH}/resources/images/basicProfile.png`;
						}else{
							empImg = `\${CONTEXTPATH}/resources/empImages/\${empImg}`;
						}
						noticeListHtml += `
						
						<div class="list-group-item list-group-item-action">
							<div class="container px-1">
								<div class="row">
								
									<!-- headDiv -->
									<div class="col-10" >
										<span class="d-inline me-3" style="float:left">
											<img src="\${empImg}" alt="Avatar" class="empListimgradius emplistimgsize">
										</span>
										<div>
											<div>
												<small><span class="display-6"><small>\${notice.postTitle}</small></span> 
													<span class="mx-2">\${notice.wriDate }</span> 
												</small>
											</div>
											<small><span>\${notice.empNm }</span></small>
										</div>
									</div>	
								<!-- btnDiv  -->
									<div class="col-2 d-flex pe-0" >
								        <button type="button" 
								        		class="btn btn-outline-dark p-0 hide-arrow ms-auto" 
								        		data-bs-toggle="dropdown" 
								        		style="border:none; height:40px; width:40px">
								        <i class="bx bx-dots-horizontal-rounded"></i></button>
								        
								        <div class="dropdown-menu">
								        	<span class="dropdown-item" data-bs-toggle="modal" data-bs-target="#noticeUpdateModal" onclick="editNotice(\${notice.postNo}) "><i class='bx bx-pencil me-1' ></i>수정하기</span>
								        	
								        	<span class="dropdown-item text-danger" data-bs-toggle="modal" data-bs-target="#noticeDeleteModal" onclick="delNotice( \${notice.postNo} )"><i class="bx bx-x bx-sm me-1"></i>삭제하기</span>
										</div>
									</div>
								</div>					
								<!-- bodyDiv -->	
								
								<div class="mx-5 px-3">
									<pre class="pt-2">\${notice.postCont }</pre>
									<div>
										<button class="btn btn p-0 ms-auto"  
												style="background-color:transparent; border:none" 
												data-bs-toggle="collapse" 
												data-bs-target="#collapseExample\${notice.postNo}" 
												aria-expanded="false" 
												aria-controls="collapseExample\${notice.postNo}"
										>
												<div>
													<span id="attatchNum\${notice.postNo}"> </span>
												</div>
										</button>
											<div class="collapse" id="collapseExample\${notice.postNo}">

											</div>
									</div>
								</div>	
							</div>
						</div>
						
							`;
					})

					$('#listBody').html(noticeListHtml);
					
				}else{ //게시글없음
					$('#listBody').html( $("<span>").html("조건에 맞는 게시글이 없음.") );
				}
				
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
			, complete : function(){
// 				console.log("noticeList Complete 확인", noticeList)
				// noticeList마다 noticeView생성 함수 호출
				if(noticeList.length > 0){ //게시글 있음
					$.each(noticeList, function(index, notice){
						fn_noticeView( notice.postNo )
					})
				}
			}
		});
		
});

function editNotice(what){
	console.log("editNotice 호출");
	$.ajax({
		url : "${cPath}/notice/noticeUpdate.do?what="+what,
		method : "GET",
		dataType : "html",
		success : function(resp) {
			$("#updateNoticeCont").empty();
// 			console.log("edit-resp확인", resp)
			$("#updateNoticeCont").html( resp ); 
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	})
}

// 전역변수로 postNo 담기
let param ;
function delNotice(what){
	console.log("delNotice 호출", what)
	param = what;
	
}

// delete.do 실행
function delSubmit(){
	
	console.log("delSubmit호출")
	
	$.ajax({
		url : "${cPath}/notice/noticeDelete.do",
		method : "POST",
		data : {
			postNo : param
		},
		dataType : "json",
		success : function(resp) {
			console.log("결과",resp)
			console.log("결과mes",resp.message)
			window.location.reload() 
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	})
}

</script>








