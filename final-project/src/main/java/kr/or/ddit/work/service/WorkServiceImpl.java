package kr.or.ddit.work.service;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import kr.or.ddit.arm.service.ArmService;
import kr.or.ddit.commons.exception.UserNotFoundException;
import kr.or.ddit.emp.service.EmpService;
import kr.or.ddit.vo.ArmVO;
import kr.or.ddit.vo.BlgDeptVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.ExcelWorkVO;
import kr.or.ddit.vo.OwnJobVO;
import kr.or.ddit.vo.WkApVO;
import kr.or.ddit.vo.WorkVO;
import kr.or.ddit.work.dao.WorkDAO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WorkServiceImpl implements WorkService {

	@Inject
	private WorkDAO dao;
	
	@Inject
	private ArmService armService;
	
	@Inject
	private EmpService empService;
	
	@Transactional
	@Override
	public String createWorkAp(WkApVO workAp, String writer) {
		log.info("createWorkAp 파라미터 workAp : {}, writer : {}", workAp, writer);
		String result = "fail";
		try {
			// 근무신청자가 존재하는지 확인
			empService.retrieveEmp(workAp.getWaAper());
			// 연장근무시간 음수 초기화
			if(workAp.getWaExtime() < 0) workAp.setWaExtime(0.0);
			
			// 근무정책에서 야간,휴일 근무 허용여부 체크
			WorkVO work = dao.selectWork(workAp.getWkCode());
			if(work.getWkNight().equals("N") && workAp.getWaNigtime() > 0) return "nigtBan";
			if(work.getWkHd().equals("N") && workAp.getWaHdtime() > 0) return "HdBan";
			
			// 작성자가 관리자면 승인상태로 등록한다.
			EmpVO emp = empService.retrieveEmp(writer);
			if(emp.getIdRoles().get(0).contains("ROLE_ADMIN")) {
				
				int rowcnt = insertWorkAp(workAp);
				
				result = rowcnt > 0 ? "ok" : "fail";
			
			// 정상근무 시간이면 승인상태로 등록한다.
			}else if(workAp.getWaStime().equals("09:00") 
					&& workAp.getWaEtime().equals("18:00")
					&& workAp.getWaHdtime() <= 0
					&& workAp.getWkCode().equals("WK2")){
				
				int rowcnt = insertWorkAp(workAp);
				
				result = rowcnt > 0 ? "ok" : "fail";
				
			}else{
				result = "need";
			};

		} catch (UserNotFoundException e) {
			result ="fail";
		}
		
		// 로직이 실패했으면 트랜잭션 롤백처리
		if (result.equals("fail"))
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		
		log.info("createWorkAp 리턴값 : {}", result);
		return result;
	}

	@Transactional
	@Override
	public String createWorkAp(WkApVO workAp) {
		String result = "fail";
		try {
			// 근무신청자가 존재하는지 확인
			EmpVO emp = empService.retrieveEmp(workAp.getWaAper());
			
			// 속한 조직의 조직장을 결재자로 지정하기
			if(emp.getDeptList() != null && emp.getDeptList().size() > 0) {
				for (BlgDeptVO dept : emp.getDeptList()) {
					if(!StringUtils.isBlank(dept.getDhno())){
						workAp.setWaRver(dept.getDhno());
						break;
					}
				} 
			}
			// 없을시 최고관리자를 결재자 지정
			if(StringUtils.isBlank(workAp.getWaRver())) 
				workAp.setWaRver("199701001");
			// 연장근무시간 음수 초기화
			if(workAp.getWaExtime() < 0) workAp.setWaExtime(0.0);
			
			workAp.setEwApst("대기");
			
			log.info("근무 삭제 : {}", workAp);
			// 기존근무일 취소
			dao.updateWorkAp(workAp);
			log.info("근무 추가");
			// 근무기록 추가
			int rowcnt = dao.insertWorkAp(workAp);
			
			// 근무승인요청 알림등록
			if(rowcnt > 0) {
				ArmVO arm = new ArmVO();
				arm.setArmSdr(workAp.getWaAper());
				arm.setArmRcvr(workAp.getWaRver());
				arm.setArmCont(emp.getEmpNm()+"님이 근무 승인을 요청 했어요.");
				arm.setArmUrl("/home/todo/inbox.do");
				arm.setArmStat("N");
				armService.createArm(arm);
			}
			
			result = rowcnt > 0 ? "ok" : "fail";

		} catch (UserNotFoundException e) {
			result ="fail";
		}
		
		// 로직이 실패했으면 트랜잭션 롤백처리
		if (result.equals("fail"))
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		
		log.info("createWorkAp 리턴값 : {}", result);
		return result;
	}
	
	@Transactional
	@Override
	public String removeWorkAp(WkApVO workAp) {
		log.info("removeWorkAp 파라미터 workAp : {}", workAp);
		String result = "fail";
		try {
			// 근무신청자가 존재하는지 확인
			empService.retrieveEmp(workAp.getWaAper());

			int rowcnt = dao.updateWorkAp(workAp);
				
			result = rowcnt > 0 ? "ok" : "fail";

		} catch (UserNotFoundException e) {
			result ="fail";
		}
		
		// 로직이 실패했으면 트랜잭션 롤백처리
		if (result.equals("fail"))
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		
		log.info("removeWorkAp 리턴값 : {}", result);
		return result;
	}
	
	@Transactional
	@Override
	public String rejectWorkAp(String waNo) {
		log.info("rejectWorkAp 파라미터 waNo : {}", waNo);
		WkApVO wkAp = dao.selectWorkAp(waNo);

		String result = "fail";
		// 받은 근무기록번호가 존재하는 근무기록일시 작업 수행 
		if(wkAp !=null) {
			int rowcnt = dao.rejectWorkAp(waNo);
			// 근무반려 알림등록
			if(rowcnt > 0) {
				String sendName = empService.retrieveEmp(wkAp.getWaRver()).getEmpNm();
				
				ArmVO arm = new ArmVO();
				arm.setArmSdr(wkAp.getWaRver());
				arm.setArmRcvr(wkAp.getWaAper());
				arm.setArmCont(sendName+"님이 근무 승인을 반려했어요.");
				arm.setArmUrl("/work/myWork.do");
				arm.setArmStat("N");
				armService.createArm(arm);
			}
			
			result = rowcnt > 0 ? "ok" : "fail";
		}
		
		log.info("rejectWorkAp 리턴값 : {}", result);
		return result;
	}
	
	@Transactional
	@Override
	public String confirmWorkAp(String waNo) {
		log.info("confirmWorkAp 파라미터 waNo : {}", waNo);
		WkApVO wkAp = dao.selectWorkAp(waNo);

		String result = "fail";
		// 받은 근무기록번호가 존재하는 근무기록일시 작업 수행 
		if(wkAp !=null) {
			int rowcnt = dao.confirmWorkAp(waNo);
			
			// 근무승인 알림등록
			if(rowcnt > 0) {
				ArmVO arm = new ArmVO();
				arm.setArmSdr(wkAp.getWaRver());
				arm.setArmRcvr(wkAp.getWaAper());
				arm.setArmCont("근무 승인이 완료 되었어요.");
				arm.setArmUrl("/work/myWork.do");
				arm.setArmStat("N");
				armService.createArm(arm);
			}
			
			result = rowcnt > 0 ? "ok" : "fail";
		}
		
		log.info("confirmWorkAp 리턴값 : {}", result);
		return result;
	}
	
	/**
	 * 근무등록 (자동 승인)
	 * 등록할 날에 근무기록이 존재할시 기존 기록들을 취소하고
	 * 승인 상태로 등록하는 메서드
	 * @param workAp
	 * @return 성공 : 1, 실패 : 0
	 */
	public int insertWorkAp(WkApVO workAp) {
		int rowcnt = 0;
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date();
		String today = format.format(now);
		// 승인처리 오늘날짜
		workAp.setEwAdate(today);
		workAp.setEwApst("승인");
		
		// 기존근무일 취소
		dao.updateWorkAp(workAp);
		// 근무기록 추가
		rowcnt = dao.insertWorkAp(workAp);
		log.info("service insertWorkAp 리턴값 : {}",rowcnt);
		return rowcnt;
	}

	@Override
	public List<ExcelWorkVO> workExcelList(String sDate, String eDate) {
		List<EmpVO> empList = dao.selectEmpWorkTimeList(sDate, eDate);
		List<ExcelWorkVO> excelList = new ArrayList<ExcelWorkVO>();
		for (EmpVO empVO : empList) {
			ExcelWorkVO excel = new ExcelWorkVO();
			excel.setEmpNo(empVO.getEmpNo());
			excel.setEmpNm(empVO.getEmpNm());
			excel.setEmpMail(empVO.getEmpMail());
			excel.setEntDate(empVO.getEntDate());
			excel.setOutDate(empVO.getOutDate());
			String dept ="";
			String jnm ="";
			String dtnm ="";
			String date = sDate+" → "+eDate;
			
			String waTltime = "";
			String waExtime = "";
			String waNigtime = "";
			String waHdtime = "";
			
			for (BlgDeptVO deptVO : empVO.getDeptList()) {
				dept += deptVO.getDnm() +", ";
				dtnm += deptVO.getDtnm() +", ";
			}
			for (OwnJobVO jobVO : empVO.getJobList()) {
				jnm += jobVO.getJnm() +", ";
 			}
			for (WkApVO workVO : empVO.getWorkApList()) {
				waTltime  = workVO.getWaTltime().toString();
				waExtime  = workVO.getWaExtime().toString();
				waNigtime = workVO.getWaNigtime().toString();
				waHdtime  = workVO.getWaHdtime().toString();
			}
			excel.setDept(dept);
			excel.setJnm(jnm);
			excel.setDtnm(dtnm);
			excel.setGrd(empVO.getGrdNm());
			excel.setPtn(empVO.getPtnNm());
			excel.setWaTltime(waTltime);
			excel.setWaExtime(waExtime);
			excel.setWaNigtime(waNigtime);
			excel.setWaHdtime(waHdtime);
			excel.setDate(date);
			
			excelList.add(excel);
		}
		
		return excelList;
	}




}
