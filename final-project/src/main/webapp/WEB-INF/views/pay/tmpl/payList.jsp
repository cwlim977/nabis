<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

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

#payplus{
	float : right;
}

.tgbtn{
	margin-left: 10px;
}

</style>

 <button type="button" id="payplus" class="btn btn-outline-primary" onclick="location.href='${cPath }/pay/payInsert.do?ptNo=${ptNo }'">
 	<i class='bx bx-plus'></i>지급항목 추가
 </button>


<br><br>

<div class="div-box">
	<div class="divider text-start">
		<div class="divider-text">법정필수 항목</div>
	</div>

	<c:choose>
		<c:when test="${not empty esPayList }">
			<c:forEach var="esPay" items="${esPayList}">
				<div class="card ded shadow-lg" style="width: 18rem;  height: 12rem; position: relative;">
				  <div class="card-body">
				    <h5 class="card-text dedset">${esPay.pyNm }</h5>
					 <div class="form-check form-switch mb-2 dedset align-middle tgbtn">
						 <input class="form-check-input paychk " type="checkbox" data-pycode="${esPay.pyCode }" data-ppyamt="${esPay.pyAmt }"
						 <c:forEach var="ptm" items="${ptmList}">
						  	<c:if test="${ptm.pyCode eq esPay.pyCode }">checked</c:if>
				    	 </c:forEach> />
					  </div>	
				    <br>
				    <span class="badge bg-label-danger"  style="position: absolute; bottom: 20px;">법정필수</span>
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
		<c:when test="${not empty nesPayList }">
			<c:forEach var="nesPay" items="${nesPayList}">
				<div class="card ded shadow-lg" style="width: 18rem; height: 13rem; position: relative;">
					<div class="card-body">
						<h5 class="card-text dedset ">${nesPay.pyNm }</h5>
						<div class="form-check form-switch mb-2 dedset align-middle tgbtn">
				           <input class="form-check-input" type="checkbox" data-pycode="${nesPay.pyCode }" data-ppyamt="${nesPay.pyAmt }"
					           <c:forEach var="ptm" items="${ptmList}">
								  <c:if test="${ptm.pyCode eq nesPay.pyCode }">checked</c:if>
						    	</c:forEach> />
				         </div>
						<div class="btn-group dedset dedsetbtn">
							<button type="button"
								class=" btn border btn-icon rounded-pill dropdown-toggle hide-arrow"
								data-bs-toggle="dropdown">
								<i class='bx bx-dots-vertical-rounded'></i>
							</button>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="${cPath }/pay/payUpdate.do?pyCode=${nesPay.pyCode}&ptNo=${ptNo}"><i class='bx bx-edit-alt' ></i>  지급항목 수정</a></li>
								<li><a class="dropdown-item text-danger" href="${cPath }/pay/payDelete.do?pyCode=${nesPay.pyCode}&ptNo=${ptNo}"><i class='bx bx-trash' ></i>  삭제하기</a></li>
							</ul>
						</div>
						<h6 class="card-text"><fmt:formatNumber maxFractionDigits="3" value="${nesPay.pyAmt}" type="number" />원</h6>
						<p class="fs-tiny">${nesPay.pyAbst }</p>
						<br>
						<div style="position: absolute; bottom: 20px;">
							<span class="badge bg-label-dark">기타수당</span> 
							<span class="badge bg-label-dark">
							<c:choose>
							<c:when test="${nesPay.pyTax eq 'N' }">
								비과세
							</c:when>
							<c:otherwise>
								과세
							</c:otherwise>
							</c:choose>
							</span>
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
		let pyCode = $(this).data("pycode");
		let ppyAmt = $(this).data("ppyamt");
		
		$.ajax({
			url : "${cPath}/pay/ptmakeInsert.do",
			data : {
				ptNo : ptNo
				,pyCode : pyCode
				,ppyAmt : ppyAmt
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
		let pyCode = $(this).data("pycode");
		
		$.ajax({
			url : "${cPath}/pay/ptmakeDelete.do",
			data : {
				ptNo : ptNo
				,pyCode : pyCode
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

