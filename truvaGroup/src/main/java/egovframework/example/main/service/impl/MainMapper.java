package egovframework.example.main.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("mainMapper")
public interface MainMapper {

	List<Map> themeList() throws Exception;

	List<Map> courseAllList() throws Exception;

	void insertCourseLike(HashMap<String, Object> paramMap);

	void deleteCourseLike(HashMap<String, Object> paramMap);

	List<Map> selectWishList(HashMap wishMap) throws Exception;

	EgovMap reviewInfList(String courseNumber) throws Exception;

}