package egovframework.example.outline.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.example.cmmn.service.CmmnVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface StoryService {

	List<Map> storyList(String storyNumber) throws Exception;

	void insertCount(String storyNumber) throws Exception;

	List<Map> storyListVO(CmmnVO cmmnVO) throws Exception;

	EgovMap storyListCnt(CmmnVO cmmnVO) throws Exception;

	void storyLikeID(HashMap<String, Object> paramMap);

	EgovMap storyLike(HashMap storyLikeMap) throws Exception;

}

