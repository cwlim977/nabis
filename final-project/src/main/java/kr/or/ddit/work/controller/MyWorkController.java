package kr.or.ddit.work.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.WkApVO;
import kr.or.ddit.vo.WorkVO;
import kr.or.ddit.work.dao.WorkDAO;
import kr.or.ddit.work.service.WorkService;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/work")
public class MyWorkController {
	
	@Inject
	WorkDAO dao;
	
	@Inject
	WorkService service;
	
	/**
	 * 사원 근무 조회
	 * @param request
	 * @param model
	 * @return
	 */
	@GetMapping(value ="myWork.do")
	public String list(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String empNo = ((EmpVO)session.getAttribute("authEmp")).getEmpNo();
		
		List<WorkVO>  workList = dao.selectWorkList();
		
		model.addAttribute("workList", workList); 
		model.addAttribute("empNo", empNo); 
		return "work/my";
	}
	
	/**
	 * 비동기 근무 유형 리스트 조회
	 * @return 
	 */
	@GetMapping(value = "getWorkOptionList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<WorkVO> getWorkOptionList() {
		log.info("getWorkOptionList.do 비동기 요청");
		
		List<WorkVO>  workList = dao.selectWorkList();
		
		return workList;
	}
	/**
	 * 비동기 개인 근무기록 상세 조회
	 * @return 
	 */
	@GetMapping(value = "getWorkApDetail.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public WkApVO getWorkApDetail(@RequestParam(required=true, name="apNo") String waNo) {
		log.info("getWorkApDetail.do 비동기 요청 파라미터 : {}", waNo);
		return dao.selectWorkAp(waNo); 
	}
	
	/**
	 * 비동기 개인 근무기록 리스트 조회
	 * @return 
	 */
	@PostMapping(value = "myWork.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> myWorkListAjax(@RequestParam(required=true) String empNo
								, @RequestParam(required=true) Integer num) {
		log.info("myWork.do 비동기 요청 파라미터 : empNO {}, num {}",empNo ,num);
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("empNo", empNo);
		paramMap.put("num", num);
		
		List<WkApVO>  workApList = dao.selectWorkApList(paramMap);
		Integer workWeekTime = dao.selectWorkApWeekTime(paramMap);
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		jsonData.put("workApList", workApList);
		jsonData.put("workWeekTime", workWeekTime);
		return jsonData;
	}

	/**
	 * 비동기 근무기록 추가
	 * @return 
	 */
	@PostMapping(value = "workApplication.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> workApplicationAjax(
			HttpServletRequest request
			,@RequestBody @Valid WkApVO workAp
			,Errors errors
			) {
		log.info("workApplication.do 비동기 요청 파라미터 : {}",workAp);
		// 세션에서 아이디를 꺼내 변수에 저장한다.
		HttpSession session = request.getSession();
		String writer = ((EmpVO)session.getAttribute("authEmp")).getEmpNo();
		
		String status = "fail";
		
		if(!errors.hasErrors()){
			String result = service.createWorkAp(workAp, writer);
			log.info("createWorkAp() result 값 {}",result );
			switch (result) {
			case "ok":
				status = "success";
				break;
				
			case "fail":
				status = "fail";
				break;
				
			case "need":
				status = "need";
				break;
				
			case "nigtBan":
				status = "nigtBan";
				break;
			case "HdBan":
				status = "HdBan";
				break;
				
			default:
				status = "fail";
				break;
			}
		}else {
			log.info("workApplication.do errors :{}", errors.toString());
		}
		
		Map<String, Object> jsonDate = new HashMap<String, Object>();
		jsonDate.put("status", status);
		
		return jsonDate;
	}
	
	/**
	 * 비동기 근무기록 승인요청
	 * @return 
	 */
	@PostMapping(value = "workApprovalApplication.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> workApprovalApplication(
			@RequestBody @Valid WkApVO workAp
			,Errors errors
			) {
		log.info("workApprovalApplication.do 요청 파라미터 : {}",workAp);
		
		String status = "fail";
		
		if(!errors.hasErrors()){
			String result = service.createWorkAp(workAp);
			log.info("createWorkAp() result 값 {}",result );
			switch (result) {
			case "ok":
				status = "success";
				break;
				
			case "fail":
				status = "fail";
				break;
				
			case "need":
				status = "need";
				break;
				
			default:
				status = "fail";
				break;
			}
		}else {
			log.info("workApplication.do errors :{}", errors.toString());
		}
		
		Map<String, Object> jsonDate = new HashMap<String, Object>();
		jsonDate.put("status", status);
		
		return jsonDate;
	}
	
	/**
	 * 비동기 근무기록 삭제
	 * @return 
	 */
	@PostMapping(value = "workApRemove.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> workApRemoveAjax(
			@RequestBody @Valid WkApVO workAp
			,Errors errors
			) {
		log.info("workApRemove.do 비동기 요청 파라미터 : {}",workAp);
		
		String status = "fail";
		
		if(!errors.hasErrors()){
			String result = service.removeWorkAp(workAp);
			log.info("removeWorkAp() result 값 {}",result );
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
		}else {
			log.info("workApRemove.do errors :{}", errors.toString());
		}
		
		Map<String, Object> jsonDate = new HashMap<String, Object>();
		jsonDate.put("status", status);
		
		return jsonDate;
	}
	
	
}
