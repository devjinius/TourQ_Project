package egovframework.example.main.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.main.service.MainService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class MainController {
	
	@Resource(name = "mainService")
	private MainService mainService;
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "main.do")
	public String initMain(ModelMap model, HttpServletRequest request) throws Exception {

		List<Map> recList = new ArrayList<Map>();
		List<Map> themeList = mainService.themeList();
		List<Map> courseAllList = mainService.courseAllList();
		List<Map> courseRandom = new ArrayList<Map>();

		// 중복방지를 위해 -1 임시 변수 생성
		int temp = -1;
		
		// 2번 random을 만든다.
		for (int i = 0; i < 2; i++) {
			
			// 랜덤 번호 생성
			int ran = (int)(Math.random() * courseAllList.size());
			
			// 랜덤이 temp(첫번째 랜덤 번호)와 같다면 같지 않을 때까지 반복하여 random 생성 
			while (ran == temp) {
				
				ran = (int)(Math.random() * courseAllList.size());
			}
			
			// random을 temp에 저장하여 다음 반복 때 비교할때 사용
			temp = ran;
			
			// List에 추가
			courseRandom.add(courseAllList.get(ran));
		}
		
		// 추천코스를 걸러낸다.
		for (Map map : courseAllList) {
			
			if (map.get("recommand").equals("Y")) {
				
				recList.add(map);
			}
		}
		
		// 하트 채우기 위해 wishLike 가져오기
		// 세션에 값이 있다면 멤버넘버를 가져온다.
		if(request.getSession().getAttribute("memberSession")!=null) {
			
			Map sessionMember = (Map) request.getSession().getAttribute("memberSession");
			
			String memberNumber = (String) sessionMember.get("memberNumber");
			
			// 화면에 내릴 코스리스트의 코스번호를 가져온다.
			List courseNumberList = new ArrayList();
			for (Map map : recList) {
				
				courseNumberList.add(map.get("courseNumber"));
			}
			
			// map에 코스넘버와 코스번호리스트를 담는다.
			HashMap wishMap = new HashMap();

			wishMap.put("memberNumber", memberNumber);
			wishMap.put("courseNumberList", courseNumberList);
			
			// wishlike에가서 멤버넘버와 코스번호가 일치하는 리스트를 가져온다.
			List<Map> wishList = mainService.selectWishList(wishMap);
			
			// 위시리스트에 코스번호가있으면 Y, 없으면 N으로 courseList에 담아서 넘긴다. 
			for (Map map : recList) {
				
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
			
			for (Map map : recList) {
				
				map.put("wish", "N");
			}
		}
		
		ArrayList<String> cNumberList = new ArrayList<String>(); 
		for (Map course : recList) {
			
			cNumberList.add((String) course.get("courseNumber"));
		}
		
		// review 가져온다.
		List<Map> reviewInfo = mainService.reviewInfoList(cNumberList);
		
		for (int i = 0; i < recList.size(); i++) {
			
			recList.get(i).put("totCnt", reviewInfo.get(i).get("totcnt"));
			recList.get(i).put("rank", reviewInfo.get(i).get("rank"));
		}

		model.addAttribute("recList", recList);
		System.out.println(recList);
		model.addAttribute("themeList", themeList);
		model.addAttribute("courseList", courseRandom);
		
		return "main/main.tiles";
	}
	
	@RequestMapping(value = "mainLikeID.do")
	public void mainLikeID(HttpServletRequest request) throws Exception {
		
		try {
			
			// 세션에서 memberNumber를 받아온다.
			Map sessionMember = (Map) request.getSession().getAttribute("memberSession");
			
			String memberNumber = (String) sessionMember.get("memberNumber");
			
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			
			// insert할 값들을 넣어준다.
			paramMap.put("memberNumber", memberNumber);
			paramMap.put("gubun", request.getParameter("gubun"));
			paramMap.put("courseNumber", request.getParameter("courseNumber"));
			
			mainService.courseLikeID(paramMap);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
