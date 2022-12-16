package kr.or.ddit.commons.websocket;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;
@Slf4j
public class WebSocketPushMessageHandler extends TextWebSocketHandler {
	
	@Resource(name="allWsSessions")
	private List<WebSocketSession> allWsSessions; 
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("웹소켓 접속 사원번호 : {}",session.getPrincipal().getName());
		if(session.getPrincipal().getName() != null) {
			allWsSessions.add(session); 
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		allWsSessions.remove(session);
	}
	
}
