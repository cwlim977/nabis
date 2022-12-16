package kr.or.ddit.emp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.emp.dao.EmpDAO;
import kr.or.ddit.emp.service.EmpService;
import kr.or.ddit.vo.AsgmtVO;
import kr.or.ddit.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/emp")
public class EmpTransferController {

	@Inject
	private EmpService service;
	
	@Inject
	private EmpDAO dao;
	
	// 인사 발령 내역 조회
	@GetMapping(value = "empTransferList.do")
	public String empTransferList() {
		return "empManager/empTransferList";
	}
	/**
	 * 비동기 전체인사발령 내역 조회
	 * @return 
	 */
	@PostMapping(value = "empTransferList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<AsgmtVO> empTransferListAjax() {
		log.info("empTransferList.do 비동기 요청");
		
		List<AsgmtVO>  transferList = dao.selectAllAsgmtList();
		return transferList;
	}
	/**
	 * 비동기 인사발령 상세내역 조회
	 * @return 
	 */
	@GetMapping(value = "empTransferDetail.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<EmpVO> empTransferDetailAjax(@RequestParam String asgmtNo) {
		log.info("empTransferDetail.do 비동기 요청");
		
		List<EmpVO>  transferDetailList = dao.selectAsgmtDetail(asgmtNo);
		return transferDetailList;
	}

	// 메모 수정
	@GetMapping(value = "empTransferUdate.do")
	public String empTransferUpdate() {
		return "empManager/empTransferList";
	}

	// 발령 취소
	@GetMapping(value = "empTransferDelete.do")
	public String empTransferDelete() {
		return "empManager/empTransferList";
	}

	/**
	 * 비동기 인사발령 대상목록 조회
	 * @param searchParam - 부서코드 검색파라미터
	 * @return 
	 */
	@PostMapping(value = "empList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public List<EmpVO> empList(@RequestBody Map<String, Object> searchParam) {
		log.info("empList.do 요청 파라미터 : {}", searchParam);
		
		List<EmpVO> empList = dao.selectEmpListSearch(searchParam);
		return empList;
	}
	
	/**
	 * 인사발령 
	 * 사원 여러명의 동시 인사발령
	 * @param asgmtList - 사원들의 인사발령 정보
	 * @param request - 세션에서 사원번호를 꺼내기 위함.
	 * @return
	 */
	@PostMapping(value = "empTransferInsert.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> empTransferInsert(
			@RequestBody List<AsgmtVO> asgmtList
			, HttpServletRequest request
			) {
		log.info("empTransferInsert.do 요청 파라미터 : {}", asgmtList);
		
		// 인사발령 작성자를 기록하기위해 세션에서 아이디를 꺼내 변수에 저장한다.
		HttpSession session = request.getSession();
		String writer = ((EmpVO)session.getAttribute("authEmp")).getEmpNo();
		
		String status = "fail";
		
		ServiceResult result = service.createAsgmts(asgmtList, writer);
		log.info("createAsgmts() result 값 {}",result );
		
		switch (result) {
			case OK:
				status = "success";
				break;
				
			case FAIL:
				status = "fail";
				break;
				
			default:
				status = "fail";
				break;
		}
		
		Map<String, Object> jsonDate = new HashMap<String, Object>();
		jsonDate.put("status", status);
		return jsonDate;
		
	}

}
