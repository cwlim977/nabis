package kr.or.ddit.notice.event;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.vo.NoticeVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component //하위컨테이너등록
public class NoticeEventListener {
	@Resource(name="allWsSessions")
	private List<WebSocketSession> allWsSessions;
	
	@EventListener(NewNoticeEvent.class)
	public void newNoticeEventListener(NewNoticeEvent event) throws IOException {
		NoticeVO newNotice = event.getSource();
		log.info("{} 가 작성한 새글 , {} 제목으로 올라왔음.", newNotice.getWriNo(), newNotice.getPostTitle());
		
		// WebSocket 연결이 수립되어 있는 모든 사용자에게 푸시 메시지 전송.
		ObjectMapper mapper = new ObjectMapper(); //모두 읽을 수 있어야한다 - marshalling 해야
		mapper.setVisibility(PropertyAccessor.FIELD, JsonAutoDetect.Visibility.ANY);
		String jsonPayload = mapper.writeValueAsString(newNotice); //json 완성
		TextMessage message = new TextMessage(jsonPayload); //json을 message로
		
		for(WebSocketSession singleSession : allWsSessions) {
			singleSession.sendMessage(message); //message 보낸다.
		}
	}
}
