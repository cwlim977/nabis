package kr.or.ddit.workflow.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WorkflowWriteController {
	
	@GetMapping("/workflow/write/templates.do")
	public String settingMain() {
		return "workflow/write/templates";
	}
	
}
