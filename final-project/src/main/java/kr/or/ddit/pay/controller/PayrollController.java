package kr.or.ddit.pay.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.commons.util.SimpleExcelFile;
import kr.or.ddit.pay.dao.PayrollDAO;
import kr.or.ddit.pay.service.PayTmpService;
import kr.or.ddit.pay.service.PayrollService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.ExcelPayVO;
import kr.or.ddit.vo.ExcelWorkVO;
import kr.or.ddit.vo.PayRcdVO;
import kr.or.ddit.vo.PayTmpVO;
import kr.or.ddit.vo.PayrollSetVO;
import kr.or.ddit.vo.PayrollVO;
import kr.or.ddit.vo.PrEmpVO;
import lombok.extern.slf4j.Slf4j;

//급여정산
@Slf4j
@Controller
@RequestMapping("/pay")
public class PayrollController {
	
	/*급여 정산 (급여정산 홈, 정산, 지난 정산내역) */
	/*급여*/
	
	@Inject
	private PayrollService prService;
	
	@Inject
	private PayTmpService tmpService;
	
	@Inject
	private PayrollDAO prDAO;
	
	@ModelAttribute("proll")
	public PayrollVO payroll() {
		return new PayrollVO();
	}
	
	@ModelAttribute("premp")
	public PrEmpVO premp() {
		return new PrEmpVO();
	}
	
	//[급여정산]=============================================================================================
	
	//급여정산 홈 조회
	@GetMapping("/payHome.do")
	public String payHome(
//		@ModelAttribute("proll") @Validated PayrollVO proll
		Model model
	) {
		List<PayTmpVO> tmpList = tmpService.retrievePayTmpList();
		model.addAttribute("tmpList", tmpList); //급여템플릿 목록
		return "pay/payHome";
	}
	
	String message = null;		
	String logicalViewName = null;
	
	
	//급여정산 - 템플릿 선택해서 급여대장 생성
	@PostMapping("payrollInsert.do")
	@ResponseBody
	public Map<String, Object> prollInsert(
		@ModelAttribute("proll") @Validated PayrollVO proll
	) {
		ServiceResult result = prService.createProll(proll);
		
		String status = "";
		if(ServiceResult.OK.equals(result)) {
			status = "SUCCESS";
		}else {
			status = "FAIL";
		}
		
		String prNo = proll.getPrNo();
		String prPtno = proll.getPrPtno();
		
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("prNo", prNo);
		data.put("prPtno", prPtno);
		data.put("status", status);
		return data;
	}
	
	//급여정산 - 급여대장 삭제
	@PostMapping("prollDelete.do")
	@ResponseBody
	public String prollDelete(
		@RequestParam(name="prNo", required=true) String prNo
	) {
		ServiceResult result = prService.removeProll(prNo);
		
		if(ServiceResult.OK.equals(result)) { 
			return "SUCCESS";
		}else {
			return "FAIL";
		}
	}
	
	//급여정산 - 대상자조회
	@PostMapping("wageEmp.do")
	public String empList(
		     PayrollVO payroll
		  //, @ModelAttribute("proll") PayrollVO proll
		  , Model model
	) {
		log.info("payroll{} " + payroll );
		PayrollVO resproll = prService.retrieveProll(payroll);
		List<EmpVO> settledEmpList = prService.empSettlement(payroll);
		
		model.addAttribute("proll", resproll);					//급여대장정보
		model.addAttribute("settledEmpList", settledEmpList);	//근무기록 있는 대상자목록 출력
		log.info("resproll{}",resproll);
		log.info("settledEmpList{}",settledEmpList);
		return "pay/wage/wageEmp";
	}
	
	//급여정산 - 대상자 선택 후 확정
	@PostMapping(value="payempInsert.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> payEmpIns(
		@RequestBody List<PrEmpVO> payempList
	){
		log.info("payempList {}",payempList);
		ServiceResult result = prService.createPayEmp(payempList);
		
		String status = "";
		
		if(ServiceResult.OK.equals(result)) { 
			status = "SUCCESS";
		}else {
			status = "FAIL";
		}
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("status", status);
		return data;
	}
	
