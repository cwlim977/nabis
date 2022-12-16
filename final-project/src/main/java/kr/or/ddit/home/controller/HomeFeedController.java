package kr.or.ddit.home.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.home.dao.HomeDAO;
import kr.or.ddit.notice.dao.NoticeDAO;
import kr.or.ddit.vo.ApplicationVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.WkApVO;
import kr.or.ddit.work.dao.WorkDAO;
import kr.or.ddit.work.service.WorkService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/home")
public class HomeFeedController {
	
	@Inject
	HomeDAO dao;
	
	@Inject
	NoticeDAO noticeDAO;
	
	@Inject
	WorkDAO workDao;
	
	@Inject
	WorkService workService; 

	@GetMapping(value="feed.do")
	public String homeFeed(Model model) {
		int noticeCnt = noticeDAO.selectNoticeCnt();
		model.addAttribute("noticeCnt", noticeCnt );
		return "home/feed";
	}
	
	@GetMapping(value="applicationList.do"	,produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<ApplicationVO> applicationListJson(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String empNo = ((EmpVO)session.getAttribute("authEmp")).getEmpNo();
		
		return dao.selectApplicationList(empNo);
	}
	
	/**
	 * 비동기 근무기록 반려
	 * @return Map<String, Object> jsonDate
	 */
	@PostMapping(value = "workApReject.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> workApRejectAjax(
			@RequestParam(name="apNo", required=true) String waNo
			) {
		log.info("workApReject.do 비동기 요청 파라미터 : {}",waNo);
		
		String status = "fail";
		
		String result = workService.rejectWorkAp(waNo);
		log.info("rejectWorkAp() result 값 {}",result );
		switch (result) {
		case "ok":
			status = "success";
			break;
			
		case "fail":
			status = "fail";
			break;
			
		default:
			status = "fail";
			break;
		}
		
		Map<String, Object> jsonDate = new HashMap<String, Object>();
		jsonDate.put("status", status);
		
		return jsonDate;
	}
	
	/**
	 * 비동기 근무기록 승인
	 * @return Map<String, Object> jsonDate
	 */
	@PostMapping(value = "workApConfirm.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> workApConfirmAjax(
			@RequestParam(name="apNo", required=true) String waNo
			) {
		log.info("workApConfirm.do 비동기 요청 파라미터 : {}",waNo);
		
		String status = "fail";
		
		String result = workService.confirmWorkAp(waNo);
		log.info("confirmWorkAp() result 값 {}",result );
		switch (result) {
		case "ok":
			status = "success";
			break;
			
		case "fail":
			status = "fail";
			break;
			
		default:
			status = "fail";
			break;
		}
		
		Map<String, Object> jsonDate = new HashMap<String, Object>();
		jsonDate.put("status", status);
		
		return jsonDate;
	}

	//일정리스트 불러오기
	@ResponseBody
	@PostMapping("/calendarList.do")
	public List<HashMap<String,Object>> schedule(HttpServletRequest request){
		HttpSession session = request.getSession();
		EmpVO emp = (EmpVO) session.getAttribute("authEmp");
		
		JSONObject jo;
		JSONArray ja = new JSONArray();
		
		List<WkApVO> list= workDao.selectSchedule(emp);
		HashMap<String,Object> map = new HashMap<String, Object>();
		for(WkApVO vo: list) {
			String title = "";
			title = vo.getEmpNm() + " - " + vo.getWkNm() + "("+vo.getWaStime()+")";
			if(vo.getWkCode().equals("WK1")) title = vo.getEmpNm() + " - " + vo.getWkNm() + "(하루종일)";
			if(vo.getWkCode().equals("WK6")) title = vo.getEmpNm() + " - " + vo.getWkNm() + "(오전반차)";
			if(vo.getWkCode().equals("WK7")) title = vo.getEmpNm() + " - " + vo.getWkNm() + "(오후반차)";
			map.put("title", title);
			map.put("start", vo.getWaDate());
			if(vo.getWkCode().equals("WK1") || vo.getWkCode().equals("WK6") || vo.getWkCode().equals("WK7")) map.put("color", "#4d638c");
			map.put("allDay","true");
			jo = new JSONObject(map);
			ja.add(jo);
		}
		
		return ja;
	}
	
	//하루일정리스트 불러오기
	@ResponseBody
	@PostMapping("/dayCalendarList.do")
	public List<WkApVO> daySchedule(
			HttpServletRequest request
			,@RequestParam String scdDate){
		HttpSession session = request.getSession();
		EmpVO emp = (EmpVO) session.getAttribute("authEmp");
		emp.setEntDate(scdDate);
		log.info("/dayCalendarList.do 요청 파라미터 scdDate : {} , emp : {}",scdDate, emp);
		List<WkApVO> list= workDao.selectDaySchedule(emp);
		return list;
	}
}

