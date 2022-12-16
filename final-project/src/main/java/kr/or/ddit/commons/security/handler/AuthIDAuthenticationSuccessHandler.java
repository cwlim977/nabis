package kr.or.ddit.commons.security.handler;

import java.io.IOException;
import java.net.Inet4Address;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import kr.or.ddit.vo.AcsLogVO;
import kr.or.ddit.vo.EmpVOWrapper;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AuthIDAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler{
	@Override
	public void onAuthenticationSuccess(
			HttpServletRequest request, 
			HttpServletResponse response,
			Authentication authentication
	) throws ServletException, IOException {
		EmpVOWrapper wrapper = (EmpVOWrapper) authentication.getPrincipal();
		HttpSession session = request.getSession();
		String sessionId = session.getId();
		session.setAttribute("sessionId", sessionId);
		session.setAttribute("authEmp", wrapper.getRealEmp());
		log.info("authEmp : {}", wrapper.getRealEmp());
		
//		AcsLogVO acs = new AcsLogVO();
//		acs.setEmpNo(wrapper.getRealEmp().getEmpNo());
//		acs.setAcsIp(Inet4Address.getLocalHost().getHostAddress());
		
		
		super.onAuthenticationSuccess(request, response, authentication);
	}
}

