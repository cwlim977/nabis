package kr.or.ddit.pay.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.PayAlwVO;
import kr.or.ddit.vo.PayDedVO;
import kr.or.ddit.vo.PensionVO;

@Mapper
public interface PensionDAO {
	public List<PensionVO> selectPensionList();
}
