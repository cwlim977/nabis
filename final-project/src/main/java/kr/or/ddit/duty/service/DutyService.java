package kr.or.ddit.duty.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.vo.DutyVO;

public interface DutyService {
	// 직위 List 조회
	public List<DutyVO> retrieveDutyList();
	
	// 직위 수정
	public ServiceResult modifyDuty(DutyVO Duty);

	// 직위 추가
	public ServiceResult createDuty(DutyVO Duty);

	// 직위 삭제
	public ServiceResult removeDuty(String dcode);

	// 직위 List 조회
	public String retrieveMaxDtcode();
}
