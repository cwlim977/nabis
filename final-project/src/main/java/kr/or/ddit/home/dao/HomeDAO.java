package kr.or.ddit.home.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.ApplicationVO;

@Mapper
public interface HomeDAO {
	/**
	 * 특정 승인자 해당 요청 리스트 조회
	 * @param empNo - 승인자 번호
	 * @return
	 */
	public List<ApplicationVO> selectApplicationList(String empNo);
}
