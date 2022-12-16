package kr.or.ddit.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import kr.or.ddit.commons.validate.DeleteGroup;
import kr.or.ddit.commons.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="ddCode")
public class PayDedVO {
	
	//급여 공제 항목(DED)
	
	//공제코드
	@NotBlank(groups= {UpdateGroup.class, DeleteGroup.class})
	@Size(max = 9)
	private String ddCode;
	
	//부모코드
	private String parentDcd;
	
	//공제명
	@NotBlank
	private String ddNm;
	
	//공제금액
	private Integer ddAmt;
	
	//정산포함여부
	private String ddYn;
	
	//산출식
	private String ddFml;
	
	//공제설명
	@Size(max = 1000)
	private String ddAbst;
	
	//법정필수여부
	private String ddLyn;

}
