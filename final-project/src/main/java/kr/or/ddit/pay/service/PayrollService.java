package kr.or.ddit.pay.service;


import java.util.List;
import java.util.Map;


import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.ExcelPayVO;
import kr.or.ddit.vo.ExcelWorkVO;
import kr.or.ddit.vo.PayRcdVO;
import kr.or.ddit.vo.PayrollSetVO;
import kr.or.ddit.vo.PayrollVO;
import kr.or.ddit.vo.PrEmpVO;
import kr.or.ddit.vo.WkApVO;

public interface PayrollService {
	// [급여정산]=====================================================
	//급여 정산(급여대장) 생성
	public ServiceResult createProll(PayrollVO payroll);
	
	//급여 정산 조회
	public PayrollVO retrieveProll(PayrollVO payroll);
	
	//급여 정산 삭제
	public ServiceResult removeProll(String prNo);
	
	//급여 정산 기간 중 근무 기록 있는 대상자 조회
	public List<WkApVO> retrieveEmpList(PayrollVO payroll);
	
	//급여 대상자 등록
	public ServiceResult createPayEmp(List<PrEmpVO> payempList);
	
	//급여 대상자 조회
	public List<PrEmpVO> retrievePayEmpList(String prNo);
	
	//급여 대상자 출력
	public List<EmpVO> empSettlement(PayrollVO payroll);
	
	//급여 정산 별 항목 정산 기록에 등록
	public ServiceResult createPayRcd(List<PayRcdVO> payrcdList);
	
	//지급 계산
	public List<PayrollSetVO> alwSettlement(PayrollVO payroll);
	
	//공제 항목 계산을 위한 과세금액 조회
	public int retrieveTaxable(PayRcdVO rcd);
	
	//공제 계산
	public List<PayrollSetVO> taxSettlement(PayrollVO payroll);
	
	//사원 별 정산 기록 조회
	public PayRcdVO retrievePayRcd(PayRcdVO rcd);
	
	//정산 별 요약 목록 조회
	public List<PayRcdVO> retrievePaySumList(String prNo);
	
	//정산 별 요약 합계 조회
	public List<PayRcdVO> retreiveTotalSumList(String prNo);
	
	//지난 정산 정보 조회
	public Map<String, Object> prevSettlement(PayrollVO proll);
	
	//정산 별 확정된 대상자 정보 조회
	public List<EmpVO> prevEmpSettlement(PayrollVO payroll);
	
	//정산 별 상세 목록 조회
	public List<PayRcdVO> retrieveProllRecordList(String prNo);
	 
	//정산 완료 등록
	public ServiceResult modifyProllFin(PayrollVO proll);
	 
	//정산 완료 세팅 (이전정산 정보)
	public Map<String, Object> resSettlement(PayrollVO proll);
	
	//급여이체리스트 엑셀 가공
	public List<ExcelPayVO> salaryTransferExcelList(String prNo, String transferDate);
	 
	//[급여]=======================================================
	//급여 귀속연도 정산 목록 조회 (개인별)
	public List<PayrollVO> paystubListSettlement(Map<String, Object> paramMap);
	
	//급여 명세서 세팅 (선택정산 정보)
	public Map<String, Object> paystubSettlement(Map<String, Object> paramMap);
	
	//원천징수 영수증 세팅
	public Map<String, Object> withholdSettlement(Map<String, Object> paramMap);
	
	
	 
}
