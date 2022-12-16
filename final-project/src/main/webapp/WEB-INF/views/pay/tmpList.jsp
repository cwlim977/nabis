<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="${cPath }/resources/css/ijs.css" />

<style>
.bmark{
	border : none;
}

.bmk:hover{
	background-color : #fbfcfe;
}

.bxs-bookmark{
	color : #cdd2d6;
}

.ckmark.bxs-bookmark{
    color : #f04785;
}
</style>

<div class="text-lg-end">
  <button type="button" class="btn btn-success mvbtn" onclick="location.href = '${cPath }/pay/tmpInsert.do'">
	<i class='bx bx-plus'></i> 정산템플릿 추가
 </button>
</div>
<br>
<div class="div-box">
	<c:choose>
		<c:when test="${not empty tmpList }">
			<c:forEach var="tmp" items="${tmpList}">
				<div class="card ded border shadow-lg" style="width: 25rem; height: 13rem">
					<div class="card-body ">
						<h5 class="card-text dedset">${tmp.ptNm }</h5>
						<div class="btn-group dedset dedsetbtn">
                            <button type="button" class="btn rounded-pill btn-icon me-2">
                              <span class="tf-icons bx bxs-bookmark markspan
                              <c:if test="${tmp.ptBmk eq 'Y' }">
                              	ckmark
                              </c:if>
                              " data-ptno="${tmp.ptNo }">
                              </span>
                            </button>
							<button type="button"
								class=" btn btn-primary btn-icon rounded-pill dropdown-toggle hide-arrow"
								data-bs-toggle="dropdown">
								<i class="bx bx-dots-vertical-rounded"></i>
							</button>
							<ul class="dropdown-menu">
								<li>
									<a class="dropdown-item" href="${cPath }/pay/tmpUpdate.do?ptNo=${tmp.ptNo}">
									<i class='bx bx-edit-alt'></i> 정산템플릿 수정</a>
								</li>
								<li>
									<a class="dropdown-item text-danger" href="${cPath }/pay/tmpDelete.do?ptNo=${tmp.ptNo}">
									<i class='bx bx-trash'></i> 삭제하기</a>
								</li>
							</ul>
						</div>
						<br> <br>
						<p>${tmp.ptAbst}</p>
						<br> <br> <span class="badge bg-label-success">근로소득</span>
					</div>
				</div>
			</c:forEach>
		</c:when>
		<c:otherwise>
				템플릿 데이터 없음
		</c:otherwise>
	</c:choose>
</div>



<script>


const togglingBtns = document.querySelectorAll('.markspan'); 

togglingBtns.forEach(function(btns){ 
    btns.addEventListener ("click", function() { 
        btns.classList.toggle('ckmark');
        
        if ($(this).hasClass('ckmark')){
	        let ptNo = $(this).data("ptno");
	        console.log(ptNo);
	        
	        $.ajax({
				url : "${cPath}/pay/tmpBmkInsert.do",
				data : {
					ptNo : ptNo
				},
				success : function(resp) {
					console.log(resp);
				},
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			});
        }else{
        	let ptNo = $(this).data("ptno");
	        console.log(ptNo);
	        
	        $.ajax({
				url : "${cPath}/pay/tmpBmkDelete.do",
				data : {
					ptNo : ptNo
				},
				success : function(resp) {
					console.log(resp);
				},
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			});
        }
    });
});

</script>