package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "vpCngCode")
public class VacPosnVO implements Serializable {
	
	@NotBlank
	@Size(max=30)
	private String vpCngCode;
	@NotBlank
	@Size(max=9) 
	private String empNo;
	@Size(max=9) 
	private String vclfCode;
	@NotBlank
	@Size(max=9) 
	private String vcCode;
	@Size(max=7) 
	private String vpCngDate;
	@NotBlank
	@Size(max=9) 
	private String vpCngCase;
	@Size(max=1000) 
	private String vpCngRsn;
	@NotNull 
	@Min(0) 
	private Double vpDays;

	private Double vpAddDays;
	private Double vpSubDays;
	
	private List<VacVO> vacList; // has many - 새 직원 휴가 부여할 때 사용한다.
	
	private VacVO vacVo; // has a - 직원의 휴가 개요에 사용한다.
	
	private Double latestVpDays; // Mapper selectKey
	
	private String vaapCode;
	
}
