package kr.or.ddit.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "dtcode")
public class DutyVO {

	// 직책 코드
	@NotBlank
	@Size(max = 9)
	private String dtcode;
	
	// 직책 이름
	@NotBlank
	@Size(max = 30)
	private String dtnm;
	
	// 직책개요
	@Size(max = 1000)
	private String dtabst;
	
	// 직책보조수당
	private Integer dtbnf;
}
