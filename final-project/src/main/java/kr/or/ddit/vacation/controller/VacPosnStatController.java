package kr.or.ddit.vacation.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.vacation.service.VacationService;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PagingVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/memberVacation")
public class VacPosnStatController {
	
	@Inject
	private VacationService service;
	
	@GetMapping("vacPosnStatView.do")
	public String vacPosnStatView(Model model) {
		Map<String, Object> listMap = service.retrieveFilterOptionLists();
		model.addAttribute("listMap", listMap);
		return "vacation/vacPosnStat";
	}
	
	@PostMapping(value="vacPosnStatSearch.do", consumes=MediaType.APPLICATION_JSON_UTF8_VALUE, produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public Map<String, Object> vacPosnStatSearch(
			@RequestBody Map<String, Object> dataMap
	) {
		Map<String, Object> resp = new HashMap<>();
		PagingVO<EmpVO> pagingVO = new PagingVO<>();
		if(dataMap.get("page") != null) {
			pagingVO.setCurrentPage(Integer.parseInt(dataMap.get("page").toString()));
		}else {
			pagingVO.setCurrentPage(1);
		}
		pagingVO.setDataMap(dataMap);
		int totalRecord = service.retrieveVacPosnStatBySearchCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		List<EmpVO> searchList = service.retrieveVacPosnStatBySearch(pagingVO);
		pagingVO.setDataList(searchList);
		String status = "success";
		if(searchList.isEmpty()) status = "empty";
		else resp.put("pagingVO", pagingVO);
		resp.put("status", status);
		return resp;
	}
	
}
