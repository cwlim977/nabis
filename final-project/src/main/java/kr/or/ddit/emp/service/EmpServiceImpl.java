package kr.or.ddit.emp.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.apache.commons.lang3.StringUtils;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.commons.exception.UserNotFoundException;
import kr.or.ddit.dept.dao.DeptDAO;
import kr.or.ddit.emp.dao.EmpDAO;
import kr.or.ddit.emp.dao.OthersDAO;
import kr.or.ddit.mypage.service.MypageService;
import kr.or.ddit.vacation.dao.VacationDAO;
import kr.or.ddit.vo.AsgmtVO;
import kr.or.ddit.vo.BlgDeptVO;
import kr.or.ddit.vo.CnthxVO;
import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.OwnJobVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.VacPosnVO;
import kr.or.ddit.vo.VacVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class EmpServiceImpl implements EmpService {
	
	
	private final EmpDAO dao;
	
	private final OthersDAO otherDao;
	
	private final VacationDAO vacDao;
	
	private final DeptDAO deptDao;
	
	private final MypageService myPageService;
	
	@Override
	public EmpVO retrieveEmp(String empNo) {
		EmpVO emp = dao.selectEmp(empNo);
		if(emp == null)
			throw new UserNotFoundException(empNo);
		return emp;
	}

	@Override
	public List<EmpVO> retrieveEmpList() {
		return dao.selectEmpList();
	}
	@Override
	public List<EmpVO> getExcelEmpList() {
		List<EmpVO> empList = dao.selectEmpList();
		for (EmpVO empVO : empList) {
			for (BlgDeptVO myDept : empVO.getDeptList()) {
				if(myDept.getMainck().equals("Y")) {
					empVO.setDeptFlow(myDept.getDeptFlow());
					empVO.setDeptExcel(myDept.getDnm());
					if(myDept.getDtnm() != null)
						empVO.setDeptExcel(myDept.getDnm()+"· "+myDept.getDtnm());
				}
			} 
			//deptExcel
		}
		
		return empList;
	}
	@Override
	public List<EmpVO> retrieveEmpList(PagingVO<EmpVO> pagingVO) {
		return dao.selectEmpListPaging(pagingVO);
	}

	@Override
	public int retrieveEmpCount(PagingVO<EmpVO> pagingVO) {
		return dao.selectTotalRecord(pagingVO);
	}
	
	@Override
	public List<EmpVO> retrieveEmpCntStatusList(Map<String, Object> paramArr) {
		return dao.selectEmpCntStatusList(paramArr);
	}
	
	@Override
	@Transactional
	public ServiceResult createEmp(EmpVO emp, AsgmtVO asgmt, CnthxVO cnthx) {
		ServiceResult result = null;
		try {
			retrieveEmp(emp.getEmpNo());
			result = ServiceResult.PKDUPLICATED;
			
		} catch (UserNotFoundException e) {
			
			// 성별 설정
			String strReg = emp.getRegno2().toString();
			strReg = strReg.substring(0, 1);
			log.info("strReg : ",strReg);
			if(strReg.equals("1") || strReg.equals("3")) {
				emp.setEmpGen("남자");
			}else {
				emp.setEmpGen("여자");
			}
			
			// 기본 사원 추가
			int rowcnt = dao.insertEmp(emp);
			
			// 입력한 비밀번호 암호화
			PasswordEncoder encoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
			String encoded = encoder.encode(emp.getEmpPass());
			emp.setEmpPass(encoded);
			
			// 사원추가 성공시 사원비밀번호 추가
			if(rowcnt > 0) rowcnt = dao.insertEmpId(emp);
			
			// 인사 발령 객체에 정보 등록 후 DB에 추가
			asgmt.setAsgmtPers(emp.getEmpNo()); 	// 인사발령대상
			asgmt.setAsgmtDate(emp.getEntDate()); 	// 발령일자 (사원의 입사일로 설정)
			asgmt.setAsgmtClf("입사"); 				// 발령구분
			if(rowcnt > 0) rowcnt = dao.insertAsgmt(asgmt);
			
			
			// 이전의 과정이 모두 성공하면  담당직무 추가 메소드 호출 
			if(rowcnt > 0 && asgmt.getJcodeList() !=null)
				rowcnt = insertJobList(asgmt);
			
			// 이전 과정 성공 후 선택한 조직코드가 리스트에 있을시 소속부서 추가 메소드 호출
			if(rowcnt > 0 && asgmt.getDeptList() !=null) 
				rowcnt = insertDeptList(asgmt);
			
			// 계약 객체에 정보 등록 후 DB에 추가
			cnthx.setCntCngr(emp.getEmpNo()); // 임금근로계약대상
			if(rowcnt > 0 && cnthx.getCnthxList() !=null) {
				List<CnthxVO> cnthxVO = cnthx.getCnthxList();
				
				// 근로계약 존재시 추가
				if(cnthxVO.get(0) != null) {
					cnthxVO.get(0).setCntWriter(cnthx.getCntWriter());
					cnthxVO.get(0).setCntCngr(cnthx.getCntCngr());
					
					rowcnt = myPageService.insertLaborCrt(cnthxVO.get(0));
				}
				// 임금계약 존재시 추가
				if(rowcnt > 0 && cnthx.getCnthxList().size() > 1) {
					cnthxVO.get(1).setCntWriter(cnthx.getCntWriter());
					cnthxVO.get(1).setCntCngr(cnthx.getCntCngr());
					
					rowcnt = myPageService.insertWageCrt(cnthxVO.get(1));
				}
				
			}
			
			
			// 사원 추가가 성공했을 때 휴가를 부여한다. - hgk
			if(rowcnt > 0) {
				String empNo = emp.getEmpNo();
				List<VacVO> vacList = vacDao.selectNewEmpVacation(empNo);
				if(vacList != null) {
					VacPosnVO vacPosnVo = new VacPosnVO();
					vacPosnVo.setEmpNo(empNo);
					vacPosnVo.setVpCngCase("부여");
					vacPosnVo.setVpCngRsn("입사시 자동 부여");
					vacPosnVo.setVacList(vacList);
					rowcnt = vacDao.insertNewEmpVacation(vacPosnVo);
				}
				else rowcnt = 0;
			}
			
			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
			
		}
		
		// 로직이 실패했으면 트랜잭션 롤백처리
		if (result == ServiceResult.FAIL)
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		
		return result;
	}
	
	@Override
	@Transactional
	public ServiceResult createAsgmt(AsgmtVO asgmt) {
		
		ServiceResult result = null;
		
		try {
			// 인사발령대상자가 DB에 존재하는 사원인지 체크
			retrieveEmp(asgmt.getAsgmtPers());
			
			// 대상자의 예정인사발령이 이미있는지 체크
			//	AsgmtVO asgmtChk = dao.selecetAsgmt(asgmt.getAsgmtPers());
			//	if(asgmtChk != null)
			//		throw new AlreadyExistException(empNo);
			
			// 인사발령 추가
			int rowcnt = dao.insertAsgmt(asgmt);
			
			// 이전의 과정이 모두 성공하면  담당직무 추가 메소드 호출 
			if(rowcnt > 0 && asgmt.getJcodeList() !=null)
				rowcnt = insertJobList(asgmt);
			
			// 이전 과정 성공 후 선택한 조직코드가 리스트에 있을시 소속부서 추가 메소드 호출
			if(rowcnt > 0 && asgmt.getDeptList() !=null) 
				rowcnt = insertDeptList(asgmt);
			
			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
			
		} catch (UserNotFoundException e) {
			return ServiceResult.FAIL;
		}
		
		// 로직이 실패했으면 트랜잭션 롤백처리
		if (result == ServiceResult.FAIL)
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		
		return result;
	}
	
	@Override
	@Transactional
	public ServiceResult createAsgmts(List<AsgmtVO> asgmtList, String writer) {
		
		ServiceResult result = null;
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		try {
			// 인사발령대상자가 DB에 존재하는 사원인지 체크
			// 대상자의 예정인사발령이 이미있는지 체크
			for (AsgmtVO asgmtVO : asgmtList) {
				retrieveEmp(asgmtVO.getAsgmtPers());
				//	AsgmtVO asgmtChk = dao.selecetAsgmt(asgmt.getAsgmtPers());
				//	if(asgmtChk != null)
				//		throw new AlreadyExistException(empNo);
			}
			
			paramMap.put("asgmtList", asgmtList);
			paramMap.put("writer", writer);

			
			// 인사발령 추가
			int rowcnt = dao.insertAsgmts(paramMap);
			log.info("paramMap {}", paramMap.toString());
			
			for (AsgmtVO asgmtVO : asgmtList) {
				asgmtVO.setAsgmtNo(Integer.parseInt((String) paramMap.get("id"))); 
				// 이전의 과정이 모두 성공하면  담당직무 추가 메소드 호출 
				if(rowcnt > 0 && asgmtVO.getJcodeList() !=null)
					rowcnt = insertJobList(asgmtVO);
				
				// 이전 과정 성공 후 선택한 조직코드가 리스트에 있을시 소속부서 추가 메소드 호출
				if(rowcnt > 0 && asgmtVO.getDeptList() != null) 
					rowcnt = insertDeptList(asgmtVO);
			}
			
			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
			
		} catch (UserNotFoundException e) {
			return ServiceResult.FAIL;
		}
		
		// 로직이 실패했으면 트랜잭션 롤백처리
		if (result == ServiceResult.FAIL)
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		
		return result;
	}
	
	@Override
	@Transactional
	public ServiceResult cancelAsgmt(AsgmtVO asgmt) {
		ServiceResult result = null;
		
		try {
			// 인사발령대상자가 DB에 존재하는 사원인지 체크
			retrieveEmp(asgmt.getAsgmtPers());
			
			// 인사발령 취소
			int rowcnt = dao.deleteAsgmt(asgmt);
			
			result = rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
			
		} catch (UserNotFoundException e) {
			return ServiceResult.FAIL;
		}
		return result;
	}
	
	/**
	 * 하나의 인사발령객체에 대한 다중 직무 추가 메소드
	 * asgmtVO 안에 인사발령번호가 있어야됩니다.
	 * @param asgmtVO - asgmtVO 안에 jcodeList[] 배열로 유효검사후 추가합니다.
	 * @return 성공 : 1 , 실패 : 0
	 */
	private int insertJobList(AsgmtVO asgmtVO) {
		int result = 1;
		
		// 직무코드 중복 검사
		for (int i = 0; i < asgmtVO.getJcodeList().length; i++) {
			for (int j = 0; j < i; j++) {
				if (asgmtVO.getJcodeList()[i].equals(asgmtVO.getJcodeList()[j])) {  
					log.info("insertJobList 메소드 : 담당직무 추가 직무코드 중복 발생");
					result = 0;
				}
			}
		}

		// AsgmtVO 안의 직무코드배열을 OwnJobVO에 옮기는 과정
		List<OwnJobVO> ownJobList = new ArrayList<>();
		asgmtVO.setJobList(ownJobList);
		for (String jcode  : asgmtVO.getJcodeList()) {
			OwnJobVO job = new OwnJobVO();
			job.setAsgmtNo(asgmtVO.getAsgmtNo());
			job.setAsgmtPers(asgmtVO.getAsgmtPers());
			job.setJcode(jcode);
			ownJobList.add(job);
		}

		// 담당직무 insert 함수 호출
		if(result > 0) result = otherDao.insertOwnJob(asgmtVO);

		return result;
	}


	/**
	 * 하나의 인사발령객체에 대한 다중 부서,직책 추가 메소드
	 * asgmtVO 안에 인사발령번호가 있어야됩니다.
	 * @param asgmtVO
	 * @return 성공 : 1 , 실패 : 0
	 * @throws ParseException 
	 */
	private int insertDeptList(AsgmtVO asgmtVO) {
		int result = 1;
		List<BlgDeptVO> deptList = asgmtVO.getDeptList();

		// 부서코드 중복 검사 
		for (int i = 0; i < deptList.size(); i++) {
			if(StringUtils.isEmpty(deptList.get(i).getDcode())) {
				log.info("insertDeptList 메소드 : 소속부서 추가 부서코드 Null 발생");
				result = 0;
			}
			for (int j = 0; j < i; j++) {
				if (deptList.get(i).getDcode().equals(deptList.get(j).getDcode() )) { 
					log.info("insertDeptList 메소드 : 소속부서 추가 부서코드 중복 발생");
					result = 0;
				}
			}
		}

		// 주소속 여부 일치 시 Y로 추가 AND 인사발령번호 등록
		for (BlgDeptVO deptVO : deptList) {
			deptVO.setAsgmtNo(asgmtVO.getAsgmtNo()); // 인사발령번호 등록
			deptVO.setAsgmtPers(asgmtVO.getAsgmtPers()); // 인사발령대상 등록

			if(!StringUtils.isBlank(deptVO.getMainck()) && deptVO.getMainck().equals("Y")) {
				deptVO.setMainck("Y");
			}else {
				deptVO.setMainck("N");
			}

			if(!StringUtils.isBlank(deptVO.getDno()) && deptVO.getDno().equals("Y")) {
				deptVO.setDno("Y");
			}else {
				deptVO.setDno("N");
			}
			
			
		}

		// 소속부서 insert 함수 호출
		if(result > 0) result = otherDao.insertBlgDept(asgmtVO);
		log.info("insertBlgDept result : {}" ,result);
		
		// 인사발령 대상자들의 부서장을 모두 해제한다.
		if(result > 0) deptDao.resetDeptHead(asgmtVO.getAsgmtPers());
		log.info("resetDeptHead result : {}" ,result);
		
		// 인사발령 대상자들의 부서장 권한을 모두 해제한다. (단 최고관리자를 제외한다)
		if(result > 0 ) dao.resetIdRoles(asgmtVO.getAsgmtPers());
		log.info("resetIdRoles result : {}" ,result);
			
		// 인사발령이 오늘날짜인 경우 조직장 여부 있을시 조직장 업데이트
		if(dateComparison(asgmtVO.getAsgmtDate()).equals("today") && result > 0) {
			
			
			// 인사발령 대상의 조직장 설정
			for (BlgDeptVO deptVO : deptList) {
				if(!StringUtils.isBlank(deptVO.getDno()) && deptVO.getDno().equals("Y")) {
					DeptVO setDept = new DeptVO();
					setDept.setDcode(deptVO.getDcode());
					setDept.setDhno(asgmtVO.getAsgmtPers());
					log.info("setDept result : {}" ,setDept.getDhno());
					
					// 바꿀 부서의 전 조직장 번호
					String preDhno = deptDao.selectDept(setDept.getDcode()).getDhno();
					
					result = deptDao.updateDeptHead(setDept);
					log.info("updateDeptHead result : {}" ,result);
					
					// 인사발령 대상의 조직장 설정시 부서장 권한을 부여한다. (단 최고관리자를 제외한다)
					log.info("updateIdRoles 파라미터 : {}" ,asgmtVO.getAsgmtPers());
					if(result > 0 )  result = dao.updateIdRoles(asgmtVO.getAsgmtPers());
					log.info("updateIdRoles result : {}" ,result);
					
					// 이전 조직장이 모든 조직장을 내려놓았을시 부서장 권한을 해제한다.
					if(result > 0 && !(deptDao.checkDeptHead(preDhno) > 0)) dao.resetIdRoles(preDhno);
					log.info("resetIdRoles result : {}" ,result);
				}
			}
			
		}
		log.info("insertDeptList result : {}" ,result);
		return result;
	}

	
	/**
	 * 오늘을 기준으로 날짜를 비교
	 * @param strDate - 비교할 문자열날짜
	 * @return later - 이후 날짜, pre - 이전 날짜, today - 오늘 날짜
	 * @throws ParseException
	 */
	private String dateComparison(String strDate){
		String result ="";
		//오늘날짜 yyyy-MM-dd로 생성
		String todayfm = new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()));
		 
		//yyyy-MM-dd 포맷 설정
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		 
		//비교할 date와 today를데이터 포맷으로 변경
		Date date;
		Date today;
		try {
			date = new Date(dateFormat.parse(strDate).getTime());
			today = new Date(dateFormat.parse(todayfm).getTime());
		} catch (ParseException e) {
			throw new RuntimeException(e);
		}
		 
		//compareTo메서드를 통한 날짜비교
		int compare = date.compareTo(today); 
		//조건문
		if(compare > 0) {
		  log.info("date가 today보다 큽니다.(date > today)");
		  result = "later";
		}else if(compare < 0) {
		  log.info("today가 date보다 큽니다.(date < today)");
		  result = "pre";
		}else {
		  log.info("today와 date가 같습니다.(date = today)");
		  result = "today";
		}
		return result;
	}




}
