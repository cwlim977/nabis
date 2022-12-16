package kr.or.ddit.home.service;


import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.emp.service.EmpService;
import kr.or.ddit.home.dao.HomeDAO;
import lombok.extern.slf4j.Slf4j;

@Service
public class HomeServiceImpl implements HomeService {
	
	@Inject
	private HomeDAO dao;
	@Inject
	private EmpService empService;
	

}
