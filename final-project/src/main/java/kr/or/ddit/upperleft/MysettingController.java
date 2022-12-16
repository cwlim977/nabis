package kr.or.ddit.upperleft;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MysettingController {
	
	@RequestMapping(value="/mySetting.do")
	public String mySetting(
		@RequestParam(name="my_setting_tab", defaultValue="Root") String tabName
	) {
		return "upperleft/mySettingTab"+tabName;
	}
}
