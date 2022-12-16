package kr.or.ddit.pay.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.vo.PayTmpVO;

public interface PayTmpService {
	
	public ServiceResult createPayTmp(PayTmpVO tmp);
	
	public ServiceResult modifyPayTmp(PayTmpVO tmp);

	public ServiceResult removePayTmp(String ptNo);
	
	public PayTmpVO retrievePayTmp(String ptNo);
	
	public List<PayTmpVO> retrievePayTmpList();
	
	public ServiceResult createTmpBmk(String ptNo);
	
	public ServiceResult removeTmpBmk(String ptNo);
	

}
