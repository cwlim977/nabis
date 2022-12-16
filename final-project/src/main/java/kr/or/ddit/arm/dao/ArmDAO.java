package kr.or.ddit.arm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.ArmVO;

@Mapper
public interface ArmDAO {
	
	/**
	 * 개인의 알람 목록 조회
	 * @param armRcvr - 수신자번호
	 * @return 알람 목록
	 */
	public List<ArmVO> selectArmList(@Param("armRcvr") String armRcvr);
	
	/**
	 * 특정 알람 삭제
	 * @param armNo - 알람번호 
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteArm(@Param("armNo") String armNo);
	
	/**
	 * 개인의 알람 모두 삭제
	 * @param armRcvr - 수신자번호
	 * @return 성공 > 0, 실패 : 0
	 */
	public int deleteArmAll(@Param("armRcvr") String armRcvr);
	
	/**
	 * 알람 추가
	 * @param armVO - 알람 정보
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertArm(ArmVO armVO);
	
	/**
	 * 알람 읽음 처리
	 * @param armNo - 알람번호
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateArm(@Param("armNo") String armNo);
	
	/**
	 * 알람 모두 읽음 처리
	 * @param armRcvr - 수신자번호
	 * @return 성공 > 0, 실패 : 0
	 */
	public int updateArmAll(@Param("armRcvr") String armRcvr);

}
