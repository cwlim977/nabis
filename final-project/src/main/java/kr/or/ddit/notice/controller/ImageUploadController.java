package kr.or.ddit.notice.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.servlet.ServletContext;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;


import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ImageUploadController {
//	@Inject
//	private WebApplicationContext context;  -- 이거 이용하는 주석처리 방법도 있다.
	@Inject
	private ServletContext application; //realpath 용도가 아니라 cpath 용도다
	@Value("#{appInfo.attatchFolder}") //baan이 아니라 properties니까 inject 아니고 value 쓴다
	private String imageFolderURL;
	@Value("#{appInfo.attatchFolder}") //spring loader + property editor의 역할 같은 걸 다른 타입으로 받으려고 할때 작동한다
	private Resource imageFolderRes;
	private File saveFolder;
	
	//컨테이너 내부 관리는 생명주기를 갖는다 - 컨테이너가 호출할 수 있는 콜백을 갖는다 - init(모든 injection이 끝난 후), destroy
	@PostConstruct //생성자 이후, injection 끝난 후 컨테이너가 실행해라
	public void init() throws IOException { //예외 호출한놈=스프링 컨테이너가 가져간다
//		Resource imageFolderRes = context.getResource(imageFolderURL);
		saveFolder = imageFolderRes.getFile();
		
//		String realPath = application.getRealPath(imageFolderURL);
//		File saveFolder = new File(realPath);
		if(!saveFolder.exists())
			saveFolder.mkdirs(); //계층구조, 부모의 부모의 부모도 아직 생성되지 않았을 수 있다.
		log.info("이미지폴더 url : {}", imageFolderURL);
		log.info("로딩된 saveFolder : {}", saveFolder.getCanonicalPath()); //D:\A_TeachingMaterial\6.JspSpring\workspace\.metadata\.plugins\~ 내부서버 주소 나온다.
	}
	
	@PostMapping(value="/notice/imageUpload.do", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Map<String, Object> imageUpload(@RequestPart(required=true) MultipartFile upload ) throws IOException { //filteItem ver2 part ver3에 종속된다, 이름 같으면 생략가능함
		Map<String, Object> target = new HashMap<>(); //vo 대신 collection 사용 -- 많이쓸거같으면 domain 만들어라
		
//		fileName
//		uploaded
//		url
//		error : {message, number}
		
		if(!upload.isEmpty()) { //업로드 됨
			String saveName = UUID.randomUUID().toString(); //겹치지 않는 16진수의 긴 이름이 생성
			try(
				InputStream is = upload.getInputStream();
			){
				File saveFile = new File(saveFolder, saveName);
				FileUtils.copyInputStreamToFile(is, saveFile); //응답 json으로 marshalling 으로 내보내야
				String fileName = upload.getOriginalFilename();
				int uploaded = 1;
				String url = String.format("%s%s/%s", application.getContextPath() , imageFolderURL, saveName);
				target.put("fileName", fileName);
				target.put("uploaded", uploaded);
				target.put("url", url);
				log.info("target확인 : {}", target);
			}
		}else { //업로드 안됨
			Map<String, Object> error = new HashMap<>();
			target.put("error", error);
			error.put("number", 400);
			error.put("message", "업로드된 이미지가 비어있음~");
		}
		return target;
	}

}
