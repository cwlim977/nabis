package kr.or.ddit.vacation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.commons.enumpkg.ServiceResult;

import kr.or.ddit.vacation.service.VacationService;
import kr.or.ddit.vo.BlgDeptVO;
import kr.or.ddit.vo.EmpVO;

import kr.or.ddit.vo.VacPosnVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/myVacation")
public class VacOutlineController {
	
	@Inject
	private VacationService service;
	
	@GetMapping("vacOutlineView.do")
	public String vacOutlineView(
			HttpServletRequest request,
			Model model
	) {
		HttpSession session = request.getSession();
		EmpVO empVo = (EmpVO) session.getAttribute("authEmp");
		log.info("empVo : {}", empVo);
		Map<String, Object> map = service.retrieveVacOutline(empVo.getEmpNo());
		log.info("retrieveVacOutline Map : {}", map);
		model.addAttribute("map", map);
		return "vacation/vacOutline";
	}
	
	@PostMapping(value="vacApply.do", 
			consumes=MediaType.APPLICATION_JSON_UTF8_VALUE, 
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> vacApplyDetail(
			@RequestBody Map<String, Object> dataMap
			, BindingResult errors
	) {
		Map<String, Object> resp = new HashMap<>();
		String status = "success";
		ServiceResult result = service.createVacApply(dataMap);
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
	
	@GetMapping(value="vacCancel.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> vacCancel(@RequestParam String vaapCode) {
		Map<String, Object> resp = new HashMap<>();
		String status = "success";
		ServiceResult result = service.cancelVacApply(vaapCode);
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
	
	@PostMapping(value="vaapFileUpload.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> vaapFileUpload(
				@RequestParam(value="vaapCode") String vaapCode,
				@RequestParam(value="uploadFile") MultipartFile uploadFile
			) 
	{
		log.info("vaapCode : {}", vaapCode);
		log.info("uploadFile : {}", uploadFile);
		Map<String, Object> resp = new HashMap<>();
		String status = "success";
		ServiceResult result = service.uploadVaapFile(vaapCode, uploadFile);
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
	
}