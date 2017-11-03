package egovframework.example.adminStory.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.example.adminStory.service.StoryVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("adminStoryMapper")
public interface AdminStoryMapper {

	void insertStory(Map<String, Object> valueMap);

	List<Map> storyList(StoryVO storyVO) throws Exception;

	EgovMap storyListCnt(StoryVO storyVO) throws Exception;

	EgovMap storyContents(String storyNumber) throws Exception;

	void deleteCourse(String storyNumber) throws Exception;

	void updateStory(Map<String, Object> valueMap);

	EgovMap selectStoryNumber() throws Exception;

}
