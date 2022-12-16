package kr.or.ddit.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;
import org.apache.tiles.autotag.core.runtime.annotation.Parameter;
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
import kr.or.ddit.commons.validate.DeleteGroup;
import kr.or.ddit.commons.validate.InsertGroup;
import kr.or.ddit.commons.validate.UpdateGroup;
import kr.or.ddit.mypage.service.MypageService;
import kr.or.ddit.vo.AccaVO;
import kr.or.ddit.vo.CareerVO;
import kr.or.ddit.vo.CmcodeVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.GrdVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Slf4j
@RequiredArgsConstructor
@Controller
public class CareerInfoController {

	@Inject
	private final MypageService service;
	
	@ModelAttribute("empVo")
	public EmpVO emp() {
		return new EmpVO();
	}
	
	@ModelAttribute("careerVO")
	public CareerVO career() {
		return new CareerVO();
	}
	
	
	@ModelAttribute("gradeClfList")
	public List<CmcodeVO> gradClfList(){
		return service.selectGradeClfList();
	}
	
	@ModelAttribute("acClfList")
	public List<CmcodeVO> acClfList(){
		return service.selectAcClfList();
	}
	
	
	// 경력/학력 정보 조회
	@RequestMapping(value="/mypage/careerInfoRetrieve.do")
	public String careerRetrieve(
		
		@RequestParam(name="empNo", required=true)String empNo,
		Model model
		) {
	
		EmpVO empVo = service.selectEmp(empNo);
		model.addAttribute("empVo",empVo);
		List<CareerVO> careerVo = service.selectCareer(empNo);
		model.addAttribute("careerVO", careerVo);	
		
		
/*		List<CmcodeVO> gradeClfList = service.selectGradeClfList();
		List<CmcodeVO> acClfList = service.selectAcClfList();
		*/
	return "mypage/careerInfoList";
	}
	
	
	
	@GetMapping(value="/mypage/careerList.do")
	@ResponseBody
	public Map<String, Object> careerList(){
		
		Map<String, Object> map = new HashMap<>();
		
		List<CmcodeVO> cntCaseList = service.selectCaCntCaseList();
		List<CmcodeVO> gradeClfList = service.selectGradeClfList();
		List<CmcodeVO> acClfList = service.selectAcClfList();
		
		
		map.put("cntCaseList", cntCaseList);
		map.put("gradeClfList", gradeClfList);
		map.put("acClfList", acClfList);
		
		return map ; 
		
	}
	
	
	// ajax로 career List select 
	@GetMapping(value="/mypage/selectCareerList.do")
	@ResponseBody
	public List<CareerVO> selectCareerList(
			@RequestParam(name="empNo") String empNo
			) {
		
			List<CareerVO> carrerVO = service.selectCareer(empNo);
		
		return carrerVO;
	}
	
	
	
	@GetMapping(value="/mypage/selectCareerView.do")
	@ResponseBody
	public CareerVO selectCareerView(
			@RequestParam(name="caNo") String caNo
			
			) {
		
		CareerVO careerVo = service.selectCareerView(caNo);
		return careerVo;
		
	}
	
	
	
	// 경력/학력 정보 추가
	@PostMapping(value="/mypage/careerInfoInsert.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String , Object> careerInfoInsert(
			 CareerVO career
			
			) {
		
	int result = service.insertCareerInfo(career);
	log.info(career.getCaNo());  
	
	Map<String , Object> insertMap = new HashMap<>();
	insertMap.put("result", result);
	insertMap.put("caNo", career.getCaNo());
		
		return insertMap;
	}
	
	
	
	
		
  // 경력/학력정보 수정
  @PostMapping(value="/mypage/careerInfoUpdate.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
  @ResponseBody
   public int careerInfoUpdate(
		  CareerVO career
		  
		   ) {
	  
	  int result =  service.careerInfoUpdate(career);	  
	   return result;
   }
  
  // 경력/학력정보 삭제
  @PostMapping(value="/mypage/careerInfoDelete.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
  @ResponseBody
  public int careerInfoDelete(
		 @Validated(DeleteGroup.class) @RequestParam(name="caNo") String caNo
		  ) {
	  
	  int result = service.careerInfoDelete(caNo);
	  
	  
	  return result;
  }
  
  
  // 학력 정보 조회
  
  
  // 학력 정보 추가 
  @PostMapping(value="/mypage/accInfoInsert.do", produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
  @ResponseBody
  public int accInfoInsert(
		  AccaVO acca
		  ) {
	  
	  int result = service.accInfoInsert(acca);
	  
	  
	  return result ;
  }
  
	
  
  
  @GetMapping(value="/mypage/selectAccaList.do")
  @ResponseBody
  public List<AccaVO> selectAccaList(
		  @RequestParam(name="empNo") String empNo
		  ) {
	  
	  List<AccaVO> accaList = service.selectAccaList(empNo);
	  return accaList ;
	  
  }
  
  
  
  
  @PostMapping(value="/mypage/updateAccaInfo.do")
  @ResponseBody
  public int updateAccaInfo(
		  AccaVO acca
		  ) {
	  
	  int result = service.updateAccaInfo(acca);
	  
	  return result;
  }
  
  
  @PostMapping(value="/mypage/deleteAccaInfo.do")
  @ResponseBody
  public int deleteAccaInfo(
		  @RequestParam(name="accaNo") String accaNo
		  ) {
	  
	  int result = service.deleteAccaInfo(accaNo);
	  
	  return result;
  }
  
  
  
  
  
  
}
