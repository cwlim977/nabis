package kr.or.ddit.emp.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.commons.exception.UserNotFoundException;
import kr.or.ddit.vo.AsgmtVO;
import kr.or.ddit.vo.CnthxVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PagingVO;

public interface EmpService {
	
	/**
	 * 사원 정보 상세조회
	 * @param empNo 조회할 사원의 번호
	 * @return 존재하지 않는다면, {@link UserNotFoundException} 발생.
	 */
	public EmpVO retrieveEmp(String empNo);
	
	/**
	 * 사원 목록 조회
	 * @param
	 * @return
	 */
	public List<EmpVO> retrieveEmpList();
	public List<EmpVO> getExcelEmpList();
	public List<EmpVO> retrieveEmpList(PagingVO<EmpVO> pagingVO);
	public int retrieveEmpCount(PagingVO<EmpVO> pagingVO);
	
	/**
	 * 사원 계약상태 목록 조회
	 * @param paramArr - 계약상태 필터 파라미터
	 * @return
	 */
	public List<EmpVO> retrieveEmpCntStatusList(Map<String, Object> paramArr);
	
	/**
	 * 사원 신규 등록
	 * @param emp - 신규등록되는 사원정보 객체
	 * @param asgmt - 사원 신규등록 작성자
	 * @param cnthx 
	 * @return {@link ServiceResult.PKDUPLICATED}, {@link ServiceResult.OK}, {@link ServiceResult.FAIL}
	 */
	public ServiceResult createEmp(EmpVO emp, AsgmtVO asgmt, CnthxVO cnthx);
	
	/**
	 * 인사발령 등록
	 * @param asgmt - 등록할 인사발령 정보가 담긴 객체
	 * @return {@link ServiceResult.OK}, {@link ServiceResult.FAIL}
	 */
	public ServiceResult createAsgmt(AsgmtVO asgmt);
	
	/**
	 * 인사발령 여러명 등록
	 * @param asgmtList - 사원들의 인사발령 정보 
	 * @param writer - 인사발령 작성자
	 * @return {@link ServiceResult.OK}, {@link ServiceResult.FAIL}
	 */
	public ServiceResult createAsgmts(List<AsgmtVO> asgmtList, String writer);
	
	/**
	 * 인사발령예정 취소
	 * @param asgmt - 취소할 인사발령 객체
	 * @return {@link ServiceResult.OK}, {@link ServiceResult.FAIL}
	 */
	public ServiceResult cancelAsgmt(AsgmtVO asgmt);




}
