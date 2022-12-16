package kr.or.ddit.insight.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.CnthxVO;


@Mapper
public interface InsightDAO {

	/**
	 * 구성원의 계약 유형별 비율을 담은 List객체를 조회하는 메서드
	 * @return 구성원의 계약 유형별 비율을 담은 List객체
	 */
	public List<CnthxVO> cntCaseList();
	
	/**
	 * 특정기간 내 수습완료율을 조회하는 메서드
	 * @param prSdate 조회 시작일자
	 * @param prEdate 조회 종료일자
	 * @return 수습완료을 숫자를 나타내는 String data
	 */
	public String prEndRate(@Param("prSdate")String prSdate, @Param("prEdate")String prEdate);
	
	/**
	 * 선택한 연도의 퇴직률을 조회하는 메서드
	 * @param outDate 퇴직률을 조회하기위한 string타입 연도 변수
	 * @return 퇴직률을 나타내는 String data
	 */
	public String outRateRetrieve(@Param("outDate")String outDate);
	
	/**
	 * 현재 재직중인 구성원 전체의 성비를 조회하는 메서드
	 * @return 구성원의 남성성비, 여성성비와 각 인원수 및 총원수를 담음 hashMap객체
	 */
	public HashMap<String, Object> sexRatioRetrieve();
	
	/**
	 * 사원목록에 등록된, 퇴직인원 포함 총 인원의 재직기간 조회
	 * @return 구성원의 재직기간 목록을 담은 map객체
	 */
	public List<HashMap<String, String>> serviceYearRetrieve();  
	
	/**
	 * 현재 재직중인 사원의 나이를 조회
	 * @return 재직중인 사원의 나이를 담은 List<Integer>객체
	 */
	public List<Integer> ageRetrieve();
	
	/**
	 * 현재 재직중인 사원의 연봉을 조회
	 * @return 재직중인 사원의 int타입 연봉을 담은 List객체
	 */
	public List<Integer> avgSalaryRetrieve();
	
	/**
	 * 일자별 평균 근무시간, 최대 근무시간, 최소근무시간을 조회하는 메서드
	 * 승인된 근무만 조회하며, 승인대기 또는 반려의 경우는 계산에 합산되지 않음. 
	 * @return 일자별 평균근무시간, 최대근무시간, 최소근무시간을 담은 List객체
	 */
	public List<HashMap<String, String>> workTimeRetrieve();	
	
	/**
	 * 부서별 성별구성을 조회하는 메서드
	 * 조회되는 내용은 구성원 성별, 구성원 이름, 구성원의 주조직에 해당하는 부서이름, 시원번호, 인사발령번호를 담은 HashMap객체의 list를 반환한다 . 
	 * @return 부서별 성별구성등을 담은 HashMap객체의 list
	 */
	public List<HashMap<String, String>> sexPerDeptRetrieve();
	
	/**
	 * 부서별 평균임금, 최저임금, 최고임금 조회하는 메서드, 상위부서순으로 정렬
	 * @return 부서이름, 부서코드, 부서평균임금, 부서최저임금, 부서최고임금 정보를 담은 HashMap객체 List
	 */
	public List<HashMap<String,Object>> deptPerWageRetrieve();
	
	/**
	 * 재직중인 총원수를 나타내는 메서드
	 * @return 재직중인 총원수, 작년 재직총원수, 두 해의 증감율
	 */
	public HashMap<String,String> memberCount(@Param("selectedDate") String selectedDate);
	
	/**
	 * 현재 재직중인 사원 중 수습기간에 있는 사원 수 조회
	 * @return 수습중인 사원정보를 담은 list객체
	 */
	public List<HashMap<String,String>> prMemberRetieve();
	
	/**
	 * 모든 퇴사자들의 퇴사기간 조회
	 * @return 모든퇴사자들의 퇴사기간을 담은 HashMap타입 List
	 */
	public List<HashMap<String,String>> outPeriodTotal();
	
	/**
	 * 전체 퇴사자들의 평균 퇴사기간 조회
	 * @return 전체 퇴사자들의 평균 퇴사일자를 String객체로 반환
	 */
	public String avgOutPeriod();
}
