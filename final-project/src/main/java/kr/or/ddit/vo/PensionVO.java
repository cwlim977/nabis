package kr.or.ddit.vo;


import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@EqualsAndHashCode(of = "psNo")
@ToString
public class PensionVO  {
	
	// 퇴직소득번호
	@NotBlank
	@Size(max = 9)
	private String psNo;
	// 사원번호
	@NotBlank
	@Size(max = 100)
	private String psEmpno;
	// 정산시작일
	@Size(max = 1000)
	private String calSdate;
	// 퇴직급여유형
	private String psCase;
	// 가입일
	private String psSdate;
	// 연금운용사
	private String psBank;
	// 계좌번호
	private String psAcnt;
	// 정산상태
	private String psSt;
}
