package kr.or.ddit.vo;

import lombok.Data;

@Data
public class PayrollSetVO {
	
	//사원 별 급여항목 계산 
	
	//사원번호
	private String empNo;

	//사원명
	private String empNm;
	
	//총가족수
	private int famCnt;
	
	
	//지급-----------------------------------------------------
	   
	//기본시급
    private int basePayHour;
    
    //소정근무시간
    private int contractHour;
    
    //미달근무시간
    private String unpaidHour;
    
    //기본급차감금
    private int unpaidAmount;
    
    //기본지급금
    private int basePayMonth;
    
    //차감근무 제외한 지급금
    private int totalBasePayMonth;
    
    //연장근무시간
    private String extendWork;
    
    //연장수당
    private int extendBonus;
    
    //야간근무시간
    private String nightWork;
    
    //야간수당
    private int nightBonus;
    
    //휴일근무시간
    private String holydayWork;
    
    //휴일수당
    private int holydayBonus;
    
    //초과근무시간합계
    private String totalOvertime;
    
    //초과근무수당합계
    private int totalOverBonus;
    
    //종전 식대(식비 - 계약변경 이력 테이블에서 가져옴)
    private int mealAllowance; 
    
	//공제-----------------------------------------------------
	
	//과세총액
	private int taxable;
	
	//소득세
	private int incomeTax; 		// WD101
	
	//지방소득세
	private int incomeTaxLocal; // WD102
	
	//국민연금
	private int pension; 		// WD201
	
	//건강보험
	private int health; 		// WD202
	
	//장기요양
	private int longcare; 		// WD203
	
	//고용보험
	private int employIns; 		// WD204

}
