package kr.or.ddit.duty.controller;

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
import kr.or.ddit.duty.service.DutyService;
import kr.or.ddit.vo.DutyVO;

@Controller
@RequestMapping("/duty/dutySave.do")
public class DutySaveController {
	@Inject
	private DutyService service;
	
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
		DutyVO duty = new DutyVO();
		
		System.out.println("left가져오기"+jsonLeftData);
		System.out.println("mid가져오기"+jsonMidData);
		System.out.println("right가져오기"+jsonRightData);
		
		JSONArray jsonLeftArray = new JSONArray(jsonLeftData);
		JSONArray jsonMidArray = new JSONArray(jsonMidData);
		JSONArray jsonRightArray = new JSONArray(jsonRightData);
		
		// left removeDuty
		if(jsonLeftArray.length() > 0) {
			for(int i=0; i<jsonLeftArray.length(); i++) {
				
				JSONObject jsonObject = jsonLeftArray.getJSONObject(i);
				String dtcode =jsonObject.get("id").toString().trim();
	
				if(!errors.hasErrors()) {
					ServiceResult result = service.removeDuty(dtcode);
					switch (result) {
					case PKDUPLICATED:
						model.addAttribute("message", "코드 중복");
						logicalViewName = "jsonView";
						break;
					case OK:
						System.out.println("ok");
						logicalViewName = "redirect:/duty/dutyList.do";
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
		} // -- end left removeDuty end --
		
		// mid modifyDuty
		if(jsonMidArray.length() > 0) {
			for(int i=0; i<jsonMidArray.length(); i++) {
				
				duty = new DutyVO();
				JSONObject jsonObject = jsonMidArray.getJSONObject(i);
	
				String dtcode =jsonObject.get("id").toString().trim();
				String dtnm =jsonObject.get("text").toString().trim();
				String uprDtcode =jsonObject.get("parent").toString().trim();
	
				if (uprDtcode.equals("#")) uprDtcode=""; 
				
				duty.setDtcode(dtcode);
				duty.setDtnm(dtnm);
//				duty.setUprptnCode(uprPtnCode);
				
				if(!errors.hasErrors()) {
					ServiceResult result = service.modifyDuty(duty);
					switch (result) {
					case OK:
						System.out.println("ok");
						logicalViewName = "redirect:/duty/dutyList.do";
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
		} // -- end mid modifyDuty end --
		
		// right createDuty
		if(jsonRightArray.length() > 0) {
			for(int i=0; i<jsonRightArray.length(); i++) {
				duty = new DutyVO();
				JSONObject jsonObject = jsonRightArray.getJSONObject(i);
	
				String dtcode =jsonObject.get("id").toString().trim();
				String dtnm =jsonObject.get("text").toString().trim();
//				String uprptnCode =jsonObject.get("parent").toString().trim();
	
//				if (uprptnCode.equals("#")) uprptnCode=""; 
				
				duty.setDtcode(dtcode);
				duty.setDtnm(dtnm);
//				duty.setUprptnCode(uprptnCode);
			
				if(!errors.hasErrors()) {
					ServiceResult result = service.createDuty(duty);
					switch (result) {
					case PKDUPLICATED:
						model.addAttribute("message", "코드 중복");
						logicalViewName = "jsonView";
						break;
					case OK:
						System.out.println("ok");
						logicalViewName = "redirect:/duty/dutyList.do";
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
		}// -- end mid modifyDuty end --
		
		return logicalViewName;
	} 
	
}
