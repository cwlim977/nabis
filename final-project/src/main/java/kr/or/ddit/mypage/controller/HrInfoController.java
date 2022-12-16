package kr.or.ddit.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.emp.service.EmpService;
import kr.or.ddit.mypage.service.MypageService;
import kr.or.ddit.vo.AsgmtVO;
import kr.or.ddit.vo.CmcodeVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.OwnJobVO;
import kr.or.ddit.work.dao.WorkDAO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class HrInfoController {

	//인사정보 조회, 정보변경 내역 조회, 근무시간 조회, 남은연차 조회
	private final MypageService service;
	
	private final EmpService empService;
	
	private final WorkDAO workDao;
	

	@ModelAttribute("asgmt")
	public AsgmtVO asgmt() {
		return new AsgmtVO();
	}

	
	@ModelAttribute("ownJob")
	public OwnJobVO ownJob() {
		return new OwnJobVO();
	}
	
	
	
	//인사정보 조회, 정보변경 내역 조회, 근무시간 조회, 남은연차 조회
	@RequestMapping(value="/mypage/hrInfoRetrieve.do")
	public String hrInfoRetrieve(
			@RequestParam(name="empNo" , required=true )String empNo,
			Model model) {

		EmpVO hrInfo = service.selectEmp(empNo);
		List<CmcodeVO> labelList = service.selectLabel();
		
		//근무시간 조회
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("empNo", empNo);
		paramMap.put("num", "0");
		int workTime = workDao.selectWorkApWeekTime(paramMap);
			
		
		log.info("hrInfoRetrieve.do hrInfo : {}, labelList : {}",hrInfo, labelList );
		model.addAttribute("empVo", hrInfo);
		model.addAttribute("labelList", labelList);
		model.addAttribute("workTime", workTime);

		return "mypage/hrInfoList";
	}
	

	
	//기본정보변경을 눌렀을 때 ajax input에 데이터를 보여주는  
	@RequestMapping(value="/mypage/hrInfoview.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public EmpVO hrInfoView(
			@RequestParam( name="empNo", required=true )String empNo
			) {
		EmpVO hrInfo = service.selectEmp(empNo);
		
		return hrInfo ;
	}
	
	
	
	// 인사정보 추가
	@PostMapping(value="/mypage/hrInfoInsert.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> hrInfoInsert(
			@RequestBody @Validated AsgmtVO asgmtVo
			, HttpServletRequest request
		) {
		
		log.info("hrInfoInsert 요청 파라미터 {}", asgmtVo);
		
		// 인사발령 작성자를 기록하기위해 세션에서 아이디를 꺼내 변수에 저장한다.
		HttpSession session = request.getSession();
		asgmtVo.setWriter(((EmpVO)session.getAttribute("authEmp")).getEmpNo());
		
		String status = "fail";
		
		ServiceResult result = empService.createAsgmt(asgmtVo);
		log.info("createAsgmt() result 값 {}",result );
		
		switch (result) {
			case OK:
				status = "success";
				break;
			case FAIL:
				status = "fail";
				break;
			default:
				status = "fail";
				break;
		}
		
		Map<String, Object> jsonDate = new HashMap<String, Object>();
		jsonDate.put("status", status);
		return jsonDate;
	}
	
	// 인사발령예정 취소
	@PostMapping(value="/mypage/hrInfoCancel.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> hrInfoCancel(
			AsgmtVO asgmtVo
		) {
		log.info("hrInfoCancel 요청 파라미터 {}", asgmtVo);
		
		String status = "fail";
		
		ServiceResult result = empService.cancelAsgmt(asgmtVo);
		log.info("cancelAsgmt() result 값 {}",result );
		
		switch (result) {
			case OK:
				status = "success";
				break;
			case FAIL:
				status = "fail";
				break;
			default:
				status = "fail";
				break;
		}
		
		Map<String, Object> jsonDate = new HashMap<String, Object>();
		jsonDate.put("status", status);
		return jsonDate;
	}	
	
	
	
		
  // 휴직,퇴직, 인사정보 수정  @Validated(UpdateGroup.class)
  @RequestMapping(value="/mypage/hrInfoUpdate.do")
   public String hrInfoUpdate( 
		   @ModelAttribute("emp") EmpVO emp
		   , Errors errors
		   , Model model


		   ) {
	  
	  
	  log.info("conroller emp 값 {}",emp);
	  
	  
	  
	   String logicalViewName = null;
	      if(!errors.hasErrors()) {
	    	  
	    	  ServiceResult result = service.updateEmp(emp);
	    	
	    	  log.info("update result 값 {}",result );
	    	  
	      
	         switch (result) {
	         case OK:
	            logicalViewName = "redirect:/mypage/hrInfoRetrieve.do?empNo="+emp.getEmpNo();
	            break;

	         default:
	        	 model.addAttribute("message", "서버오류가 발생했습니다. 다시 시도해 주세요.");
	            logicalViewName = "redirect:/mypage/hrInfoRetrieve.do?empNo="+emp.getEmpNo();
	            break;
	         }
	      }else {
	         logicalViewName = "redirect:/mypage/hrInfoRetrieve.do?empNo="+emp.getEmpNo();
	      }
	      return logicalViewName;
   }
		   
	
  
	
}
