package egovframework.example.adminCustomer.service;

import egovframework.example.cmmn.service.CmmnVO;

public class AdCustomJqgridVo extends CmmnVO{

	private static final long serialVersionUID = 1L;
	
	private String searchSelect = "";
	
	private String searchText = "";
	
	private String memberNumber = "";

	public String getSearchSelect() {
		return searchSelect;
	}
	public void setSearchSelect(String searchSelect) {
		this.searchSelect = searchSelect;
	}
	public String getSearchText() {
		return searchText;
	}
	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}
	public String getMemberNumber() {
		return memberNumber;
	}
	public void setMemberNumber(String memberNumber) {
		this.memberNumber = memberNumber;
	}

}
