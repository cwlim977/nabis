package kr.or.ddit.vacation.view;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;

import kr.or.ddit.vo.MenuVO;

public class VacViewPreparer implements ViewPreparer {
	@Override
	public void execute(Request req, AttributeContext context) {
		
		MenuVO menu1 = new MenuVO("/myVacation/vacOutlineView.do", "내 휴가");
		MenuVO menu2 = new MenuVO("/memberVacation/vacPosnStatView.do", "구성원 휴가");
		MenuVO menu3 = new MenuVO("/memberVacation/annualVacAdjustmentHistory.do", "연차 조정 내역");
		MenuVO menu4 = new MenuVO("/memberVacation/annualVacBatchAdjustment.do", "연차 일괄 조정");
		MenuVO menu5 = new MenuVO("/vacationConfig/vacConfigView.do", "휴가 설정");
		
		List<MenuVO> menuList = Arrays.asList(menu1, menu2, menu3, menu4, menu5);
		
		MenuVO smenu1 = new MenuVO("/myVacation/vacOutlineView.do", "휴가 개요");
		MenuVO smenu2 = new MenuVO("/myVacation/annualVacDetailView.do", "연차 상세");
		MenuVO smenu3 = new MenuVO("/memberVacation/vacPosnStatView.do", "휴가 보유 현황");
		MenuVO smenu4 = new MenuVO("/memberVacation/vacAplyHistoryView.do", "휴가 신청 내역");
		MenuVO smenu5 = new MenuVO("/memberVacation/annualVacManageView.do", "연차 관리");
		
		List<MenuVO> subMenuList = Arrays.asList(smenu1, smenu2, smenu3, smenu4, smenu5);
		
		Map<String, Object> requestScope =  req.getContext(Request.REQUEST_SCOPE);
		requestScope.put("menuList", menuList);
		requestScope.put("subMenuList", subMenuList);
		
	}
}
