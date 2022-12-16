package kr.or.ddit.setting.controller;


import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.emp.controller.EmpController;
import kr.or.ddit.setting.dao.SettingDAO;
import kr.or.ddit.vo.CompanyVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class SettingController {
   
   @Inject
   private SettingDAO dao;
   
   
   
   @GetMapping("/setting/main.do")
   public String settingMain(
         Model model
         ) {
      
      model.addAttribute("companyInfo",dao.selectCompany()) ;
      
      
      return "setting/settingMain";
   }
   
   
   
   
   @GetMapping(value="/setting/selectCompany.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
   @ResponseBody
   public CompanyVO selectCompany() {
      log.info("controller 넘어옴");
       CompanyVO com = dao.selectCompany();
      log.info("com{}",com);
      return com;
      
      
      }
   
   
   @PostMapping(value="/setting/updateCompany.do",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
   @ResponseBody
   public int updateCompany(
         CompanyVO com
         ) {
	   log.info("com{}",com);
      int res = dao.insertCompany(com);
      return res;
   }
}









