package egovframework.example.myPage.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.example.myPage.service.MyPageVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("myPageMapper")
public interface MyPageMapper {

	@SuppressWarnings("rawtypes")
	List<Map> selectMyOrderList(HashMap userId) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectMyPoint(MyPageVO myPageVO) throws Exception;
	
	EgovMap myPointTotCnt(MyPageVO myPageVO) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectMyQuestion(MyPageVO myPageVO) throws Exception;
	
	EgovMap myQuestionTotCnt(MyPageVO myPageVO) throws Exception;

	@SuppressWarnings("rawtypes")
	EgovMap selectMainPoint(HashMap userId) throws Exception;
	
	@SuppressWarnings("rawtypes")
	EgovMap selectMainAsk(HashMap userId) throws Exception;
	
	@SuppressWarnings("rawtypes")
	EgovMap selectMainTotAsk(HashMap userId) throws Exception;
	
	EgovMap selectMainAnswer(EgovMap ask) throws Exception;

	@SuppressWarnings("rawtypes")
	EgovMap selectMainTotOrder(HashMap userId) throws Exception;
	
	EgovMap selectShowMore(String param1) throws Exception;
	
	EgovMap selectAnswer(String param1) throws Exception;

	@SuppressWarnings("rawtypes")
	EgovMap selectMyInfo(HashMap userId) throws Exception;

	@SuppressWarnings("rawtypes")
	EgovMap selectMainLike(HashMap userId) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectGetMyFavorit(HashMap userId) throws Exception;

	@SuppressWarnings("rawtypes")
	Map selectMyCourseList(String i) throws Exception;

	EgovMap selectGetReview(String cosNum) throws Exception;

	@SuppressWarnings("rawtypes")
	void deletFavoritList(HashMap userId) throws Exception;
}