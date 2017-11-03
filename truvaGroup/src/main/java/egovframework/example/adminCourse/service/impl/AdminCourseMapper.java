package egovframework.example.adminCourse.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.example.adminCourse.service.CourseVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("adminCourseMapper")
public interface AdminCourseMapper {

	List<Map> courseList(String courseNo) throws Exception;

	List<Map> markerList(String courseNo) throws Exception;

	void courseDetailInsert(CourseVo courseVo) throws Exception;

	List<Map> themeList() throws Exception;

	void insertTheme(Map<String, Object> castMap);

	List<Map> selectPYN(String string) throws Exception;

	void updatePY(String string) throws Exception;

	void updatePN(String string) throws Exception;

	List<Map> selectRYN(String string) throws Exception;

	void updateRY(String string) throws Exception;

	void updateRN(String string) throws Exception;

	void courseDetailUpdate(CourseVo courseVo) throws Exception;

	List<Map> courseListVO(CourseVo courseVo) throws Exception;

	EgovMap courseListCnt(CourseVo courseVo) throws Exception;

	List<Map> themeCount() throws Exception;

	void deleteCourse(String courseNumber) throws Exception;

	void deleteTheme(String courseNumber) throws Exception;

	EgovMap selectRCourse() throws Exception;

	EgovMap selectCourseNumber() throws Exception;

	List<Map> busList() throws Exception;

}
