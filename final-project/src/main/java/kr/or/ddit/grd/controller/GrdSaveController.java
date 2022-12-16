package kr.or.ddit.grd.controller;

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
import kr.or.ddit.grd.service.GrdService;
import kr.or.ddit.vo.GrdVO;

@Controller
@RequestMapping("/grd/grdSave.do")
public class GrdSaveController {
	
	@Inject
	private GrdService service;
	
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
		GrdVO grd = new GrdVO();
		
		System.out.println("left가져오기"+jsonLeftData);
		System.out.println("mid가져오기"+jsonMidData);
		System.out.println("right가져오기"+jsonRightData);
		
		JSONArray jsonLeftArray = new JSONArray(jsonLeftData);
		JSONArray jsonMidArray = new JSONArray(jsonMidData);
		JSONArray jsonRightArray = new JSONArray(jsonRightData);
		
		// left removeGrd
		if(jsonLeftArray.length() > 0) {
			for(int i=0; i<jsonLeftArray.length(); i++) {
				
				JSONObject jsonObject = jsonLeftArray.getJSONObject(i);
				String grdCode =jsonObject.get("id").toString().trim();
	
				if(!errors.hasErrors()) {
					ServiceResult result = service.removeGrd(grdCode);
					switch (result) {
					case PKDUPLICATED:
						model.addAttribute("message", "코드 중복");
						logicalViewName = "jsonView";
						break;
					case OK:
						System.out.println("ok");
						logicalViewName = "redirect:/grd/grdList.do";
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
		} // -- end left removeGrd end --
		
		// mid modifyGrd
		if(jsonMidArray.length() > 0) {
			for(int i=0; i<jsonMidArray.length(); i++) {
				
				grd = new GrdVO();
				JSONObject jsonObject = jsonMidArray.getJSONObject(i);
	
				String grdCode =jsonObject.get("id").toString().trim();
				String grdNm =jsonObject.get("text").toString().trim();
				String uprGrdCode =jsonObject.get("parent").toString().trim();
	
				if (uprGrdCode.equals("#")) uprGrdCode=""; 
				
				grd.setGrdCode(grdCode);
				grd.setGrdNm(grdNm);
//				Grd.setUprptnCode(uprPtnCode);
				
				if(!errors.hasErrors()) {
					ServiceResult result = service.modifyGrd(grd);
					switch (result) {
					case OK:
						System.out.println("ok");
						logicalViewName = "redirect:/grd/grdList.do";
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
		} // -- end mid modifyGrd end --
		
		// right createGrd
		if(jsonRightArray.length() > 0) {
			for(int i=0; i<jsonRightArray.length(); i++) {
				grd = new GrdVO();
				JSONObject jsonObject = jsonRightArray.getJSONObject(i);
	
				String grdCode =jsonObject.get("id").toString().trim();
				String grdNm =jsonObject.get("text").toString().trim();
//				String uprptnCode =jsonObject.get("parent").toString().trim();
	
//				if (uprptnCode.equals("#")) uprptnCode=""; 
				
				grd.setGrdCode(grdCode);
				grd.setGrdNm(grdNm);
//				Grd.setUprptnCode(uprptnCode);
			
				if(!errors.hasErrors()) {
					ServiceResult result = service.createGrd(grd);
					switch (result) {
					case PKDUPLICATED:
						model.addAttribute("message", "코드 중복");
						logicalViewName = "jsonView";
						break;
					case OK:
						System.out.println("ok");
						logicalViewName = "redirect:/grd/grdList.do";
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
		}// -- end mid modifyGrd end --
		
		return logicalViewName;
	} 
	
}
