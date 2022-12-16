package kr.or.ddit.vo;

import java.io.Serializable;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@Data
@EqualsAndHashCode(of = "bdNo")
public class BlgDeptVO implements Serializable {

	// 소속부서 번호
	// @NotBlank
	@Size(max = 9)
	private String bdNo;
	// 인사발령번호
	@NotNull
	@Min(0)
	private Integer asgmtNo;
	// 인사발령대상
	@NotBlank
	@Size(max = 9)
	private String asgmtPers;
	// 부서코드
	@NotBlank
	@Size(max = 9)
	private String dcode;

	// 부서 흐름도
	private String deptFlow;
	// 부서명
	private String dnm;
	// 부서장 사원번호
	private String dhno;

	// 직책 코드
	private String dtcode;
	// 직책명
	private String dtnm;

	// 주 부서여부
	@Size(max = 3)
	private String mainck;

	// 조직장체크여부
	private String dno;
	
}
