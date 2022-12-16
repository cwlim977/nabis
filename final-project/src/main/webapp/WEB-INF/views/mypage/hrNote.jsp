<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<div class="empFormheader">
	<div class="mypagetablewidth">
		<div class="card shadow-none ">
			<div class="">
				<!--   <h5 class="card-header pt-2 ps-3 fs-4 fw-bold">인사정보</h5> -->

				<!-- 인사노트 작성폼 -->
				<form>
					<div class="mb-3 ps-3 fs-4  me-5">
						<textarea id="noteCont" name="noteCont"
							class="form-control hrnotewrite" onfocus="this.value='';"
							rows="10" cols="20" wrap="hard" placeholder="내용을 입력해주세요. 권한이 있는 사람만 볼 수 있습니다."></textarea>
						<div class="d-flex mt-2">
							<button id="insertBtn" type="button"
								class="btn btn-primary empaddbutton">작성하기</button>
						</div>
					</div>
				</form>

			</div>

		</div>


		<%-- 				<c:forEach items="${hrnoteList}" var="hrnote"> --%>
		<%-- 				${hrnote.empNm} --%>
		<%-- 				</c:forEach> --%>



		<!-- 인사노트 목록 -->
		<c:forEach items="${hrnoteList}" var="hrnote">
			<div class="div01">
				<!-- 인사노트 작성자정보 -->
				<div class="d-flex ps-3 mb-2 me-5 ">
					<div class="d-flex align-self-center align-items-center">
						<img
							src="${cPath}/resources/images/basicProfile.png"
							alt="Avatar" class="empListimgradius emplistimgsize">
						<div class="mx-3 mt-1">
							<strong>${hrnote.empNm}</strong><br> <span class="fs-tiny">${hrnote.wriDate}</span>
						</div>
					</div>



					<!--수정삭제 버튼  -->
					<!-- 본인이 작성한 글에만 수정,삭제 버튼 뜨도록 함 -->
						<c:choose>
							<c:when test="${hrnote.writer == authEmp.empNo}">
								<div class="btn-group empaddbutton">
									<button type="button"
										class="btn  btn-icon btn-light  dropdown-toggle hide-arrow mt-2 p-0"
										data-bs-toggle="dropdown" aria-expanded="false">
										<i class='bx bx-dots-horizontal-rounded'></i>
									</button>
			
			
									<ul class="dropdown-menu dropdown-menu-end">
										<li>
											<a class="dropdown-item hreditBtn" data-note="${hrnote.noteNo }">수정하기</a>
										</li>
										<li>
											<a class="dropdown-item hrDeleteBtn" data-note="${hrnote.noteNo }" data-writer="${hrnote.writer }">삭제하기</a>
										</li>
			
									</ul>
								</div>
							</c:when>
							<c:otherwise>
								
							</c:otherwise>
						</c:choose>
					<!--수정삭제 버튼  -->

				</div>

				<div>
					<form>
						<div class="mb-3 ps-3 fs-4  me-5 noteContBf div02"  style="display:block;">
							<br>
							<h6 id="basic-default-message" class="">${hrnote.noteCont}</h6>
							<div class="d-flex mt-2">
							</div>
							<br>
						</div>
						<div class="mb-3 ps-3 fs-4  me-5 noteContAf div03" style="display:none;">
							<textarea id=""
								class="form-control hrnotewrite editNoteCont"
								rows="10" cols="20" wrap="hard" 
								placeholder="">${hrnote.noteCont}</textarea>
							<div class="d-flex mt-2">
								<button type="button" class="btn btn-primary empaddbutton editBtn" data-note="${hrnote.noteNo }" data-writer="${hrnote.writer}">수정하기</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</c:forEach>

	</div>




	<!-- 오른쪽 card들 -->
	<c:if test="${empRole eq 'admin' || empRole eq 'manager' ||  authEmp.empNo eq empVo.empNo}">
	<div class="col-md-6 col-xl-4 mypagerightwidth">
		<div
			class="card shadow-none bg-transparent border border-secondary mb-4 mypagecardheigh">
			<div class="card-body cntcard mt-5 pb-4">
				<div>
					<span class="card-title">근무시간</span>
					<h4 class="card-text">
						<span>0</span>분
					</h4>
				</div>
				<div class="cnticon">
					<i class='bx bxs-user bx-md cnti'></i>
				</div>
			</div>
		</div>

		<div
			class="card shadow-none bg-transparent border border-secondary mb-4 mypagecardheigh">
			<div class="card-body cntcard mt-5 pb-4">
				<div>
					<span class="card-title">남은 연차</span>
					<h4 class="card-text">
						<span>0</span>일
					</h4>
				</div>
				<div class="cnticon">
					<i class='bx bxs-user bx-md cnti'></i>
				</div>
			</div>
		</div>

		<div
			class="card shadow-none bg-transparent border border-secondary mb-4 mypagecardheigh">
			<div class="card-body cntcard mt-5 pb-4">
				<div>
					<span class="card-title">급여</span>
					<h4 class="card-text">
						<span>11</span>월 급여 명세서
					</h4>
				</div>
				<div class="cnticon">
					<i class='bx bxs-user bx-md cnti'></i>
				</div>
			</div>
		</div>


	</div>
