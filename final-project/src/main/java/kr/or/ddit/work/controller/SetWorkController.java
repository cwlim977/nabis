package kr.or.ddit.work.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.validate.UpdateGroup;
import kr.or.ddit.vo.WorkVO;
import kr.or.ddit.work.dao.WorkDAO;
import kr.or.ddit.work.service.WorkService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/setting")
public class SetWorkController {
	
	@Inject
	WorkDAO dao;
	
	@Inject
	WorkService service;
	
	@GetMapping("workSet.do")
	public String workSetView() {
		return "setting/workSet";
	}
	
	/**
	 * 비동기 근무 유형 리스트 조회
	 * @return 
	 */
	@GetMapping(value = "getWorkList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<WorkVO> getWorkList() {
		log.info("getWorkList.do 비동기 요청");
		List<WorkVO>  workList = dao.selectWorkList();
		
		return workList;
	}
	
	@PostMapping(value = "createWork.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> createWork(
			@RequestBody @Valid WorkVO work
			,Errors errors
			) {
		log.info("createWork.do 비동기 요청 파라미터 : {}",work);
		
		String status = "fail";
		
		if(!errors.hasErrors()){
			int rowCnt = dao.insertWork(work);
			log.info("insertWork() rowCnt 값 {}",rowCnt );
			String result = rowCnt > 0 ? "ok" : "fail";
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
			log.info("createWork.do errors :{}", errors.toString());
		}
		
		Map<String, Object> jsonDate = new HashMap<String, Object>();
		jsonDate.put("status", status);
		
		return jsonDate;
	}
	@PostMapping(value = "modifyWork.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> modifyWork(
			@RequestBody @Validated(UpdateGroup.class) WorkVO work
			,Errors errors
			) {
		log.info("modifyWork.do 비동기 요청 파라미터 : {}",work);
		
		String status = "fail";
		
		if(!errors.hasErrors()){
			if(work.getWkHd() == null) work.setWkHd("N");
			if(work.getWkNight() == null) work.setWkNight("N");
			int rowCnt = dao.updateWork(work);
			log.info("insertWork() rowCnt 값 {}",rowCnt );
			String result = rowCnt > 0 ? "ok" : "fail";
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
			log.info("modifyWork.do errors :{}", errors.toString());
		}
		
		Map<String, Object> jsonDate = new HashMap<String, Object>();
		jsonDate.put("status", status);
		
		return jsonDate;
	}
	@PostMapping(value = "deleteWork.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> deleteWork(
			@RequestParam(required=true) String wkCode
			) {
		log.info("deleteWork.do 비동기 요청 파라미터 : {}",wkCode);
		
		String status = "fail";
		
		int rowCnt = dao.deleteWork(wkCode);
		log.info("deleteWork() rowCnt 값 {}",rowCnt );
		String result = rowCnt > 0 ? "ok" : "fail";
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
}
