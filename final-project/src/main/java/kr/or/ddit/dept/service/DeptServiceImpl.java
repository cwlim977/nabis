package kr.or.ddit.dept.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.dept.dao.DeptDAO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.vo.DeptVO;

@Service
public class DeptServiceImpl implements DeptService {
	@Inject
	private DeptDAO dao;

	@Override
	public ServiceResult createDept(DeptVO dept) {
//		ServiceResult result = null;
//		try {
//			result = ServiceResult.PKDUPLICATED;
//		}catch (UserNotFoundException e) {
			int rowcnt = dao.insertDept(dept);
			return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
//			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
//		}
//		return result;
	}

	@Override
	public List<DeptVO> retrieveDeptList() {
		return dao.selectDeptList();
	}

//	@Override
//	public DeptVO retrieveDept(String dcode) {
//		return dao.selectDept(dcode);
//	}

	@Override
	public ServiceResult modifyDept(DeptVO dept) {
//		retrieveDept(dept.getDcode());
		int rowcnt = dao.updateDept(dept);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeDept(String dcode) {
		
		int rowcnt = dao.deleteDept(dcode);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	@Override
	public String retrieveMaxDcode() {
		return dao.selectMaxDcode();
	}

}
