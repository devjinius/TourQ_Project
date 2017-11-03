package egovframework.example.adminCourse.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.antlr.grammar.v3.ANTLRParser.throwsSpec_return;
import org.springframework.stereotype.Service;

import egovframework.example.adminCourse.service.AdminCourseService;
import egovframework.example.adminCourse.service.CourseVo;
import egovframework.example.information.service.InformationService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("adminCourseService")
public class AdminCourseServiceImpl extends EgovAbstractServiceImpl implements AdminCourseService {

	@Resource(name = "adminCourseMapper")
	private AdminCourseMapper adminCourseMapper;
	
	
	@Override
	public List<Map> courseList(String courseNo) throws Exception {

		return adminCourseMapper.courseList(courseNo);
	}


	@Override
	public List<Map> markerList(String courseNo) throws Exception {

		return adminCourseMapper.markerList(courseNo);
	}

	@Override
	public void courseDetailIUD(CourseVo courseVo) throws Exception {

		if (courseVo.getCourseNumber().equals("")) {

			adminCourseMapper.courseDetailInsert(courseVo);
		} else if (courseVo.getCourseNumber() != null) {
			
			adminCourseMapper.courseDetailUpdate(courseVo);
		}
	}


	@Override
	public List<Map> themeList() throws Exception {

		return adminCourseMapper.themeList();
	}


	@Override
	public void insertTheme(Map<String, Object> castMap) {

		adminCourseMapper.insertTheme(castMap);
	}


	@Override
	public void updatePR(Map<String, Object> prMap) throws Exception {
		
		String[] checked = (String[]) prMap.get("checked");
		
		if(prMap.get("gubun").equals("P")){

			for (int i = 0; i < checked.length; i++) {
				
				List<Map> yn = adminCourseMapper.selectPYN(checked[i]);
				
				if(yn.get(0).get("popular").equals("Y")) {
					
					adminCourseMapper.updatePY(checked[i]);
				} else {
					
					adminCourseMapper.updatePN(checked[i]);
				}
			}
		} else if (prMap.get("gubun").equals("R")) {
			
			
			
			for (int i = 0; i < checked.length; i++) {
				
				List<Map> yn = adminCourseMapper.selectRYN(checked[i]);
				
				if(yn.get(0).get("recommand").equals("Y")) {
					
					// Y면 N으로 해라
					adminCourseMapper.updateRY(checked[i]);
				} else {
					
					// N이면 Y로 하기전에
					EgovMap selectRCourse = adminCourseMapper.selectRCourse();
					// 추천코스 개수 (bigDecimal) int 변환
					int rCourse = ((BigDecimal) selectRCourse.get("count")).intValue();
					// 현재 Y가 6개면 에러 발생
					if (rCourse == 6) {throw new Exception();}
					
					// 아니면 Y로 만들어줘라
					adminCourseMapper.updateRN(checked[i]);
				}
			}
		}
	}


	@Override
	public List<Map> courseList(CourseVo courseVo) throws Exception {

		return adminCourseMapper.courseListVO(courseVo);
	}

	@Override
	public EgovMap courseListCnt(CourseVo courseVo) throws Exception {

		return adminCourseMapper.courseListCnt(courseVo);
	}


	@Override
	public List<Map> themeCount() throws Exception {

		return adminCourseMapper.themeCount();
	}


	@Override
	public void deleteCourse(String[] values) throws Exception {

		for (String courseNumber : values) {
			
			adminCourseMapper.deleteCourse(courseNumber);
		}
	}


	@Override
	public void deleteTheme(String[] values) throws Exception {
		
		for (String courseNumber : values) {
			
			adminCourseMapper.deleteTheme(courseNumber);
		}		
	}


	@Override
	public EgovMap selectCourseNumber() throws Exception {

		return adminCourseMapper.selectCourseNumber();
	}


	@Override
	public List<Map> busList() throws Exception {

		return adminCourseMapper.busList();
	}

}