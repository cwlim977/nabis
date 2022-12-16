package kr.or.ddit.notice.controller;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.notice.service.NoticeService;
import kr.or.ddit.vo.AttatchVO;

@Controller
public class AttatchDownloadController { //downloadView 로 모델2로 분리함 (여기서 다하면 req, resp한군데서하니까 model1이다)
	
	//첨부 파일 다운로드
	
	@Inject
	private NoticeService service; //AOP TARGET의 PROXY 구현체만들기 위해, CONTROLLER 사이 결합력 낮추기 위해 INTERFACE 사용한다
	
	@RequestMapping("/notice/download.do")
	public String download(
			@RequestParam(name="what", required=true) int attNo
			,Model model
	)throws IOException{
		AttatchVO attatch = service.retrieveAttatch(attNo);
		model.addAttribute("attatch", attatch);
		return "downloadView";
		
	}
}
