package kr.or.ddit.pay.service;

import java.util.List;

import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.vo.PayAlwVO;
import kr.or.ddit.vo.PayDedVO;

public interface PayDedService {
	
	public PayAlwVO retrievePay(String pyCode);
	
	public PayDedVO retrieveDed(String ddCode);
	
	public List<PayAlwVO> retrievePayList(String legal);
	
	public List<PayDedVO> retrieveDedList(String legal);
	
	public ServiceResult createPay(PayAlwVO pay);
	
	public ServiceResult createDed(PayDedVO ded);
	
	public ServiceResult modifyPay(PayAlwVO pay);

	public ServiceResult modifyDed(PayDedVO ded);
	
	public ServiceResult removePay(String pyCode);
	
	public ServiceResult removeDed(String ddCode);
	

}
