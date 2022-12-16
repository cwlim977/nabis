package kr.or.ddit.vo;


import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import kr.or.ddit.commons.validate.DeleteGroup;
import kr.or.ddit.commons.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@Data
@EqualsAndHashCode(of="codeNo")
public class PayRcdVO implements Serializable{
	
	//급여정산기록 (PAYRCD)
	
	//정산기록번호
	@NotBlank(groups= {UpdateGroup.class, DeleteGroup.class})
	@Size(max = 30)
	private String codeNo;
	
	//급여정산번호
	@NotBlank
	@Size(max = 9)
	private String prNo;
	
	//사원번호
	@NotBlank
	@Size(max = 9)
	private String empNo;
	
	//항목코드
	private String codeCd;
	
	//항목이름
	private String codeNm;
	
	//항목금액
	private Integer codeAmt;
	
	//완료여부
	private String finyn;
	
	//삭제여부
	private String delyn;
	
	//------------------------------
	//정산 귀속월
	private String prBlg;
	
	//정산 항목 별 사원 수
	private String empCnt;
	
	//정산 항목 별 합계 금액
	private String sumAmt; 
	
	//정산 지급·공제 항목 구분 코드
	private String clf;
	
	//정산 지급·공제별 총 사원 수
	private String totalCnt;
	
	//정산 지급·공제별 총 합계
	private String totalAmt;
}
