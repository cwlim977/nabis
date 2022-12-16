package kr.or.ddit.vo;


import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@EqualsAndHashCode(of = "ascNo")
public class AcsLogVO {

	// 접속로그번호
	private String ascNo;
	
	// 사원번호
	private String empNo;
	
	// 접속일자
	private String acsDate;
	
	// 접속아이피
	private String acsIp;
}
