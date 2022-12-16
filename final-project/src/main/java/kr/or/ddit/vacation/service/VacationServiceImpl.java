package kr.or.ddit.vacation.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import javax.inject.Inject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.TypeFactory;

import kr.or.ddit.arm.service.ArmService;
import kr.or.ddit.commons.attatch.dao.AttatchDAO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.commons.exception.VacNotFoundException;
import kr.or.ddit.emp.dao.OthersDAO;
import kr.or.ddit.emp.service.EmpService;
import kr.or.ddit.vacation.dao.VacationDAO;
import kr.or.ddit.vo.ArmVO;
import kr.or.ddit.vo.AttatchVO;
import kr.or.ddit.vo.DeptVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.VacApplyVO;
import kr.or.ddit.vo.VacPosnVO;
import kr.or.ddit.vo.VacSchVO;
import kr.or.ddit.vo.VacVO;
import kr.or.ddit.vo.WkApVO;
import kr.or.ddit.work.dao.WorkDAO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class VacationServiceImpl implements VacationService {
	
	@Inject
	private VacationDAO vacDao;
	
	@Inject
	private AttatchDAO attatchDao;
	
	@Inject
	private WorkDAO workDao;
	
	@Inject
	private ArmService armService;
	
	@Inject
	private EmpService empService;
	
	@Inject
	private OthersDAO othersDao; 
	
	@Value("#{appInfo.attatchFolder}")
	private Resource attatchFolder;
	
	private File saveFolder;
	
	private ObjectMapper mapper;
	
	@PostConstruct
	public void init() throws IOException {
		saveFolder = attatchFolder.getFile();
		mapper = new ObjectMapper();
	}
	
	/* 휴가 설정 */
	
	@Override
	public List<VacVO> retrieveVacList() {
		List<VacVO> vacList = vacDao.selectVacList();
		return vacList;
	}
	
	@Override
	public VacVO retrieveVacation(String vcNm) {
		VacVO vacation = vacDao.selectVacation(vcNm);
		if(vacation == null) throw new VacNotFoundException(vcNm);
		return vacation;
	}
	

	@Override
	@Transactional
	public ServiceResult modifyAnnualLeaveVacAddGive(List<Map<String, Integer>> annualVacAddGiveList) {
		int rowCnt = vacDao.deleteAnnualLeaveVacAddGive();
		if(rowCnt > 0 && !CollectionUtils.isEmpty(annualVacAddGiveList)) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("annualVacAddGiveList", annualVacAddGiveList);
			rowCnt += vacDao.insertAnnualLeaveVacAddGive(map);
		}
		return rowCnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	@Override
	@Transactional
	public ServiceResult createVacation(VacVO vacation) {
		ServiceResult result = null;
		try {
			retrieveVacation(vacation.getVcNm());
			result = ServiceResult.PKDUPLICATED;
		} catch (VacNotFoundException e) {
			int rowCnt = vacDao.insertVacation(vacation);
			result = rowCnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
		}
		return result;
	}
	
	@Override
	@Transactional
	public ServiceResult modifyVacation(VacVO vacation) {
		int rowCnt = vacDao.updateVacation(vacation);
		return rowCnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	@Transactional
	public ServiceResult inactiveVacation(String vcNm) {
		int rowCnt = vacDao.deleteVacation(vcNm);
		return rowCnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	/* 휴가 설정 */
	
	/* 휴가 개요 */
	
	@Override
	public Map<String, Object> retrieveVacOutline(String empNo) {
		Map<String, Object> map = new HashMap<>();
		List<VacPosnVO> vacPosnVoList = vacDao.selectVacPosnVoList(empNo);
		log.info("vacPosnVoList : {}", vacPosnVoList);
		map.put("vacPosnVoList", vacPosnVoList);
		List<VacApplyVO> vacApplyVoList = vacDao.selectVacApplyVoListByEmpNo(empNo);
		log.info("vacApplyVoList : {}", vacApplyVoList);
		map.put("vacApplyVoList", vacApplyVoList);
		return map;
	}

	@Override
	public String createVpCngCode(String empNo) {
		Integer latestVpCngNo = vacDao.selectLatestVpCngNo(empNo);
		StringBuilder vpCngCode = new StringBuilder("VP");
		vpCngCode.append(empNo);
		vpCngCode.append("CNG");
		vpCngCode.append(latestVpCngNo+1);
		return vpCngCode.toString();
	}
	
	@Override
	@Transactional
	public ServiceResult createVacationPossession(VacPosnVO vacPosnVo) {
		int rowCnt = 0;
		if(vacPosnVo.getVpCngCode() == null) {
			String vpCngCode = createVpCngCode(vacPosnVo.getEmpNo());
			vacPosnVo.setVpCngCode(vpCngCode);
		};
		rowCnt = vacDao.insertVacationPossession(vacPosnVo);
		return rowCnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public String createVaapCode(String vaapEmp) {
		Integer latestVaapNo = vacDao.selectLatestVaapNo(vaapEmp);
		StringBuilder vaapCode = new StringBuilder(vaapEmp);
		if(latestVaapNo == null) {
			vaapCode.append("VAAP1");
		}
		else {
			vaapCode.append("VAAP");
			vaapCode.append(latestVaapNo+1);
		}
		return vaapCode.toString();
	}
	
	// 휴가 신청
	@Override
	@Transactional
	public ServiceResult createVacApply(Map<String, Object> dataMap) { // 결재자 신청자 
		int rowCnt = 0;
		VacApplyVO vacApplyVo = mapper.convertValue(dataMap.get("vacApplyVo"), VacApplyVO.class);
		List<VacSchVO> vacSchVoList = mapper.convertValue(dataMap.get("vacSchVoList"), TypeFactory.defaultInstance().constructCollectionType(List.class, VacSchVO.class));
		String vaapCode = createVaapCode(vacApplyVo.getVaapEmp());
		vacApplyVo.setVaapCode(vaapCode);
		rowCnt = vacDao.insertVacationApply(vacApplyVo);
		
		
		if(rowCnt > 0) {
			for(VacSchVO vacSchVo : vacSchVoList) { vacSchVo.setVaapCode(vaapCode); }
			rowCnt = vacDao.insertVacationSchedule(vacSchVoList);
		}
		else {
			rowCnt = 0;
		}
		
		//##################################################################################
		// 2022-12-08 10:47 LCW
		// 근무기록에 휴가신청 추가
		if(rowCnt >0) {
			
			// 휴가 신청한날만큼 반복문으로 근무기록
			for(VacSchVO vacSchVo : vacSchVoList) {
				
				WkApVO workAp = new WkApVO();
				
				// 근무기록 신청자
				workAp.setWaAper(vacApplyVo.getVaapEmp());
				// 근무일자 설정
				workAp.setWaDate(vacSchVo.getVsEachDate());
				// 근무한시간 설정
				workAp.setWaTltime(8.0);
				// 결재상태 대기로 설정
				workAp.setEwApst("대기");
				// 근무시간설정
				workAp.setWaStime("09:00");
				workAp.setWaEtime("18:00");
				
				// !!안쓰는 *반려사유* 필드에 하나의 휴가신청 판단을 위한 휴가신청코드 설정!!
				workAp.setEwRejrsn(vacSchVo.getVaapCode());
				
				// 휴가종류에 따른 근무코드 설정
				// 휴가 하루종일
				if(vacSchVo.getVsUseDays() == 1) {
					workAp.setWkCode("WK1");
				}else {
					// 휴가 오전반차
					if(vacSchVo.getVsEtime().equals("14:00")) {
						workAp.setWkCode("WK6");
						
					// 휴가 오후반차
					}else {
						workAp.setWkCode("WK7");
						
					}
				}
				
				log.info("createVacApply() 근무 삭제 사원번호: {}, 근무일자: {}", workAp.getWaAper(), workAp.getWaDate());
				// 기존근무일 취소
				workDao.updateWorkAp(workAp);
				
				log.info("createVacApply() 근무 추가 : {}", workAp);
				// 근무기록 추가
				rowCnt = workDao.insertWorkAp(workAp);
				
			}
		}
		
		//##################################################################################
		// 2022-12-08 10:47 LCW
		// 휴가신청 알림 추가
		if(rowCnt > 0) {
			
			// 휴가신청자 이름
			String armSdrName = empService.retrieveEmp(vacApplyVo.getVaapEmp()).getEmpNm();
			
			ArmVO arm = new ArmVO();
			// 알림 발신자
			arm.setArmSdr(vacApplyVo.getVaapEmp());
			// 알림 수신자
			arm.setArmRcvr(vacApplyVo.getVaapApEmp());
			// 알림 내용
			arm.setArmCont(armSdrName+"님이 휴가 승인을 요청 했어요.");
			// 알림 주소
			arm.setArmUrl("/home/todo/inbox.do");
			// 알림 읽기여부
			arm.setArmStat("N");
			// 알림 DB 추가
			if(armService.createArm(arm) == ServiceResult.OK) rowCnt = 1;
		}
		
		//##################################################################################
		
		
		return rowCnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	@Transactional
	public ServiceResult cancelVacApply(String vaapCode) {
		int rowCnt = 0;
		rowCnt = vacDao.updateVacApplyCcSt(vaapCode);
		if(rowCnt > 0) {
			VacPosnVO vacPosnVo = vacDao.selectVacPosnByVaapCode(vaapCode);
			if(vacPosnVo != null) {
				vacPosnVo.setVpCngCase("취소");
				vacPosnVo.setVpCngRsn("휴가 신청을 취소한다.");
				vacPosnVo.setVpAddDays(vacPosnVo.getVpSubDays());
				vacPosnVo.setVpSubDays(null);
				ServiceResult result = createVacationPossession(vacPosnVo);
				log.info("cancelVacApply createVacationPossession result : {}", result);
				if(!result.equals(ServiceResult.OK)) rowCnt = 0;
			}
		}
		//##################################################################################
		// 2022-12-08 11:03 LCW
		// 근무기록에 휴가 삭제
		if(rowCnt > 0) {
			rowCnt = workDao.deleteWorkApToVac(vaapCode);
			log.info("cancelVacApply 근무기록 삭제 vaapCode : {}, rowCnt : {}", vaapCode, rowCnt);
		}
		//##################################################################################
		
		return rowCnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	@Transactional
	public ServiceResult uploadVaapFile(String vaapCode, MultipartFile uploadFile) {
		int rowCnt = 0;
		rowCnt = vacDao.updateVaapFileCnt(vaapCode);
		if(rowCnt > 0) {
			AttatchVO attatch = new AttatchVO(uploadFile);
			attatch.setVaapCode(vaapCode);
			Map<String, Object> map = new HashMap<>();
			List<AttatchVO> attatchList = new ArrayList<AttatchVO>();
			attatchList.add(attatch);
			map.put("attatchList", attatchList);
			rowCnt = attatchDao.insertAttatches(map);
			try {
				attatch.saveTo(saveFolder);
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
		}
		return rowCnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	/* 휴가 개요 */
	
	/* 연차 상세 */
	
	@Override
	public List<VacPosnVO> retrieveVacPosnListByKeyWords(String empNo, String year) {
		Map<String, Object> map = new HashMap<>();
		map.put("empNo", empNo);
		map.put("year", Integer.parseInt(year)); // Integer.valueOf();
		return vacDao.selectVacPosnListByMap(map);
	}

	/* 연차 상세 */
	
	/* 휴가 보유 현황 */
	
	@Override
	public Map<String, Object> retrieveFilterOptionLists() {
		Map<String, Object> map = new HashMap<>();
		List<DeptVO> deptList = othersDao.selectDeptList();
		map.put("deptList", deptList);
		List<VacVO> vacList = vacDao.selectAllVacation();
		map.put("vacList", vacList);
		return map;
	}
	
	@Override
	public List<EmpVO> retrieveVacPosnStatBySearch(PagingVO<EmpVO> pagingVO) {
		String empNm = mapper.convertValue(pagingVO.getDataMap().get("empNm"), String.class);
		List<String> deptList = mapper.convertValue(pagingVO.getDataMap().get("deptList"), TypeFactory.defaultInstance().constructCollectionType(List.class, String.class));
		List<String> vacList = mapper.convertValue(pagingVO.getDataMap().get("vacList"), TypeFactory.defaultInstance().constructCollectionType(List.class, String.class));
		Map<String, Object> map = new HashMap<>();
		map.put("empNm", empNm);
		map.put("deptList", deptList);
		map.put("vacList", vacList);
		pagingVO.setDataMap(map);
		return vacDao.selectVacPosnStat(pagingVO);
	}

	@Override
	public int retrieveVacPosnStatBySearchCount(PagingVO<EmpVO> pagingVO) {
		return vacDao.selectVacPosnStatTotalRecord(pagingVO);
	}

	/* 휴가 보유 현황 */

	/* 휴가 신청 내역 */
	
	@Override
	public List<VacApplyVO> retrieveVacApplyList(Integer year, Integer month) {
		Map<String, Object> map = new HashMap<>();		
		map.put("year", year);
		map.put("month", month);
		return vacDao.selectVacApplyVoListByDate(map);
	}

	@Override
	@Transactional
	public ServiceResult vacApplyManage(String vaapCode, String behavior) {
		int rowCnt = 0;
		if(StringUtils.isNotEmpty(behavior)) {
			Map<String, String> map = new HashMap<>();
			map.put("vaapCode", vaapCode);
			map.put("behavior", behavior);
			rowCnt = vacDao.updateVacApplyApSt(map);
			
			VacApplyVO vacApplyVo = retrieveVacApply(vaapCode);
			
			//##################################################################################
			// 2022-12-12 10:32 LCW
			// 휴가승인 반려에 따른 알림 및 근무기록 반영
			
			
			if(rowCnt > 0 && behavior.equals("approve")) {
				// 근무기록 해당 휴가승인
				rowCnt = workDao.confirmWorkApToVac(vaapCode);
				
				// 휴가승인 알림 추가
				if(rowCnt > 0) {
					
					ArmVO arm = new ArmVO();
					// 알림 발신자
					arm.setArmSdr(vacApplyVo.getVaapApEmp());
					// 알림 수신자
					arm.setArmRcvr(vacApplyVo.getVaapEmp());
					// 알림 내용
					arm.setArmCont("휴가 사용이 승인되었어요.");
					// 알림 주소
					arm.setArmUrl("/myVacation/vacOutlineView.do");
					// 알림 읽기여부
					arm.setArmStat("N");
					// 알림 DB 추가
					if(armService.createArm(arm) == ServiceResult.OK) rowCnt = 1;
				}
				
			}else if(rowCnt > 0 && behavior.equals("reject")) {
				
				// 근무기록 해당 휴가삭제
				rowCnt = workDao.deleteWorkApToVac(vaapCode);
				log.info("vacApplyManage 근무기록 삭제 vaapCode : {}, rowCnt : {}", vaapCode, rowCnt);
				
				// 휴가반려 알림 추가
				if(rowCnt > 0) {
					
					// 휴가 결재자 이름
					String armSdrName = empService.retrieveEmp(vacApplyVo.getVaapApEmp()).getEmpNm();
					
					ArmVO arm = new ArmVO();
					// 알림 발신자
					arm.setArmSdr(vacApplyVo.getVaapApEmp());
					// 알림 수신자
					arm.setArmRcvr(vacApplyVo.getVaapEmp());
					// 알림 내용
					arm.setArmCont(armSdrName+"님이 휴가 사용을 반려 했어요.");
					// 알림 주소
					arm.setArmUrl("/myVacation/vacOutlineView.do");
					// 알림 읽기여부
					arm.setArmStat("N");
					// 알림 DB 추가
					if(armService.createArm(arm) == ServiceResult.OK) rowCnt = 1;
				}
			}
			//##################################################################################
			
			if(rowCnt > 0 && behavior.equals("approve")) {
				log.info("승인일 때 vacApplyVo : {}", vacApplyVo);
				VacPosnVO vacPosnVo = new VacPosnVO();
				vacPosnVo.setEmpNo(vacApplyVo.getVaapEmp());
				vacPosnVo.setVclfCode(vacApplyVo.getVacVo().getVclfCode());
				vacPosnVo.setVcCode(vacApplyVo.getVacVo().getVcCode());
				vacPosnVo.setVpCngCase("사용");
				StringBuilder sb = new StringBuilder("\"");
				sb.append(vacApplyVo.getVacVo().getVcNm());
				sb.append("\" 휴가를 사용한다.");
				vacPosnVo.setVpCngRsn(sb.toString());
				if(vacApplyVo.getVacVo().getVcGmtd().contains("신청시")) vacPosnVo.setVpSubDays(0.0);
				else vacPosnVo.setVpSubDays(vacApplyVo.getVaapDays());
				vacPosnVo.setVaapCode(vacApplyVo.getVaapCode());
				log.info("승인일 때 vacPosnVo : {}", vacPosnVo);
				ServiceResult result = createVacationPossession(vacPosnVo);
				if(!result.equals(ServiceResult.OK)) rowCnt = 0;
			};
		}
		return rowCnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	public VacApplyVO retrieveVacApply(String vaapCode) {
		return vacDao.selectVacApplyVoByVaapCode(vaapCode);
	}
	
	/* 휴가 신청 내역 */
	
}
