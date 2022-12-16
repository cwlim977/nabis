package kr.or.ddit.pay.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.pay.dao.PtMakeDAO;
import kr.or.ddit.vo.PtMakeVO;

@Service
public class PtMakeServiceImpl implements PtMakeService {

	@Inject
	private PtMakeDAO ptmDAO; 
	
	//템플릿 별 포함 항목 조회
	@Override
	public List<PtMakeVO> retrievePtMake(String ptNo) {
		return ptmDAO.selectPtMakeList(ptNo);
	}

	//템플릿 별 포함 항목 추가
	@Override
	public ServiceResult createPtMake(PtMakeVO ptm) {
		int rowcnt = ptmDAO.insertPtMake(ptm);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	//템플릿 별 포함 항목 삭제
	@Override
	public ServiceResult removePtMake(PtMakeVO ptm) {
		int rowcnt = ptmDAO.deletePtMake(ptm);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
