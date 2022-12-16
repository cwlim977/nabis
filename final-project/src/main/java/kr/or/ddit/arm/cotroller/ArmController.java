package kr.or.ddit.arm.cotroller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.arm.service.ArmService;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.vo.ArmVO;
import kr.or.ddit.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping(value="/arm", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class ArmController {
	
	@Inject
	private ArmService service;
	
	
	@GetMapping("/armList.do")
	@ResponseBody
	public List<ArmVO> notifyList(HttpServletRequest request){
		HttpSession session = request.getSession();
	    String empNo = (((EmpVO)session.getAttribute("authEmp")).getEmpNo());
	    
	    log.info("armList.do 비동기 요청 empNo : {}",empNo);
	    
		return service.retrieveArmList(empNo);
	}
	
	//모든 메세지 읽음처리
	@GetMapping("/armAllRead.do")
	@ResponseBody
	public ServiceResult notifyAllRead(HttpServletRequest request){
		HttpSession session = request.getSession();
	    String empNo = (((EmpVO)session.getAttribute("authEmp")).getEmpNo());
	    
	    log.info("armAllRead.do 비동기 요청 empNo : {}",empNo);
	    
		ServiceResult result = service.modifyAllArm(empNo);
		return result;
	}
	//메세지 하나 읽음 처리
	@PostMapping("/armRead.do")
	@ResponseBody
	public ServiceResult notifyRead(@RequestParam(required=true) String armNo){
		ServiceResult result = service.modifyArm(armNo);
		return result;
	}
	//알림 하나 제거
	@PostMapping("/armDelete.do")
	@ResponseBody
	public ServiceResult notifyDelete(@RequestParam(required=true) String armNo){
    	ServiceResult result = service.removeArm(armNo);
		return result;
	}
	//알림 전부 제거
	@PostMapping("/armAllDelete.do")
	@ResponseBody
	public ServiceResult notifyAllDelete(HttpServletRequest request){
		HttpSession session = request.getSession();
	    String empNo = (((EmpVO)session.getAttribute("authEmp")).getEmpNo());
	    
    	ServiceResult result = service.removeAllArm(empNo);
		return result;
	}
}
