package kr.or.ddit.home.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/home")
	public class TodoController {
	
	@GetMapping(value="/todo/inbox.do")
	public String inbox() {
		return "home/todo/inbox";
	}
	
	@GetMapping(value="/todo/sent.do")
	public String sent() {
		return "home/todo/sent";
	}
}