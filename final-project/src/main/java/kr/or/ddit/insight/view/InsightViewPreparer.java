package kr.or.ddit.insight.view;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;

import kr.or.ddit.vo.MenuVO;

public class InsightViewPreparer implements ViewPreparer {

	@Override
	public void execute(Request req, AttributeContext context) {
		MenuVO menu1 = new MenuVO("/home/feed.do", "홈 피드-수정중");
		MenuVO menu2 = new MenuVO("/home/notice.do", "회사소식-수정중");
		MenuVO menu3 = new MenuVO("/home/todo/inbox.do", "할 일-수정중");
		List<MenuVO> menuList = Arrays.asList(menu1, menu2, menu3);
		Map<String, Object> requestScope = req.getContext(Request.REQUEST_SCOPE);
		requestScope.put("menuList", menuList);
		
		
		
	}
}
