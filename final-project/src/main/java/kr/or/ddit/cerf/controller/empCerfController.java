package kr.or.ddit.cerf.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.cerf.dao.CerfDAO;
import kr.or.ddit.emp.dao.EmpDAO;
import kr.or.ddit.vo.CerfVO;
import kr.or.ddit.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/cerf")
public class empCerfController {
	
	@Inject
	private CerfDAO dao; 
	
	@Inject
	private EmpDAO empDao;
	
	@GetMapping(value="/empCerf.do")
	public String company(Model model) {
		
	
			
			
		List<EmpVO> cerfList = dao.selectCerfEmpList();	
		
		log.info("cerfList {} ", cerfList);
			model.addAttribute("cerfList",cerfList);
		return "cerf/empCerf";
	}
	
	
	
	@GetMapping(value="/searchCerf.do", produces= MediaType.APPLICATION_JSON_UTF8_VALUE )
	@ResponseBody
	public List<EmpVO> searchCerfList(
			@RequestParam String empNm
			){
		List<EmpVO> searchCerf =  dao.searchCerfList(empNm);		
		return searchCerf;
	}
	
	
	
	
	
	@GetMapping(value="/empCerfSelect.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<CerfVO> empCerfSelect(
			@RequestParam() String cfEmp  
			){
		
			List<CerfVO> empCerfList = dao.selectCerfList(cfEmp);
			log.info("empCerfList", empCerfList);
			return empCerfList;
		
			}
}