package kr.or.ddit.emp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.AsgmtVO;
import kr.or.ddit.vo.BlgDeptVO;
import kr.or.ddit.vo.CmcodeVO;
import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.DutyVO;
import kr.or.ddit.vo.GrdVO;
import kr.or.ddit.vo.JobVO;
import kr.or.ddit.vo.PstnVO;

/**
 *	부서, 직책, 직무, 직위, 직급 
 *	셀렉트 옵션용 리스트 정보 조회.
 *	
 */
@Mapper
public interface OthersDAO {
	
	/**
	 * 부서 코드, 이름 조회
	 * @return 부서 코드,이름 리스트
	 */
	public List<DeptVO> selectDeptList();
	public List<DutyVO> selectDutyList();
	public List<JobVO> selectJobList();
	public List<PstnVO> selectPstnList();
	public List<GrdVO> selectGrdList();
	/**
	 * 근로유형조회
	 * @return 근로유형, 근로유형코드 리스트
	 */
	public List<CmcodeVO> LaborCaseList();
	
	/**
	 * 소득구분조회
	 * @return 소득구분항목
	 */
	public List<CmcodeVO> incomeCaseList();
	
	/**
	 * 담당 직무 추가
	 * @param asgmt
	 * @return 성공 : 1 , 실패 : 0
	 */
	public int insertOwnJob(AsgmtVO asgmt);
	
	/**
	 * 소속 부서 직책 추가
	 * @param asgmt
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertBlgDept(AsgmtVO asgmt);
	
	
	/**
	 * 부서의 조직장 변경
	 * @param blgDept
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateDeptHead(BlgDeptVO blgDept);
}
