package egovframework.example.adminStory.web;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import sun.util.resources.CalendarData;
import egovframework.example.adminCourse.service.CourseVo;
import egovframework.example.adminStory.service.AdminStoryService;
import egovframework.example.adminStory.service.StoryVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class AdminStoryController {
	
	@Resource(name = "adminStoryService")
	private AdminStoryService adminStoryService;
	
	@RequestMapping(value = "adminStory.do")
	public String adminStory(ModelMap model, HttpServletRequest request, StoryVO storyVO) throws Exception {
		
		storyVO.setRows(7);
		List<Map> storyList = adminStoryService.storyList(storyVO);
		EgovMap storyListCnt = adminStoryService.storyListCnt(storyVO);
		
		// 페이징에 필요한 처리
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("page", storyVO.getPage());
		resMap.put("totalPage", storyListCnt.get("totalPage"));
		resMap.put("pageScale", storyVO.getPageScale());
		
		int pageGroup = (int) Math.ceil((double) storyVO.getPage() / storyVO.getPageScale() );
		
		long startPage = (pageGroup - 1) * storyVO.getPageScale() + 1;

		storyVO.setStartPage(startPage);
		
		resMap.put("startPage", storyVO.getStartPage());
		
		long endPage = startPage + storyVO.getPageScale() - 1;
		
		storyVO.setEndPage(endPage);
		
		resMap.put("endPage", endPage);
		
		long prePage = (pageGroup-2) * storyVO.getPageScale() + 1 + (storyVO.getPageScale()-1);
						//여기는 이전 그룹의 처음숫자 						// 여길 추가하면 이전그룹의 마지막숫자 
		
		long nextPage = pageGroup * storyVO.getPageScale() + 1;
		
		resMap.put("pageGroup", pageGroup);
		resMap.put("prePage", prePage);
		resMap.put("nextPage", nextPage);
		
		modifyDate(storyList);
		
		model.addAttribute("storyList", storyList);
		model.addAttribute("storyListCnt", storyListCnt);
		model.addAttribute("resMap", resMap);
		
		return "adminStory/adminStory.atiles";
	}
	
	// Date를 YYYY-MM-DD형식으로 변형하는 메서드
	@SuppressWarnings("unchecked")
	private List<Map> modifyDate(List<Map> storyList) {
		
		for (Map map : storyList) {
			
			String datetime = String.valueOf(map.get("storyDate"));
			
			String date = datetime.split(" ")[0];
			
			map.replace("storyDate", date);
		}
		
		return storyList;
	}
		
	@RequestMapping(value = "adminStoryDetail.do")
	public String adminStoryDetail(HttpServletRequest request, ModelMap model) throws Exception {
		
		String storyNumber = request.getParameter("storyNumber");
		
		EgovMap storyContents = adminStoryService.storyContents(storyNumber);
		
		String contents = (String) storyContents.get("storyContents");
		contents = contents.replaceAll("&lt;", "<");
		contents = contents.replaceAll("&gt;", ">");
		contents = contents.replaceAll("&quot;", "\'");
		contents = contents.replaceAll("&nbsp;", " ");
		contents = contents.replaceAll("\"", "\'");
		contents = contents.replaceAll("&amp;", "&");
		
		storyContents.put("storyContents", contents);
		
		model.addAttribute("storyCon", storyContents);
		
		return "adminStory/adminStoryDetail.atiles";
	}
	
	@RequestMapping(value = "adminStoryCreate.do")
	public String adminStoryCreate() throws Exception {
		
		return "adminStory/adminStoryCreate.atiles";
	}
	
	@RequestMapping(value = "adminStoryIUD.do")
	public String adminStoryIUD(HttpServletRequest request, ModelMap model) throws Exception {
		
		System.out.println(request.getParameter("storyNumber"));
		
		Map<String, Object> valueMap = new HashMap<String, Object>();

		valueMap.put("title", request.getParameter("title"));
		valueMap.put("subtitle", request.getParameter("subtitle"));
		valueMap.put("contents", request.getParameter("contents"));
		valueMap.put("storyNumber", request.getParameter("storyNumber"));

		try {
			
			adminStoryService.storyIUD(valueMap);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		
		if(request.getParameter("storyNumber").equals("N")) {
			
//			storyNumber 새로 가져오고
			
			EgovMap storyNumberMap = adminStoryService.selectStoryNumber();
			
			String storyNumber = String.valueOf(storyNumberMap.get("storyNumber"));
			
			try {
				
				//파일업로드 -> enum으로 변경 필요함
				MultipartHttpServletRequest multi = (MultipartHttpServletRequest)request;
				
				//첨부파일의 갯수가 여러개 -> Iterator
				Iterator<String> iterator = multi.getFileNames();
				
				while(iterator.hasNext()){
					
					MultipartFile mfile = multi.getFile(iterator.next()); //해당 첨부파일 정보를 얻어온다.
					
					String temp = "story_" + storyNumber+ ".jpg";
					File file = new File(request.getSession().getServletContext().getRealPath("/")+"/images/uploads/blog/" + temp);

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
		
		return "redirect:/adminStory.do";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "adminStoryDelete.do")
	public String adminStoryDelete(HttpServletRequest request) throws Exception {
		
		Enumeration<String> attr = request.getParameterNames();
		
		while (attr.hasMoreElements()) {
			
			String attrName = (String) attr.nextElement();

			if (attrName.equals("checkbox")) {
				
				String[] values = request.getParameterValues("checkbox");
				
				adminStoryService.deleteCourse(values);
			}
			
		}
		
		return "redirect:/adminStory.do";
	}

}
