package egovframework.example.memberLogin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface MemberLoginService {

	EgovMap getPw(String memberId) throws Exception;

	void register(LoginVO loginVO);

	void insertPoint(EgovMap memberNumberMap) throws Exception;

	EgovMap selectRecMn() throws Exception;

	void updateMemberInfo(LoginVO loginVO) throws Exception;

}

