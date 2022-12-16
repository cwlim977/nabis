package kr.or.ddit.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import kr.or.ddit.commons.validate.DeleteGroup;
import kr.or.ddit.commons.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="pyCode")
public class PayAlwVO {
	
	//급여 지급 항목(PAY)
	
	//지급코드
	@NotBlank(groups= {UpdateGroup.class, DeleteGroup.class})
	@Size(max = 9)
	private String pyCode;
	
	//부모코드
	private String parentPcd;
	
	//지급명
	@NotBlank
	private String pyNm;
	
	//지급금액
	private Integer pyAmt;
	
	//정산포함여부
	private String pyYn;
	
	//과세여부
	private String pyTax;
	
	//산출식
	private String pyFml;
	
	//법정필수여부
	private String pyLyn;
	
	//지급설명
	@Size(max = 1000)
	private String pyAbst;

}
