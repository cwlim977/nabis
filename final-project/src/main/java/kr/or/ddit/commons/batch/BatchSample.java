package kr.or.ddit.commons.batch;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;


@Component
@Slf4j
public class BatchSample {
	
//	@Scheduled(initialDelay=0, fixedRate=1000)
	// 초 분 시 일 월 요일 (요일 설정시 day 와 충돌나니까 day를 ?로 교체해준다)

//	@Scheduled(cron="0 5 0 * * ?") 매월 매일 0시 5분에 동작
	@Scheduled(cron="0 45 9 * * ?")
	public void printNumber() {
		log.info("스케줄러 테스트");
		// 파생데이터 삭제후 멤버 삭제 
		// 웹서버가 동작이 멈추면안됨
	}
}
