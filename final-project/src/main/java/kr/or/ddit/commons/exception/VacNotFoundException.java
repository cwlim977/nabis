package kr.or.ddit.commons.exception;

public class VacNotFoundException extends PKNotFoundException {
	
	private String vcNm;
	
	public VacNotFoundException(String vcNm) {
		this.vcNm = vcNm;
	}

	@Override
	public String getMessage() {
		return String.format("%s 휴가가 존재하지 않음.", this.vcNm);
	}

}
