package kr.or.ddit.pay.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.emp.dao.EmpDAO;
import kr.or.ddit.pay.dao.PensionDAO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PensionVO;
import lombok.extern.slf4j.Slf4j;

// 퇴직소득 조회

@Slf4j
@Controller
public class ServListController {
	@Inject
	EmpDAO empDAO;
	
	@Inject
	PensionDAO pensionDAO;
	
	
	@RequestMapping(value="/pay/servList.do")
	public String dedList(Model model) {
		log.info("호출됨");
		
		List<EmpVO> empList =empDAO.selectEmpList();
		List<PensionVO> pensionList =pensionDAO.selectPensionList();
		
		model.addAttribute("empList",empList);
		model.addAttribute("pensionList",pensionList);
		
		
		return "pay/serv/servList";
	}
	
	@ResponseBody
	@GetMapping(value="/pay/servList.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Map<String, Object> EPMap() {
		
		List<EmpVO> empList =empDAO.selectEmpList();
		List<PensionVO> pensionList =pensionDAO.selectPensionList();
		
		log.info("pensionList{}",pensionList.toString());
		Map<String, Object> EPMap = new HashMap<String, Object>();
		
		EPMap.put("empList", empList);
		EPMap.put("pensionList", pensionList);
		log.info("EPMap{}",EPMap.toString());
		
		return EPMap;
	}

}
