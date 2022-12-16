package kr.or.ddit.arm.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.vo.ArmVO;


public interface ArmService {

	/**
	 * 개인 알람 목록 조회
	 * @param empNo - 수신자 사원번호
	 * @return 수신 알람목록
	 */
	public List<ArmVO> retrieveArmList(String armRcvr);

	/**
	 * 특정 알람 삭제
	 * @param armNo - 알람번호 
	 * @return {@link ServiceResult.OK}, {@link ServiceResult.FAIL}
	 */
	public ServiceResult removeArm(String armNo);
	
	/**
	 * 개인의 알람 모두 삭제
	 * @param armRcvr - 수신자 사원번호
	 * @return {@link ServiceResult.OK}, {@link ServiceResult.FAIL}
	 */
	public ServiceResult removeAllArm(String armRcvr);
	
	/**
	 * 알람 추가
	 * @param armVO - 알람 정보
	 * @return {@link ServiceResult.OK}, {@link ServiceResult.FAIL}
	 */
	public ServiceResult createArm(ArmVO armVO);

	/**
	 * 알람 읽음 처리
	 * @param armNo - 알람번호
	 * @return {@link ServiceResult.OK}, {@link ServiceResult.FAIL}
	 */
	public ServiceResult modifyArm(String armNo);
	
	/**
	 * 알람 모두 읽음 처리
	 * @param armRcvr - 수신자 사원번호
	 * @return {@link ServiceResult.OK}, {@link ServiceResult.FAIL}
	 */
	public ServiceResult modifyAllArm(String armRcvr);

	
}
