package kr.or.ddit.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@Data
@EqualsAndHashCode(of = "noteNo")
public class HrnoteVO implements Serializable {
	
	//인사노트 번호
	@NotBlank
	@Size(max = 30)
	private String noteNo;
	
	//대상사원번호
	@NotBlank
	@Size(max = 9)
	private String hrEmpno;
	
	@Size(max = 300)
	private String empNm;
	
	//노트내용
	@Size(max = 3000)
	private String noteCont;
	
	//작성일자
	@NotBlank
	private String wriDate;
	
	//기록자사원번호
	@NotBlank
	@Size(max = 9)
	private String writer;
	
	//노트삭제여부
	@Size(max =3)
	private String noteDelyn;
	
}
