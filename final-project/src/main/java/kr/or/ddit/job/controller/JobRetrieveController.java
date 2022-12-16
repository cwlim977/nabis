package kr.or.ddit.job.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.job.service.JobService;
import kr.or.ddit.vo.JobVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/job")
public class JobRetrieveController {

	@Inject
	private JobService service;

	@RequestMapping("jobList.do")
	public String jobList(Model model) {
		List<JobVO> jobList = service.retrieveJobList();
		model.addAttribute("jobList", jobList);

		return "job/jobtest";
	}

	@ResponseBody
	@GetMapping(value = "jobList.do", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<JobVO> jobLoad() {

		List<JobVO> jobList = service.retrieveJobList();

		return jobList;
	}

	@ResponseBody
	@RequestMapping("maxJcode.do")
	public String doGet() {
		System.out.println("max들어옴");
		String maxJcode = service.retrieveMaxJcode();
		log.info("여기 test1 {}", maxJcode);

		return maxJcode;
	}
}