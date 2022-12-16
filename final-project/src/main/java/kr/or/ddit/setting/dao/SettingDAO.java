package kr.or.ddit.setting.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.vo.CompanyVO;

@Mapper
public interface SettingDAO {

   
   
   public CompanyVO selectCompany();
   
   public int insertCompany(CompanyVO com);
}