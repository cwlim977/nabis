package kr.or.ddit.dept.service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.vo.DeptVO;

import java.util.List;

public interface DeptService {

	// 조직도 조회
//	public DeptVO retrieveDept(String dcode);

	// 조직도 List 조회
	public List<DeptVO> retrieveDeptList();

	// 조직도 수정
	public ServiceResult modifyDept(DeptVO dept);

	// 조직도 추가
	public ServiceResult createDept(DeptVO dept);

	// 조직도 삭제
	public ServiceResult removeDept(String dcode);

	// 조직도 List 조회
	public String retrieveMaxDcode();
}
