package kr.or.ddit.cerf.view;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;

import kr.or.ddit.vo.MenuVO;

public class CerfViewPreparer implements ViewPreparer {

	@Override
	public void execute(Request req, AttributeContext context) {
		MenuVO menu0 = new MenuVO("/cerf/my.do", "문서·증명서");
		List<MenuVO> menuList = Arrays.asList(menu0);
		Map<String, Object> requestScope = req.getContext(Request.REQUEST_SCOPE);
		requestScope.put("menuList", menuList);

		
		MenuVO menu1 = new MenuVO("/cerf/myCerf.do", "내 문서");
		MenuVO menu2 = new MenuVO("/cerf/empCerf.do", "구성원");
		List<MenuVO> subMenuList = Arrays.asList(menu1, menu2);
		requestScope = req.getContext(Request.REQUEST_SCOPE);
		requestScope.put("subMenuList", subMenuList);
		
		 
	}

}
