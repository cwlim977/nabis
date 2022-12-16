package kr.or.ddit.dept.controller;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.dept.service.DeptService;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.commons.validate.InsertGroup;
import kr.or.ddit.vo.DeptVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/dept/deptInsert.do")
public class DeptInsertController {

	@Inject
	private DeptService service;
	
	@ModelAttribute("command")
	public String command() {
		return "INSERT";
	}
	
	@PostMapping
	@GetMapping
	public String doPost(
		@Validated(InsertGroup.class) @ModelAttribute("jsonData") String jsonData
		, BindingResult errors
		, Model model
	) {
		
		String logicalViewName = null;
		DeptVO dept = new DeptVO();
		
		System.out.println("가져오기"+jsonData);
				
		JSONArray jsonArray = new JSONArray(jsonData);
		for(int i=0; i<jsonArray.length(); i++) {
			
			dept = new DeptVO();
			JSONObject jsonObject = jsonArray.getJSONObject(i);

			String dcode =jsonObject.get("id").toString().trim();
			String dnm =jsonObject.get("text").toString().trim();
			String uprDcode =jsonObject.get("parent").toString().trim();

			if (uprDcode.equals("#")) uprDcode=""; 
			
			dept.setDcode(dcode);
			dept.setDnm(dnm);
			dept.setUprDcode(uprDcode);
		
		
		if(!errors.hasErrors()) {
			log.info("여기 test1 {}", dept);
			ServiceResult result = service.createDept(dept);
			log.info("여기 test2 {}", dept);
			switch (result) {
			case PKDUPLICATED:
				model.addAttribute("message", "코드 중복");
				logicalViewName = "dept/depttest";
				break;
			case OK:
				System.out.println("ok");
				logicalViewName = "redirect:/dept/deptList.do";
				break;

			default:
				System.out.println("fail");
				model.addAttribute("message", "서버 오류, 쫌따 다시 하셈.");
				logicalViewName = "dept/depttest";
				break;
			}
		}else {
			logicalViewName = "dept/depttest";
		}
	}
		return logicalViewName;
	}
}
