package egovframework.example.myPage.service;

import egovframework.example.cmmn.service.CmmnVO;

public class MyPageVO extends CmmnVO {	
	
	@SuppressWarnings("unused")
	private static final long serialVersionUID = 1L;
	
	private String userId = "";
	
	private long rows = 10;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public long getRows() {
		return rows;
	}

	public void setRows(long rows) {
		this.rows = rows;
	}
}
