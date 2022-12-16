<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
<style>
/* .li-wrap{ */
/* 	position: relative; */
/* } */
/* .li-wrap i{ */
/* 	vertical-align:middle; */
/* } */
/* .li-text{ */
/* 	position: absolute; */
/* 	transform: translate(-50%, -50%); */
/* 	text-align:center; */
/* } */

</style>

<!-- <ul> -->
<!-- 	<li> 진행중 li start -->
<!-- 		<div> -->
<!-- 			<span>진행중 (5)</span> -->
<!-- 		</div> -->
<!-- 		<div style="min-width: 100%; display: table;"> -->
<!-- 			<ul class="todoList"> -->
<!-- 				<li class="isClickable-true c-csEAhz-ijnoTk-hasHoverExtra-true"> -->
<!-- 					<div class="c-hFKVrr"> -->
<!-- 						<div class="c-iyseWy"> -->
<!-- 							<div class=""> -->
<!-- 								<span data-state="closed"> -->
<!-- 									<div data-role="avatar-root" class="c-cmpvrW c-cmpvrW-gMqBZQ-size-default"> -->
<!-- 										<div data-role="avatar-outline" class="PJLV"></div> -->
<!-- 										<span data-role="avatar-content-root" class="c"> -->
<!-- 											<span class="c-kfyqlQ c-kfyqlQ-igDqISd-css">나비</span> -->
<!-- 										</span> -->
<!-- 									</div> -->
<!-- 								</span> -->
<!-- 								<div class=""> -->
<!-- 									<div class=""> -->
<!-- 										<span class=""> -->
<!-- 											<span class=""> -->
<!-- 												<span class=""> -->
<!-- 													<span> -->
<!-- 														<span data-lokalise="true" data-key="todo.work_record.title">근무 승인 요청</span> -->
<!-- 													</span> -->
<!-- 													<span class="c-icCTaa"> -->
<!-- 														<span>김나비</span> -->
<!-- 														<span> -->
<!-- 															<span data-state="closed">약 16시간 전</span> -->
<!-- 														</span> -->
<!-- 													</span> -->
<!-- 												</span> -->
<!-- 											</span> -->
<!-- 										</span> -->
<!-- 									</div> -->
<!-- 									<span class="c-lmMdX c-lmMdX-igzNXgu-css"> -->
<!-- 										<div>2022. 11. 9 (수) - 근무,연장 근무</div> -->
<!-- 									</span> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
						
<!-- 						<div class="c-ihnDDS" style="margin-left: 8px;"> -->
<!-- 							<div class="c-fmTwhW"> -->
<!-- 								<div data-role="extra" class="PJLV"> -->
<!-- 									<div -->
<!-- 										class=""> -->
<!-- 										<svg width="22" height="22" viewBox="0 0 24 24" fill="none" -->
<!-- 											xmlns="http://www.w3.org/2000/svg" -->
<!-- 											style="width: 22px; height: 22px; flex-shrink: 0;"> -->
<!-- 											<path -->
<!-- 												d="M9.78284 17.5657L8.65147 16.4343L13.0858 12L8.65147 7.56567L9.78284 6.4343L15.3485 12L9.78284 17.5657Z" -->
<!-- 												fill="#cdd2d6" fill-rule="evenodd" clip-rule="evenodd"></path></svg> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 								<div data-role="hover-extra" class="text-end"> -->
<!-- 									<button type="button" aria-disabled="false" class="btn unhide"> -->
<!-- 										<i class="bx bx-chevron-right"></i> -->
<!-- 									</button> -->
<!-- 									내 설정 modal -->
<!-- 									<a href="#" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#sentModal"> -->
<!-- 										<i class='bx bx-cog' ></i>내 설정 -->
<!-- 									</a> -->

<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</li> -->
<!-- 			</ul> -->
<!-- 		</div> -->
<!-- 	</li>진행중 li end -->
	
<!-- 	<li> 완료 li start -->
<!-- 		<!-- Hoverable Table rows --> 
<!-- 			<table class="table table-hover;" style="table-layout: fixed">  "table-bordered" -->
<!-- 				<tbody class="table-border-bottom-0; table-border-right-0"> -->
<!-- 					<tr> -->
<!-- 						<th class="c1">완료한 일</th> -->
<!-- 						<th class="c2"> -->
<!-- 							<div class="text-end"> -->
<!-- 							</div> -->
<!-- 						</th> -->
<!-- 					</tr> -->
<!-- 					<tr class="todoList"> -->
<!-- 						<td> -->
<!-- 							<a href="#" class="menu-link"> <img -->
<%-- 								src="${cPath}/resources/assets/img/avatars/5.png" alt="Avatar" --%>
<!-- 								class="rounded-circle w-px-50 h-px-50"> -->
<!-- 								<div class="mx-3 mt-1"> -->
<!-- 									<strong>김판다</strong><br> <span class="fs-tiny">마케터</span> -->
<!-- 								</div> -->
<!-- 							</a> -->
<!-- 						</td> -->
						
<!-- 						<td> -->
<!-- 							<div data-role="hover-extra" class="li-wrap "> -->
<!-- 								<i class='bx bxs-square-rounded' style="z-index: 1"></i> -->
<!-- 								<div class="li-text "> -->
<!-- 										<span>세엣</span> -->
<!-- 									</div> -->
							
<!-- 								<button type="button" aria-disabled="false" class="btn"> -->
<!-- 									<i class="bx bx-chevron-right"></i> -->
<!-- 								</button> -->
								
