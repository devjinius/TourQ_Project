package egovframework.example.myPage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;


public interface MyPageService {

	@SuppressWarnings("rawtypes")
	List<Map> selectMyOrderList(HashMap userId) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectMyPoint(MyPageVO myPageVO) throws Exception;
	EgovMap myPointTotCnt(MyPageVO myPageVO) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectMyQuestion(MyPageVO myPageVO) throws Exception;
	EgovMap myQuestionTotCnt(MyPageVO myPageVO) throws Exception;

	@SuppressWarnings("rawtypes")
	HashMap selectGetInfo(HashMap userId) throws Exception;
	EgovMap selectShowMore(String param1) throws Exception;

	@SuppressWarnings("rawtypes")
	EgovMap selectMyInfo(HashMap userId) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectGetMyFavorit(HashMap userId) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectMyCourseList(String cookieVal) throws Exception;

	EgovMap selectGetReview(String cosNum) throws Exception;

	@SuppressWarnings("rawtypes")
	void deletFavoritList(HashMap userId) throws Exception;
}