package kr.or.ddit.pay.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.vo.PtMakeVO;

public interface PtMakeService {
	
	public List<PtMakeVO> retrievePtMake(String ptNo);
	
	public ServiceResult createPtMake(PtMakeVO ptm);
	
	public ServiceResult removePtMake(PtMakeVO ptm);

}
