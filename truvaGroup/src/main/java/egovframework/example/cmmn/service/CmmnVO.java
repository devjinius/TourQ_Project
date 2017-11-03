package egovframework.example.cmmn.service;

import egovframework.example.cmmn.service.CmmnVO;

public class CmmnVO {	
	
	private static final long serialVersionUID = 1L;
	
	private long rows = 2; // 한번에 보여 줄 row수

	private long page = 1; // 현재 페이지
	
	private long totalPage = 1; // 총 몇페이진지
	
	private long startPage = 1; //  
	
	private long endPage = 1; //
	
	private long pageScale = 4; // 다음 전에 보여지는 페이지 수
	
	public long getRows() {
		return rows;
	}

	public void setRows(long rows) {
		this.rows = rows;
	}

	public long getPage() {
		return page;
	}

	public void setPage(long page) {
		this.page = page;
	}

	public long getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(long totalPage) {
		this.totalPage = totalPage;
	}

	public long getStartPage() {
		return startPage;
	}

	public void setStartPage(long startPage) {
		this.startPage = startPage;
	}

	public long getEndPage() {
		return endPage;
	}

	public void setEndPage(long endPage) {
		this.endPage = endPage;
	}

	public long getPageScale() {
		return pageScale;
	}

	public void setPageScale(long pageScale) {
		this.pageScale = pageScale;
	}
	
	
}
