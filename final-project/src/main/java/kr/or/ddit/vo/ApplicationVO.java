package kr.or.ddit.vo;

import java.io.Serializable;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@SuppressWarnings("serial")
@Getter
@Setter
@ToString
@EqualsAndHashCode(of = "apNo")
public class ApplicationVO implements Serializable {
	// 아이디
	private String apNo;
	
	// 신청자 번호
	private String apEmp;
	
	// 신청자 이름
	private String empNm;
	
	// 신청자 프로필
	private String empImg;
	
	// 신청일자
	private String apDate;

	// 결재상태
	private String apStat;
	
	// 유형
	private String apType;
	
}
