package kr.or.ddit.vo;

import java.io.Serializable;


import kr.or.ddit.commons.util.annotation.ExcelColumn;
import lombok.Data;
import lombok.EqualsAndHashCode;

@SuppressWarnings("serial")
@Data
@EqualsAndHashCode(of = "empNo")
public class ExcelPayVO implements Serializable {


	@ExcelColumn(headerName="사원번호")
	private String empNo;
	
	@ExcelColumn(headerName="이름")
	private String empNm;
	
	@ExcelColumn(headerName="이메일")
	private String empMail;
	
	@ExcelColumn(headerName="입사일")
	private String entDate;
	
	@ExcelColumn(headerName="퇴사일")
	private String outDate;
	
	@ExcelColumn(headerName="조직")
	private String dept;
	
	@ExcelColumn(headerName="역할(직무)")
	private String jnm;
	
	@ExcelColumn(headerName="직책")
	private String dtnm;
	
	@ExcelColumn(headerName="직급")
	private String grd;
	
	@ExcelColumn(headerName="직위")
	private String ptn;

	
	@ExcelColumn(headerName="입금 은행")
	private String bank;
	@ExcelColumn(headerName="입금 계좌번호")
	private String acctNo;
	@ExcelColumn(headerName="예금주")
	private String ower;
	@ExcelColumn(headerName="받는 통장 표시")
	private String receivingbankbook;
	@ExcelColumn(headerName="보내는 통장 표시")
	private String sandBankbook;
	@ExcelColumn(headerName="지급일")
	private String transferDate;
}
