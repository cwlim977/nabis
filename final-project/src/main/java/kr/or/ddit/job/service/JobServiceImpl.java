package kr.or.ddit.job.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.job.dao.JobDAO;
import kr.or.ddit.vo.JobVO;

@Service
public class JobServiceImpl implements JobService {

		@Inject
		private JobDAO dao;

		@Override
		public ServiceResult createJob(JobVO job) {
//			ServiceResult result = null;
//			try {
//				result = ServiceResult.PKDUPLICATED;
//			}catch (UserNotFoundException e) {
				int rowcnt = dao.insertJob(job);
				return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
//				result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
//			}
//			return result;
		}
		
		@Override
		public List<JobVO> retrieveJobList() {
			return dao.selectJobList();
		}

//		@Override
//		public JobVO retrieveJob(String dcode) {
//			return dao.selectJob(dcode);
//		}

		@Override
		public ServiceResult modifyJob(JobVO job) {
//			retrieveJob(Job.getDcode());
			int rowcnt = dao.updateJob(job);
			return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		}

		@Override
		public ServiceResult removeJob(String jcode) {
			
			int rowcnt = dao.deleteJob(jcode);
			return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		}
		
		@Override
		public String retrieveMaxJcode() {
			return dao.selectMaxJcode();
		}

	}