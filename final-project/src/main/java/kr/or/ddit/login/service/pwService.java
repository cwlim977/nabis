package kr.or.ddit.login.service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.vo.EmpVO;

public interface pwService {
	public ServiceResult modifyEmpPass(EmpVO emp);
}
