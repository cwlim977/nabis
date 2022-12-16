package kr.or.ddit.pay.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.PayAlwVO;
import kr.or.ddit.vo.PayDedVO;

@Mapper
public interface PayDedDAO {
	/**
	 * 지급 항목 조회
	 * @param pyCode
	 * @return PayAlwVO
	 */
	public PayAlwVO selectPay(@Param("pyCode") String pyCode);
	/**
	 * 공제 항목 조회
	 * @param ddCode
	 * @return PayDedVO
	 */
	public PayDedVO selectDed(@Param("ddCode") String ddCode);
	/**
	 * 지급 항목 목록 조회
	 * @param legal
	 * @return List<PayAlwVO>
	 */
	public List<PayAlwVO> selectPayList(String legal);
	/**
	 * 공제 항목 목록 조회
	 * @param legal
	 * @return List<PayAlwVO>
	 */
	public List<PayDedVO> selectDedList(String legal);
	/**
	 * 지급 항목 생성
	 * @param pay
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertPay(PayAlwVO pay);
	/**
	 * 공제 항목 생성
	 * @param ded
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertDed(PayDedVO ded);
	/**
	 * 지급 항목 수정
	 * @param pay
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updatePay(PayAlwVO pay);
	/**
	 * 공제 항목 수정
	 * @param ded
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updateDed(PayDedVO ded);
	/**
	 * 지급 항목 삭제
	 * @param pyCode
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deletePay(@Param("pyCode") String pyCode);
	/**
	 * 공제 항목 삭제
	 * @param ddCode
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deleteDed(@Param("ddCode") String ddCode);

}