	//급여정산 - 지급항목 조회
	@PostMapping("wagePay.do")
	public String wagePay(
		PayrollVO payroll,	Model model
	) {
		PayrollVO  proll = prService.retrieveProll(payroll);
		List<PayrollSetVO> settledAlwList = prService.alwSettlement(payroll);
		model.addAttribute("proll", proll);
		model.addAttribute("settledAlwList", settledAlwList);
		
		return "pay/wage/wagePay";
	}
	
	
	//급여정산 - 사원의 항목 별 금액을 정산기록에 등록한다
	@PostMapping(value ="payrcdInsert.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> wagePayIns(
		@RequestBody List<PayRcdVO> payrcdList
	){
		log.info("payrcdList {}",payrcdList);
		ServiceResult result = prService.createPayRcd(payrcdList);
		
		String status = "";
		
		if(ServiceResult.OK.equals(result)) { 
			status = "SUCCESS";
		}else {
			status = "FAIL";
		}
		
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("status", status);
		return data;
	}
	
	//급여정산 - 공제항목 조회
	@PostMapping("wageDed.do")
	public String wageDed(
		  PayrollVO payroll
		, @ModelAttribute("proll") PayrollVO proll
		, Model model
	) {
		PayrollVO resproll = prService.retrieveProll(payroll);
		model.addAttribute("proll", resproll);

		List<PayrollSetVO> settledTaxList = prService.taxSettlement(payroll);
		model.addAttribute("settledTaxList", settledTaxList);
		
		log.info("settax {}", settledTaxList);
		
		return "pay/wage/wageDed";
	}
	
	//급여정산 - 정산 미리보기 조회
	@PostMapping("wagePrev.do")
	public String wagePrev(
		  PayrollVO payroll
		, @ModelAttribute("proll") PayrollVO proll
		, Model model
	) {
		//이번 정산 요약 정보
		proll = prService.retrieveProll(payroll);
		List<PayRcdVO> sumList = prService.retrievePaySumList(payroll.getPrNo());
		List<PayRcdVO> totalList = prService.retreiveTotalSumList(payroll.getPrNo());

		//이번 정산 상세 정보
		List<EmpVO> settledEmpList = prService.prevEmpSettlement(payroll);
		List<PayRcdVO> settledDetailList = prService.retrieveProllRecordList(payroll.getPrNo());
		
		//지난 정산 요약 정보
		Map<String, Object> prvMap = prService.prevSettlement(payroll);
		@SuppressWarnings("unchecked")
		List<PayRcdVO> prevSumList = (List<PayRcdVO>) prvMap.get("prevSumList");
		@SuppressWarnings("unchecked")
		List<PayRcdVO> prevTotalList = (List<PayRcdVO>) prvMap.get("prevTotalList");
		
		model.addAttribute("proll", proll);					  		// 다음 페이지 이동, 이번정산 정보
		model.addAttribute("sumList", sumList);				  		// 정산 별 요약 목록 조회
		model.addAttribute("totalList", totalList); 		  		// 정산 별 총 인원수, 총 합계 조회
		model.addAttribute("prevSumList",prevSumList);		  		// 이전 정산 별 요약 목록 조회
		model.addAttribute("prevTotalList",prevTotalList);	  		// 이전 정산 별 총 인원수, 총 합계 조회
		model.addAttribute("prevBlg", prvMap.get("prevBlg")); 		// 이전 정산 귀속월
		model.addAttribute("settledEmpList",settledEmpList);  		// 이번 정산 대상자 상세 정보
		model.addAttribute("settledDetailList",settledDetailList);  // 이번 정산 항목별 상세 정보
		
		log.info("prevSum {}", prevSumList);
		log.info("prevTotal {}", prevTotalList);
		log.info("settledDetailList {}", settledDetailList);
		return "pay/wage/wagePrev";
	}
	
