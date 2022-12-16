package kr.or.ddit.vo;

import java.io.Serializable;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import kr.or.ddit.commons.validate.DeleteGroup;
import kr.or.ddit.commons.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@Data
@EqualsAndHashCode(of="prempNo")
public class PrEmpVO implements Serializable{

	//급여템플릿_사원 (PREMP)
	
	@NotBlank(groups= {UpdateGroup.class, DeleteGroup.class})
	@Size(max = 30)
	private String prempNo;
	
	//급여정산번호
	@NotBlank
	@Size(max = 9)
	private String prNo;
	
	//사원번호
	@NotBlank
	@Size(max = 9)
	private String empNo;
	
	//사원명
	private String empNm;

}
