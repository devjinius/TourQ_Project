package egovframework.example.information.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.information.service.InformationCourseVO;
import egovframework.example.information.service.InformationService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class InformationController {
	
	@Resource(name = "informationService")
	private InformationService informationService;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "localCourse.do")
	public String localCourse(ModelMap model, HttpServletRequest request,@ModelAttribute InformationCourseVO informationCourseVO) throws Exception {
		
		//페이징을 위해 row를 6으로
		informationCourseVO.setRows(6);
		
		//코스와 페이지수를 가져온다.
		List<Map> courseList = informationService.courseList(informationCourseVO);
		EgovMap courseListCnt =  informationService.courseListCnt(informationCourseVO);
		
		// 페이징에 필요한 처리
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("page", informationCourseVO.getPage());
		resMap.put("totalPage", courseListCnt.get("totalPage"));
		resMap.put("pageScale", informationCourseVO.getPageScale());
		
		int pageGroup = (int) Math.ceil((double) informationCourseVO.getPage() / informationCourseVO.getPageScale() );
		
		long startPage = (pageGroup - 1) * informationCourseVO.getPageScale() + 1;

		informationCourseVO.setStartPage(startPage);
		
		resMap.put("startPage", informationCourseVO.getStartPage());
		
		long endPage = startPage + informationCourseVO.getPageScale() - 1;
		
		informationCourseVO.setEndPage(endPage);
		
		resMap.put("endPage", endPage);
		
		long prePage = (pageGroup-2) * informationCourseVO.getPageScale() + 1 + (informationCourseVO.getPageScale()-1);
						//여기는 이전 그룹의 처음숫자 						// 여길 추가하면 이전그룹의 마지막숫자 
		
		long nextPage = pageGroup * informationCourseVO.getPageScale() + 1;
		
		resMap.put("pageGroup", pageGroup);
		resMap.put("prePage", prePage);
		resMap.put("nextPage", nextPage);
		
		//페이지와 관련된 것 모델로 내린다.
		model.addAttribute("resMap", resMap);

		// 오른편 지도에 마커를 찍기위해 출발지 마커만 가져온다.
		List<Map> markerList = informationService.markerListZero(informationCourseVO);
		
		// 테마 목록을 보여주기 위해 테마리스트를 불러와 모델에 내린다.
		List<Map> themeList = informationService.themeList();
		

		// 하트 채우기 위해 wishLike 가져오기
		// 세션에 값이 있다면 멤버넘버를 가져온다.
		if(request.getSession().getAttribute("memberSession")!=null) {
			
			Map sessionMember = (Map) request.getSession().getAttribute("memberSession");
			
			String memberNumber = (String) sessionMember.get("memberNumber");
			
			// 화면에 내릴 코스리스트의 코스번호를 가져온다.
			List courseNumberList = new ArrayList();
			for (Map map : courseList) {
				
				courseNumberList.add(map.get("courseNumber"));
			}
			
			// map에 코스넘버와 코스번호리스트를 담는다.
			HashMap wishMap = new HashMap();

			wishMap.put("memberNumber", memberNumber);
			wishMap.put("courseNumberList", courseNumberList);
			
			// wishlike에가서 멤버넘버와 코스번호가 일치하는 리스트를 가져온다.
			List<Map> wishList = informationService.selectWishList(wishMap);
			
			// 위시리스트에 코스번호가있으면 Y, 없으면 N으로 courseList에 담아서 넘긴다. 
			for (Map map : courseList) {
				
				for (Map map2: wishList) {
					
					if(map.get("courseNumber").equals(map2.get("courseNumber"))){
						map.put("wish", "Y");
						break;
					} else{
						map.put("wish", "N");
					}
				}
			}
			
		// 세션에 값이 없다면 wish에 모두 N을 담아 보낸다.
		} else {
			
			for (Map map : courseList) {
				
				map.put("wish", "N");
			}
		}
		
		ArrayList<String> cNumberList = new ArrayList<String>(); 
		for (Map course : courseList) {
			
			cNumberList.add((String) course.get("courseNumber"));
		}
		
		// review 가져온다.
		List<Map> reviewInfo = informationService.reviewInfoList(cNumberList);
		
		for (int i = 0; i < courseList.size(); i++) {
			
			courseList.get(i).put("totCnt", reviewInfo.get(i).get("totcnt"));
			courseList.get(i).put("rank", reviewInfo.get(i).get("rank"));
		}
		
		model.addAttribute("courseList", courseList);
		model.addAttribute("courseListCnt", courseListCnt);
		model.addAttribute("markerList", markerList);
		model.addAttribute("themeList", themeList);

		return "information/localCourse.tiles";
	}
	
	@RequestMapping(value = "seoulro.do")
	public String seoulro(ModelMap model, HttpServletRequest request, @ModelAttribute InformationCourseVO informationCourseVO) throws Exception {
		
		String courseNo = request.getParameter("courseNumber");
		
		informationCourseVO.setRows(4);
		// 코스 리스트 호출
		List<Map> courseList = informationService.courseList(courseNo);
		String[] timeArr = String.valueOf(courseList.get(0).get("courseStartTime")).split("_");
		String startTime = "";
		for (int i = 0; i < timeArr.length; i++) {
			
			timeArr[i] = timeArr[i] + ":00";
		}

		courseList.get(0).replace("courseStartTime", StringUtils.join(timeArr, " / "));
		// tap2의 마커리스트 호출
		List<Map> markerList = informationService.markerList(courseNo);
		// tap3의 reviewList 호출
		List<Map> reviewList = informationService.reviewList(informationCourseVO);
		EgovMap reviewListCnt =  informationService.reviewListCnt(informationCourseVO);
		modifyDate(reviewList);
		
		// 페이징에 필요한 처리
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("page", informationCourseVO.getPage());
		resMap.put("totalPage", reviewListCnt.get("totalPage"));
		resMap.put("pageScale", informationCourseVO.getPageScale());
		
		int pageGroup = (int) Math.ceil((double) informationCourseVO.getPage() / informationCourseVO.getPageScale() );
		
		long startPage = (pageGroup - 1) * informationCourseVO.getPageScale() + 1;

		informationCourseVO.setStartPage(startPage);
		
		resMap.put("startPage", informationCourseVO.getStartPage());
		
		long endPage = startPage + informationCourseVO.getPageScale() - 1;
		
		informationCourseVO.setEndPage(endPage);
		
		resMap.put("endPage", endPage);
		
		long prePage = (pageGroup-2) * informationCourseVO.getPageScale() + 1 + (informationCourseVO.getPageScale()-1);
						//여기는 이전 그룹의 처음숫자 						// 여길 추가하면 이전그룹의 마지막숫자 
		
		long nextPage = pageGroup * informationCourseVO.getPageScale() + 1;
		
		resMap.put("pageGroup", pageGroup);
		resMap.put("prePage", prePage);
		resMap.put("nextPage", nextPage);
		resMap.put("totalCnt", reviewListCnt.get("totalTotCnt"));
		
		// 소수점 둘째자리에서 반올림
		double b = Math.round(Double.valueOf(String.valueOf(reviewListCnt.get("totRank")))*10d) / 10d;
		resMap.put("totRank", 	b);
		
		//페이지와 관련된 것 모델로 내린다.
		model.addAttribute("resMap", resMap);
		model.addAttribute("courseList", courseList);
		model.addAttribute("markerList", markerList);
		model.addAttribute("reviewList", reviewList);
		
		return "information/seoulro.tiles";
	}
	
	@SuppressWarnings("unchecked")
	private List<Map> modifyDate(List<Map> reviewList) {
		
		for (Map map : reviewList) {
			
			String datetime = String.valueOf(map.get("reviewDate"));
			
			String date = datetime.split(" ")[0];
			
			map.replace("reviewDate", date);
		}
		
		return reviewList;
	}
	
	@RequestMapping(value = "busCourse.do")
	public String busCourse() throws Exception {
		
		return "information/busCourse.tiles";
	}
	
	@RequestMapping(value = "courseTest.do")
	public String courseTest() throws Exception {
		
		return "information/courseTest.tiles";
	}
	
	@RequestMapping(value = "courseLikeID.do")
	public void courseLikeID(HttpServletRequest request) throws Exception {
		
		try {
			
			// 세션에서 memberNumber를 받아온다.
			Map sessionMember = (Map) request.getSession().getAttribute("memberSession");
			
			String memberNumber = (String) sessionMember.get("memberNumber");
			
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			
			// insert할 값들을 넣어준다.
			paramMap.put("memberNumber", memberNumber);
			paramMap.put("gubun", request.getParameter("gubun"));
			paramMap.put("courseNumber", request.getParameter("courseNumber"));
			
			informationService.courseLikeID(paramMap);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
