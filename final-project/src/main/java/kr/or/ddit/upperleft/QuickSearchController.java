package kr.or.ddit.upperleft;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.emp.dao.EmpDAO;
import kr.or.ddit.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class QuickSearchController {
	
	@Inject
	private EmpDAO dao;
/*	
	@RequestMapping(value="/quickSearch.do")
	public String quickSearch(
		@RequestParam(name="quick_search_tab", defaultValue="Root") String tabName
	) {
		return "upperleft/quickSearchTab"+tabName;
	}*/
	
	
	
	@PostMapping(value="/quickSearch.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<EmpVO> quickSearchEmp(
			String empNm
			){
		log.info("quickSearch controller empNm값 : {}", empNm);
		List<EmpVO> quickEmpList  = dao.quickSerchEmp(empNm);
		
		log.info("quickEmpList 값 {}",quickEmpList);
		
		return quickEmpList;
		
	}
}

