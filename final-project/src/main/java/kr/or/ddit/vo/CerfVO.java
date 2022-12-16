package kr.or.ddit.vo;


import java.io.Serializable;
import java.sql.Date;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import org.quartz.Job;

import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@Data
@EqualsAndHashCode(of = "cfNo")
public class CerfVO implements Serializable{

	@NotBlank
	@Size(max=30)
	private String cfNo;  	// 증명서 번호
	@NotBlank
	@Size(max=9)
	private String cfEmp; 	// 사원번호
	@NotBlank
	@Size(max=100)
	private String cfNm; 	// 증명서분류(재직/경력)
	@NotBlank
	private String cfDate; 	// 발급일자
	@NotBlank
	@Size(max=1000)
	private String cfRsn; 	// 발급사유
	
	@NotBlank
	@Size(max=3)
	private String regCheck;
	
/*	@NotBlank
	@Size(max=6)
	private String cfRegno1;  // 주민번호 앞자리
	@NotBlank
	@Size(max=7)
	private String cfRegno2;  // 주민번호 뒷자리
	@NotBlank
	@Size(max=100)
	private String cfAddr; 	  // 주소
	@NotBlank
	private String cfEdate;   // 입사일
	private String cfOdate;   // 퇴사일
	@NotBlank
	@Size(max=50)
	private String cfDept;    // 조직
	@NotBlank
	@Size(max=50)
	private String cfPstn;    // 직위
*/
}
