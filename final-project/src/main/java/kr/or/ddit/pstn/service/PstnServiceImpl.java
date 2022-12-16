package kr.or.ddit.pstn.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.pstn.dao.PstnDAO;
import kr.or.ddit.vo.PstnVO;

@Service
public class PstnServiceImpl implements PstnService {
	@Inject
	private PstnDAO dao;

	@Override
	public ServiceResult createPstn(PstnVO pstn) {
//		ServiceResult result = null;
//		try {
//			result = ServiceResult.PKDUPLICATED;
//		}catch (UserNotFoundException e) {
			int rowcnt = dao.insertPstn(pstn);
			return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
//			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
//		}
//		return result;
	}
	
	@Override
	public List<PstnVO> retrievePstnList() {
		return dao.selectPstnList();
	}

//	@Override
//	public PstnVO retrievePstn(String dcode) {
//		return dao.selectPstn(dcode);
//	}

	@Override
	public ServiceResult modifyPstn(PstnVO pstn) {
//		retrievePstn(Pstn.getDcode());
		int rowcnt = dao.updatePstn(pstn);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removePstn(String dcode) {
		
		int rowcnt = dao.deletePstn(dcode);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	@Override
	public String retrieveMaxPtnCode() {
		return dao.selectMaxPtnCode();
	}

}
