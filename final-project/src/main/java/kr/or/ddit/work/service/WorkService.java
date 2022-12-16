package kr.or.ddit.work.service;



import java.util.List;


import kr.or.ddit.vo.ExcelWorkVO;
import kr.or.ddit.vo.WkApVO;

public interface WorkService {

	/**
	 * 근무등록 하기
	 * 사원의 근무를 등록하기전 검증을 걸친다
	 * - 작성자가 관리자면 등록한다.
	 * - 작성자가 일반 사원이면 야간, 연장, 휴일 이 포함되면 need(요청필요)를 내보낸다.
	 * - 작성자가 일반 사원이면 정상업무 시간(09:00 ~ 18:00) 이외 스케줄을 등록시 need(요청필요)를 내보낸다. 
	 * @param workAp - 근무기록 정보 
	 * @param writer - 근무등록 작성자
	 * @return ok : 성공, fail : 실패, need : 요청필요
	 */
	public String createWorkAp(WkApVO workAp, String writer);

	/**
	 * 근무요청 등록
	 * 사원의 근무요청을 등록한다.
	 * 승인자는 사원의 속해있는 주조직 부서장, 조직 부서장, 최고관리자 순으로 없을시 배정된다.
	 * @param workAp - 근무기록 정보 
	 * @return ok : 성공, fail : 실패
	 */
	public String createWorkAp(WkApVO workAp);
	
	/**
	 * 근무기록 삭제
	 * 사원의 근무기록을 삭제한다.
	 * @param workAp - 근무기록 정보
	 * @return ok : 성공, fail : 실패
	 */
	public String removeWorkAp(WkApVO workAp);
	
	/**
	 * 근무기록 반려
	 * 사원의 근무기록을 반려한다.
	 * @param waNo - 근무기록 번호
	 * @return ok : 성공, fail : 실패
	 */
	public String rejectWorkAp(String waNo);

	/**
	 * 근무기록 승인
	 * 사원의 근무기록을 승인한다.
	 * @param waNo - 근무기록 번호
	 * @return ok : 성공, fail : 실패
	 */
	public String confirmWorkAp(String waNo);
	
	/**
	 * 정한 기간동안의 사원별 근무시간 엑셀용 가공 리스트를 가져온다.
	 * @param sDate - 시작일
	 * @param eDate - 종료일
	 * @return
	 */
	public List<ExcelWorkVO> workExcelList(String sDate, String eDate);
}
