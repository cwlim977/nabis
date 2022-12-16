package kr.or.ddit.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@EqualsAndHashCode(of="cmCode")
@Data
public class CmcodeVO implements Serializable{

	@NotBlank
	@Size(max = 30)
	private String cmCode;
	@Size(max = 30)
	private String parentCd;
	@NotBlank
	@Size(max = 300)
	private String codeNm;
	@Size(max = 3000)
	private String codeAbst;
	
	private String regDate;
	private String wriDate;
	
	
}
