package egovframework.example.adminCourse.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface AdminCourseService {

	List<Map> courseList(String courseNo) throws Exception;

	List<Map> markerList(String courseNo) throws Exception;

	void courseDetailIUD(CourseVo courseVo)throws Exception;

	List<Map> themeList() throws Exception;
	
	void insertTheme(Map<String, Object> castMap);

	void updatePR(Map<String, Object> prMap) throws Exception;

	List<Map> courseList(CourseVo courseVo) throws Exception;

	EgovMap courseListCnt(CourseVo courseVo) throws Exception;

	List<Map> themeCount() throws Exception;

	void deleteCourse(String[] values) throws Exception;

	void deleteTheme(String[] values) throws Exception;

	EgovMap selectCourseNumber() throws Exception;

	List<Map> busList() throws Exception;

}

