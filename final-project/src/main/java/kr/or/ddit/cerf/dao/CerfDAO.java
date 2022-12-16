package kr.or.ddit.cerf.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.CerfVO;
import kr.or.ddit.vo.EmpVO;

@Mapper
public interface CerfDAO {
	
	
	/**
	 * 문서 ,증명서 구성원 List 조회 
	 * 
	 * @return 성공 List<EmpVo> 실패 null
	 * 
	 */
	public List<EmpVO> selectCerfEmpList();
	
	
	/**
	 * 문서,증명서 구성원 List 구성원이름 검색 
	 * @param empNo
	 * @return 검색된 List<EmpVO> 
	 */
	public List<EmpVO> searchCerfList(String empNo);
	
	
	/**
	 * 증명서 발급 받을때 필요한 emp정보 select 
	 * @param empNo
	 * @return 성공 empVO 실패 null
	 */
	public EmpVO selectCerfInfo(String empNo);
	
	
	
	/**
	 * 발급 내역 저장 
	 * @param cerfVo
	 * @return 성공 1 실패 0
	 */
	public int insertCerf(CerfVO cerfVo);
	
	
	/**
	 * 증명서 내역 List 조회
	 * @return 성공 cerfVo List  실패 null
	 */
	public List<CerfVO> selectCerfList(String cfEmp);
	
	
	
	/**
	 * 한사원의 재직,경력 증명서 내역 List 조회
	 * @param cerf
	 * @return 실패 null
	 */
	public List<CerfVO> selectDetailCerf(CerfVO cerf);
}




