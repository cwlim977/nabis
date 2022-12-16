package kr.or.ddit.vo;


import java.io.Serializable;

import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@Data
@EqualsAndHashCode(of="ictCd")
public class IcmTaxVO implements Serializable{
	
	//급여정산 공제 - 원천세 계산을 위한 근로소득 간이세액표  (ICMTAX)
	
	//소득세코드
	private String ictCd;
	
	//월급여기준 (이상)
	private Integer ictStdm;
	
	//월급여기준 (미만)
	private Integer ictStdl;
	
	//공제 가족 수--------------------------------------
	
	private Integer ict01;
	
	private Integer ict02;
	
	private Integer ict03;
	
	private Integer ict04;
	
	private Integer ict05;
	
	private Integer ict06;
	
	private Integer ict07;
	
	private Integer ict08;
	
	private Integer ict09;
	
	private Integer ict10;
	
	private Integer ict11;

}
