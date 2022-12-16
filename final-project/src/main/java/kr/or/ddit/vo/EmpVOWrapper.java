package kr.or.ddit.vo;

import java.util.Arrays;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;

public class EmpVOWrapper extends User{

	private EmpVO realEmp;

	public EmpVOWrapper(EmpVO realEmp) {
		super(realEmp.getEmpNo(), realEmp.getEmpPass()
				, AuthorityUtils.createAuthorityList(
					Arrays.stream(
						realEmp.getIdRoles().stream().map(role->{
							return role.split(",");
						}).toArray(String[][]::new)
					).flatMap(roles-> {
						return Arrays.stream(roles);
					}).toArray(String[]::new)
				)
		);
		this.realEmp = realEmp;
	}
	
	public EmpVO getRealEmp() {
		return realEmp;
	}
	
}
