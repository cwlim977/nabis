package kr.or.ddit.arm.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.context.WebApplicationContext;

import kr.or.ddit.arm.dao.ArmDAO;
import kr.or.ddit.commons.enumpkg.ServiceResult;
import kr.or.ddit.commons.websocket.event.NewArmEvent;
import kr.or.ddit.vo.ArmVO;

@Service
public class ArmServiceImpl implements ArmService {
	
	@Inject
	private ArmDAO dao;
	
	@Inject
	private WebApplicationContext context;
	
	@Override
	public List<ArmVO> retrieveArmList(String armRcvr) {
		return dao.selectArmList(armRcvr);
	}

	@Override
	public ServiceResult removeArm(String armNo) {
		int rowcnt = dao.deleteArm(armNo);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult removeAllArm(String armRcvr) {
		int rowcnt = dao.deleteArmAll(armRcvr);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult createArm(ArmVO armVO) {
		int rowcnt = dao.insertArm(armVO);
		
		if(rowcnt > 0 ) {
			NewArmEvent event = new NewArmEvent(armVO);
			context.publishEvent(event);
		}
		
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifyArm(String armNo) {
		int rowcnt = dao.updateArm(armNo);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

	@Override
	public ServiceResult modifyAllArm(String armRcvr) {
		int rowcnt = dao.updateArmAll(armRcvr);
		return rowcnt > 0 ? ServiceResult.OK : ServiceResult.FAIL;
	}

}
