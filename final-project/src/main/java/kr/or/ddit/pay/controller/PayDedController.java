package kr.or.ddit.pay.controller;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
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
import kr.or.ddit.pay.service.PayDedService;
import kr.or.ddit.pay.service.PayTmpService;
import kr.or.ddit.pay.service.PtMakeService;
import kr.or.ddit.vo.PayAlwVO;
import kr.or.ddit.vo.PayDedVO;
import kr.or.ddit.vo.PayTmpVO;
import kr.or.ddit.vo.PtMakeVO;


@Controller
@RequestMapping("/pay")
public class PayDedController {
	
	/*급여 템플릿 - 지급·공제항목  조회 수정 삭제*/
	/*급여 템플릿 별 항목 사용 여부 설정 */
	
	@Inject
	private PayDedService service;
	
	@Inject
	private PtMakeService ptmService;
	
	@Inject
	private PayTmpService tmpService;
	
	@ModelAttribute("pay")
	public PayAlwVO pay() {
		return new PayAlwVO();
	}
	
	@ModelAttribute("ded")
	public PayDedVO ded() {
		return new PayDedVO();
	}
	
	@ModelAttribute("tmp")
	public PayTmpVO tmp() {
		return new PayTmpVO();
	}
	
	// 지급항목 목록 조회
	@GetMapping("payList.do")
	public String payList(
		  @RequestParam(name="ptNo" ,required=true) String ptNo
		, Model model
		, RedirectAttributes redirectAttributes
	) {
		
		if(StringUtils.isEmpty(ptNo)){
			redirectAttributes.addFlashAttribute("tcmd", "템플릿 생성 먼저 해주세요!");
			return "redirect:/pay/tmpInsert.do";
		}
		
		List<PayAlwVO> esPayList = service.retrievePayList("Y");
		List<PayAlwVO> nesPayList = service.retrievePayList("N");
		List<PtMakeVO> ptmList = ptmService.retrievePtMake(ptNo);
		PayTmpVO tmp = tmpService.retrievePayTmp(ptNo);
		model.addAttribute("esPayList", esPayList); //지급목록(법정필수)
		model.addAttribute("nesPayList", nesPayList);//지급목록(사용자추가)
		model.addAttribute("ptmList", ptmList); //템플릿별 사용여부
		model.addAttribute("tmp", tmp); //header에서 사용
		model.addAttribute("ptNo",ptNo);//지급목록 redirect시 사용
		return "pay/tmpl/payList";
	}
	
	// 공제항목 목록 조회
	@GetMapping("dedList.do")
	public String dedList(
		  @RequestParam(name="ptNo") String ptNo
		, Model model
		, RedirectAttributes redirectAttributes
	) {
		if(StringUtils.isEmpty(ptNo)){
			redirectAttributes.addFlashAttribute("tcmd", "템플릿 생성 먼저 해주세요!");
			return "redirect:/pay/tmpInsert.do";
		}
		
		List<PayDedVO> esDedList = service.retrieveDedList("Y");
		List<PayDedVO> nesDedList = service.retrieveDedList("N");
		List<PtMakeVO> ptmList = ptmService.retrievePtMake(ptNo);
		PayTmpVO tmp = tmpService.retrievePayTmp(ptNo);
		model.addAttribute("esDedList", esDedList); //공제목록(법정필수)
		model.addAttribute("nesDedList", nesDedList); //공제목록(사용자추가)
		model.addAttribute("ptmList", ptmList); //템플릿별 사용여부
		model.addAttribute("tmp", tmp); //header에서 사용
		model.addAttribute("ptNo",ptNo); //공제목록 redirect시 사용
		return "pay/tmpl/dedList";
		
	}
	
	// 지급항목 생성 form 가져오기
	@GetMapping("payInsert.do")
	public String payForm(
		  @RequestParam(name="ptNo") String ptNo
		, Model model
	) {
		PayTmpVO tmp = tmpService.retrievePayTmp(ptNo);
		model.addAttribute("tmp", tmp);
		return "pay/tmpl/payForm";
	}

	String message = null;
	String logicalViewName = null;
	String tcmd = null;
	
	// 지급항목 생성
	@PostMapping("payInsert.do")
	public String payInsert(
		  @ModelAttribute("pay") @Validated PayAlwVO pay
		, @RequestParam(name="ptNo") String ptNo
		, Errors errors
		, RedirectAttributes redirectAttributes
	) {
		if(!errors.hasErrors()) {
			ServiceResult result = service.createPay(pay);
			switch (result) {
			case OK:
				redirectAttributes.addFlashAttribute("tcmd", "지급항목 생성이 완료되었습니다.");
				logicalViewName = "redirect:/pay/payList.do?ptNo="+ptNo;
				break;
			default:
				message = "생성 중 문제가 발생하였습니다. 잠시 후 다시 시도 부탁드립니다.";
				redirectAttributes.addFlashAttribute("message", message);
				logicalViewName = "pay/tmpl/payForm";
				break;
			}
		}else {
			logicalViewName = "pay/tmpl/payForm";
		}
		return logicalViewName;
	}
	
	
	// 공제항목 생성 form 가져오기
	@GetMapping("dedInsert.do")
	public String dedForm(
		@RequestParam(name="ptNo") String ptNo
		,Model model
	) {
		PayTmpVO tmp = tmpService.retrievePayTmp(ptNo);
		model.addAttribute("tmp", tmp);
		return "pay/tmpl/dedForm";
	}
	
