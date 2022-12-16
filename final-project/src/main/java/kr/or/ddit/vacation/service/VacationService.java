package kr.or.ddit.vacation.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.commons.exception.VacNotFoundException;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.VacApplyVO;
import kr.or.ddit.vo.VacPosnVO;
import kr.or.ddit.vo.VacVO;

public interface VacationService {
	
	/* 휴가 설정 */
	
	/**
	 * 휴가 전체 조회하기
	 * @return List<VacVO>
	 */
	public List<VacVO> retrieveVacList();
	/**
	 * 휴가 개별 조회하기
	 * @return VacVO, 휴가가 존재하지 않을 때 {@link VacNotFoundException} 발생한다. 
	 */
	public VacVO retrieveVacation(String vcNm);
	/**
	 * 연차 추가 부여 수정하기
	 * @return {@link ServiceResult.OK}, {@link ServiceResult.FAIL}
	 */
	public ServiceResult modifyAnnualLeaveVacAddGive(List<Map<String, Integer>> annualVacAddGiveList);
	/**
	 * 휴가 추가하기
	 * @param vacation
	 * @return 	이미 휴가가 존재할 때 : {@link ServiceResult.PKDUPLICATED}, 
	 * 			휴가 추가에 성공했을 때 : {@link ServiceResult.OK}, 
	 * 			휴가 추가에 실패했을 때 : {@link ServiceResult.FAIL}
	 */
	public ServiceResult createVacation(VacVO vacation);
	/**
	 * 휴가 수정하기
	 * @param vacation
	 * @return  휴가 수정에 성공했을 때 : {@link ServiceResult.OK}, 
	 * 			휴가 수정에 실패했을 때 : {@link ServiceResult.FAIL}
	 */
	public ServiceResult modifyVacation(VacVO vacation);
	/**
	 * 휴가 삭제하기
	 * @param vcNm
	 * @return 	휴가 삭제에 성공했을 때 : {@link ServiceResult.OK}, 
	 * 			휴가 삭제에 실패했을 때 : {@link ServiceResult.FAIL}
	 */
	public ServiceResult inactiveVacation(String vcNm);
	
	/* 휴가 설정 */
	
	/* 휴가 개요 */
		
	/**
	 * 직원 개인의 휴가에 대한 최신의 보유와 모든 신청 정보를 가져온다.
	 * 1. 휴가 보유-휴가 정보 List
	 * 2. 휴가 신청-휴가 일정 List
	 * @return Map<String, Object>
	 */
	public Map<String, Object> retrieveVacOutline(String empNo);
	
	/* 휴가 신청 */
	
	/**
	 * 휴가 신청자의 휴가 변경 코드를 생성하기
	 * @param empNo
	 * @return String
	 */
	public String createVpCngCode(String empNo);
	
	/**
	 * 휴가 신청자의 휴가 보유 현황을 변경하기 
	 * @param vacPosnVo
	 * @return int
	 */
	public ServiceResult createVacationPossession(VacPosnVO vacPosnVo);
	
	/**
	 * 휴가 신청자의 휴가 신청 코드를 생성하기
	 * @param vaapEmp
	 * @return String
	 */
	public String createVaapCode(String vaapEmp);
	
	/**
	 * 휴가 신청자의 휴가 신청을 생성하기
	 * @param vacApplyVo
	 * @return 	휴가 수정에 성공했을 때 : {@link ServiceResult.OK}, 
	 * 			휴가 수정에 실패했을 때 : {@link ServiceResult.FAIL}
	 */
	public ServiceResult createVacApply(Map<String, Object> dataMap);
	
	/* 휴가 신청 */
	
	/* 휴가 취소 */
	
	/**
	 * 예정 휴가를 취소하기
	 * @param vaapCode
	 * @return 	휴가 취소에 성공했을 때 : {@link ServiceResult.OK}, 
	 * 			휴가 취소에 실패했을 때 : {@link ServiceResult.FAIL}
	 */
	public ServiceResult cancelVacApply(String vaapCode);
	
	/* 휴가 취소 */
	
	/* 증명 자료 제출 */
	
	/**
	 * 휴가 신청 증명 자료를 업로드 하기
	 * @param uploadFile
	 * @return 	업로드에 성공했을 때 : {@link ServiceResult.OK}, 
	 * 			업로드에 실패했을 때 : {@link ServiceResult.FAIL}
	 */
	public ServiceResult uploadVaapFile(String vaapCode, MultipartFile uploadFile);
	
	/* 증명 자료 제출 */
	
	/* 휴가 개요 */
	
	/* 연차 상세 */
	
	/**
	 * 특정 년도별로 직원의 휴가 보유 이력을 조회하기
	 * @param empNo
	 * @param year
	 * @return List<VacPosnVO>
	 */
	public List<VacPosnVO> retrieveVacPosnListByKeyWords(String empNo, String year);
	
	/* 연차 상세 */
	
	/* 휴가 보유 현황 */
	
	/**
	 * 필터 검색을 위해서 모든 부서와 휴가의 리스트를 조회하기
	 * @return Map<String, Object>
	 */
	public Map<String, Object> retrieveFilterOptionLists();
	
	/**
	 * 검색한 휴가 보유 현황 레코드 수
	 * @param pagingVO
	 * @return
	 */
	public int retrieveVacPosnStatBySearchCount(PagingVO<EmpVO> pagingVO);
	/**
	 * 검색을 통해서 휴가 보유 현황을 조회하기
	 * @param dataMap
	 * @return List<EmpVO>
	 */
	public List<EmpVO> retrieveVacPosnStatBySearch(PagingVO<EmpVO> pagingVO);
	
	/* 휴가 보유 현황 */
	
	/* 휴가 신청 내역 */
	
	/**
	 * 년도와 월에 맞는 모든 휴가 신청 정보를 조회하기
	 * @return List<VacApplyVO>
	 */
	public List<VacApplyVO> retrieveVacApplyList(Integer year, Integer month);
	
	/**
	 * 관리자가 휴가 신청 내역과 홈 피드에서 직원이 신청한 휴가를 반려하거나 승인한다.
	 * @param vaapCode
	 * @param behavior
	 * @return  결재에 성공했을 때 : {@link ServiceResult.OK}, 
	 * 			결재에 실패했을 때 : {@link ServiceResult.FAIL}
	 */
	public ServiceResult vacApplyManage(String vaapCode, String behavior);
	
	/**
	 * 휴가 신청 내역과 홈 피드에 사용되는 휴가 신청 정보를 조회한다.
	 * @param vaapCode
	 * @return VacApplyVO
	 */
	public VacApplyVO retrieveVacApply(String vaapCode);
	
	/* 휴가 신청 내역 */
	
}
