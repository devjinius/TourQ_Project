package egovframework.example.adminMemberInfo.web;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.example.adminMemberInfo.service.AdminMemberInfoService;
import egovframework.example.adminMemberInfo.service.AdminMemberVO;
import egovframework.example.cmmn.JsonUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Controller
public class AdminMemberInfoController {
	
	@Resource(name="adminMemberInfoService")
	private AdminMemberInfoService adminMemberInfoService;
	
	@RequestMapping(value = "adminMemberInfo.do")
	public String adminMemberInfo() throws Exception {
		
		return "adminMemberInfo/adminMemberInfo.atiles";
	}
	
	@RequestMapping(value = "adminMemberGrid.do")
	public void adminMemberGrid(HttpServletRequest request, HttpServletResponse response, @ModelAttribute AdminMemberVO adminMemberVO, ModelMap model) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		String quotZero = request.getParameter("param");
		
		quotZero = quotZero.replaceAll("&quot;", "\"");
		
		Map<String, Object> castMap = new HashMap<String, Object>();
		
		castMap = JsonUtil.JsonToMap(quotZero);
		
		adminMemberVO.setSearchId((String) castMap.get("searchId"));
		
		List<EgovMap> jqGridList = adminMemberInfoService.selectJqgridList(adminMemberVO);
		
		for (EgovMap memberList : jqGridList) {
			
			String str = memberList.get("memberHpf") + "-" + memberList.get("memberHpm") + "-" + memberList.get("memberHpl"); 
			String date = String.valueOf(memberList.get("memberRegdate")).split(" ")[0];
			
			memberList.put("memberHp", str);
			memberList.put("memberDate", date);

			if (memberList.get("adminYn").equals("Y")) {
				
				memberList.put("adminType", "관리자");
			} else {
				
				memberList.put("adminType", "일반");
			}
		}
		
		EgovMap jqGridListCnt = adminMemberInfoService.selectJqgridListCnt(adminMemberVO);
		
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		
		resMap.put("records", jqGridListCnt.get("totaltotcnt"));
		resMap.put("rows", jqGridList);
		resMap.put("page", request.getParameter("page"));
		resMap.put("total", jqGridListCnt.get("totalpage"));
		
		out = response.getWriter();
		
		out.write(JsonUtil.HashMapToJson(resMap).toString());
	}
	
	
	@RequestMapping(value = "addRowPoint.do")
	public void addRowPoint(HttpServletResponse response,HttpServletRequest request, ModelMap model) throws Exception {
			
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		String quotZero = request.getParameter("param");
	
		quotZero = quotZero.replaceAll("&quot;", "\"");
		
		Map<String, Object> castMap = new HashMap<String, Object>();
		
		castMap = JsonUtil.JsonToMap(quotZero);
		
		out = response.getWriter();
		try {
			adminMemberInfoService.addRow(castMap);
		} catch (Exception e) {
			System.out.println("point insert 오류입니다.");
			
			
			out.write("FAIL");
		}
		out.write("SUCCESS");
		
		
	}
	

}
