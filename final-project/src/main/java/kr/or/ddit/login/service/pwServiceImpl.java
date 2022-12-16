package kr.or.ddit.login.service;

import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.login.dao.loginDAO;
import kr.or.ddit.vo.EmpVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class pwServiceImpl implements pwService{
	
	private final loginDAO loginDAO;
	
	@Override
	public ServiceResult modifyEmpPass(EmpVO emp) {
		ServiceResult result = null;
		
		// 입력한 비밀번호 암호화
		PasswordEncoder encoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
		String encoded = encoder.encode(emp.getEmpPass());
		emp.setEmpPass(encoded);
		
		log.info("emp확인{}",emp);
		int rowcnt = loginDAO.updateEmpPass(emp);
		result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		
		return result;
	}
}
