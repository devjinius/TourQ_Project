package egovframework.example.footer.web;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.footer.service.FooterService;
import egovframework.example.left.service.LeftService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class FooterController {

	@Resource(name = "footerService")
	private FooterService footerService;
	
	@RequestMapping(value = "/footerStory.do")
	public void footerStory(HttpServletResponse response) throws Exception {
		
		EgovMap storyRecent = footerService.storyRecent();
		EgovMap reviewRecent = footerService.reviewRecent();
		
		List<Map> resList = new ArrayList<Map>();
		
		resList.add(storyRecent);
		resList.add(reviewRecent);
		System.out.println(resList);
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		out = response.getWriter();
		
		
		out.write(JsonUtil.ListToJson(resList));
	}
	
}