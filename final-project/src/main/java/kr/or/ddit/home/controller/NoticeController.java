package kr.or.ddit.home.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/home")
	public class NoticeController {
	
		@GetMapping(value = "/notice.do")
		public String notice() {
			return "home/notice";
		}
}
