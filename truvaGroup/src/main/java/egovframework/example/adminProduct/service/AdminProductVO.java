package egovframework.example.adminProduct.service;

import egovframework.example.cmmn.service.CmmnVO;

public class AdminProductVO extends CmmnVO {	
	
	@SuppressWarnings("unused")
	private static final long serialVersionUID = 1L;
	private long pageScale = 10;
	private String couseNumber = "";
	
	public long getPageScale() {
		return pageScale;
	}
	public void setPageScale(long pageScale) {
		this.pageScale = pageScale;
	}
	public String getCouseNumber() {
		return couseNumber;
	}
	public void setCouseNumber(String couseNumber) {
		this.couseNumber = couseNumber;
	}
}