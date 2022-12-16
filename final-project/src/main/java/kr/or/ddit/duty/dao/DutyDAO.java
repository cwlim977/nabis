package kr.or.ddit.duty.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.DutyVO;

@Mapper
public interface DutyDAO {
	public List<DutyVO> selectDutyList();
	
	public int updateDuty(DutyVO duty); 
	 
	public int insertDuty(DutyVO duty);
	
	public int deleteDuty(String dtcode);
	
	public String selectMaxDtcode();
	
}
