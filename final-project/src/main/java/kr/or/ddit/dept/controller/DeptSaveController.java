package kr.or.ddit.dept.controller;

import javax.inject.Inject;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.commons.validate.UpdateGroup;
import kr.or.ddit.dept.service.DeptService;
import kr.or.ddit.vo.DeptVO;

@Controller
@RequestMapping("/dept/deptSave.do")
public class DeptSaveController {
	@Inject
	private DeptService service;
	
	@PostMapping
	@ResponseBody
	public String doPost(
		@Validated(UpdateGroup.class) 
		@ModelAttribute("jsonLeftData") String jsonLeftData
		,@ModelAttribute("jsonMidData") String jsonMidData
		,@ModelAttribute("jsonRightData") String jsonRightData
		, BindingResult errors
		, Model model
	) {
		String logicalViewName = null;
		DeptVO dept = new DeptVO();
		
		System.out.println("left가져오기"+jsonLeftData);
		System.out.println("mid가져오기"+jsonMidData);
		System.out.println("right가져오기"+jsonRightData);
		
		JSONArray jsonLeftArray = new JSONArray(jsonLeftData);
		JSONArray jsonMidArray = new JSONArray(jsonMidData);
		JSONArray jsonRightArray = new JSONArray(jsonRightData);
		
		// left removeDept
		if(jsonLeftArray.length() > 0) {
			for(int i=0; i<jsonLeftArray.length(); i++) {
				
				JSONObject jsonObject = jsonLeftArray.getJSONObject(i);
				String dcode =jsonObject.get("id").toString().trim();
	
				if(!errors.hasErrors()) {
					ServiceResult result = service.removeDept(dcode);
					switch (result) {
					case PKDUPLICATED:
						model.addAttribute("message", "코드 중복");
						logicalViewName = "jsonView";
						break;
					case OK:
						System.out.println("ok");
						logicalViewName = "redirect:/dept/deptList.do";
						break;
		
					default:
						System.out.println("fail");
						model.addAttribute("message", "서버 오류, 쫌따 다시 하셈.");
						logicalViewName = "jsonView";
						break;
					}
				}else {
					logicalViewName = "jsonView";
				}
			}
		} // -- end left removeDept end --
		
		// mid modifyDept
		if(jsonMidArray.length() > 0) {
			for(int i=0; i<jsonMidArray.length(); i++) {
				
				dept = new DeptVO();
				JSONObject jsonObject = jsonMidArray.getJSONObject(i);
	
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
						logicalViewName = "jsonView";
						break;
					}
				}else {
					logicalViewName = "jsonView";
				}
			}
		} // -- end mid modifyDept end --
		
		// right createDept
		if(jsonRightArray.length() > 0) {
			for(int i=0; i<jsonRightArray.length(); i++) {
				dept = new DeptVO();
				JSONObject jsonObject = jsonRightArray.getJSONObject(i);
	
				String dcode =jsonObject.get("id").toString().trim();
				String dnm =jsonObject.get("text").toString().trim();
				String uprDcode =jsonObject.get("parent").toString().trim();
	
				if (uprDcode.equals("#")) uprDcode=""; 
				
				dept.setDcode(dcode);
				dept.setDnm(dnm);
				dept.setUprDcode(uprDcode);
			
				if(!errors.hasErrors()) {
					ServiceResult result = service.createDept(dept);
					switch (result) {
					case PKDUPLICATED:
						model.addAttribute("message", "코드 중복");
						logicalViewName = "jsonView";
						break;
					case OK:
						System.out.println("ok");
						logicalViewName = "redirect:/dept/deptList.do";
						break;
		
					default:
						System.out.println("fail");
						model.addAttribute("message", "서버 오류, 쫌따 다시 하셈.");
						logicalViewName = "jsonView";
						break;
					}
				}else {
					logicalViewName = "jsonView";
				}
			}
		}// -- end mid modifyDept end --
		
		return logicalViewName;
	} 
	
}
