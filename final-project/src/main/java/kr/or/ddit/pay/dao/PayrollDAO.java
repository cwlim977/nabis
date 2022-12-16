package kr.or.ddit.pay.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.w3c.dom.ls.LSInput;

import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.IcmTaxVO;
import kr.or.ddit.vo.IncCerfVO;
import kr.or.ddit.vo.PayRcdVO;
import kr.or.ddit.vo.PayrollVO;
import kr.or.ddit.vo.PrEmpVO;
import kr.or.ddit.vo.WkApVO;

@Mapper
public interface PayrollDAO {
	
/*급여 정산 */
	//[급여대장]===================================================================
	
	/**
	 * 급여 정산 생성 (=급여대장 생성)
	 * @param payroll
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertProll(PayrollVO payroll);
	
	/**
	 * 급여 정산 별 PAYROLL, PAYTPL, PTMAKE 정보를 조회
	 * @param payroll (prPtno 정산템플릿번호 , prNo 정산번호)
	 * @return
	 */
	public PayrollVO selectProll(PayrollVO payroll);
	
	/**
	 * 급여 정산 삭제
	 * @param prNo
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteProll(@Param("prNo") String prNo);
	
	/**
	 * 선택한 귀속월에 속하는 급여 정산 목록 조회
	 * @param blgYear
	 * @return
	 */
	public List<PayrollVO> selectProllList(@Param("blgYear") String blgYear);
	
	//[대상자]====================================================================
	
	/**
	 * 대상자 - 정산 생성 시 선택한 기간에 근무 내역이 있는 사원들을 조회
	 * @param payroll (prSdate 정산작일 , prEdate 정산종료일)
	 * @return
	 */
	public List<WkApVO> selectEmpList(PayrollVO payroll);
	
	/**
	 * 대상자 - 정산 생성 시 선택한 기간에 근무 내역이 있는 사원의 근로유형을 조회 
	 * @param empNo
	 * @return blCase (근무유형)
	 */
	public String selectEmpCase(@Param("empNo") String empNo);
	
	/**
	 * 대상자 - 근무내역 있는 사원 중 체크한 사원을 대상자로 확정한다
	 * @param payempList
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertPayEmp(@Param("payempList") List<PrEmpVO> payempList);
	
	/**
	 * 대상자 - 정산 별 확정된 대상자 조회 
	 * @param prNo (정산번호)
	 * @return 
	 */
	public List<PrEmpVO> selectPayEmpList(@Param("prNo") String prNo);
	
	//[공통·지급]=================================================================
	
	/**
	 * 공통 - 확정 지급·공제 내역 정산기록에 등록 
	 * @param payrcdList
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertPayRcd(@Param("payrcdList") List<PayRcdVO> payrcdList);
	
	/**
	 * 지급 - 총 근무 시간 조회
	 * @param paramMap (사원번호, 정산시작일, 정산종료일)
	 * @return
	 */
	public double selectTotalWork(Map<String, Object> paramMap);
	
	/**
	 * 지급 - 연장근무 시간 조회
	 * @param paramMap (사원번호, 정산시작일, 정산종료일)
	 * @return
	 */
	public WkApVO selectOvertime(Map<String, Object> paramMap);
	
	
	//[공제]=====================================================================
	
	/**
	 * 공제 - 과세총액 조회 
	 * @param rcd
	 * @return taxable
	 */
	public int selectTaxable(PayRcdVO rcd);
	
	/**
	 * 공제 - 공제대상 가족 수 조회 
	 * @param empNo
	 * @return famCnt
	 */
	public int selectFamCount(@Param("empNo") String empNo);
	
	/**
	 * 공제 - 7세 이상 20세 이하 자녀의 수 조회 
	 * @param empNo
	 * @return childCnt
	 */
	public int selectChdCount(@Param("empNo") String empNo);
	
	/**
	 * 공제 - 근로소득 간이세액표 조회 
	 * @param monthlyInc
	 * @return 소득 구간 간이세액
	 */
	public IcmTaxVO selectIcmTax(@Param("monthlyInc") int monthlyInc);
	
	/**
	 * 사원의 급여정산 별 급여대장 조회 
	 * @param rcd
	 * @return
	 */
	public PayRcdVO selectPayRcd(PayRcdVO rcd);
	
	//[미리보기]===================================================================
	
	/**
	 * 미리보기 - 정산 별 요약 목록 조회 (전체사원) 
	 * @param prNo
	 * @return
	 */
	public List<PayRcdVO> selectPaySumList(@Param("prNo") String prNo);
	
	/**
	 * 미리보기 - 정산별 요약 총 인원 수, 총 합계 조회 (전체사원) 
	 * @param prNo
	 * @return
	 */
	public List<PayRcdVO> selectTotalSumList(@Param("prNo") String prNo);
	
	/**
	 * 미리보기 - 현재 정산의 이전 귀속연월 조회(전체사원) 
	 * @param prNo
	 * @return prevBlg (이전 귀속연월)
	 */
	public String selectPrevBelong(@Param("prNo") String prNo);
	
	/**
	 * 미리보기 - 현재 템플릿을 사용한 지난 정산의 정산번호 조회(전체사원) 
	 * @param payroll
	 * @return prNo 
	 */
	public String selectPrevProllNo(PayrollVO payroll);

	/**
	 * 미리보기 - 정산 별 세부내역 목록 조회
	 * @param prNo
	 * @return 
	 */
	public List<PayRcdVO> selectProllRecordList(@Param("prNo") String prNo);
	
	/**
	 * 정산완료 - 정산 완료 버튼 클릭 시 완료 처리 (지급총액, 공제총액, 실지급액, 정산완료일, 정산완료여부 수정)
	 * @param payroll
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateProllFin(PayrollVO payroll);
	
	// 2022-12-10 LCW
	/**
	 * 급여이체리스트 조회
	 * @param prNo - 정산번호
	 * @return
	 */
	public List<EmpVO> selectSalaryTransferList(@Param("prNo") String prNo);
	
/* 급여 */
	/**
	 * 급여 - 선택한 귀속연도의 정산 번호 목록 조회 (사원 별)
	 * @param paramMap (사원번호, 귀속연도)
	 * @return
	 */
	public List<PayrollVO> selectProllbyYear(Map<String, Object> paramMap);

	/**
	 * 급여 - 정산별 총금액 조회 (사원별)
	 * @param paramMap (사원번호, 정산번호)
	 * @return
	 */
	public List<PayRcdVO> selectTotalStub(Map<String, Object> paramMap);
	
	/**
	 * 급여 - 급여명세 조회 (사원별, 정산별)
	 * @param paramMap (사원번호, 정산번호)
	 * @return
	 */
	public List<PayRcdVO> selectPaystub(Map<String, Object> paramMap);
	
/* 급여정산 - 자료관리*/	
	/**
	 * 자료관리 - 증명서 발급 내역 조회 (전체사원)
	 * @return
	 */
	public List<IncCerfVO> selectCerfList();
	
	/**
	 * 자료관리 - 증명서 발급 내역 등록
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertCerf(Map<String, Object> args);
}
