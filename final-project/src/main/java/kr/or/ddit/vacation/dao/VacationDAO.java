package kr.or.ddit.vacation.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.VacApplyVO;
import kr.or.ddit.vo.VacPosnVO;
import kr.or.ddit.vo.VacSchVO;
import kr.or.ddit.vo.VacVO;

@Mapper
public interface VacationDAO {
	
	/* 사원 등록 */
	
	/**
	 * 새로운 사원에게 부여할 수 있는 휴가를 조회하기
	 * @param empNo
	 * @return List<VacVO>
	 */
	public List<VacVO> selectNewEmpVacation(String empNo);
	/**
	 * 새로운 사원에게 부여할 수 있는 휴가를 부여하기
	 * @param vacList
	 * @return int
	 */
	public int insertNewEmpVacation(VacPosnVO vacPosnVo);
	
	/* 사원 등록 */
	
	/* 휴가 설정 */
	
	/**
	 * 휴가 전체 조회하기
	 * @return List<VacVO>
	 */
	public List<VacVO> selectVacList();
	/**
	 * 휴가 개별 조회하기
	 * @param vcNm
	 * @return VacVO
	 */
	public VacVO selectVacation(String vcNm);
	/**
	 * 연차 추가 부여 삭제하기
	 * @return int
	 */
	public int deleteAnnualLeaveVacAddGive();
	/**
	 * 연차 추가 부여 추가하기
	 * @return int
	 */
	public int insertAnnualLeaveVacAddGive(Map<String, Object> map);
	/**
	 * 휴가 추가하기
	 * @param vacation
	 * @return int
	 */
	public int insertVacation(VacVO vacation);
	/**
	 * 휴가 수정하기
	 * @param vacation
	 * @return int
	 */
	public int updateVacation(VacVO vacation);
	/**
	 * 휴가 삭제하기
	 * @param vcNm
	 * @return int
	 */
	public int deleteVacation(String vcNm);
	
	/* 휴가 설정 */
	
	/* 휴가 개요 */
	
	/**
	 * 최신의 휴가 보유 - 휴가 정보 조회하기
	 * @return List<VacPosnVO>
	 */
	public List<VacPosnVO> selectVacPosnVoList(String empNo);
	
	/**
	 * 사원 번호로 휴가 신청 정보 조회하기
	 * @param paramMap
	 * @return List<VacApplyVO>
	 */
	public List<VacApplyVO> selectVacApplyVoListByEmpNo(String empNo);
	
	/* 휴가 신청 */
	
	/**
	 * 휴가 신청자의 가장 최근 휴가 보유 코드의 번호를 조회하기
	 * @param empNo
	 * @return int
	 */
	public Integer selectLatestVpCngNo(String empNo);
	
	/**
	 * 휴가 보유 테이블에 행 삽입하기
	 * @param vacPosnVo
	 * @return int
	 */
	public int insertVacationPossession(VacPosnVO vacPosnVo);
	
	/**
	 * 휴가 신청자의 가장 최근 휴가 신청 코드의 번호를 조회하기
	 * @param vaapEmp
	 * @return
	 */
	public Integer selectLatestVaapNo(String vaapEmp);
	
	/**
	 * 휴가 신청 테이블에 행 삽입하기
	 * @param vacApplyVo
	 * @return int
	 */
	public int insertVacationApply(VacApplyVO vacApplyVo);
	
	/**
	 * 휴가 일정 테이블에 행 삽입하기
	 * @param vacSchVoList
	 * @return int
	 */
	public int insertVacationSchedule(List<VacSchVO> vacSchVoList);
	
	/* 휴가 신청 */
	
	/* 휴가 취소 */
	
	/**
	 * 휴가 신청을 취소 상태로 업데이트 하기
	 * @param vaapCode
	 * @return int
	 */
	public int updateVacApplyCcSt(String vaapCode);
	
	/**
	 * 휴가 신청의 휴가 보유 변경을 조회하기
	 * @param vaapCode
	 * @return VacPosnVO
	 */
	public VacPosnVO selectVacPosnByVaapCode(String vaapCode);
	
	/* 휴가 취소 */
	
	/* 증명 자료 제출 */
	
	public int updateVaapFileCnt(String vaapCode);
	
	/* 증명 자료 제출 */
	
	/* 휴가 개요 */
	
	/* 연차 상세 */
	
	/**
	 * 휴가 보유 리스트를 조회하기
	 * @param map
	 * @return List<VacPosnVO>
	 */
	public List<VacPosnVO> selectVacPosnListByMap(Map<String, Object> map); 
	
	/* 연차 상세 */
	
	/* 휴가 보유 현황 */
		
	/**
	 * 모든 휴가의 코드와 이름을 조회하기
	 * @return List<VacVO>
	 */
	public List<VacVO> selectAllVacation();
	
	/**
	 * 휴가 보유를 조회하기
	 * @param pagingVO
	 * @return List<EmpVO>
	 */
	public List<EmpVO> selectVacPosnStat(PagingVO<EmpVO> pagingVO);
	
	/**
	 * 휴가 보유 조회 갯수
	 * @param pagingVO
	 * @return
	 */
	public int selectVacPosnStatTotalRecord(PagingVO<EmpVO> pagingVO);
	
	/* 휴가 보유 현황 */
	
	/* 휴가 신청 내역 */
	
	/**
	 * 날짜로 휴가 신청 정보 조회하기
	 * @return List<VacApplyVO>
	 */
	public List<VacApplyVO> selectVacApplyVoListByDate(Map<String, Object> map);
	
	/**
	 * 휴가 신청의 결재 상태 갱신하기
	 * @param map
	 * @return int
	 */
	public int updateVacApplyApSt(Map<String, String> map);
	
	/**
	 * 휴가 신청 코드로 휴가 신청 정보 조회하기
	 * @param vaapCode
	 * @return VacApplyVO
	 */
	public VacApplyVO selectVacApplyVoByVaapCode(String vaapCode);
	
	/* 휴가 신청 내역 */
	
}
