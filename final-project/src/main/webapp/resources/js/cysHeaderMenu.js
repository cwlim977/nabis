// 테이블 데이터 리스트 비동기로 가져오기 
// 비동기로 휴직이력을 가져와서 테이블 내용을 보여줍니다.
// 전역변수 사용중 {}
	let bkHxtbody = $('#bkHxtbody');
	let wkHxtbody = $('#wkHxtbody');
	let wageHxtbody = $('#wageHxtbody');
	let nowEmptStat = $('#nowState');
	let prestText = $("#stBtn").text().trim();		/*현재 재직상태*/
	let nowstText = $("#stBtn");					/*변경하면서 실시간으로 반영되는 재직상태*/
	let delno="";
	let editno="";
	let cnthxNo="";
	let vEmpNo = "";
	//오늘날짜
	let vtoday = new Date();
	vtoday = vtoday.toISOString().slice(0, 10);		/*날짜 형식 수정(yyyy-mm-dd) */

	
//---------------------<document.ready함수>------------------------------------------------------------------------------------------------------	
	$(document).ready(function(){

//---------------------[휴직목록]-----------------------------------------------------
		//휴직삭제버튼을 누르면, 삭제버튼에 담겨있는 글번호(고유키)를 직접 삭제할 수 있도록 '#hxDelBtnFinal'에 담아주는 함수
		$(document).on("click", ".hxDelBtn", function() {
			delno = $(this).data("delno");
			let hxDelBtnFinal = $('#hxDelBtnFinal');
			hxDelBtnFinal.data("delno", delno);
//			console.log("새로만든함수 delno",delno);
		});
		
		
		//휴직수정버튼을 누르면, 수정버튼에 담겨있는 글번호(고유키)를 직접 수정할 수 있도록 '#hxDelBtnFinal'에 담아주는 함수
		$(document).on("click", ".bkEditBtn", function() {
			editno = $(this).data("editno");
//			console.log("새로만든함수 editno",editno);
		});

		
		//휴직이력삭제 (삭제 confirm시동작)
		$(document).on("click",'#hxDelBtnFinal',function(){
			console.log("휴직이력삭제함수");
//			console.log("삭제함수 내에서의 emptNo : ",delno);
			$.ajax({
				url : "bkDelete.do",
				data : {
					emptNo : delno
				},
				type : "POST",
				success : function(resp) {
					console.log(resp);
					if(resp == "SUCCESS"){
						toastr.success('휴직이력을 성공적으로 삭제하였습니다');
						bkHxSelect();
					}else{
						toastr.error('휴직이력 삭제에 실패하였습니다');	
					}
				},
				error : function(errorResp) {
					console.log(errorResp.status);
					toastr.error('휴직이력 삭제에 실패하였습니다');
				}
			});
		});
		
		
		//휴직이력수정 (목록에서 수정버튼 클릭시 동작)
		$(document).on("click","#bkEditBtn",function(){
			let editbkSt = $('#editbkSt').val();
			let EditbkMemo = $("#EditbkMemo").val().replace(/(?:\r\n|\r|\n)/g,'<br/>');
//			console.log("editno : ",editno);
//			console.log("휴직수정버튼누름");
//			console.log("버튼누름 startDate : "+std);
//		    console.log("버튼누름 vEndDate : "+end);
//		    console.log("버튼누름 empNo : "+empNo);
//		    console.log("버튼누름 empSt : "+empSt);
		    
		    $.ajax({
				url : "bkUpdate.do",
				data : {
					emptNo : editno,
					bkSdate : std,
					bkEdate : end,
					stClf : editbkSt,
					stMemo : EditbkMemo
				},
				type : "POST",
				success : function(resp) {
					console.log(resp);
					if(resp == "SUCCESS"){
						toastr.success('휴직내용이 수정되었습니다.');
						$("#bkEditModal").modal('hide');
						bkHxSelect();
						//오늘 날짜가 휴직 기간 이내에 포함이 된다면 상태를 휴직으로 바꿔주고, 그렇지 않다면 그대로 둔다. 
						if(dateStr >= std && dateStr <= end){
							$("#stBtn").attr('class','btn btn-warning dropdown-toggle dropdown-toggle-split empstat-toggle-padding').text("휴직");
//							console.log("휴직기간에포함된다")
						}else{
//							console.log("휴직기간에 포함되지 않는다")
						};
						stTagChange();
//						console.log("bk-eidt-if문 실행");
					}else{
						toastr.error('휴직내용 수정에 실패하였습니다');	
					}
				},
				error : function(errorResp) {
					console.log(errorResp.status);
					toastr.error('휴직내용 수정에 실패하였습니다');
				}
		    });
		});
		
//=====================[재직상태 끝]======================================================		
		
//---------------------[근로계약목록]-----------------------------------------------------
		//하단 offcanvas의 근로계약버튼 누르면 목록조회 
		$(document).on("click","#wkListBtn", function(){
			vEmpNo = $(this).data("empno");
//			console.log("여기에요친구들",vEmpNo);
			wkListPrint(vEmpNo);
		});
		
		
		//하단 offcanvas의 임금계약버튼 누르면 목록조회 
		$(document).on("click","#wageListBtn", function(){
			vEmpNo = $(this).data("empno");
//			console.log("여기에요친구들",vEmpNo);
			wageListPrint(vEmpNo)
		});

		
		//근로계약삭제버튼을 누르면, 삭제버튼에 담겨있는 글번호(고유키)를 직접 삭제할 수 있도록 '#wkhxDelBtnFinal'에 담아주는 이벤트
		$(document).on("click", ".wkhxDelBtn", function() {
			delno = $(this).data("delno");
			let wkhxDelBtnFinal = $('#wkhxDelBtnFinal');
			wkhxDelBtnFinal.data("delno", delno);
//			console.log("새로만든함수 delno",delno);
		});
		
		
		//근로계약 삭제버튼 클릭시 삭제하는 이벤트
		$(document).on("click",'#wkhxDelBtnFinal',function(){
			cntHxDel();
		});
		
		
		//근로계약수정버튼 누르면, 수정 offcanvas띄워주는 이벤트
		$(document).on("click",".wkhxEditBtn", function(){
			cnthxNo = $(this).data("editno");
				console.log("cnthxNo",cnthxNo);
				console.log("근로계약 수정함수 접근");
				$('#offcanvasBothbasicCon3').offcanvas('show');
			$('#offcanvasBothLabel3').text("근로계약 수정");
			showEditWindow();	//수정용 우측 offcanvas 창 띄워주기
//			$('form[name=lbform] > div > div:nth-child(4)').hide(); //메모 란 숨기기
			
			$(document).on("click","#lbcntUpdateBtn2", function(){
				lbhxEdit(cnthxNo);	//수정함수(mypageHeaderMenu.jsp에 존제
				editInfoload(cnthxNo);	//기존정보 로딩
			});
			editInfoload(cnthxNo);		//기존정보 로딩
		});

		
		// 근로계약 변경 폼의 기존정보 가져오기
		function editInfoload(cnthxNo){
			// 인사정보 변경 폼의 기존정보 가져오기
				console.log("근로계약 정보 읽어서 로딩해주는 함수");
				$.ajax({
					url : CONTEXTPATH+"/mypage/choosenCntRetrieve.do", 
					data : {  
						    cnthxNo : cnthxNo
						   },
					dataType : "json",
					success : function(resp) { 
						console.log(resp);
						$("#lbcntSttdate2").val(resp.blctSdate);
						$("#lbcntEnddate2").val(resp.blctEdate);
						$('select[id="lbCase2"]').val(resp.blCase).prop("selected",true);
						$("#prSttdate2").val(resp.prSdate);
						$("#prEnddate2").val(resp.prEdate);
						$("#cngMm2").val(resp.cngMm);
					},
					error : function(errorResp) {
						console.log(errorResp.status);
					}
				});
		};
//=====================[근로계약목록끝]===================================================
		
//---------------------[임금계약목록]-----------------------------------------------------
		//삭제버튼을 누르면, 삭제버튼에 담겨있는 글번호(고유키)를 직접 삭제할 수 있도록 '#wkhxDelBtnFinal'에 담아주는 이벤트
		$(document).on("click", ".wagehxDelBtn", function() {
			delno = $(this).data("delno");
			let wagehxDelBtnFinal = $('#wagehxDelBtnFinal');
			wagehxDelBtnFinal.data("delno", delno);
			console.log("새로만든함수 delno",delno);
		});
		
		
		//수정버튼 누르면, 수정 offcanvas띄워주는 이벤트
		$(document).on("click",".wagehxEditBtn", function(){
			cnthxNo = $(this).data("editno");
			console.log("cnthxNo",cnthxNo);
			console.log("임금계약수정함수접근");
			//$('#offcanvasBottom').offcanvas('hide');
			$('#offcanvasBothbasicCon4').offcanvas('show');
			$('#offcanvasBothLabel4').text("임금계약 수정");
			$(document).on("click","#wgcntUpdateBtn2", function(){
				console.log("으악시팔ㅇ암ㄹ개놈들아");
				wagehxEdit(cnthxNo);	//수정함수(mypageHeaderMenu.jp에 존제
				editWageInfoload(cnthxNo);
			});
			editWageInfoload(cnthxNo);
		});
		
		
		// 임금계약 변경 폼의 기존정보 가져오기		//수정중
		function editWageInfoload(cnthxNo){
			// 인사정보 변경 폼의 기존정보 가져오기
			console.log("wageEditForm");
			
			$.ajax({
				url : CONTEXTPATH+"/mypage/choosenCntRetrieve.do", 
				data : {  
					cnthxNo : cnthxNo
				},
				dataType : "json",
				success : function(resp) { 
					console.log(resp);
					$('select[id="wgicmclf2"]').val(resp.bincClf).attr("selected",true);
					$("#wgcntSttdate2").val(resp.bwctSdate);
					$("#wgcntEnddate2").val(resp.bwctEdate);
					$("#wgicmclf2").val(resp.bincClf);
					$("#wgcntAmt2").val(resp.bcntAmt);
					$("#wgcntFex2").val(resp.bfex);
					$("#wgcngMm2").val(resp.cngMm);
				},
				error : function(errorResp) {
					console.log(errorResp.status);
				}
			});
			
		};
		
		//임금계약 삭제버튼 클릭시 삭제하는 이벤트
		$(document).on("click",'#wagehxDelBtnFinal',function(){
			cntHxDel();
		});
//=====================[임금계약목록끝]===================================================	
		
	});
