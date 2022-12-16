package kr.or.ddit.dept.controller;

import javax.inject.Inject;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.commons.validate.InsertGroup;
import kr.or.ddit.dept.service.DeptService;
import kr.or.ddit.vo.DeptVO;


@Controller
@RequestMapping("/dept/deptDelete.do")
public class DeptDeleteController {
	
	@Inject
	private DeptService service;
	
	@ModelAttribute("command")
	public String command() {
		return "DELETE";
	}
	
	@PostMapping
	@GetMapping
	public String doPost(
		@ModelAttribute("jsonData") String jsonData
		, BindingResult errors
		, Model model
	) {
		
		String logicalViewName = null;
		
		System.out.println("left가져오기"+jsonData);
				
		JSONArray jsonArray = new JSONArray(jsonData);
		if(jsonArray.length() > 0) {
		for(int i=0; i<jsonArray.length(); i++) {
			
			JSONObject jsonObject = jsonArray.getJSONObject(i);

			String dcode =jsonObject.get("id").toString().trim();

		
		if(!errors.hasErrors()) {
			ServiceResult result = service.removeDept(dcode);
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
		}
		return logicalViewName;
	}
}