package kr.or.ddit.pay.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.pay.dao.PayTmpDAO;
import kr.or.ddit.vo.PayTmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PayTmpServiceImpl implements PayTmpService {
	
	@Inject
	private PayTmpDAO tmpDAO;

	//급여정산 템플릿 생성
	@Override
	public ServiceResult createPayTmp(PayTmpVO tmp) {
		int rowcnt = tmpDAO.insertPayTmp(tmp);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	//급여정산 템플릿 수정
	@Override
	public ServiceResult modifyPayTmp(PayTmpVO tmp) {
		int rowcnt = tmpDAO.updatePayTmp(tmp);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	//급여정산 템플릿 삭제 (사용여부 Y→N)
	@Override
	public ServiceResult removePayTmp(String ptNo) {
		int rowcnt = tmpDAO.deletePayTmp(ptNo);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	//급여정산 템플릿 조회
	@Override
	public PayTmpVO retrievePayTmp(String ptNo) {
		PayTmpVO tmp = tmpDAO.selectPayTmp(ptNo);
		return tmp;
	}
	
	//급여정산 템플릿 목록 조회
	@Override
	public List<PayTmpVO> retrievePayTmpList() {
		return tmpDAO.selectPayTmpList();
	}

	//급여정산 템플릿 북마크 생성
	@Override
	public ServiceResult createTmpBmk(String ptNo) {
		int rowcnt = tmpDAO.createTmpBmk(ptNo);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}
	
	//급여정산 템플릿 북마크 삭제
	@Override
	public ServiceResult removeTmpBmk(String ptNo) {
		int rowcnt = tmpDAO.deleteTmpBmk(ptNo);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
