package egovframework.example.memberLogin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.example.adminCourse.service.CourseVo;
import egovframework.example.adminMarker.service.MarkerVO;
import egovframework.example.memberLogin.service.LoginVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("memberLoginMapper")
public interface MemberLoginMapper {

	EgovMap getPw(String memberId) throws Exception;

	void register(LoginVO loginVO);

	void insertPoint(EgovMap memberNumberMap) throws Exception;

	EgovMap selectRecMn() throws Exception;

	void updateMemberInfo(LoginVO loginVO) throws Exception;

}
