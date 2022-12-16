package kr.or.ddit.vo;

import java.io.Serializable;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@Data
@EqualsAndHashCode(of = "ojNo")
public class OwnJobVO implements Serializable {

	// 담당직무 번호
	@Size(max = 9)
	private String ojNo;
	
	// 인사발령 번호 
	@NotNull
	@Min(0)
	private Integer asgmtNo;
	
	// 인사발령대상
	@NotBlank
	@Size(max = 9)
	private String asgmtPers;
	
	// 직무 코드
	// @NotBlank
	@Size(max = 9)
	private String jcode;

	// 직무명
	private String jnm;

}
