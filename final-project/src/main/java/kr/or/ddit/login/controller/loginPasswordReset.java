package kr.or.ddit.login.controller;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.login.dao.loginDAO;
import kr.or.ddit.login.service.pwService;
import kr.or.ddit.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/login")
public class loginPasswordReset {
	
	@Inject
	private loginDAO dao;
	@Inject
	private pwService service;
	
	
	@GetMapping(value = "regCheck.do",  produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public EmpVO empView(@RequestParam String empNo 
			) {
		log.info("get 넘어옴");
		EmpVO emp = new EmpVO();
		
			log.info("empNo확인{}",empNo);
			
			emp = dao.findIdByEmpNo(empNo);
			log.info("empVo확인{}",emp);
		
		return emp;
	}
	
	@PostMapping(value ="passwordReset.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public String loginProcess(
		@RequestParam String empPass, @RequestParam String empNo 
	){
		log.info("post 넘어옴");
		log.info("empPass확인{}",empPass);
		log.info("empNo확인{}",empNo);

		String viewName = null;
		
		EmpVO emp = new EmpVO();
		
			emp.setEmpPass(empPass);
			emp.setEmpNo(empNo);
			
			service.modifyEmpPass(emp);
			
			viewName = "login";
		
		return viewName;
		
	}
	
}
















