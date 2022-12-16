package kr.or.ddit.pay.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WithholdUpdateController {
	@RequestMapping(value="/pay/withhold.do")
	public String wageRes() {
		return "pay/sett/withhold";
	}
}
