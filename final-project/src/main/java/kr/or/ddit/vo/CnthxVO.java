package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@Data
@EqualsAndHashCode(of = "cnthxNo")
public class CnthxVO implements Serializable {
	
	//계약변경이력번호
	@NotBlank
	@Size(max = 100)
	private String cnthxNo;
	
	//계약변경대상자
	@NotBlank
	@Size(max = 9)
	private String cntCngr;
	
	//계약작성자
	@NotBlank
	@Size(max = 9)
	private String cntWriter;
	
	//근로계약작성일자
	private String blctSdate;
	
	//근로계약종료일자
	private String blctEdate;
	
	//근로유형
	@Size(max = 100)
	private String blCase;
	
	//임금계약작성일자
	private String bwctSdate;
	
	//임금계약종료일자
	private String bwctEdate;
	
	//계약금액
	@Size(max = 15)
	private Integer bcntAmt;
	
	//식비
	@Size(max = 15)
	private Integer bfex;
	
	//소득구분
	@Size(max = 100)
	private String bincClf;
	
	//계약변경일자
	@NotBlank
	private String cngDate;
	
	//변경메모
	@Size(max = 3000)
	private String cngMm;
	
	//수습시작일자
	private String prSdate;
	
	//수습종료일자
	private String prEdate;
	
	// 계약상태
	private String cntSt;

	// 계약수정일자
	private String editDate;
	
	// 계약수정자
	@Size(max = 9)
	private String cntEditor;
	
	
	private List<CnthxVO> cnthxList;
}
