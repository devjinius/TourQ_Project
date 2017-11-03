	package egovframework.example.adminCustomer.web;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.adminCustomer.service.AdCustomJqgridVo;
import egovframework.example.adminCustomer.service.AdminCustomerService;
import egovframework.example.cmmn.JsonUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class AdminCustomerAskController {

	@Resource(name = "adminCustomerService")
	private AdminCustomerService adminCustomerService;
	
	@RequestMapping(value = "adminAsk.do")
	public String adminManToMan() throws Exception {  
		
		return "adminCustomer/adminAsk.atiles";
	}
	
	@SuppressWarnings("unchecked")
	private static List<EgovMap> modifyDate(List<EgovMap> listMap, String condition) {
		
		for (Map map : listMap) {
			
			String datetime = String.valueOf(map.get(condition));
			
			String date = datetime.split(" ")[0];
			
			map.replace(condition, date);
		}
		
		return listMap;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "adminAskN.do")
	public String adminAskN(HttpServletRequest request, ModelMap model,@RequestParam String memberNumber, @RequestParam String askNumber) throws Exception {  
		
//		memberInfo 출력
		EgovMap memberInfo = adminCustomerService.memberInfo(memberNumber);
		
		String str = (String) memberInfo.get("memberHpf") + "-" + memberInfo.get("memberHpm") + "-" + memberInfo.get("memberHpl");
		modifyDate(memberInfo, "memberRegdate");
		memberInfo.put("memberHp", str);
		
//		문의내용 출력
		EgovMap askInfo = adminCustomerService.askInfo(askNumber);
		
		modifyDate(askInfo, "askDate");
		String orgStr = (String) askInfo.get("askContent");
		String repStr = orgStr.replaceAll("\r\n", "<br>");
		askInfo.replace("askContent", repStr);
		
		model.addAttribute("memberInfo", memberInfo);
		model.addAttribute("askInfo", askInfo);
		
		return "adminCustomer/adminAskN.atiles";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "adminAskY.do")
	public String adminAskY(HttpServletRequest request, ModelMap model,@RequestParam String memberNumber, @RequestParam String askNumber) throws Exception {  
		
//		memberInfo 출력
		EgovMap memberInfo = adminCustomerService.memberInfo(memberNumber);
		
		String str = (String) memberInfo.get("memberHpf") + "-" + memberInfo.get("memberHpm") + "-" + memberInfo.get("memberHpl");
		modifyDate(memberInfo, "memberRegdate");
		memberInfo.put("memberHp", str);
		
//		문의내용 출력
		EgovMap askInfo = adminCustomerService.askInfo(askNumber);
		
		modifyDate(askInfo, "askDate");
		String orgStr = (String) askInfo.get("askContent");
		String repStr = orgStr.replaceAll("\r\n", "<br>");
		askInfo.replace("askContent", repStr);
		
//		답변내용 출력
		EgovMap answerInfo = adminCustomerService.answerInfo(askNumber);

		modifyDate(answerInfo, "answerDate");
		
		String contents = (String) answerInfo.get("answerContent");
		contents = contents.replaceAll("&lt;", "<");
		contents = contents.replaceAll("&gt;", ">");
		contents = contents.replaceAll("&quot;", "\'");
		contents = contents.replaceAll("&nbsp;", " ");
		contents = contents.replaceAll("&amp;", "&");
		contents = contents.replaceAll("\r", "");
		contents = contents.replaceAll("\n", "");
		contents = contents.replaceAll("(\r\n|\r|\n|\n\r)", " ");
		
		answerInfo.put("answerContent", contents);
		
		model.addAttribute("memberInfo", memberInfo);
		model.addAttribute("askInfo", askInfo);
		model.addAttribute("answerInfo", answerInfo);
		
		return "adminCustomer/adminAskY.atiles";
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private static Map modifyDate(Map map, String parsingStr) {
		
		String datetime = String.valueOf(map.get(parsingStr));
		
		String date = datetime.split(" ")[0];
		
		map.replace(parsingStr, date);
		
		return map;
	}
	
	@RequestMapping(value = "adminJqAsk.do")
	public void adminJqAsk(HttpServletRequest request ,HttpServletResponse response, @ModelAttribute AdCustomJqgridVo adCustomJqgridVo, ModelMap model) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		String quotZero = request.getParameter("param");
		
		quotZero = quotZero.replaceAll("&quot;", "\"");
		
		Map<String, Object> castMap = new HashMap<String, Object>();
		
		castMap = JsonUtil.JsonToMap(quotZero);
		
		adCustomJqgridVo.setSearchSelect((String) castMap.get("searchSelect"));
		adCustomJqgridVo.setSearchText((String) castMap.get("searchText"));
		adCustomJqgridVo.setMemberNumber(((String) castMap.get("memberNumber")));
		
		List<EgovMap> jqGridList = adminCustomerService.selectJqAskList(adCustomJqgridVo);
		
		modifyDate(jqGridList, "askDate");
		EgovMap jqGridListCnt = adminCustomerService.selectJqAskListCnt(adCustomJqgridVo);
		
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		
		resMap.put("records", jqGridListCnt.get("totaltotcnt"));
		resMap.put("rows", jqGridList);
		resMap.put("page", request.getParameter("page"));
		resMap.put("total", jqGridListCnt.get("totalpage"));
		
		out = response.getWriter();
		
		out.write(JsonUtil.HashMapToJson(resMap).toString());
	}
	
	@RequestMapping(value = "answerIU.do")
	public void answerIU(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {  
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		String quotZero = request.getParameter("param");
		
		quotZero = quotZero.replaceAll("&quot;", "\'");

		Map<String, Object> castMap = new HashMap<String, Object>();
		
		castMap = JsonUtil.JsonToMap(quotZero);
		
		out = response.getWriter();
		
		try {
			adminCustomerService.answerIU(castMap);
		} catch (Exception e) {

			out.write("FAIL");
		}
		
//		답변내용 출력
		EgovMap answerInfo = adminCustomerService.answerInfo((String) castMap.get("askNumber"));

		modifyDate(answerInfo, "answerDate");
		
		String returnStr = (String) answerInfo.get("answerDate");
		out.write("SUCCESS " + returnStr);
	}
	
}
