package egovframework.example.main.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.main.service.MainService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("mainService")
public class MainServiceImpl extends EgovAbstractServiceImpl implements MainService {

	@Resource(name = "mainMapper")
	private MainMapper mainMapper;

	@Override
	public List<Map> themeList() throws Exception {

		return mainMapper.themeList();
	}

	@Override
	public List<Map> courseAllList() throws Exception {

		return mainMapper.courseAllList();
	}

	@Override
	public void courseLikeID(HashMap<String, Object> paramMap) {
		
		if (paramMap.get("gubun").equals("I")) {
			
			mainMapper.insertCourseLike(paramMap);
		} else if (paramMap.get("gubun").equals("D")) {
			
			mainMapper.deleteCourseLike(paramMap);
		}
	}

	@Override
	public List<Map> selectWishList(HashMap wishMap) throws Exception {

		return mainMapper.selectWishList(wishMap);
	}

	@Override
	public List<Map> reviewInfoList(ArrayList<String> cNumberList)
			throws Exception {

		
		ArrayList<Map> reviewInfo = new ArrayList<Map>();
		for (String courseNumber : cNumberList) {
			
			EgovMap reviewInfoList = mainMapper.reviewInfList(courseNumber);
			
			if(reviewInfoList.get("rank") == null){
				reviewInfoList.put("rank", "0");
			}
			
			reviewInfo.add(reviewInfoList);
		}
		
		return reviewInfo;
	}
	
}