	// 정산 완료 등록 처리 (지급총액, 공제총액, 실지급액, 정산완료일, 정산완료여부 수정)
	@PostMapping("updateProllFin.do")
	@ResponseBody
	public String updateProllFin(
		PayrollVO completeProll
	) {
		ServiceResult result = prService.modifyProllFin(completeProll);
		
		if(ServiceResult.OK.equals(result)) { 
			return "SUCCESS";
		}else {
			return "FAIL";
		}
	}
	
	
	
	//급여정산 - 정산 결과 조회
	@PostMapping("wageRes.do")
	public String wageRes(
		PayrollVO payroll
		,Model model
	) {
		PayrollVO proll = prService.retrieveProll(payroll);								//이번 정산 정보
		List<PayRcdVO> totalList = prService.retreiveTotalSumList(payroll.getPrNo());	//이번 정산 총 계
		
		Map<String, Object> prevMap = prService.resSettlement(payroll);
		PayrollVO prevProll =  (PayrollVO) prevMap.get("setPrevProll");				//지난 정산 정보
		@SuppressWarnings("unchecked")
		List<PayRcdVO> prevTotalList = (List<PayRcdVO>) prevMap.get("setPrevTotalList"); //지난 정산 총 계
		
		model.addAttribute("proll", proll); 				//이번정산 정보
		model.addAttribute("totalList", totalList); 		//이번정산 총 계
		model.addAttribute("prevProll", prevProll); 		//지난정산 정보
		model.addAttribute("prevTotalList", prevTotalList); //지난정산 총 계
		
		return "pay/wage/wageRes";
	}
	
	//급여정산 - 정산 결과 엑셀다운
	@GetMapping("excelDown.do")
	public void excelDownload(
				HttpServletResponse response
				,@RequestParam(required=true) String prNo
				,@RequestParam(required=true) String transferDate
			) throws IOException, IllegalAccessException, IllegalArgumentException, InvocationTargetException{
		log.info("excelDown.do 요청 파라미터 prNo : {}, transferDate : {}", prNo, transferDate);
		
		//엑셀에 실제로 담을 데이터  페이징 없이 전체 데이터를  list로 
		List<ExcelPayVO> excelList= prService.salaryTransferExcelList(prNo, transferDate);
			
		String sheetName="급여이체리스트";
		
		
		SimpleExcelFile simpleExcelFile= new SimpleExcelFile(sheetName, ExcelPayVO.class, excelList);
		//생성자에서 sheet이름, columnName, Body생성
		 

		// 컨텐츠 타입과 파일명 지정
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename=salaryTransferList["+transferDate+"].xlsx");
		simpleExcelFile.write(response.getOutputStream());
	}
	
	
	
	//[지난정산내역]========================================================================================
	
	//지난 정산 내역 페이지 이동
	@GetMapping("/pastPayroll.do")
	public String payrollList() {
		return "pay/pastPayroll";
	}
	
	//선택한 귀속연도에 해당하는 정산 내역 목록
	@PostMapping(value="/payrollBelong.do", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<PayrollVO> payrollBelong(@RequestBody Map<String, String> args) {
		return prDAO.selectProllList(args.get("blgYear"));
	}
	
	
	//[급여]=============================================================================================
	
	//급여 페이지 이동
	@GetMapping("/paystub.do")
	public String paystub() {
		return "pay/stub/paystub";
	}
	
	//급여명세 총금액 구하기 -- param : 사원번호, 정산번호
	@PostMapping(value="/paystubTotal.do", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<PayRcdVO> paystubTotal(@RequestBody Map<String, Object> args){
		return prDAO.selectTotalStub(args); //param args : 사원번호, 정산번호
	}
	
	//선택한 귀속연도의 급여명세 목록 조회
	@PostMapping(value="/paystubBelong.do", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<PayrollVO> paystubBelong(@RequestBody Map<String, Object> args){
		return prService.paystubListSettlement(args); //param args : 귀속연도, 사원번호, 정산번호
	}
	
	//선택한 급여명세 상세정보 조회
	@PostMapping(value="/retrievePaystub.do", produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Map<String, Object> paystubCanvas(@RequestBody Map<String, Object> args){
		 return prService.paystubSettlement(args);
	}
	
	
	

}
