package kr.or.ddit.emp.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.commons.util.SimpleExcelFile;
import kr.or.ddit.commons.validate.InsertGroup;
import kr.or.ddit.emp.dao.EmpDAO;
import kr.or.ddit.emp.service.EmpService;
import kr.or.ddit.vo.AsgmtVO;
import kr.or.ddit.vo.CnthxVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/emp")
public class EmpController {
	
	@Inject
	private EmpService service; 
	@Inject
	private EmpDAO dao;
	
	@ModelAttribute("emp")
	public EmpVO member() {
		return new EmpVO();
	}
	
	/**
	 * 사원 List 페이지 이동
	 * @return "empManager/empList"
	 */
	@GetMapping("empList.do")
	public String empList() {	return "empManager/empList";	}
	/**
	 * 사원 Table형태 List 페이지 이동
	 * @return "empManager/empTable"
	 */
	@GetMapping("empTable.do")
	public String empTableList() {	return "empManager/empTable";	}
	
	@GetMapping(value ={"empList.do","empTable.do"}
			,produces=MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public PagingVO<EmpVO> empListajax(
			@RequestParam(name="page", defaultValue="1") int currentPage
			, SearchVO simpleCondtion
			) {
		
		PagingVO<EmpVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		
		pagingVO.setSimpleCondition(simpleCondtion);

		int totalRecord = service.retrieveEmpCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<EmpVO> empList = service.retrieveEmpList(pagingVO);
		pagingVO.setDataList(empList);
		
		return pagingVO;
	}
	
	
	/**
	 * 사원 계약상태 리스트 조회
	 * @param cntStFilter - 계약상태 필터검색용 파라미터
	 * @param model
	 * @return "empManager/cntStatusList"
	 */
	@GetMapping(value="cntStatusList.do")
	public String cntStatus(
			@RequestParam(required=false) String[] cntStFilter
			, Model model
			) {
		
		Map<String,Object> map = new HashMap<>();
		if(cntStFilter != null) {
			log.info("cntStatusList.do 요청파라미터{}", Arrays.toString(cntStFilter));
			map.put("paramArr", cntStFilter);
		}
		
		List<EmpVO> empList = service.retrieveEmpCntStatusList(map);
		int prRecord = dao.selectEmpCntStatusPrRecord();
		int wageRecord = dao.selectEmpCntStatusWageRecord();
		int wkRecord = dao.selectEmpCntStatusWkRecord();
		model.addAttribute("empList", empList);
		model.addAttribute("prRecord", prRecord);
		model.addAttribute("wageRecord", wageRecord);
		model.addAttribute("wkRecord", wkRecord);
		
		return "empManager/cntStatusList";
	}
	
	
	
	
	/**
	 * 사원 추가 Get 조회
	 * @param model
	 * @return "/empManager/empForm"
	 */
	@GetMapping("empForm.do")
	public String empInsert(Model model) {
		return "/empManager/empForm";
	}
	
	/**
	 * 사원 추가 Post 전송 
	 * @param model
	 * @param request - 세션꺼내기
	 * @param emp - 추가할 사원정보를 담은 객체 
	 * @param asgmt - 추가사원 입사시 인사정보를 담은 인사발령객체
	 * @param errors
	 * @return
	 */
	@PostMapping("empForm.do")
	public String doPost(
			Model model
			, HttpServletRequest request
			, @ModelAttribute("emp") @Validated(InsertGroup.class) EmpVO emp 
			, Errors errors
			, AsgmtVO asgmt
			, CnthxVO cnthx
			){
		
		// 인사발령,임금,근로계약 작성자를 기록하기위해 세션에서 아이디를 꺼내 변수에 저장한다.
		HttpSession session = request.getSession();
	    asgmt.setWriter(((EmpVO)session.getAttribute("authEmp")).getEmpNo());
	    cnthx.setCntWriter(((EmpVO)session.getAttribute("authEmp")).getEmpNo());
	    
		String message = null; 
		model.addAttribute("emp", emp);
		
		log.info("empForm 사원추가 요청파라미터 emp : {}",emp);
		log.info("empForm 사원추가 요청파라미터 asgmt : {}",asgmt);
		
		String logicalViewName = null;
		if(!errors.hasErrors()){
			ServiceResult result = service.createEmp(emp, asgmt, cnthx);
			switch (result) {
			case PKDUPLICATED:
				message = " 사원번호 중복.";
				logicalViewName = "/empManager/empForm";
				break;
			case OK:
				logicalViewName = "redirect:/emp/empList.do";
				break;
			default:
				message = " 생성중 문제가 발생하였습니다. 잠시후 다시 시도 부탁드립니다.";
				logicalViewName = "/empManager/empForm";
				break;
			}
		}else{
			logicalViewName = "/empManager/empForm";
		}
		model.addAttribute("message", message);
		return logicalViewName;
		
	}
	
	@GetMapping("excelDown.do")
	public void excelDownload(HttpServletResponse response) throws IOException, IllegalAccessException, IllegalArgumentException, InvocationTargetException{
		//엑셀에 실제로 담을 데이터  페이징 없이 전체 데이터를  list로 
		List<EmpVO> empList= service.getExcelEmpList();
			
		String sheetName="구성원리스트";
		
		
		SimpleExcelFile simpleExcelFile= new SimpleExcelFile(sheetName, EmpVO.class, empList);
		//생성자에서 sheet이름, columnName, Body생성
		 
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		String today = format.format(now);
		// 컨텐츠 타입과 파일명 지정
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename=NABIS_EMPLIST_"+today+".xlsx");
		simpleExcelFile.write(response.getOutputStream());
	}
}
