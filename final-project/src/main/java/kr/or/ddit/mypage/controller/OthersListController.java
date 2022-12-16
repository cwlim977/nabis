package kr.or.ddit.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.emp.dao.OthersDAO;
import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.DutyVO;
import kr.or.ddit.vo.GrdVO;
import kr.or.ddit.vo.JobVO;
import kr.or.ddit.vo.PstnVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping(value="/mypage", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
public class OthersListController{
	@Inject
	private OthersDAO othersDAO;
	
	@GetMapping("getDeptList.do")
	public Map<String, Object> getDeptList(){
		
		log.info("getDeptList.do 요청");
		Map<String, Object> map = new HashMap<>();
		List<DeptVO> deptList = othersDAO.selectDeptList();
		List<DutyVO> dutyList = othersDAO.selectDutyList();
		List<GrdVO> grdList = othersDAO.selectGrdList();
		List<JobVO> jobList = othersDAO.selectJobList();
		List<PstnVO> pstnList = othersDAO.selectPstnList();
		
		map.put("deptList", deptList);
		map.put("dutyList", dutyList);
		map.put("grdList", grdList);
		map.put("jobList", jobList);
		map.put("pstnList", pstnList);
		
		return map;
	}
}
