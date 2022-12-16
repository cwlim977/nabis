<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.6.1.min.js"></script>

<!-- ajax csrf confiuration -->
<script type="text/javascript">
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
	function csrfSafeMethod(method){
		return (/^(GET|HEAD|OPTIONS)$/.test(method));
	}
	$.ajaxSetup({
		beforeSend : function(xhr, settings){
			if (!csrfSafeMethod(settings.type) && !this.crossDomain){
				xhr.setRequestHeader(header, token);
			}
		}
	});
</script>

<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath }/resources/assets/img/favicon/favicon.ico" />

<!-- Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" />
<!-- <link -->
<!--   href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" -->
<!--   rel="stylesheet" -->
<!-- /> -->
<link
  href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
  rel="stylesheet"
 />
<!-- Icons. Uncomment required icon fonts -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/fonts/boxicons.css" />

<!-- Core CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/css/core.css" class="template-customizer-core-css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/css/demo.css" />

<!-- Vendors CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/bootstrap-5.1.3-dist/css/bootstrap-datepicker3.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/libs/apex-charts/apex-charts.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/yearpicker.css" />
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta3/dist/css/bootstrap-select.min.css">
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/libs/dropzone/dropzone.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/libs/bootstrap-daterangepicker/bootstrap-daterangepicker.css" />

<!-- FORM VALIDATE -->
<link rel="stylesheet" href="${cPath }/resources/assets/vendor/libs/formvalidation/dist/css/formValidation.min.css" />
<link rel="stylesheet" href="${cPath }/resources/assets/vendor/libs/formvalidation/dist/css/formValidation.css" />
<!-- SWEET ALERT -->
<link rel="stylesheet" href="${cPath }/resources/assets/vendor/libs/sweetalert2/sweetalert2.css" />
<script src="${cPath }/resources/assets/vendor/libs/sweetalert2/sweetalert2.js" ></script>
	
<!-- Jstree CSS -->
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" /> -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/assets/vendor/libs/jstree/jstree.css" />
<!-- Page CSS -->

<!-- Helpers -->
<script src="${pageContext.request.contextPath }/resources/assets/vendor/js/helpers.js"></script>

<!--  Perfect-scrollbar -->
<script src="${pageContext.request.contextPath }/resources/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

<!-- toastr window -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>


<!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
<!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
<script src="${pageContext.request.contextPath }/resources/assets/js/config.js"></script>

<script type="text/javascript">

function getContextPath() {
    let hostIndex = location.href.indexOf( location.host ) + location.host.length;
    return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};
const CONTEXTPATH = getContextPath(); 
</script>
<c:if test="${not empty message }">
	<script type="text/javascript">
		alert("${message}");
	</script>
</c:if>

<style>
body {
	font-family: 'Roboto', 'Noto Sans KR', sans-serif;
}
</style>

<c:set var="empRole" value="user" scope="request"/>
<sec:authorize access="hasRole('ROLE_MANAGER')">
	<c:set var="empRole" value="manager" scope="request"/>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_ADMIN')">
	<c:set var="empRole" value="admin" scope="request"/>
</sec:authorize>