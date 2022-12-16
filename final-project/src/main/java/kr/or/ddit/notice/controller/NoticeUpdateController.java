package kr.or.ddit.notice.controller;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.commons.validate.UpdateGroup;
import kr.or.ddit.notice.service.NoticeService;
import kr.or.ddit.vo.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notice/noticeUpdate.do")
public class NoticeUpdateController {
	private final NoticeService service;
	@Inject
	public NoticeUpdateController(NoticeService service) {
		super();
		this.service = service;
	}

	@GetMapping
	public String updateForm(
		@RequestParam(name="what", required=true) int postNo
		, Model model
	) {
		log.info("updateController GET 호출");
		NoticeVO notice = service.retrieveNotice(postNo);
		model.addAttribute("notice", notice);
		log.info("update View 확인 {}",notice);
		return "/notice/noticeEdit";	//tiles안받기 위해/추가
	}
	
	@PostMapping
	public String noticeUpdate(
		@Validated(UpdateGroup.class) @ModelAttribute("notice") NoticeVO notice
		, BindingResult errors
		, Model model
	) {
		log.info("updateController POST 호출");
		String viewName = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.modifyNotice(notice);
			String message = null;
			switch (result) {
//				case INVALIDPASSWORD:
//					message = "비밀번호 오류";
//					viewName = "board/boardEdit";
//					break;
				case OK:
					viewName = "redirect:/notice/noticeList.do";
					break;
				default:
					message = "서버 오류";
					viewName = "notice/noticeEdit";
					break;
			}
			model.addAttribute("message", message);
		}else {
			viewName = "notice/noticeEdit";
		}
		return viewName;
	}
}

















