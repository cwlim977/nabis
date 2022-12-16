package kr.or.ddit.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@Data
@EqualsAndHashCode(of = "accaNo")
public class AccaVO implements Serializable {
	
	@NotBlank
	@Size(max = 9)
	private String accaNo;
	@NotBlank
	@Size(max = 9)
	private String empNo;
	@Size(max = 20)
	private String acClf;
	@Size(max = 100)
	private String acNm;
	
	private String acEtdate;
	private String acEdate;
	@Size(max = 30)
	private String gradClf;
	@Size(max = 100)
	private String maj;
	
	
	private String accPeriod;
}
