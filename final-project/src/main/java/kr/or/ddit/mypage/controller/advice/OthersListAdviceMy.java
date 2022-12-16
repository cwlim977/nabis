package kr.or.ddit.mypage.controller.advice;

import java.util.List;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.emp.dao.EmpDAO;
import kr.or.ddit.emp.dao.OthersDAO;
import kr.or.ddit.vo.AsgmtVO;
import kr.or.ddit.vo.CmcodeVO;
import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.DutyVO;
import kr.or.ddit.vo.GrdVO;
import kr.or.ddit.vo.JobVO;
import kr.or.ddit.vo.PstnVO;

@ControllerAdvice(basePackages="kr.or.ddit.mypage.controller")
public class OthersListAdviceMy {

	@Inject
	private OthersDAO othersDao;
	@Inject
	private EmpDAO empDao;
	
	@ModelAttribute("deptList")
	public List<DeptVO> deptList(){
		return othersDao.selectDeptList();
	}
	
	@ModelAttribute("dutyList")
	public List<DutyVO> dutyList(){
		return othersDao.selectDutyList();
	}
	
	@ModelAttribute("grdList")
	public List<GrdVO> grdList(){
		return othersDao.selectGrdList();
	}
	
	@ModelAttribute("jobList")
	public List<JobVO> jobList(){
		return othersDao.selectJobList();
	}
	
	@ModelAttribute("pstnList")
	public List<PstnVO> pstnList(){
		return othersDao.selectPstnList();
	}
	
	@ModelAttribute("LaborCaseList")
	public List<CmcodeVO> LaborCaseList(){
		return othersDao.LaborCaseList();
	}
	
	@ModelAttribute("incomeCaseList")
	public List<CmcodeVO> incomeCaseList(){
		return othersDao.incomeCaseList();
	}
	
	@ModelAttribute("asgmtList")
	public List<AsgmtVO> basicInfoRetrieve(
			@RequestParam(required=false) String empNo
			) {
		return empDao.selectAsgmtList(empNo);
	}

}
