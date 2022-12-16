package kr.or.ddit.emp.view;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;

import kr.or.ddit.vo.MenuVO;



public class empTransferListPreparer implements ViewPreparer{

	@Override
	public void execute(Request req, AttributeContext context) {
		MenuVO menu1 = new MenuVO("/emp/empList.do", "구성원");///
		MenuVO menu2 = new MenuVO("/emp/empTransferList.do", "인사발령");

		MenuVO smenu1 = new MenuVO("/emp/empTransferList.do", "인사 발령");

		List<MenuVO> subMenuList = Arrays.asList(smenu1);
		
		
		List<MenuVO> menuList =  Arrays.asList(menu1, menu2);
		Map<String, Object> requestScope =  req.getContext(Request.REQUEST_SCOPE);
		requestScope.put("menuList", menuList);
		requestScope.put("subMenuList", subMenuList);
	}

}
