package kr.or.ddit.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import kr.or.ddit.commons.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="ptmNo")
public class PtMakeVO {
	
	//급여 템플릿 별 지급·공제 항목 포함여부 (PTMAKE)
	
	//급여템플릿 구성 번호
	@NotBlank(groups = {UpdateGroup.class})
	@Size(max = 9)
	private String ptmNo;
	
	//급여템플릿 번호
	@NotBlank
	private String ptNo;
	
	//공제코드
	private String ddCode;
	
	//공제금액
	private Integer pddAmt;
	
	//지급코드
	private String pyCode;
	
	//지급금액
	private Integer ppyAmt;
	
	//---------------------------------
	
	//지급코드명
	private String pyNm;
	
	//공제코드명
	private String ddNm;
	
	//공제부모코드
	private String ddPrCode;


}
