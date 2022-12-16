package kr.or.ddit.pay.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.PtMakeVO;

@Mapper
public interface PtMakeDAO {
	
	/**
	 * 템플릿 별 포함 항목 조회
	 * @return List<PtMakeVO>
	 */
	public List<PtMakeVO> selectPtMakeList(@Param("ptNo") String ptNo);
	/**
	 * 템플릿 별 포함 항목 추가
	 * @param pt
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertPtMake(PtMakeVO ptm);
	/**
	 * 템플릿 별 포함 항목 삭제
	 * @param PtMakeVO
	 * @return 성공 : 1, 실패 : 0
	 */
	public int deletePtMake(PtMakeVO ptm);

}
