package egovframework.example.adminMarker.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface AdminMarkerService {

	List<Map> courseList(MarkerVO markerVO) throws Exception;

	List<Map> markerList(String courseNo) throws Exception;

	List<Map> courseList() throws Exception;

	List<Map> markerMapList(String markerNumber) throws Exception;

	void insertMarker(HashMap<String, Object> insData) throws Exception;

	List<Map> themeList() throws Exception;

	EgovMap courseListCnt(MarkerVO markerVO) throws Exception;

	void updateMarker(HashMap<String, Object> insData) throws Exception;

	void deleteMarker(String[] values) throws Exception;

}

