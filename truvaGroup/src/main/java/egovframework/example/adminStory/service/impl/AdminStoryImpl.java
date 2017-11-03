package egovframework.example.adminStory.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.adminStory.service.AdminStoryService;
import egovframework.example.adminStory.service.StoryVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("adminStoryService")
public class AdminStoryImpl extends EgovAbstractServiceImpl implements AdminStoryService {

	@Resource(name = "adminStoryMapper")
	private AdminStoryMapper adminStoryMapper;

	@Override
	public void storyIUD(Map<String, Object> valueMap) {
		
		if(valueMap.get("storyNumber").equals("N")){
			
			adminStoryMapper.insertStory(valueMap);
		} else {
			
			adminStoryMapper.updateStory(valueMap);
		}
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> storyList(StoryVO storyVO) throws Exception {

		return adminStoryMapper.storyList(storyVO);
	}

	@Override
	public EgovMap storyListCnt(StoryVO storyVO) throws Exception {
		
		return adminStoryMapper.storyListCnt(storyVO);
	}

	@Override
	public EgovMap storyContents(String storyNumber) throws Exception {

		return adminStoryMapper.storyContents(storyNumber);
	}

	@Override
	public void deleteCourse(String[] values) throws Exception {

		for (String storyNumber : values) {
			
			adminStoryMapper.deleteCourse(storyNumber);
		}
	}

	@Override
	public EgovMap selectStoryNumber() throws Exception {

		return adminStoryMapper.selectStoryNumber();
	}

}