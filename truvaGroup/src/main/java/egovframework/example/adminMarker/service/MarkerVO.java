package egovframework.example.adminMarker.service;

import java.util.ArrayList;

import egovframework.example.cmmn.service.CmmnVO;

public class MarkerVO extends CmmnVO{	
	
	private static final long serialVersionUID = 1L;
	
	private String courseNumber = "";
	private String searchTheme = "";
	private String searchName = "";
	
	public String getCourseNumber() {
		return courseNumber;
	}
	public void setCourseNumber(String courseNumber) {
		this.courseNumber = courseNumber;
	}
	public String getSearchTheme() {
		return searchTheme;
	}
	public void setSearchTheme(String searchTheme) {
		this.searchTheme = searchTheme;
	}
	public String getSearchName() {
		return searchName;
	}
	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}
}
