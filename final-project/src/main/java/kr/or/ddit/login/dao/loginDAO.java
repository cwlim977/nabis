package kr.or.ddit.login.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.EmpVO;

@Mapper
public interface loginDAO {
	public EmpVO findIdByEmpNo(String empNo);
	public int updateEmpPass(EmpVO empVo);
}
