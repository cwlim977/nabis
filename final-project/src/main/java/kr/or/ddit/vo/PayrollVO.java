package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.List;
import java.util.Set;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import kr.or.ddit.commons.validate.DeleteGroup;
import kr.or.ddit.commons.validate.UpdateGroup;
import lombok.Data;
import lombok.EqualsAndHashCode;


@SuppressWarnings("serial")
@Data
@EqualsAndHashCode(of="prNo")
public class PayrollVO implements Serializable{
	
	//급여정산 (PAYROLL)
	
	//급여정산번호
	@NotBlank(groups= {UpdateGroup.class, DeleteGroup.class})
	@Size(max = 9)
	private String prNo;
	
	//급여템플릿번호
	@NotBlank
	@Size(max = 9)
	private String prPtno;
	
	//급여정산자
	@NotBlank(groups= {UpdateGroup.class, DeleteGroup.class})
	@Size(max = 9)
	private String prr;
	
	//정산시작일
	@NotBlank
	private String prSdate;
	
	//정산종료일
	@NotBlank
	private String prEdate;
	
	//급여지급일자
	private String prGdate;
	
	//지급총액
	private Integer pytl;
	
	//공제총액
	private Integer ddtl;
	
	//실지급액
	private Integer tlamt;
	
	//급여정산이름
	@NotBlank
	private String prNm;
	
	//급여정산귀속월
	@NotBlank
	@Size(max = 30)
	private String prBlg;
	
	//삭제여부
	private String delyn;
	
	//완료여부
	private String finyn;
	
	//정산완료일
	private String prFdate;
	
	//-------------------------------------------------
	
	private List<PtMakeVO> ptmList; // has Many (Payroll has many codes of pay and deduction)
	
	private List<PrEmpVO> empList; //  has Many (Payroll has many employees)
	//템플릿명
	private String ptNm;
	//작성자명
	private String prrNm;
}
