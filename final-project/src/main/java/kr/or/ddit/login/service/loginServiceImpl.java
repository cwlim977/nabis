package kr.or.ddit.login.service;

import javax.inject.Inject;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.stereotype.Service;

import kr.or.ddit.login.dao.loginDAO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.EmpVOWrapper;

@Service("authService")
public class loginServiceImpl implements UserDetailsManager {
	
	@Inject
	private loginDAO dao;

	@Override
	public UserDetails loadUserByUsername(String empNo) throws UsernameNotFoundException {
		EmpVO emp = dao.findIdByEmpNo(empNo);
		if(emp==null)
			throw new UsernameNotFoundException(empNo);
		return new EmpVOWrapper(emp);
	}

	@Override
	public void createUser(UserDetails user) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateUser(UserDetails user) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteUser(String username) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void changePassword(String oldPassword, String newPassword) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean userExists(String username) {
		// TODO Auto-generated method stub
		return false;
	}

}
