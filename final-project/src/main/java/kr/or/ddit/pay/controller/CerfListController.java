package kr.or.ddit.pay.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.emp.dao.EmpDAO;
import kr.or.ddit.pay.dao.PayrollDAO;
import kr.or.ddit.pay.service.PayrollService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.IncCerfVO;
import kr.or.ddit.vo.PayrollVO;
import lombok.extern.slf4j.Slf4j;

//급여정산 - 급여명세서, 원천징수영수증 조회 (관리자)
@Slf4j
@Controller
@RequestMapping("/pay")
public class CerfListController {

	@Inject
	private PayrollService prService;
	
	@Inject
	private PayrollDAO prDAO;
	
	@Inject
	private EmpDAO empDAO;
	
	//모달창 내 사원목록 조회
	@ModelAttribute("empList")
	public List<EmpVO> empList(){
		return empDAO.selectEmpList();
	}
	
	//자료관리 페이지 (증명서 발급내역) 조회
	@GetMapping("/cerfList.do")
	public String cerfList(Model model) {
		List<IncCerfVO> cerfList = prDAO.selectCerfList();
		List<EmpVO> empCerfList = empDAO.selectEmpList();
		model.addAttribute("empCerfList", empCerfList);
		model.addAttribute("cerfList", cerfList);
		return "pay/cerf/cerfList";
	}
	
	//급여관련 증명서 발급시 내역 등록
	@PostMapping(value ="/cerfInsert.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public int cerfInsert(@RequestBody Map<String, Object> args) {
		return prDAO.insertCerf(args);
	}
	
	//모달창 내 선택한 사원의  급여명세서 목록 조회
	@PostMapping(value="/cerfStubList.do", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<PayrollVO> paystubCanvas(@RequestBody Map<String, Object> args){
		 return prDAO.selectProllbyYear(args);
	}
	
	
	//=======================================================================
	//[급여 · 급여정산] 카테고리 내 급여명세서, 원천징수영수증 PDF 다운로드 공통사용
	
	//선택한 급여명세서 세팅
	@PostMapping(value="/paystubPDF.do", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Map<String, Object> paystubPDF(@RequestBody Map<String, Object> args){
		//파라미터 사원번호, 정산번호, 템플릿번호
		
		//급여명세서 상세내역 (사원정보, 회사정보, 정산정보)
		return prService.paystubSettlement(args);
	}
	
	
	//원천징수영수증 세팅
	@PostMapping(value="/withholdPDF.do", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Map<String, Object> previewWhCerf(@RequestBody Map<String, Object> args){
		//파라미터 사원번호, 정산시작일, 정산종료일
		return prService.withholdSettlement(args);
	}
	

}
