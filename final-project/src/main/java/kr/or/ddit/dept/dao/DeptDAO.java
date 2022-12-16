package kr.or.ddit.dept.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.DeptVO;

@Mapper
public interface DeptDAO {
	
	public List<DeptVO> selectDeptList();
	
	public DeptVO selectDept(String dcode);
	
	public int updateDept(DeptVO dept); 
 
	public int insertDept(DeptVO dept);
	
	public int deleteDept(String dcode);
	
	public String selectMaxDcode();
	
	/**
	 * 부서장 변경
	 * 부서테이블의 부서장번호 수정
	 * @param dept - 부서장 정보
	 * @return
	 */
	public int updateDeptHead(DeptVO dept);
	
	/**
	 * 사원의 소속 부서장 모두 해제
	 * @param empNo
	 * @return
	 */
	public int resetDeptHead(String empNo);
	
	public int checkDeptHead(String empNo);
	
}
