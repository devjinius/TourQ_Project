package egovframework.example.myPage.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.myPage.service.MyPageService;
import egovframework.example.myPage.service.MyPageVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("myPageService")
public class MyPageServiceImpl extends EgovAbstractServiceImpl implements MyPageService{
	
	@Resource(name = "myPageMapper")
	private MyPageMapper myPageMapper;

	@SuppressWarnings("rawtypes")
	@Override
	public HashMap selectGetInfo(HashMap userId) throws Exception {

		HashMap<String, Object> resMap = new HashMap<String, Object>();

		try {

			EgovMap point = myPageMapper.selectMainPoint(userId);
			
			EgovMap ask = myPageMapper.selectMainAsk(userId);
			
			EgovMap totAsk = myPageMapper.selectMainTotAsk(userId);
			
			EgovMap totOrder = myPageMapper.selectMainTotOrder(userId);
			
			EgovMap totLike = myPageMapper.selectMainLike(userId);
			
			
			try {
				resMap.put("pointTotalmile", (point == null ? "0" : point.get("pointTotalmile").toString()));
				resMap.put("askContent", (ask == null ? "0" : ask.get("askContent").toString()));
				resMap.put("askAnswerYn", (ask == null ? "N" : ask.get("askAnswerYn").toString()));
				resMap.put("totalAskCount", totAsk.get("totalAskCount"));
				resMap.put("totalOrderCount", totOrder.get("totalOrderCount"));
				resMap.put("totalLikeCount", totLike.get("totalLikeCount"));

				if (!(totAsk.get("totalAskCount").equals(0))) {
					
					if (resMap.get("askAnswerYn").equals("Y")) {
						EgovMap anser = myPageMapper.selectMainAnswer(ask);
						
						resMap.put("answerContent", anser.get("answerContent").toString());
					}
				}
			} catch (Exception e) {
				// TODO: handle exception
				throw e;
			}
		} catch (Exception e) {
			// TODO: handle exception
			throw e;
		}
		
		return resMap;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectMyOrderList(HashMap userId)
			throws Exception {
		
		return myPageMapper.selectMyOrderList(userId);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectMyPoint(MyPageVO myPageVO)
			throws Exception {
		
		return myPageMapper.selectMyPoint(myPageVO);
	}
	
	@Override
	public EgovMap myPointTotCnt(MyPageVO myPageVO) throws Exception {

		return myPageMapper.myPointTotCnt(myPageVO);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectMyQuestion(MyPageVO myPageVO)
			throws Exception {
		
		return myPageMapper.selectMyQuestion(myPageVO);
	}

	@Override
	public EgovMap myQuestionTotCnt(MyPageVO myPageVO) throws Exception {

		return myPageMapper.myQuestionTotCnt(myPageVO);
	}

	@Override
	public EgovMap selectShowMore(String param1) throws Exception {

		SimpleDateFormat date = new SimpleDateFormat("YYYY-MM-dd");
		
		EgovMap question = myPageMapper.selectShowMore(param1);
		
		String qustionDate = date.format(question.get("askDate"));
		
		question.put("askDate", qustionDate);
		
		if (question.get("askAnswerYn").equals("Y")) {
			
			EgovMap answer = myPageMapper.selectAnswer(param1);
			
			question.put("answerContent", answer.get("answerContent"));
			question.put("answerTitle", answer.get("answerTitle"));
			question.put("answerDate", date.format(answer.get("answerDate")));
		}
		return question;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public EgovMap selectMyInfo(HashMap userId) throws Exception {

		return myPageMapper.selectMyInfo(userId);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectGetMyFavorit(HashMap userId) throws Exception {

		return myPageMapper.selectGetMyFavorit(userId);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectMyCourseList(String cookieVal) throws Exception {

		String[] cookieVal2 = cookieVal.split(",");
		
		List<Map> selectMyCourseList = new ArrayList<Map>();

		try {
			for (String i : cookieVal2) {
				
				selectMyCourseList.add(myPageMapper.selectMyCourseList(i));
			}
		} catch (Exception e) {
			throw e;
		}
		
		return selectMyCourseList;
	}

	@Override
	public EgovMap selectGetReview(String cosNum) throws Exception {

		return myPageMapper.selectGetReview(cosNum);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void deletFavoritList(HashMap userId) throws Exception {

		myPageMapper.deletFavoritList(userId);
	}
}