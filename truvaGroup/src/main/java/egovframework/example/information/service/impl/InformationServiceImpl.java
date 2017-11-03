package egovframework.example.information.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.information.service.InformationCourseVO;
import egovframework.example.information.service.InformationService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("informationService")
public class InformationServiceImpl extends EgovAbstractServiceImpl implements InformationService {

	@Resource(name = "informationMapper")
	private InformationMapper informationMapper;
	
	
	@Override
	public List<Map> courseList(String courseNo) throws Exception {

		return informationMapper.courseList(courseNo);
	}


	@Override
	public List<Map> markerList(String courseNo) throws Exception {

		
		if (courseNo.equals("zero")) {
			
			//코스를 불러오는데 코스번호가 아니라 zero(구분)으로 넘어왓다면 출발지만 가져온다.
			return informationMapper.markerListZero();
		} else {
			
			return informationMapper.markerList(courseNo);
		}
	}

	@Override
	public List<Map> courseList() throws Exception {

		return informationMapper.courseList();
	}


	@Override
	public List<Map> courseList(Map<String, Object> srhCondition) {

		return informationMapper.searchCourseList(srhCondition);
	}


	@Override
	public List<Map> courseListCnt(Map<String, Object> srhCondition) {

		return informationMapper.courseListCnt(srhCondition);
	}


	@Override
	public List<Map> courseListCnt() {

		return informationMapper.courseListCnt();
	}


	@Override
	public List<Map> markerList(Map<String, Object> srhCondition)
			throws Exception {

		return informationMapper.markerListSearch(srhCondition);
	}


	@Override
	public List<Map> courseList(InformationCourseVO informationCourseVO)
			throws Exception {
		
		return informationMapper.courseListVO(informationCourseVO);
	}


	@Override
	public EgovMap courseListCnt(InformationCourseVO informationCourseVO)
			throws Exception {

		return informationMapper.courseListCnt(informationCourseVO);
	}


	@Override
	public List<Map> markerListZero(InformationCourseVO informationCourseVO)
			throws Exception {

		return informationMapper.markerListZeroVO(informationCourseVO);
	}


	@Override
	public List<Map> themeList() throws Exception {

		return informationMapper.themeList();
	}


	@Override
	public void courseLikeID(HashMap<String, Object> paramMap) {

		if (paramMap.get("gubun").equals("I")) {
			
			informationMapper.insertCourseLike(paramMap);
		} else if (paramMap.get("gubun").equals("D")) {
			
			informationMapper.deleteCourseLike(paramMap);
		}
	}


	@Override
	public List<Map> selectWishList(HashMap wishMap) throws Exception {

		return informationMapper.selectWishList(wishMap);
	}


	@Override
	public List<Map> reviewInfoList(ArrayList<String> cNumberList) throws Exception {

		ArrayList<Map> reviewInfo = new ArrayList<Map>();
		for (String courseNumber : cNumberList) {
			
			EgovMap reviewInfoList = informationMapper.reviewInfoList(courseNumber);
			
			if(reviewInfoList.get("rank") == null){
				reviewInfoList.put("rank", "0");
			}
			
			reviewInfo.add(reviewInfoList);
		}
		
		return reviewInfo;
	}


	@Override
	public List<Map> reviewList(InformationCourseVO informationCourseVO)
			throws Exception {

		return informationMapper.reviewList(informationCourseVO);
	}


	@Override
	public EgovMap reviewListCnt(InformationCourseVO informationCourseVO)
			throws Exception {

		return informationMapper.reviewListCnt(informationCourseVO);
	}


}