package kr.or.ddit.mypage.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.mypage.service.MypageService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.EmptVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mypage")
public class EmptStateController {
	@Inject
	private MypageService service;
	
	// 퇴직처리
	@PostMapping(value="/OutStInsert.do")
	@ResponseBody
	public String OutStInsert(@RequestParam(name="empNo", required=true )String empNo, @ModelAttribute("OutState") EmptVO emptVo , Model model) {
		EmpVO hrInfo = service.selectHrInfoList(empNo);
		model.addAttribute("empVo", hrInfo);
		
		log.info("insert emp out state {}",empNo);
		
		int res = service.insertOutToEmptst(emptVo);
		if(res > 0) 
			return "SUCCESS";
		return "FAIL";
	}
	
	// 휴직처리
	@PostMapping(value="/BkStInsert.do")
	@ResponseBody
	public String BkStInsert(@RequestParam(name="empNo", required=true )String empNo, @ModelAttribute("BkState") EmptVO emptVo , Model model) {
		EmpVO hrInfo = service.selectHrInfoList(empNo);
		model.addAttribute("empVo", hrInfo);
		
		log.info("insert emp break state {}",empNo);
		
		int res = service.insertBkToEmptst(emptVo);
		if(res > 0) 
			return "SUCCESS";
		return "FAIL";
	}

	
	
	// ajax 조회용, 기존 정보 가져오기. 수정등등.. ajax에서 dataType json으로 받을래요 하는건 이리로 옴
		@GetMapping(value="/breakHxRetrieve.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
		@ResponseBody
		public List<EmptVO> breakHxRetrieve(@RequestParam(name="empNo", required=true )String empNo) {
			List<EmptVO> breakHxList = service.bkStateRetrieve(empNo);
			
			return breakHxList;
		}
	
		
		
	//이게맞나?
	// 휴직이력 정보 수정
	@PostMapping(value="/bkUpdate.do")
	@ResponseBody
	public String bkUpdate( @ModelAttribute("emptVo") EmptVO emptVo, Model model ) {	//@RequestParam(name="cntEditor", required=true )String empNo,
//		EmpVO hrInfo = service.selectHrInfoList(empNo);
//		model.addAttribute("empVo", hrInfo);
		
		int res = service.modifyBkState(emptVo);
		if(res > 0) 
			return "SUCCESS";
		return "FAIL";

	}
	
	// 휴직이력 정보 삭제
	@PostMapping(value="/bkDelete.do")
	@ResponseBody
	public String bkDelete(@RequestParam(name="emptNo", required=true )String emptNo, Model model ) {
		
		int res = service.deleteBkState(emptNo);
		if(res > 0) 
			return "SUCCESS";
		return "FAIL";
		
	}	
		
	

}
