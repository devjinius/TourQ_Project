package egovframework.example.left.web;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.left.service.LeftService;

@Controller
public class LeftController {

	@Resource(name = "leftService")
	private LeftService leftService;
	
	@RequestMapping(value = "/menuList.do")
	public void mainMenuList(HttpServletResponse response, @RequestParam String menuId) throws Exception {
		
		List<Map> menuList = leftService.menuList(menuId);
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		out = response.getWriter();
		
		out.write(JsonUtil.ListToJson(menuList));
	}
	
	@RequestMapping(value = "/adminMenuList.do")
	public void adminMenuList(HttpServletResponse response,@RequestParam String menuId) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		List<Map> adminMenuList = leftService.adminMenuList(menuId);
		
		out = response.getWriter();
		
		out.write(JsonUtil.ListToJson(adminMenuList));
		System.out.println(adminMenuList);
	}
}