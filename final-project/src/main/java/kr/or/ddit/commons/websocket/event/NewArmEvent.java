package kr.or.ddit.commons.websocket.event;

import kr.or.ddit.vo.ArmVO;

public class NewArmEvent {
	private ArmVO source;

	public NewArmEvent(ArmVO source){
		this.source = source;
	}

	public ArmVO getSource() {
		return source;
	}
}
