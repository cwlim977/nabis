package kr.or.ddit.pstn.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.pstn.service.PstnService;
import kr.or.ddit.vo.PstnVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/pstn")
public class PstnRetrieveController {
	
	@Inject
	private PstnService service;
	
	@RequestMapping("pstnList.do")
	public String pstnList(
		Model model
	) {
		List<PstnVO> pstnList = service.retrievePstnList();
		model.addAttribute("pstnList", pstnList);
		
		return "pstn/pstntest";
	}
	
	@ResponseBody
	@GetMapping(value="pstnList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<PstnVO> pstnLoad() {
		
		List<PstnVO> pstnList = service.retrievePstnList();
		
		return pstnList;
	}
	
	@ResponseBody
	@RequestMapping("maxPtnCode.do")
	public String doGet(
	) {
		System.out.println("max들어옴");
		String maxDcode = service.retrieveMaxPtnCode();
		log.info("여기 test1 {}", maxDcode);
		
		return maxDcode;
	}
}
