package egovframework.example.information.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface InformationService {

	List<Map> courseList(String courseNo) throws Exception;

	List<Map> markerList(String courseNo) throws Exception;
	
	List<Map> markerList(Map<String, Object> srhCondition) throws Exception;

	List<Map> courseList() throws Exception;

	List<Map> courseList(Map<String, Object> srhCondition);

	List<Map> courseListCnt(Map<String, Object> srhCondition);

	List<Map> courseListCnt();

	List<Map> courseList(InformationCourseVO informationCourseVO) throws Exception;

	EgovMap courseListCnt(InformationCourseVO informationCourseVO) throws Exception;

	List<Map> markerListZero(InformationCourseVO informationCourseVO) throws Exception;

	List<Map> themeList() throws Exception ;

	void courseLikeID(HashMap<String, Object> paramMap);

	List<Map> selectWishList(HashMap wishMap) throws Exception;

	List<Map> reviewInfoList(ArrayList<String> cNumberList) throws Exception;

	List<Map> reviewList(InformationCourseVO informationCourseVO) throws Exception;

	EgovMap reviewListCnt(InformationCourseVO informationCourseVO) throws Exception;


}

