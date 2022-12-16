package kr.or.ddit.mypage.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.mypage.service.MypageService;
import kr.or.ddit.vo.CnthxVO;
import kr.or.ddit.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value="/mypage")
public class ContractInfoController {
	@Inject
	private MypageService service;
	
	
		// ajax 조회용, 근로계약목록 가져오기
		@GetMapping(value="/WorkCntRetrieve.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
		@ResponseBody
		public List<CnthxVO> WorkCntRetrieve(@RequestParam(name="empNo", required=true )String empNo) {
			//근로계약정보 model에 저장
			List<CnthxVO> WorkList = service.WorkCntRetrieve(empNo);
			
			return WorkList;
		}
		
		// ajax 조회용, 임금계약목록 가져오기
		@GetMapping(value="/WageCntRetrieve.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
		@ResponseBody
		public List<CnthxVO> WageCntRetrieve(@RequestParam(name="empNo", required=true )String empNo) {
			//근로계약정보 model에 저장
			List<CnthxVO> WageList = service.WageCntRetrieve(empNo);
			
			return WageList;
		}
	
	
	// 계약 정보  조회
	@GetMapping(value="/contractInfoRetrieve.do")
	public String recentWkCntRetrieve(@RequestParam(name="empNo", required=true )String empNo, Model model) {
		EmpVO hrInfo = service.selectHrInfoList(empNo);
		model.addAttribute("empVo", hrInfo);
		
		//근로계약정보 model에 저장
		CnthxVO lbCntHxList = service.selectRecentWkList(empNo);
		model.addAttribute("lbCntHxList", lbCntHxList);
		
		//임금계약정보 model에 저장
		CnthxVO WgCntHxList = service.selectRecentWageList(empNo);
		model.addAttribute("WgCntHxList", WgCntHxList);
		
		log.info("empNo : {}", empNo);
		log.info("lbCntHxList : {}", lbCntHxList);
		log.info("WgCntHxList : {}", WgCntHxList);
		
		return "mypage/contractInfoList";
	}

	
	// ajax 조회용, 기존 정보 가져오기. 수정등등.. ajax에서 dataType json으로 받을래요 하는건 이리로 옴
	@GetMapping(value="/contractInfoRetrieve.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public CnthxVO recentWkCntRetrieve(@RequestParam(name="empNo", required=true )String empNo) {
		//근로계약정보 model에 저장
		CnthxVO lbCntHxList = service.selectRecentWkList(empNo);
		
		return lbCntHxList;
	}
	
	// ajax 조회용, 기존 정보 가져오기. 수정등등.. ajax에서 dataType json으로 받을래요 하는건 이리로 옴
	@GetMapping(value="/wgcontractInfoRetrieve.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public CnthxVO recentWgCntRetrieve(@RequestParam(name="empNo", required=true )String empNo) {
		//근로계약정보 model에 저장
		CnthxVO wgCntHxList = service.selectRecentWageList(empNo);
		
		return wgCntHxList;
	}
	
//----------추가됨------------->>
	// ajax 조회용, 근로,임금계약 목록에서 개별 상세정보를 조회하는 메서드
	@GetMapping(value="/choosenCntRetrieve.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public CnthxVO choosenWkRetrieve(@RequestParam(name="cnthxNo", required=true )String cnthxNo) {
		//근로계약정보 model에 저장
		CnthxVO choosenCntInfo = service.choosenCntRetrieve(cnthxNo);
		log.info("choosenCntInfo : {}", choosenCntInfo);
		
		return choosenCntInfo;
	}
	
	
	
	// 근로계약 정보 추가
	@PostMapping(value="/LaborCntInfoInsert.do")
	@ResponseBody
	public String LaborCntInfoInsert(@RequestParam(name="cntCngr", required=true )String empNo, @ModelAttribute("lcntInfo") CnthxVO lcntInfo, Model model ) {
		EmpVO hrInfo = service.selectHrInfoList(empNo);
		model.addAttribute("empVo", hrInfo);
		
		log.info("insert controller's empNo {}",empNo);
		
		int res = service.insertLaborCrt(lcntInfo);
		if(res > 0) 
			return "SUCCESS";
		return "FAIL";
	}
	
	// 근로계약 정보 수정
	@PostMapping(value="/LaborCntInfoUpdate.do")
	@ResponseBody
	public String LaborCntInfoUpdate(@RequestParam(name="cntEditor", required=true )String empNo, @ModelAttribute("lcntInfo") CnthxVO lcntInfo, Model model ) {
		EmpVO hrInfo = service.selectHrInfoList(empNo);
		model.addAttribute("empVo", hrInfo);
		
		log.info("update controller's empNo {}",empNo);
		
		int res = service.updateRctWkList(lcntInfo);
		if(res > 0) 
			return "SUCCESS";
		return "FAIL";
	}
	
	// 근로계약 정보 삭제
	@PostMapping(value="/LaborCntInfoDelete.do")
	@ResponseBody
	public String LaborCntInfoDelete(@RequestParam(name="cnthxNo", required=true )String cnthxNo, Model model ) {
		int res = service.deleteRctWkList(cnthxNo);
		if(res > 0) 
			return "SUCCESS";
		return "FAIL";
	}
	
	
	// 임금계약 정보 추가
		@PostMapping(value="/WageCntInfoInsert.do")
		@ResponseBody
		public String WageCntInfoInsert(@RequestParam(name="cntCngr", required=true )String empNo, @ModelAttribute("wcntInfo") CnthxVO wcntInfo, Model model ) {
			EmpVO hrInfo = service.selectHrInfoList(empNo);
			model.addAttribute("empVo", hrInfo);
			
			log.info("insert controller's empNo {}",empNo);
			
			int res = service.insertWageCrt(wcntInfo);
			if(res > 0) 
				return "SUCCESS";
			return "FAIL";
		}
		
		// 임금계약 정보 수정
		@PostMapping(value="/WageCntInfoUpdate.do")
		@ResponseBody
		public String WageCntInfoUpdate(@RequestParam(name="cntEditor", required=true )String empNo, @ModelAttribute("wcntInfo") CnthxVO wcntInfo, Model model ) {
			EmpVO hrInfo = service.selectHrInfoList(empNo);
			model.addAttribute("empVo", hrInfo);
			
			log.info("update controller's empNo {}",empNo);
			
			int res = service.updateRctWgList(wcntInfo);
			if(res > 0) 
				return "SUCCESS";
			return "FAIL";
		}
}
