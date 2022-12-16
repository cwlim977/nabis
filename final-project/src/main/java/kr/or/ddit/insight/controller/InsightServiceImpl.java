package kr.or.ddit.insight.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import kr.or.ddit.insight.dao.InsightDAO;
import kr.or.ddit.insight.service.InsightService;
import kr.or.ddit.vo.CnthxVO;
import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;

//@Slf4j
@Service
@RequiredArgsConstructor
public class InsightServiceImpl implements InsightService {
	
	private final InsightDAO dao;
	
	@Override
	public List<CnthxVO> cntCaseList() {
		return dao.cntCaseList();
	}

	@Override
	public String prEndRate(String prSdate, String prEdate) {
		//조회 시작일과 종료일을 모두 입력하지 않은 경우 또는 둘 중 하나만 입력하지 않은 경우에 모두, 두 값을 공백으로 채워준다. 
		if((prSdate==null || prSdate=="") && (prEdate==null || prEdate=="")) {
			prSdate = "";
			prEdate = "";
		}else if((prSdate==null || prSdate=="") || (prEdate==null || prEdate=="")) {
			prSdate = "";
			prEdate = "";
		}else { }
		
		return dao.prEndRate(prSdate, prEdate);
	}

	@Override
	public String outRateRetrieve(String outDate) {
		//조회일자를 입력하지 않은 경우 공백으로 채워준다. 
		if(outDate==null || outDate=="") {
			outDate="";
		}else { }
		
		return dao.outRateRetrieve(outDate);
	}

	@Override
	public HashMap<String, Object> sexRatioRetrieve() {
		return dao.sexRatioRetrieve();
	}

	@Override
	public List<HashMap<String, String>> serviceYearRetrieve() {
		return dao.serviceYearRetrieve();
	}

	@Override
	public List<Integer> ageRetrieve() {
		return dao.ageRetrieve();
	}

	@Override
	public List<Integer> avgSalaryRetrieve() {
		return dao.avgSalaryRetrieve();
	}

	@Override
	public List<HashMap<String, String>> workTimeRetrieve() {
		return dao.workTimeRetrieve();
	}

	@Override
	public List<HashMap<String, String>> sexPerDeptRetrieve() {
		return dao.sexPerDeptRetrieve();
	}

	@Override
	public List<HashMap<String, Object>> deptPerWageRetrieve() {
		return dao.deptPerWageRetrieve();
	}

	@Override
	public HashMap<String,String> memberCount(String selectedDate) {
		return dao.memberCount(selectedDate);
	}

	@Override
	public List<HashMap<String,String>> prMemberRetieve() {
		return dao.prMemberRetieve();
	}

	@Override
	public List<HashMap<String, String>> outPeriodTotal() {
		return dao.outPeriodTotal();
	}

	@Override
	public String avgOutPeriod() {
		return dao.avgOutPeriod();
	}
	
	
//	private final EmpDAO dao;
//	
//	private final OthersDAO otherDao;
//	
//	private final VacationDAO vacDao;
	
	

}
