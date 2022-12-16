package kr.or.ddit.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@EqualsAndHashCode(of="comCd")
@Data
public class CompanyVO implements Serializable{
   
	

	private String comCd;
	private String comNm;
	private String comRep;
	private String comTelno;
	private String estdDate;
	private String comAddr;
	private String comRegno;
	private String corRegno;
	
}
