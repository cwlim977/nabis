package kr.or.ddit.vo;

import java.io.Serializable;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@EqualsAndHashCode(of="efamNo")
@Data
public class EmpFamVO implements Serializable{
	
	@NotBlank
	@Size(max=30)
	private String efamNo;
	@NotBlank
	@Size(max=9)
	private String efamEmpno;
	@Size(max=100)
	private String famNm;
	@Size(max=100)
	private String famRln;
	private Integer famRegno1;
	private Integer famRegno2;
	
	//자녀 세엑공제 수
	private Integer childCount;
	//기본공제 수 
	private Integer normalCount;
}
