package kr.or.ddit.vo;

import java.io.Serializable;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "vsEachDate")
public class VacSchVO implements Serializable {
	
	@NotBlank
	@Size(max=7)
	private String vsEachDate;
	@NotBlank
	@Size(max=30) 
	private String vaapCode;
	@NotBlank
	@Size(max=7)
	private String vsStime;
	@NotBlank
	@Size(max=7)
	private String vsEtime;
	@NotNull 
	@Min(0) 
	private Double vsUseDays;
	
}
