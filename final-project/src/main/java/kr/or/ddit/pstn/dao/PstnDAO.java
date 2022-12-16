package kr.or.ddit.pstn.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.PstnVO;

@Mapper
public interface PstnDAO {
	public List<PstnVO> selectPstnList();
	
	public int updatePstn(PstnVO pstn); 
	 
	public int insertPstn(PstnVO pstn);
	
	public int deletePstn(String ptnCode);
	
	public String selectMaxPtnCode();
	
}