	// 공제항목 생성	
	@PostMapping("dedInsert.do")
	public String dedInsert(
		@ModelAttribute("ded") @Validated PayDedVO ded
		,@RequestParam(name="ptNo") String ptNo
		, Errors errors
		, Model model
	) {
		if(!errors.hasErrors()) {
			ServiceResult result = service.createDed(ded);
			switch (result) {
			case OK:
				logicalViewName = "redirect:/pay/dedList.do?ptNo="+ptNo;
				break;
			default:
				message = "생성 중 문제가 발생하였습니다. 잠시 후 다시 시도 부탁드립니다.";
				logicalViewName = "pay/tmpl/dedForm";
				break;
			}
		}else {
			logicalViewName = "pay/tmpl/dedForm";
		}
		model.addAttribute("message", message);
		return logicalViewName;
	}
	
	
	// 지급항목 수정 form 가져오기
	@GetMapping("payUpdate.do")
	public String payUpdForm(
	      @RequestParam(name="pyCode", required=true) String pyCode
	     ,@RequestParam(name="ptNo") String ptNo
	     ,Model model
	) {
		PayAlwVO pay = service.retrievePay(pyCode);
		PayTmpVO tmp = tmpService.retrievePayTmp(ptNo);
		model.addAttribute("pay", pay);
		model.addAttribute("tmp", tmp);
		return "pay/tmpl/payForm";
	}
	
	// 지급항목 수정
	@PostMapping("payUpdate.do")
	public String payUpdate(
		@Validated(UpdateGroup.class) @ModelAttribute("pay") PayAlwVO pay
		,@RequestParam(name="ptNo") String ptNo
		, Errors errors
		, Model model
	) {
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyPay(pay);
			switch (result) {
			case OK:
				tcmd = "success";
				model.addAttribute("tcmd", tcmd);
				logicalViewName = "redirect:/pay/payList.do?ptNo="+ptNo;
				break;

			default:
				message = "수정 중 문제가 발생하였습니다. 잠시 후 다시 시도 부탁드립니다.";
				logicalViewName = "pay/tmpl/payForm";
				break;
			}
		}else {
			logicalViewName = "pay/tmpl/payForm";
		}
		model.addAttribute("message", message);
		return logicalViewName;
	}
	
	
	
	// 공제항목 수정 form 가져오기
	@GetMapping("dedUpdate.do")
	public String dedUpdForm(
		@RequestParam(name="ddCode", required=true) String ddCode
		, Model model
	) {
		PayDedVO ded = service.retrieveDed(ddCode);
		model.addAttribute("ded", ded);
		return "pay/tmpl/dedForm";
	}
	
	// 공제항목 수정
	@PostMapping("dedUpdate.do")
	public String payUpdate(
		@Validated(UpdateGroup.class) @ModelAttribute("ded") PayDedVO ded
		,@RequestParam(name="ptNo") String ptNo
		, Errors errors
		, Model model
	) {
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyDed(ded);
			switch (result) {
			case OK:
				logicalViewName = "redirect:/pay/dedList.do?ptNo="+ptNo;
				break;

			default:
				message = "수정 중 문제가 발생하였습니다. 잠시 후 다시 시도 부탁드립니다.";
				logicalViewName = "pay/tmpl/dedForm";
				break;
			}
		}else {
			logicalViewName = "pay/tmpl/dedForm";
		}
		model.addAttribute("message", message);
		return logicalViewName;
	}
	
	// 지급항목 삭제
	@GetMapping("payDelete.do")
	public String payDelete(
			  @RequestParam("pyCode") String pyCode
			, @RequestParam(name="ptNo") String ptNo
			, RedirectAttributes redirectAttributes
	) {
		ServiceResult result = service.removePay(pyCode);
		if(ServiceResult.OK.equals(result)) {
			logicalViewName = "redirect:/pay/payList.do?ptNo="+ptNo;
		}else {
			redirectAttributes.addFlashAttribute("message", "삭제 중 문제가 발생하였습니다. 잠시 후 다시 시도 부탁드립니다.");
			logicalViewName = "redirect:/pay/payList.do?ptNo="+ptNo;
		}
		return logicalViewName;
	}
	
	// 공제항목 삭제
	@GetMapping("dedDelete.do")
	public String dedDelete(
			  @RequestParam("ddCode") String ddCode
			, @RequestParam(name="ptNo") String ptNo
			, RedirectAttributes redirectAttributes
	) {
		ServiceResult result = service.removeDed(ddCode);
		if(ServiceResult.OK.equals(result)) {
			logicalViewName = "redirect:/pay/dedList.do?ptNo="+ptNo;
		}else {
			redirectAttributes.addFlashAttribute("message", "삭제 중 문제가 발생하였습니다. 잠시 후 다시 시도 부탁드립니다.");
			logicalViewName = "redirect:/pay/dedList.do?ptNo="+ptNo; 
		}
		return logicalViewName;
	}
	
	//--------------------------------------------------------------------
	//템플릿 별 항목 사용 여부 설정 via toggle change
	
	//항목 사용 등록
	@GetMapping("ptmakeInsert.do")
	@ResponseBody
	public String ptmakeIns(
		@ModelAttribute("ptm") PtMakeVO ptm
	) {
		ServiceResult result = ptmService.createPtMake(ptm);
		
		if(ServiceResult.OK.equals(result)) { 
			return "SUCCESS";
		}else {
			return "FAIL";
		}
	}
	
	//항목 사용 삭제
	@GetMapping("ptmakeDelete.do")
	@ResponseBody
	public String ptmakeDel(
		@ModelAttribute("ptm") PtMakeVO ptm
	) {
		ServiceResult result = ptmService.removePtMake(ptm);
		
		if(ServiceResult.OK.equals(result)) { 
			return "SUCCESS";
		}else {
			return "FAIL";
		}
	}


}
