package egovframework.example.memberLogin.service.impl;

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
import egovframework.example.memberLogin.service.LoginVO;
import egovframework.example.memberLogin.service.MemberLoginService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("memberLoginService")
public class MemberLoginServiceImpl extends EgovAbstractServiceImpl implements MemberLoginService {

	@Resource(name = "memberLoginMapper")
	private MemberLoginMapper memberLoginMapper;

	@Override
	public EgovMap getPw(String memberId) throws Exception {

		return memberLoginMapper.getPw(memberId);
	}

	@Override
	public void register(LoginVO loginVO) {
		
		memberLoginMapper.register(loginVO);
	}

	@Override
	public void insertPoint(EgovMap memberNumberMap) throws Exception {

		memberLoginMapper.insertPoint(memberNumberMap);
	}

	@Override
	public EgovMap selectRecMn() throws Exception {

		return memberLoginMapper.selectRecMn();
	}

	@Override
	public void updateMemberInfo(LoginVO loginVO) throws Exception {

		memberLoginMapper.updateMemberInfo(loginVO);
	}
	
}