package kr.or.ddit.job.controller;

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
import kr.or.ddit.job.service.JobService;
import kr.or.ddit.vo.JobVO;

@Controller
@RequestMapping("/job/jobSave.do")
public class JobSaveController {
	@Inject
	private JobService service;
	
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
		JobVO job = new JobVO();
		
		System.out.println("left가져오기"+jsonLeftData);
		System.out.println("mid가져오기"+jsonMidData);
		System.out.println("right가져오기"+jsonRightData);
		
		JSONArray jsonLeftArray = new JSONArray(jsonLeftData);
		JSONArray jsonMidArray = new JSONArray(jsonMidData);
		JSONArray jsonRightArray = new JSONArray(jsonRightData);
		
		// left removeJob
		if(jsonLeftArray.length() > 0) {
			for(int i=0; i<jsonLeftArray.length(); i++) {
				
				JSONObject jsonObject = jsonLeftArray.getJSONObject(i);
				String jcode =jsonObject.get("id").toString().trim();
	
				if(!errors.hasErrors()) {
					ServiceResult result = service.removeJob(jcode);
					switch (result) {
					case PKDUPLICATED:
						model.addAttribute("message", "코드 중복");
						logicalViewName = "jsonView";
						break;
					case OK:
						System.out.println("ok");
						logicalViewName = "redirect:/job/jobList.do";
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
		} // -- end left removeJob end --
		
		// mid modifyJob
		if(jsonMidArray.length() > 0) {
			for(int i=0; i<jsonMidArray.length(); i++) {
				
				job = new JobVO();
				JSONObject jsonObject = jsonMidArray.getJSONObject(i);
	
				String jcode =jsonObject.get("id").toString().trim();
				String jnm =jsonObject.get("text").toString().trim();
				String uprJcode =jsonObject.get("parent").toString().trim();
	
				if (uprJcode.equals("#")) uprJcode=""; 
				
				job.setJcode(jcode);
				job.setJnm(jnm);
//				job.setUprptnCode(uprPtnCode);
				
				if(!errors.hasErrors()) {
					ServiceResult result = service.modifyJob(job);
					switch (result) {
					case OK:
						System.out.println("ok");
						logicalViewName = "redirect:/job/jobList.do";
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
		} // -- end mid modifyJob end --
		
		// right createJob
		if(jsonRightArray.length() > 0) {
			for(int i=0; i<jsonRightArray.length(); i++) {
				job = new JobVO();
				JSONObject jsonObject = jsonRightArray.getJSONObject(i);
	
				String jcode =jsonObject.get("id").toString().trim();
				String jnm =jsonObject.get("text").toString().trim();
//				String uprptnCode =jsonObject.get("parent").toString().trim();
	
//				if (uprptnCode.equals("#")) uprptnCode=""; 
				
				job.setJcode(jcode);
				job.setJnm(jnm);
//				job.setUprptnCode(uprptnCode);
			
				if(!errors.hasErrors()) {
					ServiceResult result = service.createJob(job);
					switch (result) {
					case PKDUPLICATED:
						model.addAttribute("message", "코드 중복");
						logicalViewName = "jsonView";
						break;
					case OK:
						System.out.println("ok");
						logicalViewName = "redirect:/job/jobList.do";
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
		}// -- end mid modifyJob end --
		
		return logicalViewName;
	} 
	
}
