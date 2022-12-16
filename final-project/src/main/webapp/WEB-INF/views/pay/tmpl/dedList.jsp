<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>	
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>	


<style>
.ded{
	border: 1px solid  rgba(67,89,113, 0.1);
	float: left;
	margin: 15px;
}

#divded{
	margin-top: 40px;
}

.div-box{
	clear: both;
}
.dedset{
	display: inline-block;
}
.dedsetbtn{
	float: right;
}

#dedplus{
	float : right;
}
.tgbtn{
	margin-left: 10px;
}



</style>

 <button type="button" id="dedplus" class="btn btn-outline-primary" onclick="location.href='${cPath }/pay/dedInsert.do?ptNo=${ptNo }'">
 	<i class='bx bx-plus'></i>공제항목 추가
 </button>


<br><br>

<div class="div-box">
	<div class="divider text-start">
		<div class="divider-text">법정필수 항목</div>
	</div>
	
	<c:choose>
		<c:when test="${not empty esDedList }">
			<c:forEach var="esDed" items="${esDedList}">
				<div class="card ded shadow-lg" style="width: 18rem; height: 12rem; position: relative;">
				  <div class="card-body">
				    <h5 class="card-text dedset">${esDed.ddNm }</h5>
				    <div class="form-check form-switch mb-2 dedset align-middle tgbtn">
			           <input class="form-check-input" type="checkbox" data-ddcode="${esDed.ddCode }" data-pddamt="${esDed.ddAmt }"
			           	<c:forEach var="ptm" items="${ptmList}">
						 	<c:if test="${ptm.ddCode eq esDed.ddCode }">checked</c:if>
						 </c:forEach> />
			         </div>
				    <br>
				    <p class="fs-tiny">${esDed.ddAbst }</p>
					<span class="badge bg-label-danger" style="position: absolute; bottom: 20px;" >법정필수</span>
				  </div>
				</div>
			</c:forEach>
		</c:when>
	</c:choose>
</div>

<br><br><br>

<div class="div-box">
	<div class="divider text-start">
		<div id="divded" class="divider-text">추가한 항목</div>
	</div>
	<c:choose>
		<c:when test="${not empty nesDedList }">
			<c:forEach var="nesDed" items="${nesDedList}">
				<div class="card ded shadow-lg" style="width: 18rem; height: 13rem; position: relative;">
					<div class="card-body">
						<h5 class="card-text dedset">${nesDed.ddNm }</h5>
						<div class="form-check form-switch mb-2 dedset align-middle tgbtn">
				           <input class="form-check-input pdcbtn" type="checkbox" data-ddcode="${nesDed.ddCode }" data-pddamt="${nesDed.ddAmt }"
				           		<c:forEach var="ptm" items="${ptmList}">
								 	<c:if test="${ptm.ddCode eq nesDed.ddCode }">checked</c:if>
						    	</c:forEach> />
				         </div>
			
						<div class="btn-group dedset dedsetbtn">
							<button type="button"
								class=" btn border btn-icon rounded-pill dropdown-toggle hide-arrow"
								data-bs-toggle="dropdown">
								<i class="bx bx-dots-vertical-rounded"></i>
							</button>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="${cPath }/pay/dedUpdate.do?ddCode=${nesDed.ddCode}&ptNo=${ptNo}"><i class='bx bx-edit-alt' ></i>  공제항목 수정</a></li>
								<li><a class="dropdown-item text-danger" href="${cPath }/pay/dedDelete.do?ddCode=${nesDed.ddCode}&ptNo=${ptNo}"><i class='bx bx-trash' ></i>  삭제하기</a></li>
							</ul>
						</div>
						<h6 class="card-text"><fmt:formatNumber maxFractionDigits="3" value="${nesDed.ddAmt}" type="number" />원</h6>
						<p class="fs-tiny">${nesDed.ddAbst }</p>
						<br>
						<div style="position: absolute; bottom: 20px;">
							<span class="badge bg-label-dark">기타수당</span> 
						</div>
					</div>
				</div>
			</c:forEach>
		</c:when>
	</c:choose>	
</div>


<script>

$("[type=checkbox]").on("change", function(){
	if($(this).is(":checked")){
		let ptNo = '${tmp.ptNo}';
		let ddCode = $(this).data("ddcode");
		let pddAmt = $(this).data("pddamt");
		
		$.ajax({
			url : "${cPath}/pay/ptmakeInsert.do",
			data : {
				ptNo : ptNo
				,ddCode : ddCode
				,pddAmt : pddAmt
			},
			success : function(resp) {
				console.log(resp);
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	}else{
		let ptNo = '${tmp.ptNo}';
		let ddCode = $(this).data("ddcode");
		
		$.ajax({
			url : "${cPath}/pay/ptmakeDelete.do",
			data : {
				ptNo : ptNo
				,ddCode : ddCode
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




</script>
