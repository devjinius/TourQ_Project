package egovframework.example.outline.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.example.cmmn.service.CmmnVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("storyMapper")
public interface StoryMapper {

	List<Map> storyList(String storyNumber) throws Exception;

	void insertCount(String storyNumber) throws Exception;

	List<Map> storyListVO(CmmnVO cmmnVO) throws Exception;

	EgovMap storyListCnt(CmmnVO cmmnVO) throws Exception;

	void insertStoryLike(HashMap<String, Object> paramMap);

	void deleteStoryLike(HashMap<String, Object> paramMap);

	void addStoryLike(HashMap<String, Object> paramMap);

	void subStoryLike(HashMap<String, Object> paramMap);

	EgovMap selectStoryLike(HashMap storyLikeMap) throws Exception;

}
