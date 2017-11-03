package egovframework.example.myPage.web;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.myPage.service.MyPageService;
import egovframework.example.myPage.service.MyPageVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class MyPageController {
	
	@Resource(name = "myPageService")
	private MyPageService myPageService;
	
	/* 회원아이디를 가져온다*/
	@SuppressWarnings({ "rawtypes" })
	private Map getId(HttpSession session) throws Exception {
		
		HashMap<String, Object> getId = new HashMap<String, Object>();
		
		getId.put("userId", session.getAttribute("memberNumber"));
		
		return getId;
	}
	
	/* 마이페이지 메인 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "myPage.do")
	public String myPage(ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {

		HashMap userId = (HashMap) getId(session);

		String cookieVal = null;
		
		List<Map> myCourseList = new ArrayList<Map>();
		
		try {
			// 저장된 쿠키가 있으면 쿠키에 있는 코스번호로 퇴근 조회한 코스를 가져온다.
			Cookie[] cookieArr = request.getCookies();
			
			for (Cookie i : cookieArr) {
				
				if (i.getName().equals("prodCookie")) {
					
					cookieVal = i.getValue().replaceAll("%2C", ",");
				}
			}

			if (cookieVal != null) {
				
				myCourseList = myPageService.selectMyCourseList(cookieVal);
			}
			
			model.addAttribute("myCourseList", (myCourseList.size() == 0 ? "0" : myCourseList));
			
		} catch (Exception e) {
			throw e;
		}
		
		try {
			HashMap getInfo = myPageService.selectGetInfo(userId);
			
			model.addAttribute("getInfo", getInfo);
		} catch (Exception e) {
			throw e;
		}
		
		return "myPage/myPage.tiles";
	}

	/* 내 주문내역 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "myOrderList.do")
	public String myOrderList(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		
		HashMap userId = (HashMap) getId(session);
		
		try {
			List<Map> getMyOrder = myPageService.selectMyOrderList(userId);

			for (Map i : getMyOrder) {
				String orDate = i.get("orDate").toString().split(" ")[0];
				
				i.replace("orDate", orDate);
			}
			
			model.addAttribute("getMyOrder", getMyOrder);
		} catch (Exception e) {
			throw e;
		}

		return "myPage/myOrderList.tiles";
	}

	/* 나의 관심코스 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "myFavoritList.do")
	public String myFavoritList(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		
		HashMap userId = (HashMap) getId(session);
		
		List<Map> getMyFavorit = myPageService.selectGetMyFavorit(userId);
		
		for (Map i : getMyFavorit) {
			
			String cosNum = i.get("courseNumber").toString();
			
			EgovMap getReview = myPageService.selectGetReview(cosNum);
			
			i.put("totCnt", getReview.get("totCnt"));
			i.put("rank", (getReview.get("rank") == null) ? "0" : getReview.get("rank"));
		}
		
		model.addAttribute("getMyFavorit", getMyFavorit);
		
		return "myPage/myFavoritList.tiles";
	}
	
	/* 내정보 수정페이지 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "myInfo.do")
	public String myInfo(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		
		HashMap userId = (HashMap) getId(session);
		
		EgovMap myInfo = myPageService.selectMyInfo(userId);
		
		model.addAttribute("myInfo", myInfo);
		
		return "myPage/myInfo.tiles";
	}
	
	/* 나의 포인트내역 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "myPoint.do")
	public String myPoint(HttpServletRequest request, ModelMap model, HttpSession session,
			@ModelAttribute MyPageVO myPageVO) throws Exception {
		
		HashMap userId = (HashMap) getId(session);
		
		myPageVO.setUserId(userId.get("userId").toString());
		
		try {
			List<Map> getMyPoint = myPageService.selectMyPoint(myPageVO);
			
			for (Map i : getMyPoint) {
				
				String pointDate = i.get("pointDate").toString().split(" ")[0];
				String gubun = "";
				
				gubun = i.get("pointMile").toString().indexOf("-") < 0 ? "+" : "-";
				
				i.put("gubun", gubun);
				i.replace("pointDate", pointDate);
			}
			
			model.addAttribute("getMyPoint", getMyPoint);
			
			EgovMap myPointTotCnt = myPageService.myPointTotCnt(myPageVO);
			
			HashMap<String, Object> resMap = new HashMap<String, Object>(paging(myPageVO));
			
			resMap.put("page", myPageVO.getPage());
			resMap.put("totalPage", myPointTotCnt.get("totalPage"));
			resMap.put("pageScale", myPageVO.getPageScale());
			
			model.addAttribute("resMap", resMap);
		} catch (Exception e) {
			throw e;
		}

		return "myPage/myPoint.tiles";
	}
	
	/* 나의 문의내역 리스트 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "myQuestion.do")
	public String myQuestion(HttpServletRequest request, ModelMap model, HttpSession session,
			@ModelAttribute MyPageVO myPageVO) throws Exception {
		
		HashMap userId = (HashMap) getId(session);
		
		myPageVO.setUserId(userId.get("userId").toString());
		
		try {
			List<Map> getMyQuestion = myPageService.selectMyQuestion(myPageVO);
			
			for (Map i : getMyQuestion) {
				String askDate = i.get("askDate").toString().split(" ")[0];
				
				i.replace("askDate", askDate);
			}
			
			model.addAttribute("getMyQuestion", getMyQuestion);

			EgovMap myQuestionTotCnt = myPageService.myQuestionTotCnt(myPageVO);
			
			/* 내 문의내역 리스트 페이징을 가져옴 */
			HashMap<String, Object> resMap = new HashMap<String, Object>(paging(myPageVO));
			
			resMap.put("totalPage", myQuestionTotCnt.get("totalPage"));
			resMap.put("page", myPageVO.getPage());
			resMap.put("pageScale", myPageVO.getPageScale());
			
			model.addAttribute("resMap", resMap);
			
		} catch (Exception e) {
			throw e;
		}

		return "myPage/myQuestion.tiles";
	}
	
	/* 내 문의 상세보기 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "myQuestionMore.do")
	public void myQuestionMore(@RequestParam String param1, HttpServletResponse response) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		EgovMap showMore = new EgovMap();
		
		try {

			showMore = myPageService.selectShowMore(param1);
			
			try {
				if (showMore.get("askAnswerYn").equals("Y")) {

					String contents = (String) showMore.get("answerContent");
					contents = contents.replaceAll("&lt;", "<");
					contents = contents.replaceAll("&gt;", ">");
					contents = contents.replaceAll("&quot;", "\'");
					contents = contents.replaceAll("&nbsp;", " ");
					contents = contents.replaceAll("&amp;", "&");
					
					showMore.put("answerContent", contents);
				}
			} catch (Exception e) {
				// TODO: handle exception
				throw e;
			}
		} catch (Exception e) {
			// TODO: handle exception
			throw e;
		}
		
		out = response.getWriter();
		
		out.write(JsonUtil.MapToJson(showMore));
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "deletFavoritList.do")
	public String deletFavoritList(@RequestParam String param1, HttpSession session) throws Exception {

		HashMap userId = (HashMap) getId(session);
		
		userId.put("cosNum", param1.toString());
		
		try {
			myPageService.deletFavoritList(userId);
		} catch (Exception e) {
			throw e;
		}
		
		return "redirect:/myFavoritList.do";
	}
	
	/* 마이페이지 페이징 */
	@SuppressWarnings("rawtypes")
	private Map paging(@ModelAttribute MyPageVO myPageVO) throws Exception {
		
			HashMap<String, Object> resMap = new HashMap<String, Object>();

			int pageGroup = (int) Math.ceil((double) myPageVO.getPage()/myPageVO.getPageScale());
			
			long startPage = (pageGroup - 1) * myPageVO.getPageScale() + 1;
			
			myPageVO.setStartPage(startPage);
			
			resMap.put("startPage", startPage);
			
			long endPage = startPage + myPageVO.getPageScale() - 1;
			
			myPageVO.setEndPage(endPage);
			
			resMap.put("endPage", endPage);
			
			long prevPage = (2 - pageGroup) * myPageVO.getPageScale() + 1;
			long nextPage = pageGroup * myPageVO.getPageScale() + 1;
			
			resMap.put("prevPage", prevPage);
			resMap.put("nextPage", nextPage);
			resMap.put("pageGroup", pageGroup);
			
		return resMap;
	}
}
