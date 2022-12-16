package kr.or.ddit.duty.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.duty.service.DutyService;
import kr.or.ddit.vo.DutyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/duty")
public class DutyRetrieveController {

	@Inject
	private DutyService service;

	@RequestMapping("dutyList.do")
	public String dutyList(Model model) {
		List<DutyVO> dutyList = service.retrieveDutyList();
		model.addAttribute("dutyList", dutyList);

		return "duty/dutytest";
	}

	@ResponseBody
	@GetMapping(value = "dutyList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<DutyVO> dutyLoad() {

		List<DutyVO> dutyList = service.retrieveDutyList();

		return dutyList;
	}

	@ResponseBody
	@RequestMapping("maxDtcode.do")
	public String doGet() {
		System.out.println("max들어옴");
		String maxDtcode = service.retrieveMaxDtcode();
		log.info("여기 test1 {}", maxDtcode);

		return maxDtcode;
	}
}