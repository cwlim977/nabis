package kr.or.ddit.notice.event;

import kr.or.ddit.vo.NoticeVO;

public class NewNoticeEvent {
	private NoticeVO source;
	
	public NewNoticeEvent(NoticeVO source){
		this.source = source;
	}
	
	public NoticeVO getSource() {
		return source;
	}
}
