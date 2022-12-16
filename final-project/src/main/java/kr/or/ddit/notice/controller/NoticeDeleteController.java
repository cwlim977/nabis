package kr.or.ddit.notice.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.commons.validate.DeleteGroup;
import kr.or.ddit.notice.service.NoticeService;
import kr.or.ddit.vo.NoticeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class NoticeDeleteController {
	
	private final NoticeService service;
	
	@PostMapping(value="/notice/noticeDelete.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String,Object> noticeDelete( 
			@Validated(DeleteGroup.class) NoticeVO notice
			, BindingResult errors
	) { 
		log.info("noticeDelete호출");
		String message = null;
		if(!errors.hasErrors()) {
			ServiceResult result =service.removeNotice(notice);
			switch(result) {
			case OK :
				message = "ok";
				break;
			default :
				message = "fail";
				break;
			}
		}else {
			message = "fail";
		}
		Map<String,Object> map = new HashMap<>();
		map.put("message", message);
		return map;
	}
	
}