</c:if>
</div>




<script type="text/javascript">
	function refreshNoteList() {
		location.reload();
	}

	//글 작성시 사용하는 script
	$("#insertBtn").on("click",function() {
				let noteCont = $("#noteCont").val().replace(/(?:\r\n|\r|\n)/g,'<br/>');
				let empNo = ${empVo.empNo} //맞나
				let writer = ${authEmp.empNo};
				
				console.log("noteCont" + noteCont);
				console.log("empNo" + empNo);
				console.log("writer" + writer);
				
				//입력한 내용이 없으면 알람을 띄워준다
				if (noteCont === '') {
					alert('내용을 입력해주세요.');
					return;

					//	formData.append("noteCont", noteCont);
					//	formData.append("hrEmpno", empNo);	
					//	formData.append("writer", writer);	

				}

				$.ajax({
					url : "hrNoteInsert.do",
					data : {
						noteCont : noteCont,
						hrEmpno : empNo,
						writer : writer
					},
					type : "POST",
					success : function(resp) {
						console.log(resp);
					},
					error : function(errorResp) {
						console.log(errorResp.status);
					}

				});

				refreshNoteList();
			});

	//글 삭제시 사용하는 script
	$(".hrDeleteBtn").on("click", function() {
		let noteNo = $(this).data("note");
		let writer = $(this).data("writer");
		let user = ${authEmp.empNo};
		
		console.log(noteNo);
		console.log(writer);
		console.log(user);

		//로그인 한 사람과 글 쓴 사람이 일치할 때만 수정 가능하도록 controller에서 검증 걸어둠
		$.ajax({
			url : "hrNoteDelete.do",
			data : {
				noteNo : noteNo,
				writer : writer,
				user : user
			},
			type : "POST",
			success : function(resp) {
				console.log(resp)
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
		console.log("성공");
			refreshNoteList();
	});
	
	
	//인사노트 수정
	$(".hreditBtn").on("click", function() {
		//내가 수정 버튼을 클릭한 항목의 조건에 맞는 가장 가까운 부모의, 조건에 맞는 자식을 찾아서 css속성을 변경할 수 있는 코드
		$(this).closest('.div01').find('.div02').css("display","none");
		$(this).closest('.div01').find('.div03').css("display","block");
		
	});
	
	$(".editBtn").on("click", function(){
		
		let noteNo = $(this).data("note");
		let writer = $(this).data("writer");
		let user = ${authEmp.empNo};
// 		let editNoteCont = $(".editNoteCont").val().replace(/(?:\r\n|\r|\n)/g,'<br/>');
		let noteCont = $(this).closest('.div03').find('.editNoteCont').val();
		
		console.log(noteNo,"noteNo");
		console.log(writer,"writer");
		console.log(user,"user");
		console.log(noteCont,"editNoteCont");
		
		$.ajax({
			url : "hrNoteUpdate.do",
			data : {
				noteNo : noteNo,
				writer : writer,
				user : user,
				noteCont : noteCont
			},
			type : "POST",
			success : function(resp) {
				console.log(resp)
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
		console.log("성공");
			refreshNoteList();
		
	});
	
	

	// 	수정삭제 버튼누르면 수정삭제 할 수 있도록 해야 함 특히 수정... 여기서 스크립트 써야 할 듯
	/* HIDDEN 상태 조절로 가능할것으로 사료됨 */
</script>