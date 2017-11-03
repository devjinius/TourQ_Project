package egovframework.example.adminMarker.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.adminCourse.service.AdminCourseService;
import egovframework.example.adminCourse.service.CourseVo;
import egovframework.example.adminMarker.service.AdminMarkerService;
import egovframework.example.adminMarker.service.MarkerVO;
import egovframework.example.information.service.InformationService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("adminMarkerService")
public class AdminMarkerServiceImpl extends EgovAbstractServiceImpl implements AdminMarkerService {

	@Resource(name = "adminMarkerMapper")
	private AdminMarkerMapper adminMarkerMapper;
	
	@Override
	public List<Map> courseList(MarkerVO markerVO) throws Exception {

		return adminMarkerMapper.courseList(markerVO);
	}

	@Override
	public List<Map> markerList(String courseNo) throws Exception {

		return adminMarkerMapper.markerList(courseNo);
	}

	@Override
	public List<Map> courseList() throws Exception {

		return adminMarkerMapper.courseList();
	}


	@Override
	public List<Map> markerMapList(String markerNumber) throws Exception {

		return adminMarkerMapper.markerMapList(markerNumber);
	}

	@Override
	public void insertMarker(HashMap<String, Object> insData) throws Exception {

		adminMarkerMapper.insertMarker(insData);
	}


	@Override
	public List<Map> themeList() throws Exception {

		return adminMarkerMapper.themeList();
	}

	@Override
	public EgovMap courseListCnt(MarkerVO markerVO) throws Exception {

		return adminMarkerMapper.courseListCnt(markerVO);
	}

	@Override
	public void updateMarker(HashMap<String, Object> insData) throws Exception {

		adminMarkerMapper.updateMarker(insData);
	}

	@Override
	public void deleteMarker(String[] values) throws Exception {

		for (String markerNumber : values) {
			
			adminMarkerMapper.deleteMarker(markerNumber);
		}
	}
}