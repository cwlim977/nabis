package kr.or.ddit.pstn.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.vo.PstnVO;

public interface PstnService {
	// 직위 List 조회
	public List<PstnVO> retrievePstnList();
	
	// 조직도 수정
	public ServiceResult modifyPstn(PstnVO pstn);

	// 조직도 추가
	public ServiceResult createPstn(PstnVO pstn);

	// 조직도 삭제
	public ServiceResult removePstn(String ptnCode);

	// 조직도 List 조회
	public String retrieveMaxPtnCode();
}
