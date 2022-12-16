package kr.or.ddit.grd.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.vo.GrdVO;

public interface GrdService {
	// 직무 List 조회
	public List<GrdVO> retrieveGrdList();
	
	// 직무 수정
	public ServiceResult modifyGrd(GrdVO grd);

	// 직무 추가
	public ServiceResult createGrd(GrdVO grd);

	// 직무 삭제
	public ServiceResult removeGrd(String grdCode);

	// 직무 List 조회
	public String retrieveMaxGrdCode();
}
