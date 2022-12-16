package kr.or.ddit.pay.view;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;

import kr.or.ddit.vo.MenuVO;


public class PayrollViewPreparer implements ViewPreparer {
	
	@Override
	public void execute(Request req, AttributeContext context) {
		MenuVO menu1 = new MenuVO("/pay/payHome.do", "급여정산");
		MenuVO menu2 = new MenuVO("/pay/cerfList.do", "자료관리");
		List<MenuVO> menuList = Arrays.asList(menu1, menu2);
		
		MenuVO smenu1 = new MenuVO("/pay/payHome.do", "홈");
		MenuVO smenu2 = new MenuVO("/pay/pastPayroll.do", "지난 정산 내역");
		MenuVO smenu3 = new MenuVO("/pay/tmpList.do", "정산 템플릿 목록");
		List<MenuVO> subMenuList = Arrays.asList(smenu1, smenu2, smenu3);
		
		
		Map<String, Object> requestScope =  req.getContext(Request.REQUEST_SCOPE);
		requestScope.put("menuList", menuList);
		requestScope.put("subMenuList", subMenuList);
		
	}

}
