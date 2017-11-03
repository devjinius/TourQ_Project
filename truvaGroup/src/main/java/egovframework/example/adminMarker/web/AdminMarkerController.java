package egovframework.example.adminMarker.web;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.adminCourse.service.AdminCourseService;
import egovframework.example.adminMarker.service.AdminMarkerService;
import egovframework.example.adminMarker.service.MarkerVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class AdminMarkerController {
	
	@Resource(name = "adminMarkerService")
	private AdminMarkerService adminMarkerService;
	
	@RequestMapping(value = "adminMarker.do")
	public String adminMarker(ModelMap model, HttpServletRequest request, MarkerVO markerVO) throws Exception {
		
		markerVO.setRows(10);
		List<Map> courseList = adminMarkerService.courseList(markerVO);
		List<Map> themeList = adminMarkerService.themeList();
		EgovMap courseListCnt = adminMarkerService.courseListCnt(markerVO);
		
		// 페이징에 필요한 처리
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("page", markerVO.getPage());
		resMap.put("totalPage", courseListCnt.get("totalPage"));
		resMap.put("pageScale", markerVO.getPageScale());
		
		int pageGroup = (int) Math.ceil((double) markerVO.getPage() / markerVO.getPageScale() );
		
		long startPage = (pageGroup - 1) * markerVO.getPageScale() + 1;

		markerVO.setStartPage(startPage);
		
		resMap.put("startPage", markerVO.getStartPage());
		
		long endPage = startPage + markerVO.getPageScale() - 1;
		
		markerVO.setEndPage(endPage);
		
		resMap.put("endPage", endPage);
		
		long prePage = (pageGroup-2) * markerVO.getPageScale() + 1 + (markerVO.getPageScale()-1);
						//여기는 이전 그룹의 처음숫자 						// 여길 추가하면 이전그룹의 마지막숫자 
		
		long nextPage = pageGroup * markerVO.getPageScale() + 1;
		
		resMap.put("pageGroup", pageGroup);
		resMap.put("prePage", prePage);
		resMap.put("nextPage", nextPage);
		
		// courseDate를 YYYY-MM-DD형식으로 변형한 뒤 모델에 담아 보낸다.
		for (Map map : courseList) {
			
			String datetime = String.valueOf(map.get("courseDate"));
			
			String date = datetime.split(" ")[0];
			
			map.replace("courseDate", date);
		}
		
		model.addAttribute("courseList", courseList);
		model.addAttribute("themeList", themeList);
		model.addAttribute("resMap", resMap);

		return "adminMarker/adminMarker.atiles";
	}
	
	@RequestMapping(value = "adminMarkerDetail.do")
	public String adminMarkerDetail(HttpServletRequest request, ModelMap model) throws Exception {
		
		String courseNo = "";
		if(request.getParameter("courseNumber")!=null){
			
			courseNo = request.getParameter("courseNumber");
		} else if (request.getParameter("courseDetailNumber") != null) {
			
			courseNo = request.getParameter("courseDetailNumber");
		}
		
		List<Map> markerList = adminMarkerService.markerList(courseNo);
		
		model.addAttribute("markerList", markerList);

		return "adminMarker/adminMarkerDetail.atiles";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "adminMarkerCreate.do")
	public String adminMarkerCreate(HttpServletRequest request, ModelMap model) throws Exception {
		
		String courseNumber = request.getParameter("courseNumber");
		
		List<Map> markerList = adminMarkerService.markerList(courseNumber);


		HashMap markerType = new HashMap<String, String>();
		
		markerType.put("0", "출발지");
		markerType.put("1", "경유지1");
		markerType.put("2", "경유지2");
		markerType.put("3", "경유지3");
		markerType.put("4", "경유지4");
		markerType.put("5", "경유지5");
		markerType.put("6", "도착지");
		
		for (Map map : markerList) {
			
			if(markerType.containsKey((map.get("markerType")))) {
				
				markerType.remove(map.get("markerType"));
			}
		}
		
		
		
		model.addAttribute("markerType", markerType);
		
		System.out.println(markerType);
		
		return "adminMarker/adminMarkerCreate.atiles";
	}
	
	@RequestMapping(value = "adminMarkerMap.do")
	public String adminMarkerMap(HttpServletRequest request, ModelMap model) throws Exception {

		String markerNumber = request.getParameter("markerNumber");
		
		List<Map> markerList = adminMarkerService.markerMapList(markerNumber);
		
		model.addAttribute("markerList", markerList);
		
		return "adminMarker/adminMarkerMap.atiles";
	}
	
	@RequestMapping(value = "insertMarker.do")
	public String insertMarker(HttpServletRequest request, ModelMap model) throws Exception {
		
		HashMap<String, Object> insData = new HashMap<String, Object>();
		
		insData.put("courseNumber", request.getParameter("courseNumber"));
		insData.put("title", request.getParameter("title"));
		insData.put("type", request.getParameter("type"));
		insData.put("contents", request.getParameter("contents"));
		insData.put("lat", request.getParameter("lat"));
		insData.put("lon", request.getParameter("lon"));

		if(request.getParameter("markerNumber") != null){
			
			insData.put("markerNumber", request.getParameter("markerNumber"));
			
			adminMarkerService.updateMarker(insData);
		} else {
			
			adminMarkerService.insertMarker(insData);
			
			String courseNumber = request.getParameter("courseNumber");
			String type = request.getParameter("type");
			try {
				
				//파일업로드 -> enum으로 변경 필요함
				MultipartHttpServletRequest multi = (MultipartHttpServletRequest)request;
				
				//첨부파일의 갯수가 여러개 -> Iterator
				Iterator<String> iterator = multi.getFileNames();
				
				while(iterator.hasNext()){
					
					MultipartFile mfile = multi.getFile(iterator.next()); //해당 첨부파일 정보를 얻어온다.
					
					String temp = courseNumber + "_" + type + ".jpg";
					File file = new File(request.getSession().getServletContext().getRealPath("/")+"/images/markerImage/" + temp);

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
		}
		
		return "redirect:/adminMarkerDetail.do?courseNumber=" + request.getParameter("courseNumber");
	}
	
	@RequestMapping(value = "adminMarkerDelete.do")
	public String adminMarkerDelete(HttpServletRequest request, ModelMap model) throws Exception {
		

		Enumeration<String> attr = request.getParameterNames();
		
		while (attr.hasMoreElements()) {
			
			String attrName = (String) attr.nextElement();

			if (attrName.equals("checkbox")) {
				
				String[] values = request.getParameterValues("checkbox");

				adminMarkerService.deleteMarker(values);
			}
			
		}
		
		return "redirect:/adminMarkerDetail.do?courseNumber=" + request.getParameter("courseNum");
	}
	
}
