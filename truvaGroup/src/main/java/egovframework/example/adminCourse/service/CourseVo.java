package egovframework.example.adminCourse.service;

import java.util.ArrayList;

import egovframework.example.cmmn.service.CmmnVO;

public class CourseVo extends CmmnVO{	
	
	private static final long serialVersionUID = 1L;
	
	private String courseNumber = "";
	private String status = "";
	private String title = "";
	private String subtitle = "";
	private String contents = "";
	private String detail = "";
	private String time = "";
	private String price = "";
	private String startTime = "";
	private String bus = "";
	private String theme = "";
	private String place = "";
	private String seq;
	private String searchTheme = "";
	private String searchName = "";
	
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

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getCourseNumber() {
		return courseNumber;
	}
	
	public void setCourseNumber(String courseNumber) {
		this.courseNumber = courseNumber;
	}
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSubtitle() {
		return subtitle;
	}

	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String[] arr) {
		
		// startTime을 String으로 변환
		ArrayList startTimeArr = new ArrayList<String>();
		
		for (String string : arr) {
			
			startTimeArr.add(string);
		}
		
		// startTime = "00_01_02..."
		String startTime = String.join("_", startTimeArr);
				
		this.startTime = startTime;
	}

	public String getBus() {
		return bus;
	}

	public void setBus(String bus) {
		this.bus = bus;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}
}
