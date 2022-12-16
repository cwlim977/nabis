package kr.or.ddit.commons.exception;

public class VacPosnNotFoundException extends PKNotFoundException {
	
	private String empNo;
	
	public VacPosnNotFoundException(String vcNm) {
		this.empNo = empNo;
	}

	@Override
	public String getMessage() {
		return String.format("%s 휴가 보유가 존재하지 않음.", this.empNo);
	}

}
