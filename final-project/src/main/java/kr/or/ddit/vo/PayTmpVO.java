package kr.or.ddit.vo;


import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import kr.or.ddit.commons.validate.DeleteGroup;
import kr.or.ddit.commons.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="ptNo")
public class PayTmpVO{
	
	//급여템플릿(PAYTPL)
	
	//급여템플릿번호
	@NotBlank(groups= {UpdateGroup.class, DeleteGroup.class})
	@Size(max = 9)
	private String ptNo;
	
	//템플릿이름
	@NotBlank
	private String ptNm;
	
	//템플릿개요
	private String ptAbst;
	
	//비고
	private String ptMm;
	
	//생성일자
	private String ptSdate;
	
	//사용여부
	private String ptyn;
	
	//북마크여부
	private String ptBmk;

}
