package kr.or.ddit.pay.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.pay.dao.PayDedDAO;
import kr.or.ddit.vo.PayAlwVO;
import kr.or.ddit.vo.PayDedVO;
import kr.or.ddit.vo.PayTmpVO;

@Service
public class PayDedServiceImpl implements PayDedService {

	@Inject
	private PayDedDAO pdDAO;
	
	//지급항목 조회
	@Override
	public PayAlwVO retrievePay(String pyCode) {
		PayAlwVO pay = pdDAO.selectPay(pyCode);
		return pay;
	}

	//공제항목 조회
	@Override
	public PayDedVO retrieveDed(String ddCode) {
		PayDedVO ded = pdDAO.selectDed(ddCode);
		return ded;
	}
	
	//지급항목 목록 조회
	@Override
	public List<PayAlwVO> retrievePayList(String legal) {
		return pdDAO.selectPayList(legal);
	}

	//공제항목 목록 조회
	@Override
	public List<PayDedVO> retrieveDedList(String legal) {
		return pdDAO.selectDedList(legal);
	}

	//지급항목 생성
	@Override
	public ServiceResult createPay(PayAlwVO pay) {
		int rowcnt = pdDAO.insertPay(pay);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	//공제항목 생성
	@Override
	public ServiceResult createDed(PayDedVO ded) {
		int rowcnt = pdDAO.insertDed(ded);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	//지급항목 수정
	@Override
	public ServiceResult modifyPay(PayAlwVO pay) {
		int rowcnt = pdDAO.updatePay(pay);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	//공제항목 수정
	@Override
	public ServiceResult modifyDed(PayDedVO ded) {
		int rowcnt = pdDAO.updateDed(ded);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	//지급항목 삭제 (사용여부 Y→N)
	@Override
	public ServiceResult removePay(String pyCode) {
		int rowcnt = pdDAO.deletePay(pyCode);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	//공제항목 삭제 (사용여부 Y→N)
	@Override
	public ServiceResult removeDed(String ddCode) {
		int rowcnt = pdDAO.deleteDed(ddCode);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	

}
