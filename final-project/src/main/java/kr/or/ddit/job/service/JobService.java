package kr.or.ddit.job.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.vo.JobVO;

public interface JobService {
	// 직무 List 조회
	public List<JobVO> retrieveJobList();
	
	// 직무 수정
	public ServiceResult modifyJob(JobVO job);

	// 직무 추가
	public ServiceResult createJob(JobVO job);

	// 직무 삭제
	public ServiceResult removeJob(String jcode);

	// 직무 List 조회
	public String retrieveMaxJcode();
}
