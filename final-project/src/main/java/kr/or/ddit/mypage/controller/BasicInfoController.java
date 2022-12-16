package kr.or.ddit.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.mypage.service.MypageService;
import kr.or.ddit.vo.CmcodeVO;
import kr.or.ddit.vo.EmpFamVO;
import kr.or.ddit.vo.EmpVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class BasicInfoController {

	@Inject
	private final MypageService service;
	
	
	@ModelAttribute("cmCode")
	public CmcodeVO cmCode() {		
		return new CmcodeVO();
	}

	@ModelAttribute("emp")
	public EmpVO emp() {		
		return new EmpVO();
	}
	

	
	//개인정보 조회
	@RequestMapping(value="/mypage/basicInfoRetrieve.do")
	public String basicInfoRetrieve(
			@RequestParam( required=true) String empNo,
			Model model
			) {
		
		EmpVO empVo = service.selectEmp(empNo);
		List<CmcodeVO> bankList = service.bankNmList();
		EmpFamVO famVo = service.selectFamCount(empNo);
		 List<EmpFamVO> famList = service.selectFamList(empNo);
		
		 
		 
		 
		 log.info("famList {}", famList);
		 
		 model.addAttribute("famList", famList);
		model.addAttribute("famVo", famVo);
		model.addAttribute("bankList",bankList);
		model.addAttribute("empVo", empVo);
		
		return "mypage/basicInfoList";
	}
	
	
	
	// 개인정보 form 에 ajax로 값 가져오는 메소드
	@RequestMapping(value="/mypage/basicInfoView.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public EmpVO basicInfoView(
			@RequestParam(name="empNo",required=true ) String empNo
			) {
		
		EmpVO basicInfo = service.selectEmp(empNo);
		
		return basicInfo;
	}
	
	
	
	// 개인정보 추가
	@RequestMapping(value="/mypage/basicInfoInsert.do")
	public String basicInfoInsert() {
		return "empManager/empMypage";
	}
	
	
	
	
		
  // 개인정보 수정 @Validated(UpdateGroup.class)
  @RequestMapping(value="/mypage/basicInfoUpdate.do")
   public String basicInfoUpdate(
		   
		    @ModelAttribute("emp") EmpVO emp 
		   , Errors errors
		   , Model model

		   ) {
	  
	   log.info("basicInfo controller  emp {} ", emp);
	  	String logicalViewName = null;
	      if(!errors.hasErrors()) {
	    	  
	    	  ServiceResult result = service.updateBasicInfo(emp);
	    	
	    	  log.info("update result 값 {}",result );
	    	  
	      
	         switch (result) {
	         case OK:
	            logicalViewName = "redirect:/mypage/basicInfoRetrieve.do?empNo="+emp.getEmpNo();
	            break;

	         default:
	        	
	        	 model.addAttribute("message", "서버오류가 발생했습니다. 다시 시도해 주세요.");
	            logicalViewName = "redirect:/mypage/basicInfoRetrieve.do?empNo="+emp.getEmpNo();
	            break;
	         }
	      }else {
	         logicalViewName = "redirect:/mypage/basicInfoRetrieve.do?empNo="+emp.getEmpNo();
	      }
	      return logicalViewName;
   }
  

  
  
  
   // 가족 정보 추가
   @PostMapping(value="/mypage/empFamInsert.do")
   public String empFamInsert(
		   
		    @ModelAttribute("fam") EmpFamVO fam 
		   , Errors errors
		   , Model model
		   ) {
	   
	 
		String logicalViewName = null;
	      if(!errors.hasErrors()) {
	    	  
	    	  ServiceResult result = service.createEmpFam(fam);
	    	
	    	  log.info("empFam Insert result 값 {}",result);
	    	  
	      
	         switch (result) {
	         case OK:
	            logicalViewName = "redirect:/mypage/basicInfoRetrieve.do?empNo="+fam.getEfamEmpno();
	            break;

	         default:
	        	
	        	 model.addAttribute("message", "서버오류가 발생했습니다. 다시 시도해 주세요.");
	            logicalViewName = "redirect:/mypage/basicInfoRetrieve.do?empNo="+fam.getEfamEmpno();
	            break;
	         }
	      }else {
	         logicalViewName = "redirect:/mypage/basicInfoRetrieve.do?empNo="+fam.getEfamEmpno();
	      }
	      return logicalViewName;
	   
   }
   
   
   
   // 가족정보 수정시 ajax로 가져오기 
   @GetMapping(value="/mypage/basicFamView.do" , produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
   @ResponseBody
   public EmpFamVO selectFamView(
		   @RequestParam(name="efamNo" ,required=true) String efamNo
		   ) {
	   
	   log.info("가족정보 controller efamNo {}", efamNo);
	   
	   EmpFamVO fam = service.selectFamView(efamNo);
	   
	   
	   log.info("가족정보 controller 결과 fam : {}", fam);
	   
	   return fam;
   }
	   
   
   // 가족정보 수정
   @PostMapping(value="/mypage/empFamUpdate.do" ,produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
   @ResponseBody
   public int empFamUpdate(
		   @ModelAttribute EmpFamVO fam,
		   Model model,
		   Errors errors
		   
		   ){
	   
	   log.info("famupdate fam 값  : {}", fam);
	   
	   int result = service.updateEmpFam(fam);
/*	   String logicalViewName = null;
	   if(!errors.hasErrors()) {
	   
		   switch (result) {
		   
	       case OK:
	    	
	          logicalViewName = "redirect:/mypage/basicInfoRetrieve.do?empNo="+fam.getEfamEmpno();
	          break;
	
	       default:
	      	
	      	  model.addAttribute("message", "서버오류가 발생했습니다. 다시 시도해 주세요.");
	          logicalViewName = "redirect:/mypage/basicInfoRetrieve.do?empNo="+fam.getEfamEmpno();
	          break;
		       }
	    }else {
	       logicalViewName = "redirect:/mypage/basicInfoRetrieve.do?empNo="+fam.getEfamEmpno();
	    }
	    return logicalViewName;*/
		   
       return result;
   }
   
   // 가족 정보 삭제(null 업데이트)
   @PostMapping(value="/mypage/deleteEmpFam.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
   @ResponseBody
   public Map<String, Object> deleteEmpFam(
		   EmpFamVO efam
		   ){

	   Map<String, Object> eFamMap = new HashMap<String, Object>();
	   
	   log.info("가족정보 삭제 controller에서 받은 efamEmpno 값 {} ",efam.getEfamEmpno()); 
	   
	   int result = service.deleteEmpFam(efam.getEfamNo());
	   
	   if(result == 1) {
		   efam = service.selectFamCount(efam.getEfamEmpno());
		   
		   eFamMap.put("deleteResult", result);
		   eFamMap.put("efam", efam);
		   
	   }
	   eFamMap.put("deleteResult", result);
	   
	   return eFamMap;
   }
}

