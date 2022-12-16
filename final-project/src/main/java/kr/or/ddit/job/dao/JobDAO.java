package kr.or.ddit.job.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.JobVO;

@Mapper
public interface JobDAO {
	public List<JobVO> selectJobList();
	
	public int updateJob(JobVO job); 
	 
	public int insertJob(JobVO job);
	
	public int deleteJob(String jcode);
	
	public String selectMaxJcode();
}
