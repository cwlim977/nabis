package kr.or.ddit.pay.view;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;

import kr.or.ddit.vo.MenuVO;


public class PaystubViewPreparer implements ViewPreparer {
	
	@Override
	public void execute(Request req, AttributeContext context) {
		MenuVO menu1 = new MenuVO("/pay/paystub.do", "급여");
		List<MenuVO> menuList = Arrays.asList(menu1);
		
		MenuVO smenu1 = new MenuVO("/pay/paystub.do", "급여명세서 목록");
		List<MenuVO> subMenuList = Arrays.asList(smenu1);
		
		
		Map<String, Object> requestScope =  req.getContext(Request.REQUEST_SCOPE);
		requestScope.put("menuList", menuList);
		requestScope.put("subMenuList", subMenuList);
		
	}
	

}