<!-- 							</div> -->
<!-- 						</td> -->
<!-- 					</tr> -->
<!-- 				</tbody> -->
<!-- 			</table> Hoverable Table rows -->
<!-- 	</li> 완료 li end -->
<!-- </ul> -->

<!-- <!-- sent Modal --> 
<!-- <div class="modal fade" id="sentModal" tabindex="-1" aria-hidden="true"> -->
<!-- 	<div class="modal-dialog modal-dialog-centered" role="document"> -->
<!-- 		<div class="modal-content"> -->

<!-- 			<div class="modal-header"> -->
<!-- 				<h3 class="modal-title" id="modalCenterTitle">계정 및 환경 설정</h3> -->
<!-- 				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
<!-- 			</div> -->
			
<!-- 			<div class="modal-body"> -->
<!-- 				<div class="row mt-3"> -->
<!-- 					<div class="d-grid gap-2 col-lg-12 mx-auto"> -->
<!-- 						<button type="button" class="btn btn-primary btn-lg" onclick="tabAccount();"> -->
<!-- 							<i class='menu-icon tf-icons bx bxs-envelope'></i> -->
<!-- 							<div data-i18n="Analytics">이메일 변경</div> -->
<!-- 						</button> -->
<!-- 					</div> -->
<!-- 				</div> -->
				
<!-- 				<div class="row mt-3"> -->
<!-- 					<div class="d-grid gap-2 col-lg-12 mx-auto"> -->
<!-- 						<button type="button" class="btn btn-primary btn-lg" onclick="tabPassword();"> -->
<!-- 							<i class='menu-icon tf-icons bx bxs-key'></i> -->
<!-- 							<div data-i18n="Analytics">비밀번호 변경</div> -->
<!-- 						</button> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div class="modal-footer"> -->
<!-- 			</div> -->
		
<!-- 		</div>		 -->
<!-- 	</div> -->
<!-- </div> -->
<script type="text/javascript" defer="defer">




function findSeq(){

}


$(function(){
	
	
	
	
 	var color;
	var schTtl;
	var schCon;
	var stTime;

	var colorSet1 = ["#E72C51", "#F29649", "#AF539B", "#2E63AF", "#1CB4AD", "#6B7830"];
	for (i = 0; i < colorSet1.length; i++) {
		let colorDiv = document.createElement("div"); 
		colorDiv.classList.add("pallete");
		colorDiv.style.backgroundColor = colorSet1[i];
		$(colorDiv).attr('id', colorSet1[i] );
// 		$(colorDiv).attr('data-idx', 'color' + i );
		$('.colorPicker').append(colorDiv);
	}
	
	$('.pallete').on('click',function(){
		$('.pallete').css('border',''); 
		  $(this).css('border','3px solid red'); 
		  color = $(this).attr('id');
		  console.log(color);
	})
	
	var request = 
		
		$.ajax({
			url : CONTEXTPATH+"/home/calendarList.do", // 값 불러오기
			method : "POST",
			dataType : "json"
		});
	
		
	
		request.done(function(data){
		//$(function() {
			
		
		var date = new Date();
		var year = date.getFullYear();
		var month = date.getMonth();
		
		var calendarEl = document.getElementById('calendar');
		calendar = new FullCalendar.Calendar(calendarEl,{
		height : '700px',
		firstDay : 1,
		//eventDisplay : 'block',
		// 헤더에 표시할 툴바
		headerToolbar :{
		left : 'prev,next',
		center : 'title' ,
		right : 'today'
		},
		initialView : 'dayGridMonth', // 초기 로드 될 때 보이는 캘린더 화면 (기본 설정 : 달)

		//navLinks : true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
		//editable : true, // 수정 가능?
		selectable : false, // 달력 일자 드래그 설정 가능
		droppable : false, // 드래그 앤 드롭
		events : data,
/* 		events : [
			{
				title:'테스sss트',
				start: '2022-12-10',
				constraint:'비즈니스',
					allDay:"true",
			},{
				title:'테스sss트a',
				start: '2022-12-12',id:"dd"
			}
			
			
			], */
		eventTimeFormat: {
			  hour: "2-digit",
			  minute: "2-digit",
			  hour12: false
			},
 		locale : 'ko', // 한국어 설정
		})
		
		calendar.render();
		})
})
</script>
<div id="container" class="card">
<div id="calendar">
</div>
</div>

<!-- 	//일정리스트 불러오기 -->
<!-- 	@ResponseBody -->
<!-- 	@PostMapping("/calendarList") -->
<!-- 	public List<HashMap<String,Object>> allSchedule(HttpServletRequest request){ -->
<!-- 		HttpSession session = request.getSession(); -->
<!-- 		MemberVO memVO = (MemberVO) session.getAttribute("memSession"); -->
<!-- 		int memCd = memVO.getMemCd(); -->
		
<!-- 		JSONObject jo; -->
<!-- 		JSONArray ja = new JSONArray(); -->
		
<!-- 		List<ScheduleVO> list= scheduleService.allSchedule(memCd); -->
<!-- 		HashMap<String,Object> map = new HashMap<String, Object>(); -->
<!-- 		for(ScheduleVO vo: list) { -->
<!-- 			map.put("title", vo.getSchTtl()); -->
<!-- 			map.put("start", vo.getSchSt()); -->
<!-- 			map.put("end", vo.getSchEn()); -->
<!-- 			map.put("id", vo.getSchCd()); -->
<!-- 			map.put("color", vo.getSchColor()); -->
<!-- //			map.put("allDay","true"); -->
<!-- 			jo = new JSONObject(map); -->
<!-- 			ja.add(jo); -->
<!-- 		} -->
		
<!-- 		return ja; -->
<!-- 	} -->