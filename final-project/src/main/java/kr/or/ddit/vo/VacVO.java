package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = "vcCode")
public class VacVO implements Serializable {
	
	@NotBlank
	@Size(max = 100)
	private String vcNm;
	@NotBlank
	@Size(max = 1000)
	private String vcInfo;
	@NotBlank
	@Size(max = 100)
	private String vcGmtd;
	@NotNull
	@Min(0)
	private Integer vcGdays;
	@NotBlank
	@Size(max = 20)
	private String vcUseunit;
	@NotBlank
	@Size(max = 10)
	private String vcGen;
	@NotBlank
	@Size(max = 3)
	private String vcWpay;
	@NotBlank
	@Size(max = 3)
	private String vcCert;
	
	/* DB에서 가져오는 용도이다. */
	private String vclfCode;
	private String vcCode;
	private List<Map<String, Integer>> annualVacAddGiveList;
	/* DB에서 가져오는 용도이다. */
	
}
