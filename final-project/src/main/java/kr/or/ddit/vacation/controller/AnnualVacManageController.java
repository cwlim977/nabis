package kr.or.ddit.vacation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/memberVacation")
public class AnnualVacManageController {
	@GetMapping("annualVacManageView.do")
	public String annualVacManageList() {
		return "vacation/annualVacManage";
	}
	@GetMapping("annualVacBatchAdjustment.do")
	public String annualVacBatchAdjustment() {
		return "vacation/annualVacBatchAdjustment";
	}
	@GetMapping("annualVacAdjustmentHistory.do")
	public String annualVacAdjustmentHistory() {
		return "vacation/annualVacAdjustmentHistory";
	}
	@PostMapping("annualVacManageInsert.do")
	public String annualVacManageInsert() {
		return "vacation/annualVacManage";
	}
}
