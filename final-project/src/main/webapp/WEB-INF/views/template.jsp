<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!doctype html>
<html lang="en" class="light-style layout-menu-fixed" dir="ltr"
	data-theme="theme-default"
	data-assets-path="${pageContext.request.contextPath }/resources/assets/"
	data-template="vertical-menu-template-free">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<meta name="description" content="">
<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.88.1">
<meta name="theme-color" content="#7952b3">

<!-- ajax csrf confiuration -->
<meta name="_csrf" id="_csrf" content="${_csrf.token }"/>
<meta name="_csrf_header" id="_csrf_header" content="${_csrf.headerName }"/>

<title><tiles:getAsString name="title" /></title>
<tiles:insertAttribute name="preScript" />
<style type="text/css">
 .backcolor{
 	background-color: white
 }
</style>
</head>
<body>
	<!-- Layout wrapper -->
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">
			<!-- Menu -->
			<tiles:insertAttribute name="leftMenu" />
			<!-- /Menu -->

			<!-- Layout container -->
			<div class="backcolor layout-page">

				<!-- Navbar -->
				<header>
					<tiles:insertAttribute name="headerMenu" />
				</header>
				<!-- / Navbar -->
				<!-- Content wrapper -->
				<div class="content-wrapper">

					<!-- Content -->
					<div
						class="container-fluid flex-grow-1 container-p-y">
						<!-- Main Content Area start -->
						<!-- <div class="card"> -->

							<tiles:insertAttribute name="main" />

						<!-- </div> -->
						<!-- Main Content Area end -->
					</div>
					<!-- / Content -->

					<!-- Footer -->
					<footer>
						<tiles:insertAttribute name="footer" />
					</footer>
					<!-- / Footer -->
					<div class="content-backdrop fade"></div>
				</div>
				<!-- Content wrapper -->
			</div>
			<!-- / Layout page -->
		</div>

		<!-- Overlay -->
		<div class="layout-overlay layout-menu-toggle"></div>
	</div>
	<!-- / Layout wrapper -->

	<tiles:insertAttribute name="postScript" />
</body>
</html>
