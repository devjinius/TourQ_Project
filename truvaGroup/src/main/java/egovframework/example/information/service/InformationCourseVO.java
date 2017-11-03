package egovframework.example.information.service;

import egovframework.example.cmmn.service.CmmnVO;

public class InformationCourseVO extends CmmnVO {	
	
	private static final long serialVersionUID = 1L;
	
	private String searchTheme = "";
	
	private String searchName = "";
	
	private String searchPrice = "";

	private String courseNumber = "";
	
	private int startPrice;
	
	private int endPrice;
	
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

	public String getSearchPrice() {
		return searchPrice;
	}

	public void setSearchPrice(String searchPrice) {
		this.searchPrice = searchPrice;
		
		switch (searchPrice) {
		
		case "2" :
			
			setStartPrice(0);
			setEndPrice(30000);
			break;

		case "3" :
						
			setStartPrice(30000);
			setEndPrice(60000);
			break;
		case "6" :
			
			setStartPrice(60000);
			setEndPrice(100000);
			break;
		case "10" :
			
			setStartPrice(100000);
			setEndPrice(10000000);
			break;
		}
	}

	public int getStartPrice() {
		return startPrice;
	}

	public void setStartPrice(int startPrice) {
		this.startPrice = startPrice;
	}

	public int getEndPrice() {
		return endPrice;
	}

	public void setEndPrice(int endPrice) {
		this.endPrice = endPrice;
	}
	
}
