package egovframework.example.adminSeat.service;

import egovframework.example.cmmn.service.CmmnVO;

public class AdminSeatVO extends CmmnVO {	
	
	@SuppressWarnings("unused")
	private static final long serialVersionUID = 1L;
	
	private long pageScale = 10;

	public long getPageScale() {
		return pageScale;
	}
	public void setPageScale(long pageScale) {
		this.pageScale = pageScale;
	}
}