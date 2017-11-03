package egovframework.example.adminMarker.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.example.adminCourse.service.CourseVo;
import egovframework.example.adminMarker.service.MarkerVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("adminMarkerMapper")
public interface AdminMarkerMapper {

	List<Map> courseList(MarkerVO markerVO) throws Exception;

	List<Map> markerList(String courseNo) throws Exception;

	List<Map> courseList() throws Exception;

	List<Map> markerMapList(String markerNumber) throws Exception;

	void insertMarker(HashMap<String, Object> insData) throws Exception;

	List<Map> themeList() throws Exception;

	EgovMap courseListCnt(MarkerVO markerVO) throws Exception;

	void updateMarker(HashMap<String, Object> insData) throws Exception;

	void deleteMarker(String markerNumber) throws Exception;

}
