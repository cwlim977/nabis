package kr.or.ddit.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "ptnCode")
public class PstnVO {

	// 직위 코드
	@NotBlank
	@Size(max = 9)
	private String ptnCode;
	
	// 직위 이름
	@NotBlank
	@Size(max = 30)
	private String ptnNm;
	
	// 직위 개요
	@Size(max = 1000)
	private String ptnAbst;
	
	// 직위별임금금액
	private Integer ptnWgamt;
}
