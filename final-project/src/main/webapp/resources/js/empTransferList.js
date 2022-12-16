$(function() {
	// 인사발령리스트 body
	let translistBody = $('#translistBody');

	// 발령상세내역 Tbody
	let transferDtailTbody = $('#transferDtailTbody');
	
	let modalFullTitle = $('#modalFullTitle');		// 발령상세내역 모달 제목
	let modalAsgmtDate = $('#modalAsgmtDate');		// 발령상세내역 모달 발령일
	let modalAsgmtStat = $('#modalAsgmtStat');		// 발령상세내역 모달 상태
	
	// 인사발령 입력테이블 tbody
	let tbodyResult = $('#tbodyResult');
	// 인사발령 오픈캔버스창
	let offcanvasBottom = $("#offcanvasBottom");
	// 조직·직책 입력 모달창
	let modalForm = $("#modalForm");
	
	// 조직리스트
	let deptList;
	// 직책리스트
	let dutyList;
	// 직무리스트
	let jobList;
	// 직급리스트
	let grdList;
	// 직위리스트
	let pstnList
	
	let asgmtDept = $("#asgmtDept");	// 발령 대상
	let asgmtClf = $("#asgmtClf");		// 발령 라벨
	let asgmtDate = $("#asgmtDate");	// 발령일
	let asgmtMm = $("#asgmtMm");		// 발령 메모
	
	// 처음화면 인사발령리스트 가져오기 
	ajaxTransferList();
	
	// 각종 옵션 리스트 변수에 넣기
	$.ajax({
		url : CONTEXTPATH+"/mypage/getDeptList.do",
		dataType : "json",
		success : function(resp) { 
			console.log("옵션 ajax 불러오기 :",resp);
			deptList = resp.deptList;
			dutyList = resp.dutyList;
			jobList = resp.jobList;
			grdList = resp.grdList;
			pstnList = resp.pstnList;
		},
		error : function(errorResp) {
			console.log(errorResp.status);
		}
	
	});
	
	// 발령일 오늘날짜 부여 및 최소날짜 설정
	let today =	new Date().toISOString().substring(0, 10);
	document.getElementById('asgmtDate').value = today 
	$("#asgmtDate").attr("min", today);

	
//###################################################################################################################################################################################################################################
// 발령상세내역 모달
	
	$(document).on("click", ".transli", function(e) {
		// 클릭한 인사발령 정보 모달창에 반영
		let asgmtNo = $(this).data('asgmtno');
		let asgmtClf = $(this).data('asgmtclf');
		let statBadge = $(this).data('statbadge');
		let asgmtDate = $(this).data('asgmtdate');
		let asgmtStat= $(this).data('asgmtstat');
		modalFullTitle.text(asgmtClf);
		modalAsgmtDate.text(asgmtDate);
		asgmtStatHTML = `<span class="badge bg-label-${statBadge} text-dark"> ${asgmtStat} </span>`;
		modalAsgmtStat.html(asgmtStatHTML);
		
		// 발령상세내역 Tbody에 비동기 갱신
		$.ajax({
			url : CONTEXTPATH+"/emp/empTransferDetail.do",
			dataType : "json",
			data : { asgmtNo : asgmtNo},
			success : function(resp) {
				console.log("인사발령 상세내역 : ",resp);
				
				let htmlCode = "";
				
				$(resp).each(function(i, emp) {
					let bAsgmtNo;		// 발령전번호
					let bGrdNm;			// 직급
					let bPtnNm;			// 직위
					
					let aAsgmtNo;		// 발령후번호
					let aGrdNm;			// 직급
					let aPtnNm;			// 직위
					
					let asgmtDetailStat;// 발령상태
					// 프로필 유무로 이미지주소설정
					let empImg = `${CONTEXTPATH}/resources/empImages/${emp.empImg}`;
					if(!emp.empImg)
						empImg =`${CONTEXTPATH}/resources/images/basicProfile.png`;
					
					$(emp.asgmtList).each(function(i, asgmt) {
						if(asgmt.before == 'Y'){
							bAsgmtNo = asgmt.asgmtNo;
							bGrdNm = asgmt.grdNm;
							bPtnNm = asgmt.ptnNm;
						}else{
							aAsgmtNo = asgmt.asgmtNo;
							aGrdNm = asgmt.grdNm;
							aPtnNm = asgmt.ptnNm;
							asgmtDetailStat = asgmt.asgmtStat;
						}
					})
					if(!bGrdNm) bGrdNm = "";
					if(!bPtnNm) bPtnNm = "";
					if(!aGrdNm) aGrdNm = "";
					if(!aPtnNm) aPtnNm = "";
					
					let statDetailBadge ='primary';
					if(asgmtDetailStat == '취소'){
						statDetailBadge = 'secondary';
					}else{
						asgmtDetailStat = asgmtStat;
						statDetailBadge = statBadge;
					};
					
					htmlCode +=	`<tr>
									<td>
										<div class="d-flex align-self-center align-items-center">
											<img src="${empImg}" alt="Avatar" class="empListimgradius emplistimgsize">
											<div class="mx-3 mt-1">${emp.empNm}</div>
										</div>
									</td>
									<td>${emp.empNo}</td>
									<td>
										<span class="badge bg-label-${statDetailBadge}">${asgmtDetailStat}</span>
									</td><td>
									`;
					let str ="";
					$(emp.jobList).each(function(i, job) {
						if(job.asgmtNo == bAsgmtNo){
							str += job.jnm+", ";
						}
					})
					htmlCode += str.replace(/,\s*$/, "");
					
					htmlCode += `</td><td>`;
					
					str ="";
					$(emp.deptList).each(function(i, dept) {
						if(dept.asgmtNo == bAsgmtNo){
							str += dept.dnm;
							if(dept.dtnm != null)
								str += "·" + dept.dtnm;
							if(dept.dno == 'Y')
								str += "· 조직장";
						}
					})
					htmlCode += str.replace(/,\s*$/, "");
					
					htmlCode += `</td>
									<td>${bPtnNm}</td>
									<td>${bGrdNm}</td><td>`
					str ="";
					$(emp.jobList).each(function(i, job) {
						if(job.asgmtNo == aAsgmtNo){
							str += job.jnm+", ";
						}
					})
					htmlCode += str.replace(/,\s*$/, "");
					
					htmlCode += `</td><td>`;
					
					str ="";
					$(emp.deptList).each(function(i, dept) {
						if(dept.asgmtNo == aAsgmtNo){
							str += dept.dnm;
							if(dept.dtnm != null)
								str += "·" + dept.dtnm;
							if(dept.dno == 'Y')
								str += "· 조직장";
						}
					})
					htmlCode += str.replace(/,\s*$/, "");
						
					htmlCode +=	`</td>
									<td>${aPtnNm}</td>
									<td>${aGrdNm}</td>
								</tr>
					`;
				})
				transferDtailTbody.html(htmlCode);
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		})
		
		
		$("#fullscreenModaltrans").modal("show");
		return false;
	});
//###################################################################################################################################################################################################################################

	// 공지사항작성
	$(document).on("click", ".transmodalScrollable", function(e) {
		event.stopPropagation();
		$("#transmodalScrollable").modal("show");
		return false;
	});
	
	// 메모수정버튼
	$(document).on("click", ".transUpdateBtn", function(event) {
		event.stopPropagation();
	})

//###################################################################################################################################################################################################################################
// 인사발령 리스트 조회 비동기처리
	
	function ajaxTransferList() {
		
		$.ajax({
			url : CONTEXTPATH+"/emp/empTransferList.do",
			dataType : "json",
			method : "post",
			success : function(resp) {
				console.log("인사발령 리스트 : ",resp);
				
				let htmlCode = "";
				
				$(resp).each(function(i, transfer) {
					let fwrDate = new Date(transfer.fwrDate);
					let statBadge ='primary';
					if(transfer.asgmtStat == '완료') statBadge = 'success';
					if(transfer.asgmtStat == '취소') statBadge = 'secondary';
					
					let cancelBtnHtml = '';
					
					if(transfer.asgmtStat == '예정'){
						statBadge = 'primary';
						cancelBtnHtml = `<button type="button" class="btn btn-danger btn-sm  hide" data-asgmtno="${transfer.asgmtNo}">X&nbsp;발령취소</button>&nbsp;`;
					}
					
					htmlCode +=	`
					<li class="list-group-item list-group-item-action d-flex justify-content-between align-items-center listhover translistpadding transli" 
						data-asgmtno="${transfer.asgmtNo}" data-asgmtclf="${transfer.asgmtClf}" data-statbadge="${statBadge}" data-asgmtdate="${transfer.asgmtDate}" data-asgmtstat="${transfer.asgmtStat}">
					<div class="d-flex align-self-center align-items-center">
						<div class=" mt-1">
							<div>
								<span class="transname fw-bold">${transfer.asgmtClf}</span> 
								<span class="badge bg-label-${statBadge} me-1 translistbg">${transfer.asgmtStat}</span>
							</div>
								<span class="translistfont">${transfer.writerNm} </span>·<span class="translistfont"> ${fwrDate.toLocaleString()}</span>
						</div>
					</div>

					<div class="transdateborder unhide">
						<span class="emplistspan"> <i class='bx bx-calendar-alt transcal'></i> ${transfer.asgmtDate}
						</span>
					</div>

					<div class="mx-3 translistfont unhide">
						+<span>${transfer.asgmtCnt}</span>명
					</div>

					<div class="transnotictooltip me-2 hide">
						${cancelBtnHtml}
						<button type="button" class="btn btn-icon btn-outline-primary btn-sm transfermodal hide transmodalScrollable" data-bs-toggle="modal" data-bs-target="#transmodalScrollable" data-asgmtno="${transfer.asgmtNo}">
							<i class='bx bx-send'></i>
						</button>
					</div> 
					<!-- 수정하기 버튼 -->
					<div>
						<button type="button" class="btn btn-icon btn-outline-primary transfermodal dropdown-toggle btn-sm hide-arrow hide transUpdateBtn" data-bs-toggle="dropdown" aria-expanded="false">
							<i class='bx bx-pencil'></i>
						</button>
						<ul class="dropdown-menu transmodify">
							<li><a class="dropdown-item transmodia" href="javascript:void(0);" data-asgmtno="${transfer.asgmtNo}">메모 수정하기</a></li>
						</ul>
					</div>
				</li>
					`;
				})
				translistBody.html(htmlCode);
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		})
	}
//###################################################################################################################################################################################################################################

	// 발령버튼 클릭시 이벤트감지
	$("#transModalBtn").on("click", function() {
		
		if( asgmtClf.val().length == 0 || asgmtDate.val().length == 0 )
			return;
		
		// 비동기로 데이터를 가져와서 tbody 생성
		ajaxMakeTbody();
		
		offcanvasBottom.offcanvas('show');
	});
		
//#############################################################################################################################################################
// 조직 직책 추가 버튼
	let deptAddBtn = $('#deptAddBtn').on("click", function() {

		var deptform = '<div class="  mb-2 mainDeptCheck">' 
    		deptform +=' <div class=" mb-4 " >'
			deptform +='  <div class="d-flex " >'
    		deptform +='	<div class="form-check pt-2">      '
			deptform +='	    <input                         '
			deptform +='	      name="deptList[][mainck]"       '
			deptform +='	      class="form-check-input mainckList"     '
			deptform +='	      type="radio"                 '
			deptform +='	      value="Y"                     '
			deptform +='	       /> </div>					'
			deptform +='	<div class="input-group">		   '
			deptform +='	<select name="deptList[][dcode]" class="form-select dcodeList"> '
		    deptform +='      <option value>조직</option>'
		    
   			$(deptList).each(function(i, dept) {
   				deptform +='  <option value="'+dept.dcode+'">'+dept.dnm+'</option> '
			});
		    
		    deptform +='    </select>			                                                                              '
			deptform +='	<select name="deptList[][dtcode]" class="form-select dtcodeList">                          '
			deptform +='	<option value>직책(선택)</option>  '
			
   			$(dutyList).each(function(i, duty) {
   				deptform +='  <option value="'+duty.dtcode+'">'+duty.dtnm+'</option> '
			});
			
			deptform +='	</select>								                                                          '
			deptform +='	<div class="input-group-text">                                                                    '
			deptform +='	<div class="form-check mt-0">                                                                     '
			deptform +='	<input name="deptList[][dno]" class="form-check-input dnoList" type="checkbox" value="Y"/> '
			deptform +='	<label class="form-check-label"> 조직장 </label>                              '
			deptform +='	</div>                                                                                            '
			deptform +='	</div>      				                                                                      '
			deptform +='	</div>                                                                                            '
			deptform +=' <button type="button" class="btn btn-icon btn-outline-danger ms-2 " name="deptRemoveBtn" ><i class="bx bx-x"></i></button> '
			deptform +='	</div>   '                                                                                       
			deptform +=' </div>' 
			deptform +='</div>';

		$('#deptBody').append(deptform);
		$('#hideBtn').show();
		var length = $(".mainDeptCheck").length;
		if (length >= 2) {
			$('button[name=deptRemoveBtn]').show();
		}

	});

	// 조직 · 직책  지우기 버튼 
	$('body').on("click", '[name=deptRemoveBtn]', function(event) {

		$(this).closest(".mainDeptCheck").remove();
		var length = $(".mainDeptCheck").length;
		if (length == 1) {
			$('button[name=deptRemoveBtn]').hide();
		}

	})
//#############################################################################################################################################################
// 조직,직책 관련 입출력 기능 스크립트들
	
		// 클릭한 td 객체 저장 변수
		let deptTd;
		
		//조직,직책 TD 클릭시 입력 모달폼UI
		$("body").on("click", '.deptTd', function() {
			// 클릭한 td 제이쿼리 객체 저장
			deptTd = $(this);
			
			let myDeptList = $(this).closest("tr").find("input,select,textarea").serializeObject().deptList;
			console.log("클릭한 TD의 정보", myDeptList);
			
			// 조직직책 데이터에 일치하게 가져오기
	   		let html = makeDeptBody(myDeptList);
	   		$("#deptBody").html(html);
	   		if(myDeptList == null){
	   			deptAddBtn.trigger("click");
	   		}
	   		
	   		let length = $(".mainDeptCheck").length;
	   		if (length >= 2) {
	   			$('button[name=deptRemoveBtn]').show();
	   		}else{
   				$('button[name=deptRemoveBtn]').hide();
	   		
	   		}
			$("#basicModal").modal("show");
		});
		
		// 조직,직책 모달의 입력내용 해당 사원 TD에 저장하기
		$("#saveDeptBtn").on("click", function() {
			modalForm.find('.mainckList').each(function(i, elements) {
				$(elements).attr("name","deptList["+i+"][mainck]");
			});
			modalForm.find('.dcodeList').each(function(i, elements) {
				$(elements).attr("name","deptList["+i+"][dcode]");
			});
			modalForm.find('.dtcodeList').each(function(i, elements) {
				$(elements).attr("name","deptList["+i+"][dtcode]");
			});
			modalForm.find('.dnoList').each(function(i, elements) {
				$(elements).attr("name","deptList["+i+"][dno]");
			});
			let modalData = modalForm.serializeObject();
			console.log(modalData.deptList);
			
			let htmlCode = "";
   			$(modalData.deptList).each(function(i, dept) {
   				
   				if(dept.dcode.length > 0){
		   			$(deptList).each(function(i, item) {
		   				if(dept.dcode == item.dcode) htmlCode += item.dnm;
					});
		   			$(dutyList).each(function(i, item) {
		   				if(dept.dtcode == item.dtcode) htmlCode += " · " + item.dtnm; 
					});
		   			if(dept.dno == 'Y') htmlCode += " · 조직장"; 
		   			
		   			if(i != modalData.deptList.length-1) htmlCode += ", ";
   				}
	   			
			});
   			$(modalData.deptList).each(function(i, dept) {
   				if(dept.dcode.length > 0){
   					htmlCode += '<input type="hidden" name="deptList[][mainck]" value="';
	   				if(dept.mainck == 'Y'){
	   					htmlCode += 'Y"/>'; 
	   				}else{
	   					htmlCode += 'N"/>'; 
	   				}
	   				htmlCode += '<input type="hidden" name="deptList[][dcode]" value="'+dept.dcode+'" />';
	   				htmlCode += '<input type="hidden" name="deptList[][dtcode]" value="'+dept.dtcode+'" />';
	   				htmlCode += '<input type="hidden" name="deptList[][dno]" value="';
	   				if(dept.dno == 'Y'){
	   					htmlCode += 'Y"/>'; 
	   				}else{
	   					htmlCode += 'N"/>'; 
	   				}
   				}
   			});
			deptTd.html(htmlCode);
			$("#basicModal").modal("hide");
		});
		
		
		
		
//#############################################################################################################################################################
// 자신의 부서직책 리스트가 반영된 UI를 html로 만들어주는 함수
// myDeptList : 자신의 부서직책 객체가 담긴 리스트
// return : htmlCode
// 주의 스크립트 전역변수로 코드와 이름이 담긴 deptList, dutyList 활용하고 있습니다.
		
		function makeDeptBody(myDeptList) {
			let htmlCode ="";
			$(myDeptList).each(function(i, myDept) {
			
				htmlCode +='<div class="  mb-2 mainDeptCheck">' 
				htmlCode +=' <div class=" mb-4 " >'
				htmlCode +='  <div class="d-flex " >'
				htmlCode +='	<div class="form-check pt-2">      '
				if(myDept.mainck == "Y"){
	  					htmlCode +='	    <input name="deptList[][mainck]" class="form-check-input mainckList" type="radio" value="Y" checked /> '
				}else{
	  					htmlCode +='	    <input name="deptList[][mainck]" class="form-check-input mainckList" type="radio" value="Y"/> '
				}
				htmlCode +='	</div> <div class="input-group">		   '
				htmlCode +='	<select name="deptList[][dcode]" class="form-select dcodeList"> '
			    htmlCode +='      <option value>조직</option>'
			    
	   			$(deptList).each(function(index, dept) {
	   				if(myDept.dcode == dept.dcode){
	  	   					htmlCode +='  <option value="'+dept.dcode+'" selected>'+dept.dnm+'</option> '
	   				}else{
	  	   					htmlCode +='  <option value="'+dept.dcode+'">'+dept.dnm+'</option> '
	   				}
				});
			    
			    htmlCode +='    </select>			                                                                              '
				htmlCode +='	<select name="deptList[][dtcode]" class="form-select dtcodeList">                          '
				htmlCode +='	<option value>직책(선택)</option>  '
				
	   			$(dutyList).each(function(index, duty) {
	   				if(myDept.dtcode == duty.dtcode){
	  	   					htmlCode +='  <option value="'+duty.dtcode+'" selected>'+duty.dtnm+'</option> '
	   				}else{
	  	   					htmlCode +='  <option value="'+duty.dtcode+'">'+duty.dtnm+'</option> '
	   				}
				});
				
				htmlCode +='	</select>								                                                          '
				htmlCode +='	<div class="input-group-text">                                                                    '
				htmlCode +='	<div class="form-check mt-0">                                                                     '
				if(myDept.dno == "Y"){
	  					htmlCode +='	<input name="deptList[][dno]" class="form-check-input dnoList" type="checkbox" value="Y" checked/> '
				}else{
	  					htmlCode +='	<input name="deptList[][dno]" class="form-check-input dnoList" type="checkbox" value="Y"/> '
				}
				htmlCode +='	<label class="form-check-label"> 조직장 </label>                              '
				htmlCode +='	</div>                                                                                            '
				htmlCode +='	</div>      				                                                                      '
				htmlCode +='	</div>                                                                                            '
				htmlCode +=' <button type="button" class="btn btn-icon btn-outline-danger ms-2 " name="deptRemoveBtn" ><i class="bx bx-x"></i></button> '
				htmlCode +='	</div>   '                                                                                       
				htmlCode +=' </div>' 
				htmlCode +='</div>';
				
			});
			
			return htmlCode;
		}
		
		
//#############################################################################################################################################################
// 인사발령 등록폼 사원리스트 비동기로 가져오기 
// 비동기로 사원리스트를 가져와서 테이블 내용을 보여줍니다.
// 전역변수 사용중 asgmtClf, asgmtDate, asgmtMm
	function ajaxMakeTbody() {
		let data = { dcode : asgmtDept.val() };
		console.log(JSON.stringify(data));
		$.ajax({
			url : CONTEXTPATH+"/emp/empList.do",
			dataType : "json",
			data : JSON.stringify(data),
			contentType: "application/json; charset=utf-8",
			method : "post",
			success : function(resp) {
				console.log("사원리스트 : ",resp);
				let htmlCode = "";
				$(resp).each(function(i, emp) {
					// 프로필 유무로 이미지주소설정
					let empImg = `${CONTEXTPATH}/resources/empImages/${emp.empImg}`;
					if(!emp.empImg)
						empImg =`${CONTEXTPATH}/resources/images/basicProfile.png`;
					htmlCode +=	` <tr>
						<td>
						<input type="hidden" name="asgmtPers" value="${emp.empNo}" />
						<input type="hidden" name="asgmtClf" value="${asgmtClf.val()}" />
						<input type="hidden" name="asgmtDate" value="${asgmtDate.val()}" />
						<input type="hidden" name="asgmtMm" value="${asgmtMm.val()}" />
						<input class="form-check-input align-middle w-px-20 h-px-20 border-2 transTableth empChk" type="checkbox" value="">
						</td>
						<td>
						<div class="d-flex align-self-center align-items-center">
						<img src="${empImg}" alt="Avatar" class="empListimgradius emplistimgsize">
						<div class="mx-3 mt-1 searchEmpNm">${emp.empNm}</div>
						</div>
						</td>
						
						<td class="searchEmpNo">${emp.empNo}</td>
						<td>
						<select name="jcodeList[]" data-style="border" data-width="100%" data-size="6" class="searchJob" data-none-selected-text="--직무 선택--"
						multiple="multiple" data-content="<span class='badge badge-success'></span>"> `;
					
					$(jobList).each(function(i, job) {
						htmlCode += `<option value="${job.jcode }" `;
						$(emp.jobList).each(function(i, myJob) {
							if(myJob.jcode == job.jcode)
								htmlCode += "selected";
						});
						htmlCode += `>${job.jnm }</option>
							`;
					});
					
					htmlCode += `</select>
						</td>
						<td class="transtdhover deptTd">
						`;
					
					$(emp.deptList).each(function(i, dept) {
						if(dept.dcode.length > 0){
							$(deptList).each(function(i, item) {
								if(dept.dcode == item.dcode) htmlCode += item.dnm;
							});
							$(dutyList).each(function(i, item) {
								if(dept.dtcode == item.dtcode) htmlCode += " · " + item.dtnm; 
							});
							if(dept.dno == 'Y') htmlCode += " · 조직장"; 
							
							if(i != emp.deptList.length-1) htmlCode += ", ";
						}
					});
					
					$(emp.deptList).each(function(i, dept) {
						if(dept.dcode.length > 0){
							htmlCode += '<input type="hidden" name="deptList[][mainck]" value="';
							if(dept.mainck == 'Y'){
								htmlCode += 'Y"/>'; 
							}else{
								htmlCode += 'N"/>'; 
							}
							htmlCode += '<input type="hidden" name="deptList[][dcode]" value="'+dept.dcode+'" />';
							htmlCode += '<input type="hidden" name="deptList[][dtcode]" value="'+dept.dtcode+'" />';
							htmlCode += '<input type="hidden" name="deptList[][dno]" value="';
							if(dept.dno == 'Y'){
								htmlCode += 'Y"/>'; 
							}else{
								htmlCode += 'N"/>'; 
							}
						}
					});					
					htmlCode += `</td>
						<td>
						<select name="ptnCode"  data-live-search="true" data-width="100%" data-size="6" class="selectPtn" data-style="border">
						<option value="">--직위 선택--</option>
						`;
					$(pstnList).each(function(i, pstn) {
						htmlCode += `<option value="${pstn.ptnCode}" `;
						if(emp.ptnCode == pstn.ptnCode)
							htmlCode += "selected";
						htmlCode += `>${pstn.ptnNm}</option>
							`;
					});											
					
					htmlCode += `</select>
						</td>
						<td>
						<select name="grdCode"  data-live-search="true" data-width="100%" data-size="6" class="selectGrd" data-style="border">
						<option value="">--직급 선택--</option>
						`;
					$(grdList).each(function(i, grd) {
						htmlCode += `<option value="${grd.grdCode}" `;
						if(emp.grdCode == grd.grdCode)
							htmlCode += "selected";
						htmlCode += `>${grd.grdNm}</option>
							`;
					});											
					htmlCode += `</select>
						</td>
						</tr>`;
				});
				console.log(htmlCode);
				tbodyResult.html(htmlCode);
				$('select').selectpicker();
			},
			error : function(errorResp) {
				console.log(errorResp.status);
			}
		});
	} 
	

//#############################################################################################################################################################
// 사원 전체 항목 체크 버튼	
	
	let chkAll = $("#chkAll").click(function() {
		console.log("전체항목 버튼 클릭");
		if(chkAll.is(":checked")){
			$(".empChk").prop("checked", true);
			console.log("체크");
		}
		else {
			$(".empChk").prop("checked", false);
			console.log("체크해제");
		}
	});

	$(document).on('click', ".empChk", function() {
		console.log("나머지 체크");
		var total = $(".empChk").length;
		var checked = $(".empChk:checked").length;

		if(total != checked) chkAll.prop("checked", false);
		else chkAll.prop("checked", true); 
	});
	
//#############################################################################################################################################################
// 인사발령 테이블 검색 기능 
// 인사발령 테이블의 각 필드에 input태그에 검색내용을 입력하면 해당내용이 포함되는 사원들만 보여줍니다.
		
		//keyup 이벤트 딜레이
		function delay(callback, ms) {
			  var timer = 0;
			  return function() {
			    var context = this, args = arguments;
			    clearTimeout(timer);
			    timer = setTimeout(function () {
			      callback.apply(context, args);
			    }, ms || 0);
			  };
			}
		// 사원이름 검색
		$('#empNameSearchText').keyup(delay(function (e) {
			let searchText = $(this).val();
			$("#tableTarget > tbody > tr").hide(200);
			let temp = $(".searchEmpNm:contains('"+ searchText +"')");
			$(temp).closest("tr").show(200);
		}, 200));
		// 사원번호 검색
		$('#empNoSearchText').keyup(delay(function (e) {
			let searchText = $(this).val();
			$("#tableTarget > tbody > tr").hide(200);
			let temp = $(".searchEmpNo:contains('"+ searchText +"')");
			$(temp).closest("tr").show(200);
		}, 200));
		// 사원직무 검색
		$('#jobSearchText').keyup(delay(function (e) {
			let searchText = $(this).val();
			let temp;
			$("#tableTarget > tbody > tr").hide(200);
			if(searchText.length != 0){
				temp = $(".searchJob option:selected:contains('"+ searchText +"')");
			}else{
				temp = $(".searchJob:contains('"+ searchText +"')");
			}
			$(temp).closest("tr").show(200);
		}, 200));
		// 사원조직·직책 검색
		$('#deptSearchText').keyup(delay(function (e) {
			let searchText = $(this).val();
			$("#tableTarget > tbody > tr").hide(200);
			let temp = $(".deptTd:contains('"+ searchText +"')");
			$(temp).closest("tr").show(200);
		}, 200));
		// 사원직위 검색
		$('#pstnSearchText').keyup(delay(function (e) {
			let searchText = $(this).val();
			let temp;
			$("#tableTarget > tbody > tr").hide(200);
			if(searchText.length != 0){
				temp = $(".selectPtn option:selected:contains('"+ searchText +"')");
			}else{
				temp = $(".selectPtn:contains('"+ searchText +"')");
			}
			$(temp).closest("tr").show(200);
		}, 200));
		// 사원직급 검색
		$('#grdSearchText').keyup(delay(function (e) {
			let searchText = $(this).val();
			let temp;
			$("#tableTarget > tbody > tr").hide(200);
			if(searchText.length != 0){
				temp = $(".selectGrd option:selected:contains('"+ searchText +"')");
			}else{
				temp = $(".selectGrd:contains('"+ searchText +"')");
			}
			$(temp).closest("tr").show(200);
		}, 200));
//#############################################################################################################################################################
// 인사발령 비동기 전송
		
		$(addAsgmtBtn).on('click', function() {	
			let ckTrTags = $(".empChk:checked").closest("tr");
			let asgmtList = [];
			console.log(ckTrTags);
			$(ckTrTags).each(function(i, trTag) {
				let asmgtObject = $(trTag).find("input,select,textarea").serializeObject();
				asgmtList.push(asmgtObject);
			});
			console.log("asgmtList : ",asgmtList);
			
			$.ajax({
	  			url : CONTEXTPATH+"/emp/empTransferInsert.do",
				method : "post",
				dataType : "json",
				data : JSON.stringify(asgmtList),
				contentType: "application/json; charset=utf-8",
				success : function(resp) {
					if(resp.status == 'success'){
			            toastr.success('인사발령을 등록했습니다.');
			            offcanvasBottom.offcanvas('hide');
			            ajaxTransferList();
			        }else if(resp.status == 'fail'){ 
			            toastr.error('인사발령 중 오류가 발생 했습니다.');
			        }
					
				},
				error : function(errorResp) {
					console.log(errorResp.status);
					toastr.error('인사발령 중 오류가 발생 했습니다.');
					offcanvasBottom.offcanvas('hide');
				}
			});
		});	
//#############################################################################################################################################################
//PDF 생성
	   //---------------------------------------------------------
	   //  HTML > IMG > PDF 저장 via html2canvas & jspdf
	   //---------------------------------------------------------
	   $('#PDFBtn').click(function() { // pdf저장 button id
	      
	       html2canvas($('#fullscreenModaltrans')[0],{
	          scale : 2             //해상도 조정
	       }).then(function(canvas) { //저장 영역 div id
	      
	       // 캔버스를 이미지로 변환
	       var imgData = canvas.toDataURL('image/png');
	       
	       var imgWidth = 210; // 이미지 가로 길이(mm) / A4 기준 210mm
	       var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
	       var imgHeight = canvas.height * imgWidth / canvas.width;
	       var heightLeft = imgHeight;
	       var margin = 3; // 출력 페이지 여백설정
	       var doc = new jsPDF('p', 'mm');
	       var position = 0;
	          
	       // 첫 페이지 출력
	       doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
	       heightLeft -= pageHeight;
	            
	       // 한 페이지 이상일 경우 루프 돌면서 출력
	       while (heightLeft >= 20) {
	           position = heightLeft - imgHeight;
	           doc.addPage();
	           doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
	           heightLeft -= pageHeight;
	       }
	    
	       // 파일 저장
	       doc.save('인사발령.pdf');
	        
	      });
	   });
	
})//$(function() {}) 끝 부분
