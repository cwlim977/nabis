package kr.or.ddit.duty.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.duty.dao.DutyDAO;
import kr.or.ddit.vo.DutyVO;

@Service
public class DutyServiceImpl implements DutyService {
	@Inject
	private DutyDAO dao;

	@Override
	public ServiceResult createDuty(DutyVO duty) {
//		ServiceResult result = null;
//		try {
//			result = ServiceResult.PKDUPLICATED;
//		}catch (UserNotFoundException e) {
			int rowcnt = dao.insertDuty(duty);
			return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
//			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
//		}
//		return result;
	}
	
	@Override
	public List<DutyVO> retrieveDutyList() {
		return dao.selectDutyList();
	}

//	@Override
//	public DutyVO retrieveDuty(String dcode) {
//		return dao.selectDuty(dcode);
//	}

	@Override
	public ServiceResult modifyDuty(DutyVO duty) {
//		retrieveDuty(Duty.getDcode());
		int rowcnt = dao.updateDuty(duty);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeDuty(String dtcode) {
		
		int rowcnt = dao.deleteDuty(dtcode);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	@Override
	public String retrieveMaxDtcode() {
		return dao.selectMaxDtcode();
	}

}
