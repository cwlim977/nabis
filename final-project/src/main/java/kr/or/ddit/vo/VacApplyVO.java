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
@EqualsAndHashCode(of = "vaapCode")
public class VacApplyVO implements Serializable {
	
	@NotBlank
	@Size(max=30) 
	private String vaapCode;
	@NotBlank
	@Size(max=9) 
	private String vcCode;
	@Size(max=7) 
	private String vaapDate;
	@NotBlank
	@Size(max=9) 
	private String vaapEmp;
	@NotBlank
	@Size(max=9) 
	private String vaapApEmp;
	@NotNull 
	@Min(0) 
	private Double vaapDays;
	@Size(max=1000) 
	private String vaapRsn;
	@Size(max=1) 
	private String vaapApSt;
	@Size(max=7) 
	private String vaapApDate;
	@Size(max=1000) 
	private String vaapRejRsn;
	@Size(max=1) 
	private String vaapCcSt;
	@Size(max=7) 
	private String vaapCcDate;
	@Min(0)
	private Integer vaapFileCnt;
	
	private List<VacSchVO> vacSchVoList; // has many - 직원의 휴가 개요에 사용한다.

	private EmpVO empVo; // has a
	
	private VacVO vacVo; // has a
	
}
