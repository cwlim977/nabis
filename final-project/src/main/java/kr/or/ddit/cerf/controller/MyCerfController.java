package kr.or.ddit.cerf.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
public class MyCerfController {
	
	
	
	@Inject
	private CerfDAO dao;
	
/*	@Inject
	private EmpDAO empDao;*/
	
	
	
	@RequestMapping(value="/cerf/myCerf.do")
	public String myCerf(
			HttpServletRequest req
			, Model model
			) {
		
		
		HttpSession session = req.getSession();
		String empNo =  (((EmpVO)session.getAttribute("authEmp")).getEmpNo());
		
		model.addAttribute("empVO", dao.selectCerfInfo(empNo));
		model.addAttribute("cerfList", dao.selectCerfList(empNo));
		model.addAttribute("empNo",empNo); 
		
		
		return "cerf/myCerf";
		
		
		
	}
	
	
	@GetMapping(value="/cerf/selectCerfInfo.do" ,produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	@ResponseBody
	public Map<String, EmpVO> selectCerfInfo(
			@RequestParam String empNo
			) {
		
		log.info("empNo {} ",empNo);
		EmpVO empVo =  dao.selectCerfInfo(empNo);
		
		
		
		Map<String, EmpVO> cerfInfo = new HashMap<String, EmpVO>();
		
		cerfInfo.put("empVo", empVo);
		
/*		log.info("empVo 값 {} ", empVo);
		
		String message = "";
		
		String dnm =  empVo.getDeptList().get(0).getDnm();//직무
		
		if(empVo == null) {
			message += "주조직";
			
		}else if(empVo != null) {
			
			if(empVo.getEmpAddr() == null) {
				message += "주소";
			}
		}*/
		return cerfInfo ;
		
		
	/*	
		//return empVo;
		if(empVo == null) {
			
			return "FAIL" ;
		}else {
		
			return "OK";
		}*/
	}
/*	@GetMapping(value="/cerf/selectCerfInfo.do" ,produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	@ResponseBody
	public EmpVO selectCerfInfo(
			@RequestParam String empNo
			) {
		
		log.info("empNo {} ",empNo);
		EmpVO empVo =  dao.selectCerfInfo(empNo);
		
		log.info("empVo 값 {} ", empVo);
		
		
		return empVo;
		/*	if(empVo == null) {
			
			return "FAIL" ;
		}else {
		
			return "OK";
		}
	}*/
	
	
	
/*	CerfVO cerfVo,
	Model model*/
/*	
	@GetMapping(value="/cerf/myWorkPDF.do")
	public String myWorkPDF(
			CerfVO cerfVo,
			Model model,
			Errors errors
			) {
		
		
		
	
			// 발급에 필요한 정보 select 
			EmpVO empVo =  dao.selectCerfInfo(cerfVo.getCfEmp());
		
			log.info("empVo 값 {}",empVo);
			
			
			// 생년월일, 재직기간, 발급 날자 에 년/월/일 을 붙여서 보내줌
			String bir = empVo.getEmpBir();
			String entDate = empVo.getEntDate();
			String sysDate = empVo.getCfDate();
			
			
			String reBir = bir.substring(0, 4) + "년 " + bir.substring(4, 6) + "월 " + bir.substring(6, 8) +  "일 ";
			String reEDate = entDate.substring(0,4) + "년 " + entDate.substring(5, 7) + "월 " + entDate.substring(8 , 10) + "일";
			String reToday = sysDate.substring(0, 4) + "년 " + sysDate.substring(5, 7) + "월 " + sysDate.substring(8, 10) + "일";
			
			
			empVo.setEmpBir(reBir);
			empVo.setEntDate(reEDate);
			empVo.setCfDate(reToday);
			
			model.addAttribute("empVo",empVo );
			model.addAttribute("cerfVo", cerfVo);
			log.info("empVo값 {}",empVo);
			
			
			return "/cerf/myWorkPDF";
			

	}
	*/
	
	
	@GetMapping(value="/cerf/myWorkPDF.do" , produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> myWorkPDF(
			CerfVO cerfVo
			
			) {
		
			Map<String, Object> PDFList = new HashMap<>();
			
			
		
	
			// 발급에 필요한 정보 select 
			EmpVO empVo =  dao.selectCerfInfo(cerfVo.getCfEmp());
		
			log.info("empVo 값 {}",empVo);
			
			
			// 생년월일, 재직기간, 발급 날자 에 년/월/일 을 붙여서 보내줌
			String bir = empVo.getEmpBir();
			String entDate = empVo.getEntDate();
			String sysDate = empVo.getCfDate();
			
			
			String reBir = bir.substring(0, 4) + "년 " + bir.substring(4, 6) + "월 " + bir.substring(6, 8) +  "일 ";
			String reEDate = entDate.substring(0,4) + "년 " + entDate.substring(5, 7) + "월 " + entDate.substring(8 , 10) + "일";
			String reToday = sysDate.substring(0, 4) + "년 " + sysDate.substring(5, 7) + "월 " + sysDate.substring(8, 10) + "일";
			
			
			empVo.setEmpBir(reBir);
			empVo.setEntDate(reEDate);
			empVo.setCfDate(reToday);
			
			
			int row =  dao.insertCerf(cerfVo); 
			
		
			log.info("증명서 insert 후 cfNo select {}", cerfVo.getCfNo());
			PDFList.put("cfNo", cerfVo.getCfNo());
			PDFList.put("empVo", empVo);
			PDFList.put("result", row);
			PDFList.put("cerfList", dao.selectCerfList(cerfVo.getCfEmp()));
			
			
			log.info("empVo값 {}",empVo);
			
			
			return PDFList;
			

	}
}
