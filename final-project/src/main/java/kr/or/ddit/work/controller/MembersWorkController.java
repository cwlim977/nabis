package kr.or.ddit.work.controller;


import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.util.SimpleExcelFile;
import kr.or.ddit.emp.service.EmpService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.ExcelWorkVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.WorkVO;
import kr.or.ddit.work.dao.WorkDAO;
import kr.or.ddit.work.service.WorkService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/work")
public class MembersWorkController {
	
	@Inject
	WorkDAO dao;
	
	@Inject
	WorkService workService;
	
	@Inject
	EmpService empSerivce;
	
	/**
	 * 사원들 근무기록 조회 페이지 이동
	 * @return
	 */
	@GetMapping(value ="members.do")
	public String members() {
		return "work/members";
	}
	
	/**
	 * 비동기 사원들 근무기록 조회
	 * @return 
	 */
	@PostMapping(value = "members.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public PagingVO<EmpVO> empWorkListAjax(
								@RequestParam(required=false) String dcode
								, @RequestParam(defaultValue="0", required=true) Integer num
								,@RequestParam(name="page", defaultValue="1") int currentPage
			) {
		log.info("myWork.do 비동기 요청 파라미터 : {}", dcode ,num);
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("dcode", dcode);
		paramMap.put("num", num);
		
		PagingVO<EmpVO> pagingVO = new PagingVO<>();
		pagingVO.setCurrentPage(currentPage);
		
		pagingVO.setDataMap(paramMap);

		int totalRecord = dao.selectEmpWorkApListCnt(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		List<EmpVO> workApList = dao.selectEmpWorkApList(pagingVO);
		pagingVO.setDataList(workApList);
		
		return pagingVO;
	}
	
	@GetMapping(value ="memberwork.do")
	public String list(
				HttpServletRequest request
				, Model model
				, @RequestParam(required=true) String empNo 
				){
		EmpVO emp = empSerivce.retrieveEmp(empNo);
		List<WorkVO>  workList = dao.selectWorkList();
		
		model.addAttribute("workList", workList); 
		model.addAttribute("empVO" , emp);
		model.addAttribute("empNo", empNo); 
		return "work/memberWork";
	}
	
	@GetMapping("excelDown.do")
	public void excelDownload(
				HttpServletResponse response
				,@RequestParam(required=true) String sDate
				,@RequestParam(required=true) String eDate
			) throws IOException, IllegalAccessException, IllegalArgumentException, InvocationTargetException{
		log.info("excelDown.do 요청 파라미터 sDate : {}, eDate : {}", sDate, eDate);
		
		//엑셀에 실제로 담을 데이터  페이징 없이 전체 데이터를  list로 
		List<ExcelWorkVO> excelList= workService.workExcelList(sDate, eDate);
			
		String sheetName="근태리스트";
		
		
		SimpleExcelFile simpleExcelFile= new SimpleExcelFile(sheetName, ExcelWorkVO.class, excelList);
		//생성자에서 sheet이름, columnName, Body생성
		 

		// 컨텐츠 타입과 파일명 지정
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename=All_Period_Work_History_Report["+sDate+"-"+eDate+"].xlsx");
		simpleExcelFile.write(response.getOutputStream());
	}
}
