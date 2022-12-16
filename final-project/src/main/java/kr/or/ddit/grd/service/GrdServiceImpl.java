package kr.or.ddit.grd.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.grd.dao.GrdDAO;
import kr.or.ddit.vo.GrdVO;

@Service
public class GrdServiceImpl implements GrdService {

	@Inject
	private GrdDAO dao;

	@Override
	public ServiceResult createGrd(GrdVO grd) {
//		ServiceResult result = null;
//		try {
//			result = ServiceResult.PKDUPLICATED;
//		}catch (UserNotFoundException e) {
			int rowcnt = dao.insertGrd(grd);
			return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
//			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
//		}
//		return result;
	}
	
	@Override
	public List<GrdVO> retrieveGrdList() {
		return dao.selectGrdList();
	}

//	@Override
//	public GrdVO retrieveGrd(String dcode) {
//		return dao.selectGrd(dcode);
//	}

	@Override
	public ServiceResult modifyGrd(GrdVO grd) {
//		retrieveGrd(Grd.getDcode());
		int rowcnt = dao.updateGrd(grd);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeGrd(String grdCode) {
		
		int rowcnt = dao.deleteGrd(grdCode);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	@Override
	public String retrieveMaxGrdCode() {
		return dao.selectMaxGrdCode();
	}

}