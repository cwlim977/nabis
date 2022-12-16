package kr.or.ddit.notice.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.WebApplicationContext;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.commons.validate.InsertGroup;
import kr.or.ddit.notice.event.NewNoticeEvent;
import kr.or.ddit.notice.service.NoticeService;
import kr.or.ddit.vo.NoticeVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/notice/noticeInsert.do")
public class NoticeInsertController {
	private final NoticeService service; //inject 안붙여도 lombok 사용해서 상수화
	@Inject
	private WebApplicationContext context; //이벤트 만들기 위해 추가
	
	@ModelAttribute("notice") //handler 어댑터가 미리 만듦 , get메소드 실행할때 이거먼저실행해서 모델 형성후 + boardForm 실행함 , 비어있는 객체일지라도 view로 board라는 vo만든다.
	public NoticeVO notice() {
		log.info("@ModelAttribute 메소드 실행.");
		return new NoticeVO();
	}
	
//	@RequestMapping(method=RequestMethod.GET)
	@GetMapping
	public String noticeForm() {
		log.info("Get 메소드 핸들러 noticeForm 실행");
		return "/notice/noticeForm"; //logicalViewName adapter->viewResolve로 전달
	}
	
	
	@PostMapping
	public String noticeInsert( @RequestHeader("referer")String referer, 
			@Validated(InsertGroup.class) //group info 설정하려면 validated, 아니면 걍 valid
			@ModelAttribute("notice") NoticeVO notice //command object (클라이언트가 보내는 파라미터 다 vo에 넣어버림)이자 modelattribute로 사용한다 (꺼낼때 board라는 이름으로써야함~)
			,Errors errors //경우에 따라서 binding~으로하기도 , errors 검증결과받을때는 검증할 타겟 바로 다음에 써야한다. (여러개 검증할때 식별성 위해)
			,Model model
	) { 
//		board.getBoFiles(); //list로 묶고 다시 넣어
		
		log.info("Post 메소드 핸들러 noticeInsert 실행");
		String viewName = null;
		if(!errors.hasErrors()) {
			ServiceResult result = service.createNotice(notice);
			if(ServiceResult.OK.equals(result)) {
				log.info("등록 성공?");
//				viewName = "redirect:/notice/noticeView.do?what="+notice.getPostNo(); //mybatis에서 생성한 boNo
//				viewName = "redirect:/notice/noticeList.do";
				viewName =  "redirect:"+ referer; // 이전 페이지로 리다이렉트
				NewNoticeEvent event = new NewNoticeEvent(notice); //이벤트만들기
				context.publishEvent(event);
				log.info("등록 성공!");
			}else {
				log.info("등록 실패");
				String message = "등록 실패";
				model.addAttribute("message", message); //vo말고 다른 것도 보내야해서 model에 넣는다
				viewName = "notice/noticeForm"; //실패하면 입력한 boardVO와 model(message)가지고 돌아간다.
			}
		}else {
			System.out.println(errors);
			viewName = "notice/noticeForm";
		}
		return viewName;
	}
}