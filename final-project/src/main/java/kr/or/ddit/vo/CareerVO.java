package kr.or.ddit.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@Data
@EqualsAndHashCode(of= "caNo" )
public class CareerVO implements Serializable {
	
	@NotBlank
	@Size(max = 9)
	private String caNo;
	@NotBlank
	@Size(max = 9)
	private String empNo;
	@Size(max = 100)
	private String caNm;
	@Size(max = 100)
	private String caClf;
	@Size(max = 100)
	private String caCntcase;
	private String caEtdate;
	private String caEdate;
	@Size(max = 30)
	private String caDept;
	@Size(max = 30)
	private String caJob;
	@Size(max = 30)
	private String caDuty;
	@Size(max = 30)
	private String caGrd;
	
	// 경력 회사 근속 기간
	private String caPeriod;
}

