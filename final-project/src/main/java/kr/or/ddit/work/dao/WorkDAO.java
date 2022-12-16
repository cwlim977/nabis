package kr.or.ddit.work.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.WkApVO;
import kr.or.ddit.vo.WorkVO;

@Mapper
public interface WorkDAO {
	
	/**
	 * 근무 리스트 조회
	 * @return
	 */
	public List<WorkVO> selectWorkList();
	
	/**
	 * 근무 상세 조회
	 * @param workCode
	 * @return
	 */
	public WorkVO selectWork(String workCode);
	
	/**
	 * 근무 추가
	 * @param work
	 * @return
	 */
	public int insertWork(WorkVO work);
	
	/**
	 * 근무 삭제
	 * @param workCode
	 * @return
	 */
	public int deleteWork(String workCode);
	
	/**
	 * 근무 변경
	 * @param work
	 * @return
	 */
	public int updateWork(WorkVO work);
	

	/**
	 * 한주간의 사원 근무기록 총시간
	 * @param paramMap
	 * key empNo - 조회 사원번호
	 * key num - 0 : 이번주 , +-7 : 7의배수로 양수,음수 검색할 주단위 
	 * @return
	 */
	public int selectWorkApWeekTime(Map<String, Object> paramMap);
	/**
	 * 한주간의 사원 근무기록 조회
	 * @param paramMap
	 * key empNo - 조회 사원번호
	 * key num - 0 : 이번주 , +-7 : 7의배수로 양수,음수 검색할 주단위 
	 * @return
	 */
	public List<WkApVO> selectWorkApList(Map<String, Object> paramMap);
	
	/**
	 * 근무기록 상세 조회
	 * @param waNo - 조회 근무기록번호
	 * @return
	 */
	public WkApVO selectWorkAp(String waNo);
	
	/**
	 * 한주간의 모든사원 근무기록 조회
	 * @param pagingVO
	 * key dcode - 속한 부서 사원 조회
	 * key num - 0 : 이번주 , +-7 : 7의배수로 양수,음수 검색할 주단위 
	 * @return
	 */
	public List<EmpVO> selectEmpWorkApList(PagingVO<EmpVO> pagingVO);
	
	/**
	 * 한주간의 모든사원 근무기록 갯수
	 * @param pagingVO
	 * @return
	 */
	public int selectEmpWorkApListCnt(PagingVO<EmpVO> pagingVO);

	/**
	 * 휴가 신청에 따른 근무기록삭제
	 * @param vaapCode - 휴가신청코드
	 * @return
	 */
	public int deleteWorkApToVac(@Param("vaapCode") String vaapCode);
	
	/**
	 * 휴가 신청에 따른 근무기록 승인
	 * @param vaapCode - 휴가신청코드
	 * @return
	 */
	public int confirmWorkApToVac(@Param("vaapCode") String vaapCode);
	
	/**
	 * 사원의 특정날에 속하는 근무기록 삭제
	 * @param workAp
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateWorkAp(WkApVO workAp);
	
	/**
	 * 근무기록 추가
	 * @param workAp
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertWorkAp(WkApVO workAp);
	
	/**
	 * 근무기록 반려
	 * @param waNo
	 * @return 성공 : 1, 실패 : 0
	 */
	public int rejectWorkAp(String waNo);

	/**
	 * 근무기록 승인
	 * @param waNo
	 * @return 성공 : 1, 실패 : 0
	 */
	public int confirmWorkAp(String waNo);
	
	/**
	 * 사원들의 기간동안의 근무상세시간 조회 리스트
	 * @param sDate - 시작날짜 
	 * @param eDate - 종료날짜
	 * @return
	 */
	public List<EmpVO> selectEmpWorkTimeList(@Param("sDate") String sDate, @Param("eDate")String eDate);
	
	public List<WkApVO> selectSchedule(EmpVO empVO);
	
	public List<WkApVO> selectDaySchedule(EmpVO empVO);
	
}
