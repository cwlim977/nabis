<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <%-- <script src="${cPath }/resources/assets/vendor/libs/jquery/jquery.js"></script> --%>
    <script src="${cPath }/resources/assets/vendor/libs/popper/popper.js"></script>
    <script src="${cPath }/resources/assets/vendor/js/bootstrap.js"></script> 
    <script src="${cPath }/resources/assets/vendor/libs/hammer/hammer.js"></script>
    <script src="${cPath }/resources/assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->
    <script src="${cPath }/resources/assets/vendor/libs/apex-charts/apexcharts.js"></script>
	<script src="${cPath }/resources/js/bootstrap-5.1.3-dist/js/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script src="${cPath }/resources/js/yearpicker.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta3/dist/js/bootstrap-select.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
    <script type="text/javascript" src="${cPath }/resources/js/bootstrap-notify.min.js"></script>
    
    <!-- FORM VALIDATE -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/es6-shim/0.35.3/es6-shim.min.js"></script>
	<script src="${cPath }/resources/assets/vendor/libs/formvalidation/dist/js/FormValidation.min.js"></script>
	<script src="${cPath }/resources/assets/vendor/libs/formvalidation/dist/js/plugins/Bootstrap.min.js"></script>
	
    <!-- jquery-serialize-object -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-serialize-object/2.5.0/jquery.serialize-object.min.js" integrity="sha512-Gn0tSSjkIGAkaZQWjx3Ctl/0dVJuTmjW/f9QyB302kFjU4uTNP4HtA32U2qXs/TRlEsK5CoEqMEMs7LnzLOBsA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<!-- Jstree JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
    
    <!-- Main JS -->
    <script src="${cPath }/resources/assets/js/main.js"></script>

    <!-- Page JS -->
    <script src="${cPath }/resources/assets/js/dashboards-analytics.js"></script>

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    
	<script type="text/javascript">
		let url = "wss://localhost${cPath}/ws/pushMsg";
		let webSocket = new WebSocket(url);
		webSocket.onopen=function(event){
			console.log("연결수립========================");
			console.log(event);
		}
		webSocket.onclose=function(event){
			console.log("========================연결종료");
			console.log(event);
		}
		webSocket.onmessage=function(event){
			console.log("메시지 수신 : "+ event.data);
			// JSON -> Javascript object - Unmarshalling
			let newArm = JSON.parse(event.data);
			let armNo = newArm.armNo;
			let armCont = newArm.armCont;
			let armUrl = newArm.armUrl;
	// 		<a href="${cPath}/board/boardView.do?what=300">누구님의 새글</a>
			let armMsg = $("<a>").attr("href", CONTEXTPATH+armUrl)
								.text(armCont);
			$.notify({
				// options
				title:""
				,message: armMsg.html()
			},{
				// settings
				type: 'info'
				,placement: {
					from: "top",
					align: "right"
				},
			});
			
			// 새로운소식 갱신
			getArmList();
		}
		webSocket.onerror=function(event){
			console.log("에러발생");
			console.log(event)
		}
	</script>