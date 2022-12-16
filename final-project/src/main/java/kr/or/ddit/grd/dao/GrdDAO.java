package kr.or.ddit.grd.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.GrdVO;
@Mapper
public interface GrdDAO {
	public List<GrdVO> selectGrdList();
	
	public int updateGrd(GrdVO grd); 
	 
	public int insertGrd(GrdVO grd);
	
	public int deleteGrd(String grdCode);
	
	public String selectMaxGrdCode();
}
