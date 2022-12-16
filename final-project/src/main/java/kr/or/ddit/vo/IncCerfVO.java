package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@Data
@EqualsAndHashCode(of="cfNo")
public class IncCerfVO implements Serializable{
	
	//소득증명서 (INC_CERF)
	
	//증명서 번호
	private String cfNo;
	
	//사원 번호
	private String empNo;
	
	//증명서 이름
	private String cfNm;
	
	//증명서 발급일자
	private String isdate;
	
	//발급사유
	private String isueRsn;
	
	//---------------------------------------
	
	//사원명
	private String empNm;
	
	//사원이메일
	private String empMail;

}
