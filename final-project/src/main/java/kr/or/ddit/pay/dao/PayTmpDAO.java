package kr.or.ddit.pay.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


import kr.or.ddit.vo.PayTmpVO;

@Mapper
public interface PayTmpDAO {

	/**
	 * 급여정산 템플릿 생성
	 * @param tmp
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertPayTmp(PayTmpVO tmp);

	/**
	 * 급여정산 템플릿 수정
	 * @param tmp
	 * @return 성공 : 1, 실패 : 0
	 */
	public int updatePayTmp(PayTmpVO tmp);
	
	/**
	 * 급여정산 템플릿 삭제
	 * @param ptNo
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deletePayTmp(@Param("ptNo") String ptNo);
	
	/**
	 * 급여정산 템플릿 목록 조회
	 * @return 
	 */
	public List<PayTmpVO> selectPayTmpList();
	
	/**
	 * 급여정산 템플릿 조회 
	 * @param ptNo
	 * @return
	 */
	public PayTmpVO selectPayTmp(@Param("ptNo") String ptNo);
	
	/**
	 * 템플릿 북마크 등록
	 * @param ptNo
	 * @return
	 */
	public int createTmpBmk(@Param("ptNo") String ptNo);

	/**
	 * 템플릿 북마크 해제
	 * @param ptNo
	 * @return
	 */
	public int deleteTmpBmk(@Param("ptNo") String ptNo);
	
}
