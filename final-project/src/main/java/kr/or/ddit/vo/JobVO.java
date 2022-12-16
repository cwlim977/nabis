package kr.or.ddit.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "jcode")
public class JobVO {
	
	// 직무코드
	@NotBlank
	@Size(max = 9)
	private String jcode;
	
	// 직무 이름
	@NotBlank
	@Size(max = 100)
	private String jnm;
	
	// 직무 개요
	@Size(max = 1000)
	private String jabst;
	
	// 직무별임금금액
	private Integer jwgAmt;
}
