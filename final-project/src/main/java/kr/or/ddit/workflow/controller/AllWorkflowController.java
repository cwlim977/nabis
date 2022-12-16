package kr.or.ddit.workflow.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AllWorkflowController {
	
	@GetMapping("/workflow/archive/all.do")
	public String settingMain() {
		return "workflow/archive/all";
	}
	
}
