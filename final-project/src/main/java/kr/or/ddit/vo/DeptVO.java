package kr.or.ddit.vo;


import javax.validation.constraints.NotBlank;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="dcode")
public class DeptVO {
	private int level;
	// 부서코드
	@NotBlank
	private String dcode;
	
	private String uprDcode;
	
	// 부서이름
	@NotBlank
	private String dnm;
	
	// 부서장 번호
	private String dhno;
	
	private String dabst;
}
