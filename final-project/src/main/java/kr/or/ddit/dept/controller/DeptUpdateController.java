package kr.or.ddit.dept.controller;

import javax.inject.Inject;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.util.JSONPObject;
import com.lowagie.text.List;

import kr.or.ddit.dept.service.DeptService;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.commons.validate.UpdateGroup;
import kr.or.ddit.vo.DeptVO;

@Controller
@RequestMapping("/dept/deptUpdate.do")
public class DeptUpdateController {
	
	@Inject
	private DeptService service;
	
	@ModelAttribute("command")
	public String command() {
		return "UPDATE";
	}
	
	@PostMapping
	@GetMapping
	public String doPost(
		@Validated(UpdateGroup.class) @ModelAttribute("jsonData") String jsonData
		, BindingResult errors
		, Model model
	) {
		String logicalViewName = null;
		DeptVO dept = new DeptVO();
		
		System.out.println("가져오기"+jsonData);
		System.out.println("타입: "+jsonData.getClass().getName());
		//jsonData를 deptVO에 담아서 service한다
		
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
				ServiceResult result = service.modifyDept(dept);
				switch (result) {
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
