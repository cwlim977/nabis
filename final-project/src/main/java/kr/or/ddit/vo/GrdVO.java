package kr.or.ddit.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "grdCode")
public class GrdVO {

	// 직급코드
	@NotBlank
	@Size(max = 9)
	private String grdCode;
	
	// 직급이름
	@Size(max = 30)
	private String grdNm;
	
	// 직급개요
	@Size(max = 1000)
	private String grdAbst;
	
	// 직급별 임금가산
	@Size(max = 0)
	private String grdWgAdd;
}
