package kr.or.ddit.dept.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.dept.service.DeptService;
import kr.or.ddit.vo.DeptVO;

@Controller
@RequestMapping("/dept")
public class DeptRetrieveController {
	
	@Inject
	private DeptService service;
	
	@RequestMapping("deptList.do")
	public String deptList(
		Model model
	) {
		List<DeptVO> deptList = service.retrieveDeptList();
		model.addAttribute("deptList", deptList);
		
		return "dept/depttest";
	}
	
	@ResponseBody
	@GetMapping(value="deptList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<DeptVO> deptLoad() {
		
		List<DeptVO> deptList = service.retrieveDeptList();
		
		return deptList;
	}
	
}
