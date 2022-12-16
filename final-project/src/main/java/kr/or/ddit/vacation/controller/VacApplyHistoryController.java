package kr.or.ddit.vacation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.vacation.service.VacationService;
import kr.or.ddit.vo.VacApplyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/memberVacation")
public class VacApplyHistoryController {
	
	@Inject
	private VacationService service;
	
	@GetMapping("vacAplyHistoryView.do")
	public String vacAplyList(Model model) {
		return "vacation/vacAplyHistory";
	}
	
	@PostMapping(value="vacApplySchedule.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> vacApplySchedule(@RequestParam Integer year, @RequestParam Integer month) {
		Map<String, Object> resp = new HashMap<>();
		String status = "success";
		log.info("year : {} month : {}", year, month);
		List<VacApplyVO> vacApplyVoList = service.retrieveVacApplyList(year, month);
		if(vacApplyVoList.isEmpty()) status = "empty";
		else resp.put("vacApplyVoList", vacApplyVoList);
		resp.put("status", status);
		return resp;
	}
	
	@PostMapping(value="vacApplyManage.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> vacApplyManage(@RequestParam String vaapCode, @RequestParam String behavior) {
		log.info("vaapCode : {} behavior : {}", vaapCode, behavior);
		Map<String, Object> resp = new HashMap<>();
		String status = null;
		ServiceResult result = service.vacApplyManage(vaapCode, behavior);
		switch(result) {
			case OK:
				status = "success";
			break;
			default:
				status = "fail";
			break;
		}
		resp.put("status", status);
		return resp;
	}
	
	@PostMapping(value="getVacApplyDetail.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> getVacApplyDetail(String vaapCode) {
		Map<String, Object> resp = new HashMap<>();
		String status = null;
		VacApplyVO vacApplyVo = service.retrieveVacApply(vaapCode);
		if(vacApplyVo == null) status = "fail";
		else {
			status = "success";
			resp.put("vacApplyVo", vacApplyVo);
		}
		resp.put("status", status);
		return resp;
	}
	
}
