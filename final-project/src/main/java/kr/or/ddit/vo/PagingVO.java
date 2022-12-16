package kr.or.ddit.vo;

import java.util.List;
import java.util.Map;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class PagingVO<T> {
	
	public PagingVO(int screenSize, int blockSize) {
		super();
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}

	private int totalRecord;
	private int currentPage;
	private int screenSize = 7;
	private int blockSize = 5;
	private int totalPage;
	
	private int startRow;
	private int endRow;
	private int startPage;
	private int endPage;
	
	private List<T> dataList;
	
	private Map<String, Object> dataMap;
	private SearchVO simpleCondition;
	private T detailCondition;

	public void setDetailCondition(T detailCondition) {
		this.detailCondition = detailCondition;
	}
	
	public void setSimpleCondition(SearchVO simpleCondition) {
		this.simpleCondition = simpleCondition;
	}
	
	public void setDataMap(Map<String, Object> dataMap) {
		this.dataMap = dataMap;
	}
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		totalPage = (totalRecord+(screenSize-1)) / screenSize;
	}
	
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
		endRow = currentPage * screenSize;
		startRow = endRow - (screenSize-1);
		
		endPage =  blockSize * ((currentPage + (blockSize-1)) / blockSize);
		startPage = endPage - (blockSize - 1 );
	}
	
	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}
	
	String pattern = "<li class='page-item'><a class='page-link' href='#' data-page='%d'>%s</a></li>";
	
	public String getPagingHtml() {
		StringBuffer html = new StringBuffer();
		
		endPage = endPage > totalPage ? totalPage : endPage;
		
		html.append("<ul class='pagination justify-content-center'>");
		if(startPage > blockSize) {
			html.append(
				String.format(pattern, startPage-blockSize, "<i class='tf-icon bx bx-chevrons-left'></i>")
			);
		}
		for(int page = startPage; page <= endPage; page++) {
				html.append(
					String.format(pattern, page, page)
				);
		}
		if(endPage < totalPage) {
			html.append(
				String.format(pattern, endPage+1, "<i class='tf-icon bx bx-chevrons-right'></i>")
			);
		}
		html.append("</ul>");
		
		return html.toString();
	}

}
