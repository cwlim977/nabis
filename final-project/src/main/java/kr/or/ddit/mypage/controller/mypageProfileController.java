package kr.or.ddit.mypage.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.mypage.service.MypageService;
import kr.or.ddit.mypage.service.MypageServiceImpl;
import kr.or.ddit.vo.EmpVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequiredArgsConstructor
@Controller
public class mypageProfileController {
	@Inject
	private final MypageService service;
	

	@PostMapping(value="/mypage/updateEmpImg.do")
	public String updateEmpImg(
			@ModelAttribute("emp") EmpVO emp
			, Model model
			, Errors errors
			, HttpServletRequest request
			, HttpSession session
			) {
		
		log.info("img controller 넘어옴 {}", emp);
		String imagePath = request.getServletContext().getRealPath("/resources/empImages/");	
		
		log.info("imagePath {}",imagePath);
		
		

		Map<String, Object> empList = new HashMap<String, Object>();
		empList.put("emp", emp);
		empList.put("realPath", imagePath);
		
		int result =  service.updateEmpImg(empList);
		
		if(result > 0) {
			EmpVO empVO = service.selectEmp(((EmpVO) empList.get("emp")).getEmpNo());
			session.setAttribute("authEmp", empVO);
		}
		
		
		String logicalViewName = null;
		
		 if(!errors.hasErrors()) {
		
		
		 switch (result) {
        case 1:
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
    
		
		
		return logicalViewName ;
	}
	
	
	
	@PostMapping(value="/mypage/deleteEmpImg.do" ,produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public int deleteEmpImg(
			@RequestParam String empNo 
			
			) {
		
		int result =  service.deleteEmpImg(empNo);
		
		
		return result;
	}
	

	
}
