package kr.or.ddit.pay.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.commons.validate.UpdateGroup;
import kr.or.ddit.pay.service.PayTmpService;
import kr.or.ddit.vo.PayTmpVO;
import lombok.extern.slf4j.Slf4j;

//급여정산 - 정산 템플릿 목록 조회, 템플릿 별 생성, 조회, 수정, 삭제

@Slf4j
@Controller
@RequestMapping("/pay")
public class PayTmpController {
	
	@Inject
	private PayTmpService service;
	
//	@ModelAttribute("command")
//	public String command() {
//		return "INSERT";
//	}
	
	@ModelAttribute("tmp")
	public PayTmpVO tmp() {
		return new PayTmpVO();
	}
	
	
	//템플릿 목록 조회
	@GetMapping("tmpList.do")
	public String tmpList(
		Model model
	) {
		List<PayTmpVO> tmpList = service.retrievePayTmpList();
		model.addAttribute("tmpList", tmpList);
		return "pay/tmpList";
	}
	
	//템플릿 생성 form 가져오기
	@GetMapping("tmpInsert.do")
	public String tmpForm() {
		return "pay/tmpl/tmpForm";
	}
	
	String message = null;		
	String logicalViewName = null;
	
	//템플릿 생성
	@PostMapping("tmpInsert.do")
	public String tmpInsert(
		@ModelAttribute("tmp") @Validated PayTmpVO tmp
		, Errors errors
		, Model model
		, RedirectAttributes redirectAttributes
	) {
		if(!errors.hasErrors()) {
			ServiceResult result = service.createPayTmp(tmp);
			switch (result) {
			case OK:
				redirectAttributes.addFlashAttribute("tcmd", "템플릿 생성이 완료되었습니다.");
				logicalViewName = "redirect:/pay/tmpUpdate.do?ptNo="+tmp.getPtNo();
				break;

			default:
				message = "생성 중 문제가 발생하였습니다. 잠시 후 다시 시도 부탁드립니다.";
				logicalViewName = "pay/tmpl/tmpForm";
				break;
			}
		}else {
			logicalViewName = "pay/tmpl/tmpForm";
		}
		model.addAttribute("message", message);
		return logicalViewName;
	}
	
	
	//템플릿 수정 form 가져오기
	@GetMapping("tmpUpdate.do")
	public String tmpUpdForm(
		@RequestParam(name="ptNo", required=true) String ptNo
		, Model model
	) {
		PayTmpVO tmp = service.retrievePayTmp(ptNo);
		model.addAttribute("tmp", tmp);
		
		return "pay/tmpl/tmpForm";
	}
	
	//템플릿 수정
	@PostMapping("tmpUpdate.do")
	public String tmpUpdate(
		@Validated(UpdateGroup.class) @ModelAttribute("tmp") PayTmpVO tmp
		, Errors errors
		, Model model
	) {
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyPayTmp(tmp);
			switch (result) {
			case OK:
				logicalViewName = "redirect:/pay/tmpList.do";
				break;

			default:
				message = "수정 중 문제가 발생하였습니다. 잠시 후 다시 시도 부탁드립니다.";
				logicalViewName = "pay/tmpl/tmpForm";
				break;
			}
		}else {
			logicalViewName = "pay/tmpl/tmpForm";
		}
		model.addAttribute("message", message);
		return logicalViewName;
	}
	
	//템플릿 삭제
	@GetMapping("tmpDelete.do")
	public String tmpDelete(
			@RequestParam("ptNo") String ptNo, 
			RedirectAttributes redirectAttributes
	) {
		ServiceResult result = service.removePayTmp(ptNo);
		if(ServiceResult.OK.equals(result)) {
			logicalViewName = "redirect:/pay/tmpList.do";
		}else {
			redirectAttributes.addFlashAttribute("message", "삭제 중 문제가 발생하였습니다. 잠시 후 다시 시도 부탁드립니다.");
			logicalViewName = "redirect:/pay/tmpList.do"; 
		}
		return logicalViewName;
	}
	
	
	//템플릿 별 북마크 등록
	@GetMapping("tmpBmkInsert.do")
	@ResponseBody
	public String bmkIns(
		@RequestParam("ptNo") String ptNo
	) {
		ServiceResult result = service.createTmpBmk(ptNo);
		if(ServiceResult.OK.equals(result)) { 
			return "BOOKMARK INSERT SUCCESS";
		}else {
			return "FAIL";
		}
		
	}
	
	//템플릿 별 북마크 삭제
	@GetMapping("tmpBmkDelete.do")
	@ResponseBody
	public String bmkDel(
		@RequestParam("ptNo") String ptNo
	) {
		ServiceResult result = service.removeTmpBmk(ptNo);
		if(ServiceResult.OK.equals(result)) { 
			return "BOOKMARK DELETE SUCCESS";
		}else {
			return "FAIL";
		}
		
	}
	
	

}
