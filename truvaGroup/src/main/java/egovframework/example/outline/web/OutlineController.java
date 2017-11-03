package egovframework.example.outline.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.cmmn.service.CmmnVO;
import egovframework.example.outline.service.StoryService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class OutlineController {
	
	@Resource(name = "storyService")
	private StoryService storyService;
	
	@RequestMapping(value = "serviceInform.do")
	public String serviceInform() throws Exception {

		return "outline/serviceInform.tiles";
	}
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "story.do")
	public String story(ModelMap model, CmmnVO cmmnVO) throws Exception {
		
		cmmnVO.setRows(3);
		List<Map> storyList = storyService.storyListVO(cmmnVO);
		EgovMap storyListCnt = storyService.storyListCnt(cmmnVO);
		
		for (Map map : storyList) {
			
			String datetime = String.valueOf(map.get("storyDate"));
			
			String date = datetime.split(" ")[0];
			
			map.replace("storyDate", date);
		}
		
		// paging을 위한 부분
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("page", cmmnVO.getPage());
		resMap.put("totalPage", storyListCnt.get("totalPage"));
		resMap.put("pageScale", cmmnVO.getPageScale());
		
		int pageGroup = (int) Math.ceil((double) cmmnVO.getPage() / cmmnVO.getPageScale() );
		
		long startPage = (pageGroup - 1) * cmmnVO.getPageScale() + 1;

		cmmnVO.setStartPage(startPage);
		
		resMap.put("startPage", cmmnVO.getStartPage());
		
		long endPage = startPage + cmmnVO.getPageScale() - 1;
		
		cmmnVO.setEndPage(endPage);
		
		resMap.put("endPage", endPage);
		
		long prePage = (pageGroup-2) * cmmnVO.getPageScale() + 1 + (cmmnVO.getPageScale()-1);
						//여기는 이전 그룹의 처음숫자 						// 여길 추가하면 이전그룹의 마지막숫자 
		
		long nextPage = pageGroup * cmmnVO.getPageScale() + 1;
		
		resMap.put("pageGroup", pageGroup);
		resMap.put("prePage", prePage);
		resMap.put("nextPage", nextPage);
		
		model.addAttribute("storyList", storyList);
		model.addAttribute("resMap", resMap);
		
		return "outline/story.tiles";
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "storyPosting.do")
	public String storyPosting(HttpServletRequest request, ModelMap model) throws Exception {
		
		String storyNumber = request.getParameter("storyNumber");
		
		storyService.insertCount(storyNumber);

		List<Map> storyList = storyService.storyList(storyNumber);
		
		for (Map map : storyList) {
			
			String datetime = String.valueOf(map.get("storyDate"));
			
			String date = datetime.split(" ")[0];
			
			map.replace("storyDate", date);
		}
		
		if(request.getSession().getAttribute("memberSession")!=null) {
			
			Map sessionMember = (Map) request.getSession().getAttribute("memberSession");
			
			String memberNumber = (String) sessionMember.get("memberNumber");
			
			HashMap storyLikeMap = new HashMap();
			
			storyLikeMap.put("memberNumber", memberNumber);
			storyLikeMap.put("storyNumber", storyNumber);
			
			EgovMap storyLike = storyService.storyLike(storyLikeMap);
			
			if (storyLike == null) {
				storyList.get(0).put("like", "N");
			} else {
				storyList.get(0).put("like", "Y");
			}
			// 세션에 값이 없다면 wish에 모두 N을 담아 보낸다.
		} else {
			
			storyList.get(0).put("like", "N");
		}
		
		// 특수문자 처리
		String contents = (String) storyList.get(0).get("storyContents");
		contents = contents.replaceAll("&lt;", "<");
		contents = contents.replaceAll("&gt;", ">");
		contents = contents.replaceAll("&quot;", "\'");
		contents = contents.replaceAll("&nbsp;", " ");
		contents = contents.replaceAll("&amp;", "&");

		storyList.get(0).put("storyContents", contents);
		
		model.addAttribute("storyList", storyList);
		
		return "outline/storyPosting.tiles";
	}

	@RequestMapping(value = "storyLikeID.do")
	public void storyLikeID(HttpServletRequest request) throws Exception {
		
		try {
			
			// 세션에서 memberNumber를 받아온다.
			Map sessionMember = (Map) request.getSession().getAttribute("memberSession");
			
			String memberNumber = (String) sessionMember.get("memberNumber");
			
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			
			// insert할 값들을 넣어준다.
			paramMap.put("memberNumber", memberNumber);
			paramMap.put("gubun", request.getParameter("gubun"));
			paramMap.put("storyNumber", request.getParameter("storyNumber"));
			
			storyService.storyLikeID(paramMap);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}	
}
