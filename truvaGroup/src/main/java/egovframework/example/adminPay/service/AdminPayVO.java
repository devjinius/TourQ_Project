package egovframework.example.adminPay.service;

import egovframework.example.cmmn.service.CmmnVO;

public class AdminPayVO extends CmmnVO {	
	
	@SuppressWarnings("unused")
	private static final long serialVersionUID = 1L;
	private long pageScale = 10;
	private String surchSelect = "";
	
	public long getPageScale() {
		return pageScale;
	}
	public void setPageScale(long pageScale) {
		this.pageScale = pageScale;
	}
	public String getSurchSelect() {
		return surchSelect;
	}
	public void setSurchSelect(String surchSelect) {
		this.surchSelect = surchSelect;
	}
}