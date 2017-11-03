package egovframework.example.outline.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.cmmn.service.CmmnVO;
import egovframework.example.outline.service.StoryService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("storyService")
public class StoryImpl extends EgovAbstractServiceImpl implements StoryService {

	@Resource(name = "storyMapper")
	private StoryMapper storyMapper;

	@Override
	public List<Map> storyList(String storyNumber) throws Exception {

		return storyMapper.storyList(storyNumber);
	}

	@Override
	public void insertCount(String storyNumber) throws Exception {
		
		storyMapper.insertCount(storyNumber);
	}

	@Override
	public List<Map> storyListVO(CmmnVO cmmnVO) throws Exception {

		return storyMapper.storyListVO(cmmnVO);
	}

	@Override
	public EgovMap storyListCnt(CmmnVO cmmnVO) throws Exception {

		return storyMapper.storyListCnt(cmmnVO);
	}

	@Override
	public void storyLikeID(HashMap<String, Object> paramMap) {
		
		if (paramMap.get("gubun").equals("I")) {
			
			storyMapper.insertStoryLike(paramMap);
			storyMapper.addStoryLike(paramMap);
		} else if (paramMap.get("gubun").equals("D")) {
			
			storyMapper.deleteStoryLike(paramMap);
			storyMapper.subStoryLike(paramMap);
		}
	}

	@Override
	public EgovMap storyLike(HashMap storyLikeMap) throws Exception {

		return storyMapper.selectStoryLike(storyLikeMap);
	}

}