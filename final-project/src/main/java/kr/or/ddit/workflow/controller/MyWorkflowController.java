package kr.or.ddit.workflow.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MyWorkflowController {
	
	@GetMapping("/workflow/archive/my.do")
	public String settingMain() {
		return "workflow/archive/my";
	}
	
}
