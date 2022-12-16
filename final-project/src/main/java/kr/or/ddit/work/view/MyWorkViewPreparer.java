package kr.or.ddit.work.view;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;

import kr.or.ddit.vo.MenuVO;

public class MyWorkViewPreparer implements ViewPreparer {

	@Override
	public void execute(Request req, AttributeContext context) {
		MenuVO menu1 = new MenuVO("/work/myWork.do", "내 근무");
		MenuVO menu2 = new MenuVO("/work/members.do", "구성원 근무");
		List<MenuVO> menuList = Arrays.asList(menu1, menu2);
		
		
		Map<String, Object> requestScope =  req.getContext(Request.REQUEST_SCOPE);
		requestScope.put("menuList", menuList);
		
	}

}
