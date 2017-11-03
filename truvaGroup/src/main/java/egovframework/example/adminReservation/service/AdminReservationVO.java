package egovframework.example.adminReservation.service;

import egovframework.example.cmmn.service.CmmnVO;

public class AdminReservationVO extends CmmnVO {	
	
	@SuppressWarnings("unused")
	private static final long serialVersionUID = 1L;
	
	private String surchText = "";
	private String surchSelect = "";
	private long pageScale = 10;
	
	private String startDate = "";
	private String endDate = "";
	
	private String thisWeek = "";
	private String prevWeekMon = "";
	private String prevWeekSun = "";
	
	public synchronized String getSurchText() {
		return surchText;
	}
	public synchronized void setSurchText(String surchText) {
		this.surchText = surchText;
	}
	
	public synchronized String getSurchSelect() {
		return surchSelect;
	}
	public synchronized void setSurchSelect(String surchSelect) {
		this.surchSelect = surchSelect;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public long getPageScale() {
		return pageScale;
	}
	public void setPageScale(long pageScale) {
		this.pageScale = pageScale;
	}
	
	public String getThisWeek() {
		return thisWeek;
	}
	public void setThisWeek(String thisWeek) {
		this.thisWeek = thisWeek;
	}
	public String getPrevWeekMon() {
		return prevWeekMon;
	}
	public void setPrevWeekMon(String prevWeekMon) {
		this.prevWeekMon = prevWeekMon;
	}
	public String getPrevWeekSun() {
		return prevWeekSun;
	}
	public void setPrevWeekSun(String prevWeekSun) {
		this.prevWeekSun = prevWeekSun;
	}
}