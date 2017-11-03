package egovframework.example.adminCourse.web;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.adminCourse.service.AdminCourseService;
import egovframework.example.adminCourse.service.CourseVo;
import egovframework.example.cmmn.JsonUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class AdminCourseController {
	
	@Resource(name = "adminCourseService")
	private AdminCourseService adminCourseService;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "adminCourse.do")
	public String adminCourse(ModelMap model, HttpServletRequest request, CourseVo courseVo) throws Exception {
		
		// 인기나 추천을 눌렀을 경우
		if (request.getParameter("gubun") != null){
		
			Map prMap = new HashMap();
			
			prMap.put("gubun", request.getParameter("gubun"));
			
			Enumeration<String> attr = request.getParameterNames();
			
			while (attr.hasMoreElements()) {
				
				String attrNames = (String) attr.nextElement();
				
				if (attrNames.equals("checkbox")) {
					
					String[] checked = request.getParameterValues("checkbox");
					
					prMap.put("checked", checked);
				}
			}
			
			try {
				adminCourseService.updatePR(prMap);
			} catch (Exception e) {

				model.addAttribute("notRec", "추천은 최대 6개 까지만입니다!!");
			}
			
		}
			
		courseVo.setRows(10);
		// courseList 전체를 가져와 뿌린다.
		
		List<Map> courseList = adminCourseService.courseList(courseVo);
		EgovMap courseListCnt = adminCourseService.courseListCnt(courseVo);
		List<Map> themeList = adminCourseService.themeList();
		
		// 페이징에 필요한 처리
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("page", courseVo.getPage());
		resMap.put("totalPage", courseListCnt.get("totalPage"));
		resMap.put("pageScale", courseVo.getPageScale());
		
		int pageGroup = (int) Math.ceil((double) courseVo.getPage() / courseVo.getPageScale() );
		
		long startPage = (pageGroup - 1) * courseVo.getPageScale() + 1;

		courseVo.setStartPage(startPage);
		
		resMap.put("startPage", courseVo.getStartPage());
		
		long endPage = startPage + courseVo.getPageScale() - 1;
		
		courseVo.setEndPage(endPage);
		
		resMap.put("endPage", endPage);
		
		long prePage = (pageGroup-2) * courseVo.getPageScale() + 1 + (courseVo.getPageScale()-1);
						//여기는 이전 그룹의 처음숫자 						// 여길 추가하면 이전그룹의 마지막숫자 
		
		long nextPage = pageGroup * courseVo.getPageScale() + 1;
		
		resMap.put("pageGroup", pageGroup);
		resMap.put("prePage", prePage);
		resMap.put("nextPage", nextPage);
		
		
		// courseDate를 YYYY-MM-DD형식으로 변형한 뒤 모델에 담아 보낸다.
		modifyDate(courseList);
		
		model.addAttribute("courseList", courseList);
		model.addAttribute("courseListCnt", courseListCnt);
		model.addAttribute("resMap", resMap);
		model.addAttribute("themeList", themeList);
		
		return "adminCourse/adminCourse.atiles";
	}
	
	// courseDate를 YYYY-MM-DD형식으로 변형하는 메서드
	@SuppressWarnings("unchecked")
	private List<Map> modifyDate(List<Map> courseList) {
		
		for (Map map : courseList) {
			
			String datetime = String.valueOf(map.get("courseDate"));
			
			String date = datetime.split(" ")[0];
			
			map.replace("courseDate", date);
		}
		
		return courseList;
	}
	
	@RequestMapping(value = "adminCourseDetail.do")
	public String adminCourseDetail(HttpServletRequest request, ModelMap model) throws Exception {
		
		// 화면에서 받아온 코스번호를 저장한 뒤 MVC타서 한줄만 가져온다.
		String courseNo = request.getParameter("courseNumber");
		
		List<Map> courseList = adminCourseService.courseList(courseNo);
		List<Map> themeList = adminCourseService.themeList();
		List<Map> busList = adminCourseService.busList();

		model.addAttribute("courseList", courseList);
		model.addAttribute("themeList", themeList);
		model.addAttribute("busList", busList);
		
		return "adminCourse/adminCourseDetail.atiles";
	}
	
	@RequestMapping(value = "adminCourseCreate.do")
	public String adminCourseCreate(ModelMap model) throws Exception {
		
		List<Map> themeList = adminCourseService.themeList();
		List<Map> busList = adminCourseService.busList();

		model.addAttribute("themeList", themeList);
		model.addAttribute("busList", busList);
		
		return "adminCourse/adminCourseCreate.atiles";
	}
	
	@RequestMapping(value = "adminTheme.do")
	public String adminTheme(ModelMap model) throws Exception {

		List<Map> themeList = adminCourseService.themeList();
		List<Map> themeCount = adminCourseService.themeCount();
		
//		//sort를 이용하여 themeCount의 themeNumber의 값을 비교하여 sort한다.
//		try {
//			Collections.sort(themeCount, new Comparator<Map>() {
//
//				@Override
//				public int compare(Map o1, Map o2) {
//
//					return ((Integer) Integer.valueOf((String) o1.get("themeNumber"))).compareTo(Integer.valueOf((String) o2.get("themeNumber")));
//				}
//				 
//			});
//		} catch (Exception e) {e.printStackTrace();}
		
		for (Map map : themeList) {
			
			for (Map count : themeCount) {
			
				if(count.get("themeNumber").equals(map.get("themeNumber"))){
					
					map.put("themeCount", count.get("courseCount"));
					break;
				} else {

					map.put("themeCount", 0);
				}
			}
			
		}
		
		model.addAttribute("themeList", themeList);
		model.addAttribute("themeCount", themeCount);
		
		return "adminCourse/adminTheme.atiles";
	}
	
	@RequestMapping(value = "adminThemeCreate.do")
	public void adminThemeCreate(HttpServletResponse response,HttpServletRequest request, ModelMap model) throws Exception {
			
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		String quotZero = request.getParameter("param");
	
		quotZero = quotZero.replaceAll("&quot;", "\"");
		
		Map<String, Object> castMap = new HashMap<String, Object>();
		
		castMap = JsonUtil.JsonToMap(quotZero);
		
		try {
			adminCourseService.insertTheme(castMap);
		} catch (Exception e) {System.out.println("theme insert 오류입니다.");}
	}
	
}
