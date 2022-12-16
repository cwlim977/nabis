package kr.or.ddit.setting.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginHistroyController {
	
	@GetMapping("/setting/loginHistroy.do")
	public String loginHistroy() {
		return "setting/loginHistroy";
	}
	
}
