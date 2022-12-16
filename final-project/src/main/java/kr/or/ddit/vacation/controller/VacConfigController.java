package kr.or.ddit.vacation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.vacation.service.VacationService;
import kr.or.ddit.vo.VacVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/vacationConfig")
public class VacConfigController {
	
	@Inject
	private VacationService service;
	
	@GetMapping("vacConfigView.do")
	public String vacConfigView(
			Model model
	) {
		List<VacVO> vacList = service.retrieveVacList();
		model.addAttribute("vacList", vacList);
		return "vacation/vacConfig";
	}
	
	@PostMapping(value="annualLeaveVacAddGive.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, String> annualLeaveVacAddGive(
			@RequestBody List<Map<String, Integer>> annualVacAddGiveList
			, Model model
	) {
		Map<String, String> resp = new HashMap<>();
		String status = "fail";
		ServiceResult result = service.modifyAnnualLeaveVacAddGive(annualVacAddGiveList);
		switch(result) {
			case OK:
				status = "success";
			break;
			case FAIL:
				status = "fail";
			break;
		}
		resp.put("status", status);
		return resp;
	}
	
	@PostMapping(value="vacInsert.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> vacInsert(
		@Validated VacVO vacation 
		, BindingResult errors
	) {
		Map<String, Object> resp = new HashMap<>();
		String status = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.createVacation(vacation);
			switch(result) {
				case OK:
					resp.put("addVac", vacation);
					status = "success";
				break;
				case FAIL:
					status = "fail";
				break;
				case PKDUPLICATED:
					status = "pkduplicated";
				break;
			}
		}
		else {
			log.info("error : {}", errors.toString());
			status = "fail";
		}
		resp.put("status", status);
		return resp;
	}
	
	@PostMapping(value="vacDetail.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> vacDetail(@RequestParam String vcNm){
		Map<String, Object> resp = new HashMap<>();
		VacVO vacation = service.retrieveVacation(vcNm); // 나중에 시간될 때 VacNotFoundException일 때 오류 페이지 이동시키기 추가하자
		resp.put("vacation", vacation);
		return resp;
	}
	
	@PostMapping(value="vacModify.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> vacModify(
		@Validated VacVO vacation 
		, BindingResult errors
	) {
		Map<String, Object> resp = new HashMap<>();
		String status = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyVacation(vacation);
			switch(result) {
				case OK:
					resp.put("modifiedVac", vacation);
					status = "success";
				break;
				case FAIL:
					status = "fail";
				break;
			}
		}
		else {
			log.info("error : {}", errors.toString());
			status = "fail";
		}
		resp.put("status", status);
		return resp;
	}
	
	@PostMapping(value="vacDelete.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> vacDelete(@RequestParam String vcNm){
		Map<String, Object> resp = new HashMap<>();
		ServiceResult result = service.inactiveVacation(vcNm);
		String status = "fail";
		switch(result) {
			case OK:
				status = "success";
			break;
			case FAIL:
				status = "fail";
			break;
		}
		resp.put("status", status);
		return resp;
	}
	
}