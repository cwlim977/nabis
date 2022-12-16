package kr.or.ddit.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MenuVO {
	
	public MenuVO(String menuURL, String menuText) {
		super();
		this.menuURL = menuURL;
		MenuText = menuText;
	}
	
	private String menuURL;
	private String MenuText;
	private String menuId;
	private String menuColor;
	
}
