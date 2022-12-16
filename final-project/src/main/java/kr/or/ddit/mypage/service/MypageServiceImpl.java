package kr.or.ddit.mypage.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.emp.dao.EmpDAO;
import kr.or.ddit.vo.AccaVO;
import kr.or.ddit.vo.CareerVO;
import kr.or.ddit.vo.CmcodeVO;
import kr.or.ddit.vo.CnthxVO;
import kr.or.ddit.vo.EmpFamVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.EmptVO;
import kr.or.ddit.vo.HrnoteVO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MypageServiceImpl implements MypageService {
	@Inject
	EmpDAO dao;
	private File saveFolder;
	private String saveFolderPath;
	
	
	@Override
	public int updateEmpImg(Map<String, Object> empList) {
		EmpVO emp = (EmpVO) empList.get("emp");		
		saveFolderPath =  (String) empList.get("realPath");		
		
		saveFolder = new File(saveFolderPath);		
		if(!saveFolder.exists())saveFolder.mkdirs();		
		int rowcnt = dao.updateEmpImg(emp);
		
		try {
			if(rowcnt > 0)
			emp.saveTo(saveFolder);
			
			return rowcnt ;
		}catch (IOException e) {
			throw new RuntimeException(e);
		}
	}
	
	@Override
	public int deleteEmpImg(String empNo) {
		return dao.deleteEmpImg(empNo) ;
	}
	
	@Override
	public EmpVO selectEmp(String empNo) {
		return dao.selectEmp(empNo);
	}

	@Override
	public List<CareerVO> selectCareer(String empNo) {
		// TODO Auto-generated method stub
		return dao.selectCareer(empNo);
	}

	@Override
	public List<AccaVO> selectAcca(String empNo) {
		// TODO Auto-generated method stub
		return dao.selectAcca(empNo) ;
	}
	
	@Override
	public List<CmcodeVO> selectLabel() {		
		return dao.selectLabel();
	}
	
	
	@Override
	public ServiceResult updateEmp(EmpVO emp) {	
		int rowcnt = dao.updateEmp(emp);
	return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;

	}

	@Override
	public List<CmcodeVO> bankNmList() {		
		return dao.bankNmList();
	}

	@Override
	public ServiceResult updateBasicInfo(EmpVO emp) {
		
		int rowcnt= dao.updateBasicInfo(emp);
		
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	//----[인사노트 시작]------------------------------------------------------------------------
	@Override
	public List<HrnoteVO> selectHrNoteList(String empNo) {
		return dao.selectHrnote(empNo);
	}

	@Override
	public EmpVO selectHrInfoList(String empNo) {
		return dao.selectEmp(empNo);
	}
	
	@Override
	public int insertHrnote(HrnoteVO hrnote) {
		return dao.insertHrnote(hrnote);
	}

	@Override
	public int updateHrnote(HrnoteVO hrnote) {
		return dao.updateHrnote(hrnote);
	}

	@Override
	public int deleteHrnote(String noteNo) {
		return dao.deleteHrnote(noteNo);
	}
	//====[인사노트 종료]========================================================================
	
	//----[근로,임금 계약 시작]-------------------------------------------------------------------
	@Override
	public CnthxVO selectRecentWkList(String empNo) {
		return dao.selectRecentWkList(empNo);
	}

	@Override
	public CnthxVO selectRecentWageList(String empNo) {
		return dao.selectRecentWageList(empNo);
	}
	
	@Override
	public List<CnthxVO> WageCntRetrieve(String empNo) {
		return dao.WageCntRetrieve(empNo);
	}

	@Override
	public List<CnthxVO> WorkCntRetrieve(String empNo) {
		return dao.WorkCntRetrieve(empNo);
	}
	
	@Override
	public int insertLaborCrt(CnthxVO lcntInfo) {
		return dao.insertLaborCrt(lcntInfo);
	}
	
	@Override
	public int insertWageCrt(CnthxVO wcntInfo) {
		return dao.insertWageCrt(wcntInfo);
	}
	
	@Override
	public int updateRctWkList(CnthxVO lcntInfo) {
		return dao.updateRctWkList(lcntInfo);
	}
	
	@Override
	public int updateRctWgList(CnthxVO wcntInfo) {
		return dao.updateRctWgList(wcntInfo);
	}

	@Override
	public int deleteRctWkList(String cnthxNo) {
		return dao.deleteRctWkList(cnthxNo);
	}

	@Override
	public CnthxVO choosenCntRetrieve(String cnthxNo) {
		return dao.choosenCntRetrieve(cnthxNo);
	}
	//====[근로,임금 계약 끝]====================================================================

	//----[재직상태 시작]------------------------------------------------------------------------
	@Override
	public List<EmptVO> bkStateRetrieve(String empNo) {
		return dao.bkStateRetrieve(empNo);
	}
	
	@Override
	public int insertOutToEmptst(EmptVO emptVo) {
		return dao.insertOutToEmptst(emptVo);
	}

	@Override
	public int insertBkToEmptst(EmptVO emptVo) {
		return dao.insertBkToEmptst(emptVo);
	}
	
	@Override
	public int modifyBkState(EmptVO emptVo) {
		return dao.modifyBkState(emptVo);
	};
	
	@Override
	public int deleteBkState(String emptNo) {
		return dao.deleteBkState(emptNo);
	}
	//====[재직상태 종료]=======================================================================
	
	@Override
	public ServiceResult createEmpFam(EmpFamVO fam) {
		int rowcnt = dao.insertEmpFam(fam);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public List<EmpFamVO> selectFamList(String empNo) {
		return dao.selectFamList(empNo);
	}

	@Override
	public EmpFamVO selectFamCount(String empNo) {
		return dao.selectFamCount(empNo);
	}

	@Override
	public EmpFamVO selectFamView(String efamNo) {
		EmpFamVO fam = dao.selectFamView(efamNo);
		return fam;
	}

	@Override
	public int updateEmpFam(EmpFamVO fam) {
		int rowcnt = dao.updateEmpFam(fam);
		return rowcnt;
	}

	@Override
	public int deleteEmpFam(String efamNo) {
		return dao.deleteEmpFam(efamNo);
	}

	@Override
	public int insertCareerInfo(CareerVO career) {
		return dao.insertCareerInfo(career);
	}

	@Override
	public CareerVO selectCareerView(String caNo) {
		return dao.selectCareerView(caNo);
	}

	@Override
	public List<CmcodeVO> selectCaCntCaseList() {
		return dao.selectCaCntCaseList();
	}

	@Override
	public List<CmcodeVO> selectGradeClfList() {
		return dao.selectGradeClfList();
	}

	@Override
	public List<CmcodeVO> selectAcClfList() {
		return dao.selectAcClfList();
	}

	@Override
	public int careerInfoUpdate(CareerVO career) {
		return dao.careerInfoUpdate(career);
	}

	@Override
	public int careerInfoDelete(String caNo) {
		return dao.careerInfoDelete(caNo);
	}

	@Override
	public int accInfoInsert(AccaVO acca) {
		return dao.accInfoInsert(acca);
	}

	@Override
	public List<AccaVO> selectAccaList(String empNo) {
		return dao.selectAccaList(empNo);
	}

	@Override
	public int updateAccaInfo(AccaVO acca) {
		return dao.updateAccaInfo(acca);
	}

	@Override
	public int deleteAccaInfo(String accaNo) {
		return dao.deleteAccaInfo(accaNo);
	}
}
