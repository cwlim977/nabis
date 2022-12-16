package kr.or.ddit.emp.controller.advice;

import java.util.List;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import kr.or.ddit.emp.dao.OthersDAO;
import kr.or.ddit.mypage.service.MypageService;
import kr.or.ddit.vo.CmcodeVO;
import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.DutyVO;
import kr.or.ddit.vo.GrdVO;
import kr.or.ddit.vo.JobVO;
import kr.or.ddit.vo.PstnVO;

@ControllerAdvice(basePackages="kr.or.ddit.emp.controller")
public class OthersListAdvice {
	@Inject
	private OthersDAO othersDao;
	
	@Inject
	private MypageService mypageService;
	
	
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
	
	@ModelAttribute("labelList")
	public List<CmcodeVO> labelList(){
		return mypageService.selectLabel();
	}

	@ModelAttribute("incomeCaseList")
	public List<CmcodeVO> incomeCaseList(){
		return othersDao.incomeCaseList();
	}
	
}
