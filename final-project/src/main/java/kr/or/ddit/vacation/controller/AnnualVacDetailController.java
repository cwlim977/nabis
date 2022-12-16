package kr.or.ddit.vacation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.vacation.service.VacationService;
import kr.or.ddit.vo.VacPosnVO;

@Controller
@RequestMapping("/myVacation")
public class AnnualVacDetailController {
	
	@Inject
	private VacationService service;
	
	@GetMapping("annualVacDetailView.do")
	public String annualVacDetailView() {
		return "vacation/annualVacDetail";
	}
	
	@PostMapping(value="annualVacDetail.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> annualVacDetail(
			@RequestParam String empNo,
			@RequestParam String year
			
	) {
		Map<String, Object> resp = new HashMap<>();
		String status = "success";
		List<VacPosnVO> vacPosnList = service.retrieveVacPosnListByKeyWords(empNo, year);
		resp.put("vacPosnList", vacPosnList);
		if(vacPosnList.isEmpty()) status = "empty";
		resp.put("status", status);
		return resp;
	}
}