//=====================<document.ready함수끝>======================================================================================================	
	
//---------------------<일반함수>-------------------------------------------------------------------------------------------------------------------	
	
	//---------------[하단에서 올라오는  offCanvas목록 비동기 출력]-------------------------------
	
	//휴직이력목록 비동기로 조회하여 출력하는 함수
	function bkHxSelect(){
		console.log(" 휴직이력목록 출력 함수접근");
		
		$.ajax({			
			url : CONTEXTPATH+"/mypage/breakHxRetrieve.do", 
			data : { empNo : empNo },
			dataType : "json",
			success : function(resp) { 
				console.log("목록출력 ajax접근");
				console.log("휴직목록 : ", resp);
				
				let htmlCode = "";
				let nowState ="";
				
				if(!resp || resp.length == 0 || resp == null){
					htmlCode += `<tr><td colspan="6" style="text-align: center;">내용없음</td></tr>`;
					console.log("(っ °Д °;)っ(っ °Д °;)っ");
					bkHxtbody.html(htmlCode);
				}else{
					$(resp).each(function(i, breakHxList) {
						htmlCode +=	 `
							<tr>
								<td> 
									<button type="button" class="btn btn-icon btn-outline-secondary empaddbutton bkEditBtn" data-bs-toggle="modal" data-bs-target="#bkEditModal" data-editno="${breakHxList.emptNo }">
										<i class='bx bxs-pencil'></i>
									</button>
										<button type="button" tabindex="0" class="btn btn-icon btn-outline-danger hxDelBtn popover-dismiss " role="button" data-delno="${breakHxList.emptNo }" data-bs-placement="right" data-bs-toggle="popover" data-bs-offset="0,14" data-bs-trigger="focus" data-bs-html="true" data-bs-content="<p>정말 삭제하시겠습니까?</p> <div class='d-flex justify-content-between'><button type='button' class='btn btn-sm btn-label-secondary'>취소</button><button type='button' id='hxDelBtnFinal' class='btn btn-sm btn-danger' >삭제</button></div>" title="<i class='bx bx-error' style='color:#FFC300; margin-right:10px;'></i>휴직이력 삭제">
										<i class='bx bxs-trash-alt'></i>
								 	</button>
								</td>`;
								if(breakHxList.emptSt == '휴직'){
									htmlCode += `<td>${breakHxList.bkSdate} ~ ${breakHxList.bkEdate} <span class="badge bg-warning" style="margin-left:15px;">휴직중</span> </td>`;
								}else if(breakHxList.emptSt == '휴직예정'){
									htmlCode += `<td>${breakHxList.bkSdate} ~ ${breakHxList.bkEdate} <span class="badge bg-info" style="margin-left:15px;">휴직예정</span> </td>`;
								}else{
									htmlCode += `<td>${breakHxList.bkSdate} ~ ${breakHxList.bkEdate}  </td>`;
								}
						htmlCode += `<td>${breakHxList.stClf}</td>
									 <td>
										<button type="button" class="btn btn-light memo shadow-none" data-bs-toggle="tooltip" data-bs-offset="0,4" data-bs-placement="top" data-bs-html="true" data-bs-original-title=" <span>${breakHxList.stMemo}</span>">메모 보기</button>
									 </td></tr>`;
					bkHxtbody.html(htmlCode);
					popoverFirst();		/*비동기로 생성된 목록 요소에 pop over 함수 걸어줌 */
					tooltipFirst();		/*비동기로 생성된 목록 요소에 tooltip 함수 걸어줌 */
					stTagChange();		/*재직상태 변경*/
					});
				}
			},
			error : function(errorResp) {
				console.log(errorResp.status);
				console.log("휴직이력목록 출력 ajax실패");
			}
		});
	}
	
	
	//근로계약목록조회
	function wkListPrint(vEmpNo){
		$.ajax({
			url : CONTEXTPATH+"/mypage/WorkCntRetrieve.do", 
			data : { empNo : vEmpNo },
			dataType : "json",
			success : function(resp) { 
				console.log("근로계약목록출력 ajax접근");
				console.log("WorkCntRetrieve",resp);
				let wkListCode = "";
				
				if(!resp || resp.length == 0 || resp == null){
					wkListCode += `<tr><td colspan="6" style="text-align: center;">내용없음</td></tr>`;
					wkHxtbody.html(wkListCode);
				}else{
					//-----------------------------------------------------------------
					$(resp).each(function(i, WorkList) {
						wkListCode +=	 `
							<tr><td>
								<button type="button" class="btn btn-icon btn-outline-secondary empaddbutton wkEditBtn wkhxEditBtn" data-editno="${WorkList.cnthxNo }">
									<i class='bx bxs-pencil'></i>						
								</button>
								<button type="button" class="btn btn-icon btn-outline-danger empaddbutton wkhxDelBtn popover-dismiss" role="button" data-delno="${WorkList.cnthxNo }" data-bs-placement="right" data-bs-toggle="popover" data-bs-offset="0,14" data-bs-trigger="focus" data-bs-html="true" data-bs-content="<p>정말 삭제하시겠습니까?</p> <div class='d-flex justify-content-between'><button type='button' class='btn btn-sm btn-label-secondary'>취소</button><button type='button' id='wkhxDelBtnFinal' class='btn btn-sm btn-danger' >삭제</button></div>" title="<i class='bx bx-error' style='color:#FFC300; margin-right:10px;'></i>근로계약이력 삭제">
									<i class='bx bxs-trash-alt'></i>
								</button>
							</td><td>${WorkList.blctSdate}`;
						
							//현재뱃지 붙임
							if ( WorkList.blctSdate <= vtoday && vtoday <= WorkList.blctEdate ){
								wkListCode += `<span class="badge bg-success">현재</span> `;
							} else{ };
							
							//수습뱃지 붙임
							if(WorkList.prSdate!=null ){
								if(WorkList.prSdate <= vtoday && vtoday <= WorkList.prEdate ){
									wkListCode += `<span class="badge bg-secondary">수습</span>`;
								}else{ };
							}else{ };
							
							wkListCode +=`</td><td>${WorkList.blctEdate}</td><td>`;
							
								if (WorkList.blCase != null){
									wkListCode += `<span class="badge bg-label-cys-personel">${WorkList.blCase}</span>`;
								} else{ };
							
							wkListCode += `</td><td>
												<button type="button" class="btn btn-light memo shadow-none" data-bs-toggle="tooltip" data-bs-offset="0,4" data-bs-placement="top" data-bs-html="true" title=" <span>${WorkList.cngMm}</span>">메모 보기</button>
											</td>
											<td>
												<span>${WorkList.cngDate}</span><br> <span>${WorkList.cntWriter}</span>
											</td></tr>`;
						
						wkHxtbody.html(wkListCode);
						popoverFirst();					/*비동기로 생성된 목록 요소에 pop over 함수 걸어줌 */
						tooltipFirst();					/*비동기로 생성된 목록 요소에 tooltip 함수 걸어줌 */
					});
				}
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	}
	
	
	//임금계약목록조회
	function wageListPrint(vEmpNo){
		$.ajax({
			url : CONTEXTPATH+"/mypage/WageCntRetrieve.do", 
			data : { empNo : vEmpNo },
			dataType : "json",
			success : function(resp) { 
				console.log("임금계약목록출력 ajax접근");
				console.log("WageCntRetrieve",resp);
				let wageListCode = "";
				
				if(!resp || resp.length == 0 || resp == null){
					wageListCode += `<tr><td colspan="6" style="text-align: center;">내용없음</td></tr>`;
					console.log("임금계약목록 내용없음");
					wageHxtbody.html(wageListCode);
				}else{
					$(resp).each(function(i, WageList) {
						let bcntAmt = (WageList.bcntAmt).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");	//계약금액 1,000단위마다 콤마(,)찍어주기.
						
							wageListCode +=	 `
								<tr><td>
									<button type="button" class="btn btn-icon btn-outline-secondary empaddbutton wageEditBtn wagehxEditBtn" data-editno="${WageList.cnthxNo }">
										<i class='bx bxs-pencil'></i>
									</button>
									<button type="button" class="btn btn-icon btn-outline-danger empaddbutton wagehxDelBtn popover-dismiss" role="button" data-delno="${WageList.cnthxNo }" data-bs-placement="right" data-bs-toggle="popover" data-bs-offset="0,14" data-bs-trigger="focus" data-bs-html="true" data-bs-content="<p>정말 삭제하시겠습니까?</p> <div class='d-flex justify-content-between'><button type='button' class='btn btn-sm btn-label-secondary'>취소</button><button type='button' id='wagehxDelBtnFinal' class='btn btn-sm btn-danger' >삭제</button></div>" title="<i class='bx bx-error' style='color:#FFC300; margin-right:10px;'></i>임금계약이력 삭제">
										<i class='bx bxs-trash-alt'></i>
									</button>
								</td><td>${WageList.bwctSdate}  `;
							
								//현재뱃지 붙임
								if ( WageList.bwctSdate <= vtoday && vtoday <= WageList.bwctEdate ){
									wageListCode += `<span class="badge bg-success">현재</span> `;
								} else{ };

							wageListCode +=`</td><td>${WageList.bwctEdate}</td><td>`;

								if (WageList.bincClf != null){
									wageListCode += `<span class="badge bg-label-cys-personel">${WageList.bincClf}</span>`;
								} else{ };
								
							wageListCode +=`</td><td><span class="badge bg-label-cys-personel">연봉</span>` ;
							wageListCode += bcntAmt;
							wageListCode += `원</td>
												<td>
													<button type="button" class="btn btn-light memo shadow-none" data-bs-toggle="tooltip" data-bs-offset="0,4" data-bs-placement="top" data-bs-html="true" title=" <span>${WageList.cngMm}</span>">메모 보기</button>
												</td>
												<td>
													<span>${WageList.cngDate}</span><br> <span>${WageList.cntWriter}</span>
												</td></tr>`;
						wageHxtbody.html(wageListCode);
						popoverFirst();					/*비동기로 생성된 목록 요소에 pop over 함수 걸어줌 */
						tooltipFirst();					/*비동기로 생성된 목록 요소에 tooltip 함수 걸어줌 */
					});
				}
			},
			error : function(errorResp) {
				console.log(errorResp.status);
				console.log("임금계약목록출력 ajax 실패");
			}
		});
	}
	//===============[하단에서 올라오는  offCanvas목록 비동기 출력 끝]=============================
	
	//---------------[기타함수]-----------------------------------------------------------
	
	//동작여부 확인위한 콘솔출력용 test 함수
	function test(){
		alert("테스트중입니다");
//		console.log(delno);
//		console.log("today변수",today);
	}
	
	
	//사원이름 옆 상태 태그 붙여놓기
	function stTagSet(){
		if(prestText == '휴직'){
			nowEmptStat.html('<span class="badge bg-warning" style="margin-left:15px;">휴직중</span>');
		}else if(prestText == '퇴직'){
			nowEmptStat.html('<span class="badge bg-danger" style="margin-left:15px;">퇴직</span>');
		}else{ }
	}
	
	
	//사원이름 옆 상태 태그 붙이는 함수
	function stTagChange(){
		if(nowstText.text() == '휴직'){
			nowEmptStat.html('<span class="badge bg-warning" style="margin-left:15px;">휴직중</span>');
		}else if(nowstText.text() == '퇴직'){
			nowEmptStat.html('<span class="badge bg-danger" style="margin-left:15px;">퇴직</span>');
		}else{ };
	}
	
	
	//계약이력삭제함수(근로,임금계약동일) : (삭제 confirm시동작) : 상단 docmuent.ready에서 호출하여 사용
	function cntHxDel(){
		$.ajax({
			url : "LaborCntInfoDelete.do",
			data : {
				cnthxNo : delno
			},
			type : "POST",
			success : function(resp) {
				console.log(resp);
				if(resp == "SUCCESS"){
					toastr.success('계약이력을 성공적으로 삭제하였습니다');
					wkListPrint(vEmpNo);
					wageListPrint(vEmpNo);
				}else{
					toastr.error('계약이력 삭제에 실패하였습니다');	
				}
			},
			error : function(errorResp) {
				console.log(errorResp.status);
				toastr.error('계약이력 삭제에 실패하였습니다');
			}
		});
	}
	//===============[기타함수 끝]=========================================================
	
	
//bootstrap 기능 재연결 함수---------------------------------------------------------------------------------------------------------------------------
	
	//휴직목록 ajax로 다시 받아온 후, 목록에 popover 다시 설정해 주는 함수1
	function popoverFirst(){
		   var popover = new bootstrap.Popover(document.querySelector('.popover-dismiss'), {
		        trigger: 'focus'
		      })
		   
		   const popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
		   const popoverList = popoverTriggerList.map(function(popoverTriggerEl) {
		     return new bootstrap.Popover(popoverTriggerEl,{ html: true, sanitize: false });
		   });	
	}

	//휴직목록 ajax로 다시 받아온 후, 목록에 popover 다시 설정해 주는 함수2
	$(function(){
		popoverFirst();
	})

	//휴직목록 ajax로 다시 받아온 후, 목록에 tooltip 다시 설정해 주는 함수
	function tooltipFirst(){
		var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
		var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
		  return new bootstrap.Tooltip(tooltipTriggerEl)
		});
	}
	
