package kr.or.ddit.notice.view;

import java.io.File;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.web.servlet.view.AbstractView;

import kr.or.ddit.vo.AttatchVO;



public class DownloadView extends AbstractView {
	
	@Value("#{appInfo.attatchFolder}")
	private File saveFolder; //저장 폴더 잡기

	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse resp) throws Exception { //db metadata가지고 saveFile에서 찾은다음에 stream copy 뜬다. 조회구조와 같은 것
		
		AttatchVO attatch = (AttatchVO) model.get("attatch");
		
		String saveName = attatch.getAttSavename();
		File file = new File(saveFolder, saveName);//다운로드 시켜야할 객체
		
		String fileName = attatch.getAttFilename();
//		%2T - percent encoding, URL encoding (특수문자 처리)
		fileName = URLEncoder.encode(fileName, "UTF-8");
		fileName = fileName.replaceAll("\\+", " ");//encode시 +로 표현되는 띄어쓰기를 공백문자로 바꿔라
		resp.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);//8비트(1byte)기반의 스트림데이터 나간다고 mime을 셋팅한다
		resp.setContentLengthLong(attatch.getAttFilesize());
		resp.setHeader("Content-Disposition", "attatchment;filename=\""+fileName+"\"");//filename으로 다운로드해라 ("띄어쓰기 포함 설정")
		try(
			OutputStream os = resp.getOutputStream();
		){
			FileUtils.copyFile(file, os);//카피완
		}
	}
}
