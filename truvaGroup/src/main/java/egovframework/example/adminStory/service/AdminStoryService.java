package egovframework.example.adminStory.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface AdminStoryService {

	void storyIUD(Map<String, Object> valueMap);

	List<Map> storyList(StoryVO storyVO) throws Exception;

	EgovMap storyListCnt(StoryVO storyVO)  throws Exception;

	EgovMap storyContents(String storyNumber) throws Exception;

	void deleteCourse(String[] values) throws Exception;

	EgovMap selectStoryNumber() throws Exception;

}

