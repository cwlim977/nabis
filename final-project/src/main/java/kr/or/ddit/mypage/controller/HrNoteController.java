package kr.or.ddit.mypage.controller;


import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.mypage.service.MypageService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.HrnoteVO;



@Controller
@RequestMapping(value="/mypage")
public class HrNoteController {
	@Inject
	private MypageService service;
	
	// 인사노트 조회
	/**
	 * @param empNo 리스트에서 조회한 회원의 사원번호
	 * @param model 
	 * @return 인사노트 조회화면jsp주소
	 */
	@GetMapping(value="/hrNoteRetrieve.do")
	public String HrNoteRetrieve(@RequestParam(name="empNo", required=true )String empNo, Model model) {
		EmpVO hrInfo = service.selectHrInfoList(empNo);
		model.addAttribute("empVo", hrInfo);
		
		List<HrnoteVO> hrnoteList = service.selectHrNoteList(empNo);
		model.addAttribute("hrnoteList", hrnoteList);
		
		return "mypage/hrNote";
	}
	
	
	// 인사노트 작성
	@PostMapping(value="/hrNoteInsert.do")
	@ResponseBody
	public String HrNoteInsert(@ModelAttribute("hrnote") HrnoteVO hrnote ) {
		
		
		int res = service.insertHrnote(hrnote);
		
		if(res > 0) 
			return "SUCCESS";
		return "FALSE";
		
//		return "empManager/empMypage";
	}
	
	
	
	// 인사노트 수정
	@PostMapping(value="/hrNoteUpdate.do")
	@ResponseBody
	public String HrNoteUpdate(@ModelAttribute("hrnote") HrnoteVO hrnote, @RequestParam(required=true) String writer, String user ) {
		
		String msg ="";
		
		if(writer.equals(user)) {
			
			int res = service.updateHrnote(hrnote);
			
			if(res > 0) 
				return msg ="SUCCESS UPDATE";
			
		}else 
			return msg ="UPDATE FAIL";
		
		return msg ;
	}

	
	
	// 인사노트 삭제
	@PostMapping(value="/hrNoteDelete.do")
	@ResponseBody
	public String HrNoteDelete(@RequestParam(required=true) String noteNo, String writer, String user) {
		String msg ="";
		
		if(writer.equals(user)) {
		
			int res = service.deleteHrnote(noteNo);
			
			if(res > 0) 
				return msg ="SUCCESS DELETE";
			
		}else 
			return msg ="DELETE FAIL";
		return msg;
	}
	
}

