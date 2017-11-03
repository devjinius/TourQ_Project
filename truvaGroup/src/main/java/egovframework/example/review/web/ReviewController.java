package egovframework.example.review.web;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.adminCustomer.service.AdCustomJqgridVo;
import egovframework.example.cmmn.JsonUtil;
import egovframework.example.review.service.ReviewService;
import egovframework.example.review.service.impl.ReviewMapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class ReviewController {
	
	@Resource(name = "reviewService")
	private ReviewService reviewService;
	
	@RequestMapping(value = "review.do")
	public String review(ModelMap model) throws Exception {

		List<Map> themeList = reviewService.themeList();
		List<Map> reviewList = reviewService.reviewList();
		EgovMap totCnt = reviewService.totCnt();
		List<Map> themeCnt = reviewService.themeCnt();
				
		for (Map map : themeList) {
			
			for (Map count : themeCnt) {
			
				if(count.get("themeNumber").equals(map.get("themeNumber"))){
					
					map.put("themeCount", count.get("cnt"));
					break;
				} else {

					map.put("themeCount", 0);
				}
			}
			
		}
		
		model.addAttribute("themeList", themeList);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("themeCnt", themeCnt);
		
		return "review/review.tiles";
	}
	
	@RequestMapping(value = "reviewCreate.do")
	public String reviewCreate(HttpSession session, ModelMap model) throws Exception {
		
		Map sessionMap = (Map) session.getAttribute("memberSession");
		String memberNumber = (String) sessionMap.get("memberNumber");

		List<Map> beforeList = reviewService.beforeList(memberNumber);
		
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		
		modifyDate(beforeList);
		
		model.addAttribute("beforeList", beforeList);
		
		return "review/reviewCreate.tiles";
	}
	
	@RequestMapping(value = "reviewList.do")
	public void reviewList(HttpServletRequest request ,HttpServletResponse response, ModelMap model) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		String quotZero = request.getParameter("reviewNumber");
		
		EgovMap selectReview = reviewService.selectReview(quotZero);
		
		modifyDate(selectReview, "reviewDate");
		
		out = response.getWriter();

		out.write(JsonUtil.MapToJson(selectReview).toString());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private static Map modifyDate(Map map, String parsingStr) {
		
		String datetime = String.valueOf(map.get(parsingStr));
		
		String date = datetime.split(" ")[0];
		
		map.replace(parsingStr, date);
		
		return map;
	}
	
	// courseDate를 YYYY-MM-DD형식으로 변형하는 메서드
	@SuppressWarnings("unchecked")
	private List<Map> modifyDate(List<Map> courseList) {
		
		for (Map map : courseList) {
			
			String datetime = String.valueOf(map.get("departureTime"));
			
			String date = datetime.split(" ")[0];
			
			map.replace("departureTime", date);
		}
		
		return courseList;
	}
	
	@RequestMapping(value = "reviewI.do")
	public String reviewI(HttpServletRequest request, HttpSession session) throws Exception {
		
		Map sessionMap = (Map) session.getAttribute("memberSession");

		HashMap<String, Object> res = new HashMap<String, Object>();
		
		//0은 코스넘버, 1은 테마넘버, 2는 오더넘버
		String[] courseInfo = request.getParameter("courseInfo").split("_");

		res.put("courseNumber", courseInfo[0]);
		res.put("themeNumber", courseInfo[1]);
		res.put("rank", request.getParameter("rank"));
		res.put("title", request.getParameter("title"));
		res.put("contents", request.getParameter("contents"));
		res.put("memberNumber", sessionMap.get("memberNumber"));

		reviewService.insertReview(res);
		
		String orderNumber = courseInfo[2];
		
		//order테이블에 리뷰 작성으로 기록
		reviewService.updateOrderYN(orderNumber);
		
		// 방금 넣은 reviewNumber를 사진을 넣기 위해 가져온다.
		EgovMap reviewNumberMap = reviewService.selectReviewNumber();

		try {
			
			//파일업로드 -> enum으로 변경 필요함
			MultipartHttpServletRequest multi = (MultipartHttpServletRequest)request;
			
			//첨부파일의 갯수가 여러개 -> Iterator
			Iterator<String> iterator = multi.getFileNames();
			int index = 0;
			
			while(iterator.hasNext()){
				
				index++;
				
				MultipartFile mfile = multi.getFile(iterator.next()); //해당 첨부파일 정보를 얻어온다.
				
				String temp = String.valueOf(reviewNumberMap.get("reviewnumber"));
				File file = new File(request.getSession().getServletContext().getRealPath("/")+"/images/review/" + temp + ".jpg");
				
				try {
					mfile.transferTo(file);//파일 업로드 실행
				} catch (Exception e) {
					System.out.println(e.toString());
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/review.do";
	}
	
}
