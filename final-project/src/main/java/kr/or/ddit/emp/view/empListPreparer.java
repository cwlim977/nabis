package kr.or.ddit.emp.view;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.vo.MenuVO;

public class empListPreparer implements ViewPreparer{

	@Override
	@RequestMapping("/emp/empDetailView.do")
	public void execute(Request req, AttributeContext attributeContext) {
		
		MenuVO menu1 = new MenuVO("/emp/empList.do", "구성원");///
		MenuVO menu2 = new MenuVO("/emp/empTransferList.do", "인사발령");

		MenuVO smenu1 = new MenuVO("/emp/empList.do", "전체");
		MenuVO smenu2 = new MenuVO("/emp/cntStatusList.do", "계약상태");
		List<MenuVO> subMenuList = Arrays.asList(smenu1, smenu2);
		
		
		List<MenuVO> menuList =  Arrays.asList(menu1, menu2);
		Map<String, Object> requestScope =  req.getContext(Request.REQUEST_SCOPE);
		requestScope.put("menuList", menuList);
		requestScope.put("subMenuList", subMenuList);

	}

	
	
}
