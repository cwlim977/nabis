package kr.or.ddit.notice.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.notice.dao.NoticeDAO;
import kr.or.ddit.notice.service.NoticeService;
import kr.or.ddit.vo.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notice")
public class NoticeRetrieveController {
private NoticeService service; //new 안씀 container가 의존관계 가져감
	@Inject
	NoticeDAO dao;
	@Inject
	public void setService(NoticeService service) {
		this.service = service;
		log.info("주입된 business login : {}", service.getClass().getName());
	}
	
	//껍데기 UI 제공
	@RequestMapping(value="noticeList.do", method=RequestMethod.GET) //계층구조 나중에알아서 / 붙는다
	public String listUI(Model model) {
		int noticeCnt = dao.selectNoticeCnt();
		model.addAttribute("noticeCnt", noticeCnt);
		return "notice/noticeList";
	}	
	
	//껍데기 UI 제공
//	@RequestMapping(value="noticeList.do", method=RequestMethod.GET) //계층구조 나중에알아서 / 붙는다
//	public String listUI(Model model) {
//		List<NoticeVO> noticeList = service.retrieveNoticeList();
//		model.addAttribute("noticeList", noticeList); 
//		return "home/notice";
//	}
	
	@RequestMapping(value="noticeList.do", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE) //JSON으로 내보내야하는 controller
	@ResponseBody
	public List<NoticeVO> list() {
		List<NoticeVO> noticeList = service.retrieveNoticeList();
		log.info("여기 test1 {}", noticeList);
		return noticeList;
	}
	
//	@RequestMapping(value="noticeList.do", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE) //JSON으로 내보내야하는 controller
//	@ResponseBody
//	public PagingVO<BoardVO> list(
//			@RequestParam(name="page", required=false, defaultValue="1") int currentPage
////			,@RequestParam(name="searchType", required=false) String searchType
////			,@RequestParam(name="searchWord", required=false) String searchWord
//			,@ModelAttribute("simpleCondition") SearchVO simpleCondition
////			,Model model
//			
//	) { //page로 넘어온 것 currnetPage로 받는다
//		
////		SearchVO simpleCondition = new SearchVO(searchType, searchWord); request에 저렇게 넣어버리면 얘가 어떻게든 찾아서 넣어줌 우리가 이 작업 할필요 없다
//
//		PagingVO<BoardVO> pagingVO = new PagingVO<>(10,5);
//		
//		pagingVO.setCurrentPage(currentPage);
//		pagingVO.setSimpleCondition(simpleCondition);
//		
//		int totalRecord = service.retrieveBoardCount(pagingVO);
//		pagingVO.setTotalRecord(totalRecord);
//		List<BoardVO> noticeList = service.retrievenoticeList(pagingVO);
//		pagingVO.setDataList(noticeList);
//		
////		model.addAttribute("pagingVO", pagingVO); -- pagingVO가 responsebody 응답데이터 자체가 되니까 따로 model 사용 x
//		
////		return "board/noticeList";
//		return pagingVO; //마샬링의 대상 (얘가 json으로 나가야하니까 이걸로 리턴시킨다) , viewresolve로 처리안함, 얘는 비동기, 프론트단에서 결정함
//	}
	
	@GetMapping(value="noticeView.do" , produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public NoticeVO noticeView(@RequestParam(name="what", required=true) int postNo) { //default필요없음 필수니까 없으면 400 때린다
		//log.info("noticeView.do 호출 확인 {}", postNo);
		NoticeVO notice = service.retrieveNotice(postNo);
		
		//log.info("noticeView 확인 {}", notice);
		
		
		
		return notice; //adapter 가 가져간다(model+view)
	}
}
