package kr.or.ddit.pay.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.emp.dao.EmpDAO;
import kr.or.ddit.pay.dao.PayrollDAO;
import kr.or.ddit.vo.BlgDeptVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.ExcelPayVO;
import kr.or.ddit.vo.ExcelWorkVO;
import kr.or.ddit.vo.OwnJobVO;
import kr.or.ddit.vo.PayRcdVO;
import kr.or.ddit.vo.PayrollSetVO;
import kr.or.ddit.vo.PayrollVO;
import kr.or.ddit.vo.PrEmpVO;
import kr.or.ddit.vo.PtMakeVO;
import kr.or.ddit.vo.WkApVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PayrollServiceImpl implements PayrollService {

	@Inject
	private PayrollDAO prDAO;
	
	@Inject
	private EmpDAO empDAO;
	
	//[급여대장]============================================================================
	
	//급여정산 - 급여대장 생성
	@Override
	public ServiceResult createProll(PayrollVO payroll) {
		int rowcnt = prDAO.insertProll(payroll);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	//급여정산 - 급여대장 조회
	@Override
	public PayrollVO retrieveProll(PayrollVO payroll) {
		return prDAO.selectProll(payroll);
	}
	
	//급여정산 - 급여대장 삭제
	@Override
	public ServiceResult removeProll(String prNo) {
		int rowcnt = prDAO.deleteProll(prNo);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	
	//[대상자]============================================================================
	
	//급여정산 - 정산 생성 후 근무기록있는 대상자 조회
	@Override
	public List<WkApVO> retrieveEmpList(PayrollVO payroll) {
		return prDAO.selectEmpList(payroll);
	}
	
	//급여 정산 최초 생성 시 근무기록 있는 사원의 정보 조회
	@Transactional
	@Override
	public List<EmpVO> empSettlement(PayrollVO payroll){
		//정산 대상자 담는 리스트
		List<EmpVO> settledEmpList = new ArrayList<EmpVO>();
		
		//정산 생성 시 선택한 정산기간에 근무기록이 있는 사원 목록
		List<WkApVO> empList = prDAO.selectEmpList(payroll);
		
		for(WkApVO emp : empList) {
			EmpVO empVo = empDAO.selectEmp(emp.getWaAper()); //사원 정보 조회
			String empCase = prDAO.selectEmpCase(emp.getWaAper());
			empVo.setEntCase(empCase); 	//사원 근로유형
			settledEmpList.add(empVo);
		}
		return settledEmpList;
	}
	
	//급여정산 - 선택한 대상자 등록
	@Override
	public ServiceResult createPayEmp(List<PrEmpVO> payempList) {
		int rowcnt = prDAO.insertPayEmp(payempList);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	//급여정산 - 확정된 대상자 조회
	@Override
	public List<PrEmpVO> retrievePayEmpList(String prNo) {
		return prDAO.selectPayEmpList(prNo);
	}
	
	//[공통]============================================================================

	//급여정산 - 정산내역 등록 (지급,공제 내역 모두 포함)
	@Override
	public ServiceResult createPayRcd(List<PayRcdVO> payrcdList) {
		int rowcnt = prDAO.insertPayRcd(payrcdList);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	//[지급]============================================================================
	//급여정산 - 지급항목 정산
	@Transactional
	@Override
public List<PayrollSetVO> alwSettlement(PayrollVO payroll){
		
		log.info("alwSettle payroll{}" , payroll); //날짜 있나 봐야함
		//지급 정산 내역 담는 리스트
		List<PayrollSetVO> settledAlwList = new ArrayList<PayrollSetVO>();
		
		//해당 정산 확정된 대상자 목록
		List<PrEmpVO> empList = prDAO.selectPayEmpList(payroll.getPrNo());
		
		//정산의 템플릿 별 지급 지급 항목 정보 조회
		List<PtMakeVO> ptmList = prDAO.selectProll(payroll).getPtmList();
		log.info("alwptmList service {}",ptmList);
		
		//초과근무 조회
		
		for (PrEmpVO emp : empList) {
			String empNo = emp.getEmpNo();
			PayrollSetVO psvo = new PayrollSetVO();
			psvo.setEmpNm(emp.getEmpNm());  						//사원이름
			psvo.setEmpNo(empNo); 									//사번
			
			log.info("======>확인 {} ======> {}", empNo, empDAO.selectRecentWageList(empNo));
			
			//월급여액에 따른 시급 계산
			int annualInc  = empDAO.selectRecentWageList(empNo).getBcntAmt();
			
			int monthlyInc = annualInc  / 12; 
			int hourlyInc  = monthlyInc / 209 ; 
			psvo.setBasePayHour(hourlyInc);							//기본시급
			psvo.setContractHour(209);								//소정근무시간
			
			int mealAlw = empDAO.selectRecentWageList(empNo).getBfex();
			psvo.setMealAllowance(mealAlw); 						//식비(종전식대)
			
			//총 근무, 초과근무 시간 조회
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("empNo", empNo);
			paramMap.put("prSdate", payroll.getPrSdate());
			paramMap.put("prEdate", payroll.getPrEdate());
			
			double totalTime = prDAO.selectTotalWork(paramMap); //총근무시간
			double unpaidTime = 209 - totalTime ;				//미달근무시간 (소정근무시간 209 고정 - 총 근무 시간)

			//미달
			String upStr = "";
			if(unpaidTime > 0 ) {
				int upHour = (int)(Math.floor(unpaidTime));
				double upMin = unpaidTime - upHour;
				
				upStr = timeFormat(upHour, upMin); //시간 형식 세팅
				
				psvo.setUnpaidHour(upStr); 						
			}else {
				psvo.setUnpaidHour("");
			}

			
			//차감금액 계산 (미달근무시간 * 기본시급)
			
			int unpaidAmount = (int)Math.round(unpaidTime * hourlyInc);
			if(unpaidAmount<0) unpaidAmount = 0;
			psvo.setUnpaidAmount(unpaidAmount); 				//기본급차감금
			
			psvo.setBasePayMonth(monthlyInc);					//기본급(계약연봉/12)
			psvo.setTotalBasePayMonth(monthlyInc-unpaidAmount);	//기본지급금 (계약금액 - 기본급차감금)
			
			
			WkApVO wkVO = prDAO.selectOvertime(paramMap);		//초과근무시간(연장·야간·휴일)
			log.info("wkVO {}" , wkVO);
			
			//연장
			double extendTime  = wkVO.getWaExtime();
			String exStr;
			if(extendTime != 0 ) {
				int exHour = (int)(Math.floor(extendTime));
				double exMin = extendTime - exHour;
				
				exStr = timeFormat(exHour, exMin); //시간 형식 세팅
				
				psvo.setExtendWork(exStr);							//연장근무시간
			}
			
			//야간
			double nightTime   = wkVO.getWaNigtime();
			String ngStr;
			if(nightTime != 0 ) {
				int ngHour = (int)(Math.floor(nightTime));
				double ngMin = nightTime - ngHour;
				
				ngStr = timeFormat(ngHour, ngMin); //시간 형식 세팅
				
				psvo.setNightWork(ngStr);							//야간근무시간
			}
			
			//휴일
			double holydayTime = wkVO.getWaHdtime();
			String hdStr;
			if(holydayTime != 0 ) {
				int hdHour = (int)(Math.floor(holydayTime));
				double hdMin = holydayTime - hdHour;
				
				hdStr = timeFormat(hdHour, hdMin); //시간 형식 세팅
				
				psvo.setHolydayWork(hdStr);							//휴일근무시간
			}
			
			double extendBonus   = hourlyInc * 1.5 * extendTime ;
			double nightBonus    = hourlyInc * 1.5 * nightTime;
			double holydayBonus  = hourlyInc * 1.5 * holydayTime;
			
			psvo.setExtendBonus((int)Math.round(extendBonus));		//연장근무수당
			psvo.setNightBonus((int)Math.round(nightBonus));		//야간근무수당
			psvo.setHolydayBonus((int)Math.round(holydayBonus));	//휴일근무수당
			
			double totalOverTime = extendTime + nightTime + holydayTime;
			String totalStr;
			if(totalOverTime != 0 ) {
				int ttHour = (int)(Math.floor(totalOverTime));
				double ttMin = totalOverTime - ttHour;
				
				if(ttMin==0.5) {
					totalStr = ttHour+"시간"+" 30분";
				}else {
					totalStr = ttHour+"시간";
				}
				
				psvo.setTotalOvertime(totalStr);							//휴일근무시간
			}
			
			double totalBonus = extendBonus + nightBonus + holydayBonus;
			psvo.setTotalOverBonus((int)Math.round(totalBonus));			//총 초과근무수당
			
			
			settledAlwList.add(psvo);
			
		}
		
		log.info("settledAlwListChk={}",settledAlwList);
		return settledAlwList;
	}
	
	//[공제]============================================================================

	//급여정산 - 공제항목 계산을 위한 과세금액 조회
	@Override
	public int retrieveTaxable(PayRcdVO rcd) {
		return prDAO.selectTaxable(rcd);
	}

	//
	@Override
	public PayRcdVO retrievePayRcd(PayRcdVO rcd) {
		return prDAO.selectPayRcd(rcd);
	}
	
	
	//사원별 과세금액에 따른 공제항목 정산
	@Transactional
	@Override
	public List<PayrollSetVO> taxSettlement(PayrollVO payroll){
		//공제 정산 내역 담는 리스트
		List<PayrollSetVO> settledTaxList = new ArrayList<PayrollSetVO>();
		
		//해당 정산 확정된 대상자 목록
		List<PrEmpVO> empList = prDAO.selectPayEmpList(payroll.getPrNo());

		//정산의 템플릿 별 지급 공제 항목 정보 조회
		List<PtMakeVO> ptmList = prDAO.selectProll(payroll).getPtmList();
		log.info("ptmList service {}",ptmList);
		
		for (PrEmpVO emp : empList) {
			String empNo = emp.getEmpNo();
			PayrollSetVO psvo = new PayrollSetVO();
			psvo.setEmpNm(emp.getEmpNm());  			//사원이름
			psvo.setEmpNo(empNo); 						//사번

			//월급여액 계산
			int annualInc = empDAO.selectRecentWageList(empNo).getBcntAmt();
			int monthlyInc = annualInc / 12;
			
			//공제 대상 가족 수 계산
			int famCnt = prDAO.selectFamCount(empNo) + 1; //부양가족 수 (본인 포함)
			int chdCnt = prDAO.selectChdCount(empNo); 	//부양가족 중 7세 이상 20세 이하의 자녀는 2명으로 계산한다.
			int dedFamCnt = famCnt+chdCnt;
			psvo.setFamCnt(dedFamCnt);					//공제대상가족수
			
			//공제 시 필요한 과세금액 조회 (parameter : prNo, empNo)
			PayRcdVO ercd = new PayRcdVO();
			ercd.setPrNo(payroll.getPrNo());
			ercd.setEmpNo(empNo);
			log.info("ercd{}",ercd);
			int taxable = prDAO.selectTaxable(ercd);
			psvo.setTaxable(taxable); 	   				//과세금액
			log.info("taxable{}",taxable);
			
			//원천세 공제 시 월급여에따른 근로소득 간이세액표 금액 조회
			int icmTax;
			if		(dedFamCnt == 1) { icmTax = prDAO.selectIcmTax(monthlyInc).getIct01();
			}else if(dedFamCnt == 2) { icmTax = prDAO.selectIcmTax(monthlyInc).getIct02();	
			}else if(dedFamCnt == 3) { icmTax = prDAO.selectIcmTax(monthlyInc).getIct03();	
			}else if(dedFamCnt == 4) { icmTax = prDAO.selectIcmTax(monthlyInc).getIct04();	
			}else if(dedFamCnt == 5) { icmTax = prDAO.selectIcmTax(monthlyInc).getIct05();	
			}else if(dedFamCnt == 6) { icmTax = prDAO.selectIcmTax(monthlyInc).getIct06();	
			}else if(dedFamCnt == 7) { icmTax = prDAO.selectIcmTax(monthlyInc).getIct07();	
			}else if(dedFamCnt == 9) { icmTax = prDAO.selectIcmTax(monthlyInc).getIct08();	
			}else if(dedFamCnt == 9) { icmTax = prDAO.selectIcmTax(monthlyInc).getIct09();	
			}else if(dedFamCnt == 10){ icmTax = prDAO.selectIcmTax(monthlyInc).getIct10();	
			}else					 { icmTax = prDAO.selectIcmTax(monthlyInc).getIct11();	
			}
			
			for (PtMakeVO ptmVO : ptmList) {
				if(ptmVO.getDdCode() != null) {
					switch (ptmVO.getDdCode()) {
					case "WD101": //소득세
						psvo.setIncomeTax(icmTax);
						break;
					case "WD102": //지방소득세
						psvo.setIncomeTaxLocal((int)Math.round(icmTax * 0.1));
						break;
					case "WD201": //국민연금
						psvo.setPension((int)Math.round(taxable * 0.045));
						break;
					case "WD202": //건강보험
						psvo.setHealth((int)Math.round(taxable * 0.03495));
						break;
					case "WD203": //장기요양
						psvo.setLongcare((int)Math.round(taxable * 0.03495 * 0.1227));
						break;
					case "WD204": //고용보험
						psvo.setEmployIns((int)Math.round(taxable * 0.009));
						break;
	
					default:
						break;
					}
				}
			}
			settledTaxList.add(psvo);
		}
		
		return settledTaxList;
	}
	
	//[미리보기]============================================================================

	//정산별 요약 목록 조회
	@Override
	public List<PayRcdVO> retrievePaySumList(String prNo) {
		return prDAO.selectPaySumList(prNo);
	}

	//정산별 요약 합계 조회
	@Override
	public List<PayRcdVO> retreiveTotalSumList(String prNo) {
		return prDAO.selectTotalSumList(prNo);
	}
	
	//이전 정산 정보 조회
	@Transactional
	@Override
	public Map<String, Object> prevSettlement(PayrollVO proll){
		String prevBlg = prDAO.selectPrevBelong(proll.getPrNo()); 			// 현재 정산의 이전 귀속연월 조회
		log.info("prvBlg {}", prevBlg);
		
		PayrollVO prevProll = new PayrollVO();
		prevProll.setPrBlg(prevBlg);
		prevProll.setPrPtno(proll.getPrPtno()); 
		
		String prevPrNo = prDAO.selectPrevProllNo(prevProll); 				// 현재 정산과 동일한 템플릿을 사용한 지난 정산의 정산번호 조회
		log.info("prevPrNo{}",prevPrNo);
		
		
		Map<String, Object> prevMap = new HashMap<String, Object>(); //controller로 보낼 map
		
		if(prevPrNo == null) {
			prevMap.put("res","no previous data");
		}else {
			List<PayRcdVO> prevSumList = prDAO.selectPaySumList(prevPrNo);   	// 지난정산 요약 조회
			List<PayRcdVO> prevTotalList = prDAO.selectTotalSumList(prevPrNo);	// 지난정산 합계 조회
			
			prevMap.put("prevSumList", prevSumList);
			prevMap.put("prevTotalList", prevTotalList);
			prevMap.put("prevBlg", prevBlg);
			
		}
		log.info("prevMapSevice{}",prevMap);
		return prevMap;
	}
	
	//확정된 대상자의 정보 조회
	@Transactional
	@Override
	public List<EmpVO> prevEmpSettlement(PayrollVO payroll){
		//정산 대상자 담는 리스트
		List<EmpVO> settledEmpList = new ArrayList<EmpVO>();
		
		//확정된 대상자 리스트
		List<PrEmpVO> empList = prDAO.selectPayEmpList(payroll.getPrNo());
		
		for(PrEmpVO emp : empList) {
			EmpVO empVo = empDAO.selectEmp(emp.getEmpNo()); //사원 정보 조회
			String empCase = prDAO.selectEmpCase(emp.getEmpNo());
			empVo.setEntCase(empCase); 	//사원 근로유형
			settledEmpList.add(empVo);
		}
		return settledEmpList;
	}
	
	//정산별 세부 목록 조회
	@Override
	public List<PayRcdVO> retrieveProllRecordList(String prNo) {
		return prDAO.selectProllRecordList(prNo);
	}

	//정산 완료 등록
	@Override
	public ServiceResult modifyProllFin(PayrollVO payroll) {
		int rowcnt = prDAO.updateProllFin(payroll);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	
	//정산 결과 조회 세팅
	@Transactional
	@Override
	public Map<String, Object> resSettlement(PayrollVO proll){
		String prevBlg = prDAO.selectPrevBelong(proll.getPrNo()); 	// 현재 정산의 이전 귀속연월 조회
		
		PayrollVO prevProll = new PayrollVO();
		prevProll.setPrBlg(prevBlg);  			//이전정산 귀속연월
		prevProll.setPrPtno(proll.getPrPtno()); //이전정산 템플릿번호
		
		String prevPrNo = prDAO.selectPrevProllNo(prevProll); 		// 현재 정산과 동일한 템플릿을 사용한 지난 정산의 정산번호 조회
		
		prevProll.setPrNo(prevPrNo); 			//이전 정산 번호
		
		
		Map<String, Object> prevMap = new HashMap<String, Object>(); //controller로 보낼 map
		
		if(prevPrNo == null) {
			prevMap.put("res","no previous data");
		}else {
			PayrollVO setPrevProll = prDAO.selectProll(prevProll);		
			List<PayRcdVO> setPrevTotalList = prDAO.selectTotalSumList(prevProll.getPrNo());	
			
			prevMap.put("setPrevProll", setPrevProll); // 이전 정산 정보
			prevMap.put("setPrevTotalList",setPrevTotalList);  // 이전 정산 총 계
			
		}
		
		return prevMap;
	}

	
	//[급여]
	
	//선택한 귀속연도에 속하는 급여 정산
	@Transactional
	@Override
	public List<PayrollVO> paystubListSettlement(Map<String, Object> paramMap) {
		//받아온 파라미터 - 귀속연도, 사원번호
		
		// 컨트롤러로 보낼 list (귀속연도의 급여명세 목록)
		List<PayrollVO> paystubList = new ArrayList<PayrollVO>();
		
		// 선택한 귀속연도에 정산이 완료된 사원의 급여명세목록을 조회  (여러 정산이 나올 수 있다)
		List<PayrollVO> yearList = prDAO.selectProllbyYear(paramMap);

		for (PayrollVO year : yearList) {
			PayrollVO payroll = prDAO.selectProll(year); //특정 정산에 대한 정보를 조회
			PayrollVO pvo = new PayrollVO();
			pvo.setPrGdate(payroll.getPrGdate());	//지급일
			pvo.setPrBlg(payroll.getPrBlg());		//귀속월
			pvo.setPrNo(payroll.getPrNo()); 		//정산번호
			pvo.setPrPtno(payroll.getPrPtno());  	//템플릿번호
			pvo.setPrSdate(payroll.getPrSdate());   //근무기간(시작)
			pvo.setPrEdate(payroll.getPrEdate());   //근무기간(끝)
			paystubList.add(pvo);
		}

		return paystubList;
	}
	
	// 급여명세서 세팅
	@Transactional
	@Override
	public Map<String, Object> paystubSettlement(Map<String, Object> paramMap){
		//받아온 파라미터 - 귀속연도, 사원번호, 정산번호
		String empNo = String.valueOf(paramMap.get("empNo"));
		
		//controller로 보낼 map (급여정산(급여대장)정보, 해당 정산 지급,공제 항목별 금액)
		Map<String, Object> stubMap = new HashMap<String, Object>(); 
		
		PayrollVO proll = new PayrollVO();
		proll.setPrPtno((String) paramMap.get("prPtno"));
		proll.setPrNo((String) paramMap.get("prNo"));
		
		PayrollVO prollInfo = prDAO.selectProll(proll); 			//선택한 정산에 대한 정보를 조회
		
		List<PayRcdVO> totalInfo = prDAO.selectTotalStub(paramMap); //선택한 정산에 대한 총 금액 조회
		
		List<PayRcdVO> stubInfo = prDAO.selectPaystub(paramMap);	//선택한 정산에 대한 항목 정보를 조회
		
		EmpVO empInfo = empDAO.selectEmp(empNo); //사원의 정보를 조회
		
		//월급여액에 따른 시급 계산
		int annualInc  = empDAO.selectRecentWageList(empNo).getBcntAmt();
		int monthlyInc = annualInc  / 12; 
		int hourlyInc  = monthlyInc / 209 ; 
		
		stubMap.put("prollInfo", prollInfo); //선택 정산정보
		stubMap.put("totalInfo", totalInfo); //선택 정산 총금액
		stubMap.put("stubInfo", stubInfo);   //선택 정산 항목별 금액
		stubMap.put("empInfo", empInfo);	 //사원 정보
		stubMap.put("hourlyInc", hourlyInc); //사원 기본시급
		

		
		return stubMap;
		
		
		/* PDF로 받을때 추가로 더 넣어야하는 것
		 * ---사원번호, 생년월일, 사번, 소속조직, 직책
		   ---발급일, 회사명, 대표이사 , 직인 
		   ---기본시급
		 * */
	}
	
	// 원천징수영수증 세팅
	@Transactional
	@Override
	public Map<String, Object> withholdSettlement(Map<String, Object> paramMap){
		//받아온 파라미터 사원번호, 귀속연월시작일, 귀속연월종료일
		String empNo = String.valueOf(paramMap.get("empNo"));
		
		//controller로 보낼 map (사원정보, 회사정보, 귀속연월 정산의 총 금액)
		Map<String, Object> holdMap = new HashMap<String, Object>(); 
		
		
		EmpVO empInfo = empDAO.selectEmp(empNo); //사원의 정보를 조회
		
		List<PayrollVO> termProllList = prDAO.selectProllbyYear(paramMap); //선택한 기간에 귀속연월이 포함되는 정산 목록
		
		List<Object> totalInfoList = new ArrayList<Object>();
		for (PayrollVO term : termProllList) {
			paramMap.put("prNo", term.getPrNo());
			List<PayRcdVO> totalList = prDAO.selectTotalStub(paramMap);
			totalInfoList.add(totalList);
		}

		//가져가야하는 거 > 사원정보 회사정보 정산별 토탈금액
		
		holdMap.put("empInfo", empInfo);
		holdMap.put("totalInfoList", totalInfoList);
		log.info("HOLDMAP CHECK {}",holdMap);
		
		return holdMap;
	}
	
	
	//[엑셀다운/급여정산- 정산완료 페이지]============================================================================
	@Override
	public List<ExcelPayVO> salaryTransferExcelList(String prNo, String transferDate) {
		List<EmpVO> empList = prDAO.selectSalaryTransferList(prNo);
		List<ExcelPayVO> excelList = new ArrayList<ExcelPayVO>();
		for (EmpVO empVO : empList) {
			ExcelPayVO excel = new ExcelPayVO();
			excel.setEmpNo(empVO.getEmpNo());
			excel.setEmpNm(empVO.getEmpNm());
			excel.setEmpMail(empVO.getEmpMail());
			excel.setEntDate(empVO.getEntDate());
			excel.setOutDate(empVO.getOutDate());
			excel.setBank(empVO.getBank());
			excel.setAcctNo(empVO.getAcctNo());
			excel.setOwer(empVO.getOwer());
			excel.setReceivingbankbook("급여");
			excel.setSandBankbook(empVO.getEmpNm());
			
			String dept ="";
			String jnm ="";
			String dtnm ="";
			String tDate = transferDate;
			
			for (BlgDeptVO deptVO : empVO.getDeptList()) {
				dept += deptVO.getDnm() +", ";
				dtnm += deptVO.getDtnm() +", ";
			}
			for (OwnJobVO jobVO : empVO.getJobList()) {
				jnm += jobVO.getJnm() +", ";
 			}
			excel.setDept(dept);
			excel.setJnm(jnm);
			excel.setDtnm(dtnm);
			excel.setGrd(empVO.getGrdNm());
			excel.setPtn(empVO.getPtnNm());
			excel.setTransferDate(tDate);
			
			excelList.add(excel);
		}
		
		return excelList;
	}

	
	/**
	 * view에 출력할 시간 형식 모듈화
	 * @return
	 */
	private String timeFormat(int hour, double min) {
		String res = "";
		if(min==0.5 && hour !=0) {
			res = hour+"시간"+" 30분";
		}else if(min==0 && hour !=0){
			res = hour+"시간";
		}else {
			res = "30분";
		}
		return res;
	}
	
	
}
