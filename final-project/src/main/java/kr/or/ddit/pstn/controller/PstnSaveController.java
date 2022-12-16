package kr.or.ddit.pstn.controller;

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
import kr.or.ddit.pstn.service.PstnService;
import kr.or.ddit.vo.PstnVO;
@Controller
@RequestMapping("/pstn/pstnSave.do")
public class PstnSaveController {
	@Inject
	private PstnService service;
	
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
		PstnVO pstn = new PstnVO();
		
		System.out.println("left가져오기"+jsonLeftData);
		System.out.println("mid가져오기"+jsonMidData);
		System.out.println("right가져오기"+jsonRightData);
		
		JSONArray jsonLeftArray = new JSONArray(jsonLeftData);
		JSONArray jsonMidArray = new JSONArray(jsonMidData);
		JSONArray jsonRightArray = new JSONArray(jsonRightData);
		
		// left removePstn
		if(jsonLeftArray.length() > 0) {
			for(int i=0; i<jsonLeftArray.length(); i++) {
				
				JSONObject jsonObject = jsonLeftArray.getJSONObject(i);
				String ptnCode =jsonObject.get("id").toString().trim();
	
				if(!errors.hasErrors()) {
					ServiceResult result = service.removePstn(ptnCode);
					switch (result) {
					case PKDUPLICATED:
						model.addAttribute("message", "코드 중복");
						logicalViewName = "jsonView";
						break;
					case OK:
						System.out.println("ok");
						logicalViewName = "redirect:/pstn/pstnList.do";
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
		} // -- end left removePstn end --
		
		// mid modifyPstn
		if(jsonMidArray.length() > 0) {
			for(int i=0; i<jsonMidArray.length(); i++) {
				
				pstn = new PstnVO();
				JSONObject jsonObject = jsonMidArray.getJSONObject(i);
	
				String ptnCode =jsonObject.get("id").toString().trim();
				String ptnNm =jsonObject.get("text").toString().trim();
				String uprPtnCode =jsonObject.get("parent").toString().trim();
	
				if (uprPtnCode.equals("#")) uprPtnCode=""; 
				
				pstn.setPtnCode(ptnCode);
				pstn.setPtnNm(ptnNm);
//				pstn.setUprptnCode(uprPtnCode);
				
				if(!errors.hasErrors()) {
					ServiceResult result = service.modifyPstn(pstn);
					switch (result) {
					case OK:
						System.out.println("ok");
						logicalViewName = "redirect:/pstn/pstnList.do";
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
		} // -- end mid modifyPstn end --
		
		// right createPstn
		if(jsonRightArray.length() > 0) {
			for(int i=0; i<jsonRightArray.length(); i++) {
				pstn = new PstnVO();
				JSONObject jsonObject = jsonRightArray.getJSONObject(i);
	
				String ptnCode =jsonObject.get("id").toString().trim();
				String ptnNm =jsonObject.get("text").toString().trim();
//				String uprptnCode =jsonObject.get("parent").toString().trim();
	
//				if (uprptnCode.equals("#")) uprptnCode=""; 
				
				pstn.setPtnCode(ptnCode);
				pstn.setPtnNm(ptnNm);
//				pstn.setUprptnCode(uprptnCode);
			
				if(!errors.hasErrors()) {
					ServiceResult result = service.createPstn(pstn);
					switch (result) {
					case PKDUPLICATED:
						model.addAttribute("message", "코드 중복");
						logicalViewName = "jsonView";
						break;
					case OK:
						System.out.println("ok");
						logicalViewName = "redirect:/pstn/pstnList.do";
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
		}// -- end mid modifyPstn end --
		
		return logicalViewName;
	} 
	
}
