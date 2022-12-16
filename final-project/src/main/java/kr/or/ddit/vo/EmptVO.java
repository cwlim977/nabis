package kr.or.ddit.vo;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "emptNo")
public class EmptVO {

	//재직상태번호
	@NotBlank
	@Size(max = 9)
	private String emptNo;
	
	//사원번호
	@NotBlank
	@Size(max = 9)
	private String empNo;
	
	//재직상태
	@Size(max = 30)
	private String emptSt;
	
	//휴직시작일자
	private String bkSdate;
	
	//휴직종료일자
	private String bkEdate;
	
	//퇴직일자
	private String otDate;
	
	//퇴직일자
	@Size(max = 300)
	private String stClf;
	
	//퇴직일자
	@Size(max = 1000)
	private String stMemo;
	
}
