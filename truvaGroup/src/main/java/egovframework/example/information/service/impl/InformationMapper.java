package egovframework.example.information.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.example.information.service.InformationCourseVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("informationMapper")
public interface InformationMapper {

	List<Map> courseList(String courseNo) throws Exception;

	List<Map> courseList() throws Exception;
	
	List<Map> markerList(String courseNo) throws Exception;
	
	List<Map> markerListSearch(Map<String, Object> srhCondition) throws Exception;

	List<Map> markerListZero();

	List<Map> searchCourseList(Map<String, Object> srhCondition);

	List<Map> courseListCnt(Map<String, Object> srhCondition);

	List<Map> courseListCnt();

	List<Map> courseListVO(InformationCourseVO informationCourseVO) throws Exception;

	EgovMap courseListCnt(InformationCourseVO informationCourseVO) throws Exception;

	List<Map> markerListZeroVO(InformationCourseVO informationCourseVO) throws Exception;

	List<Map> themeList() throws Exception;

	void insertCourseLike(HashMap<String, Object> paramMap);

	void deleteCourseLike(HashMap<String, Object> paramMap);

	List<Map> selectWishList(HashMap wishMap) throws Exception;

	EgovMap reviewInfoList(String courseNumber) throws Exception;

	List<Map> reviewList(InformationCourseVO informationCourseVO) throws Exception;

	EgovMap reviewListCnt(InformationCourseVO informationCourseVO) throws Exception;

}
