package kr.or.ddit.commons.websocket.event;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.vo.ArmVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class ArmEventListener {

	@Resource(name="allWsSessions")
	private List<WebSocketSession> allWsSessions;

	@EventListener(NewArmEvent.class)
	public void newArmEventListener(NewArmEvent event) throws IOException {
		ArmVO newArm = event.getSource();
		log.info("{} 가 작성한 새 알림, {} 한테 보냈음.", newArm.getArmSdr(), newArm.getArmRcvr());
		//log.info("{} 가 작성한 새글, {} 제목으로 올라왔음.",newBoard.getBoWriter(),newBoard.getBoTitle());
		ObjectMapper mapper = new ObjectMapper();
		String jsonPayload = mapper.writeValueAsString(newArm);
		TextMessage message = new TextMessage(jsonPayload);
		
		for(WebSocketSession singleSession : allWsSessions) {
			System.out.println(singleSession.getPrincipal().getName());
			String empNo = singleSession.getPrincipal().getName();

			if(empNo.equals(newArm.getArmRcvr())) {
				singleSession.sendMessage(message);
			}
		}
	}

}
