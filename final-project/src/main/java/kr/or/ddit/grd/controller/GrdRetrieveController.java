package kr.or.ddit.grd.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.grd.service.GrdService;
import kr.or.ddit.vo.GrdVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/grd")
public class GrdRetrieveController {
	
	@Inject
	private GrdService service;

	@RequestMapping("grdList.do")
	public String grdList(Model model) {
		List<GrdVO> grdList = service.retrieveGrdList();
		model.addAttribute("grdList", grdList);

		return "grd/grdtest";
	}

	@ResponseBody
	@GetMapping(value = "grdList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<GrdVO> grdLoad() {

		List<GrdVO> grdList = service.retrieveGrdList();

		return grdList;
	}

	@ResponseBody
	@RequestMapping("maxGrdCode.do")
	public String doGet() {
		System.out.println("max들어옴");
		String maxGrdCode = service.retrieveMaxGrdCode();
		log.info("여기 test1 {}", maxGrdCode);

		return maxGrdCode;
	}
}