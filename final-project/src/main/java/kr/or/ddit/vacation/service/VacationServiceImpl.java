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
	
	/* ?????? ?????? */
	
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

	/* ?????? ?????? */
	
	/* ?????? ?????? */
	
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
	
	// ?????? ??????
	@Override
	@Transactional
	public ServiceResult createVacApply(Map<String, Object> dataMap) { // ????????? ????????? 
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
		// ??????????????? ???????????? ??????
		if(rowCnt >0) {
			
			// ?????? ?????????????????? ??????????????? ????????????
			for(VacSchVO vacSchVo : vacSchVoList) {
				
				WkApVO workAp = new WkApVO();
				
				// ???????????? ?????????
				workAp.setWaAper(vacApplyVo.getVaapEmp());
				// ???????????? ??????
				workAp.setWaDate(vacSchVo.getVsEachDate());
				// ??????????????? ??????
				workAp.setWaTltime(8.0);
				// ???????????? ????????? ??????
				workAp.setEwApst("??????");
				// ??????????????????
				workAp.setWaStime("09:00");
				workAp.setWaEtime("18:00");
				
				// !!????????? *????????????* ????????? ????????? ???????????? ????????? ?????? ?????????????????? ??????!!
				workAp.setEwRejrsn(vacSchVo.getVaapCode());
				
				// ??????????????? ?????? ???????????? ??????
				// ?????? ????????????
				if(vacSchVo.getVsUseDays() == 1) {
					workAp.setWkCode("WK1");
				}else {
					// ?????? ????????????
					if(vacSchVo.getVsEtime().equals("14:00")) {
						workAp.setWkCode("WK6");
						
					// ?????? ????????????
					}else {
						workAp.setWkCode("WK7");
						
					}
				}
				
				log.info("createVacApply() ?????? ?????? ????????????: {}, ????????????: {}", workAp.getWaAper(), workAp.getWaDate());
				// ??????????????? ??????
				workDao.updateWorkAp(workAp);
				
				log.info("createVacApply() ?????? ?????? : {}", workAp);
				// ???????????? ??????
				rowCnt = workDao.insertWorkAp(workAp);
				
			}
		}
		
		//##################################################################################
		// 2022-12-08 10:47 LCW
		// ???????????? ?????? ??????
		if(rowCnt > 0) {
			
			// ??????????????? ??????
			String armSdrName = empService.retrieveEmp(vacApplyVo.getVaapEmp()).getEmpNm();
			
			ArmVO arm = new ArmVO();
			// ?????? ?????????
			arm.setArmSdr(vacApplyVo.getVaapEmp());
			// ?????? ?????????
			arm.setArmRcvr(vacApplyVo.getVaapApEmp());
			// ?????? ??????
			arm.setArmCont(armSdrName+"?????? ?????? ????????? ?????? ?????????.");
			// ?????? ??????
			arm.setArmUrl("/home/todo/inbox.do");
			// ?????? ????????????
			arm.setArmStat("N");
			// ?????? DB ??????
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
				vacPosnVo.setVpCngCase("??????");
				vacPosnVo.setVpCngRsn("?????? ????????? ????????????.");
				vacPosnVo.setVpAddDays(vacPosnVo.getVpSubDays());
				vacPosnVo.setVpSubDays(null);
				ServiceResult result = createVacationPossession(vacPosnVo);
				log.info("cancelVacApply createVacationPossession result : {}", result);
				if(!result.equals(ServiceResult.OK)) rowCnt = 0;
			}
		}
		//##################################################################################
		// 2022-12-08 11:03 LCW
		// ??????????????? ?????? ??????
		if(rowCnt > 0) {
			rowCnt = workDao.deleteWorkApToVac(vaapCode);
			log.info("cancelVacApply ???????????? ?????? vaapCode : {}, rowCnt : {}", vaapCode, rowCnt);
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

	/* ?????? ?????? */
	
	/* ?????? ?????? */
	
	@Override
	public List<VacPosnVO> retrieveVacPosnListByKeyWords(String empNo, String year) {
		Map<String, Object> map = new HashMap<>();
		map.put("empNo", empNo);
		map.put("year", Integer.parseInt(year)); // Integer.valueOf();
		return vacDao.selectVacPosnListByMap(map);
	}

	/* ?????? ?????? */
	
	/* ?????? ?????? ?????? */
	
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

	/* ?????? ?????? ?????? */

	/* ?????? ?????? ?????? */
	
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
			// ???????????? ????????? ?????? ?????? ??? ???????????? ??????
			
			
			if(rowCnt > 0 && behavior.equals("approve")) {
				// ???????????? ?????? ????????????
				rowCnt = workDao.confirmWorkApToVac(vaapCode);
				
				// ???????????? ?????? ??????
				if(rowCnt > 0) {
					
					ArmVO arm = new ArmVO();
					// ?????? ?????????
					arm.setArmSdr(vacApplyVo.getVaapApEmp());
					// ?????? ?????????
					arm.setArmRcvr(vacApplyVo.getVaapEmp());
					// ?????? ??????
					arm.setArmCont("?????? ????????? ??????????????????.");
					// ?????? ??????
					arm.setArmUrl("/myVacation/vacOutlineView.do");
					// ?????? ????????????
					arm.setArmStat("N");
					// ?????? DB ??????
					if(armService.createArm(arm) == ServiceResult.OK) rowCnt = 1;
				}
				
			}else if(rowCnt > 0 && behavior.equals("reject")) {
				
				// ???????????? ?????? ????????????
				rowCnt = workDao.deleteWorkApToVac(vaapCode);
				log.info("vacApplyManage ???????????? ?????? vaapCode : {}, rowCnt : {}", vaapCode, rowCnt);
				
				// ???????????? ?????? ??????
				if(rowCnt > 0) {
					
					// ?????? ????????? ??????
					String armSdrName = empService.retrieveEmp(vacApplyVo.getVaapApEmp()).getEmpNm();
					
					ArmVO arm = new ArmVO();
					// ?????? ?????????
					arm.setArmSdr(vacApplyVo.getVaapApEmp());
					// ?????? ?????????
					arm.setArmRcvr(vacApplyVo.getVaapEmp());
					// ?????? ??????
					arm.setArmCont(armSdrName+"?????? ?????? ????????? ?????? ?????????.");
					// ?????? ??????
					arm.setArmUrl("/myVacation/vacOutlineView.do");
					// ?????? ????????????
					arm.setArmStat("N");
					// ?????? DB ??????
					if(armService.createArm(arm) == ServiceResult.OK) rowCnt = 1;
				}
			}
			//##################################################################################
			
			if(rowCnt > 0 && behavior.equals("approve")) {
				log.info("????????? ??? vacApplyVo : {}", vacApplyVo);
				VacPosnVO vacPosnVo = new VacPosnVO();
				vacPosnVo.setEmpNo(vacApplyVo.getVaapEmp());
				vacPosnVo.setVclfCode(vacApplyVo.getVacVo().getVclfCode());
				vacPosnVo.setVcCode(vacApplyVo.getVacVo().getVcCode());
				vacPosnVo.setVpCngCase("??????");
				StringBuilder sb = new StringBuilder("\"");
				sb.append(vacApplyVo.getVacVo().getVcNm());
				sb.append("\" ????????? ????????????.");
				vacPosnVo.setVpCngRsn(sb.toString());
				if(vacApplyVo.getVacVo().getVcGmtd().contains("?????????")) vacPosnVo.setVpSubDays(0.0);
				else vacPosnVo.setVpSubDays(vacApplyVo.getVaapDays());
				vacPosnVo.setVaapCode(vacApplyVo.getVaapCode());
				log.info("????????? ??? vacPosnVo : {}", vacPosnVo);
				ServiceResult result = createVacationPossession(vacPosnVo);
				if(!result.equals(ServiceResult.OK)) rowCnt = 0;
			};
		}
		return rowCnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	public VacApplyVO retrieveVacApply(String vaapCode) {
		return vacDao.selectVacApplyVoByVaapCode(vaapCode);
	}
	
	/* ?????? ?????? ?????? */
	
}
