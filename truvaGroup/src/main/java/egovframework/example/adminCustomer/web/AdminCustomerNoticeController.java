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
public class AdminCustomerNoticeController {

	@Resource(name = "adminCustomerService")
	private AdminCustomerService adminCustomerService;
	
	@RequestMapping(value = "adminNotice.do")
	public String adminNotice(ModelMap model, HttpServletRequest request) throws Exception {  
		
		return "adminCustomer/adminNotice.atiles";
	}
	
	@RequestMapping(value = "adminNoticeDetail.do")
	public String adminNoticeDetail(@RequestParam String noticeNumber, ModelMap model, HttpServletRequest request) throws Exception {  

		EgovMap noticeDetail = adminCustomerService.noticeDetail(noticeNumber);
		
		String contents = (String) noticeDetail.get("boardContent");
		contents = contents.replaceAll("&lt;", "<");
		contents = contents.replaceAll("&gt;", ">");
		contents = contents.replaceAll("&quot;", "\'");
		contents = contents.replaceAll("&nbsp;", " ");
		contents = contents.replaceAll("&amp;", "&");
		
		noticeDetail.put("boardContent", contents);

		model.addAttribute("noticeDetail", noticeDetail);
		
		return "adminCustomer/adminNoticeDetail.atiles";
	}
	
	@RequestMapping(value = "noticeIU.do")
	public void noticeIU(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {  
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		String quotZero = request.getParameter("param");
		
		quotZero = quotZero.replaceAll("&quot;", "\'");

		Map<String, Object> castMap = new HashMap<String, Object>();
		
		castMap = JsonUtil.JsonToMap(quotZero);
		
		out = response.getWriter();
		
		try {
			adminCustomerService.noticeIU(castMap);
		} catch (Exception e) {

			out.write("FAIL");
		}
		
		out.write("SUCCESS");
	}

	@RequestMapping(value = "adminJqNotice.do")
	public void adminJqNotice(HttpServletRequest request ,HttpServletResponse response, @ModelAttribute AdCustomJqgridVo adCustomJqgridVo, ModelMap model) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		String quotZero = request.getParameter("param");
		
		quotZero = quotZero.replaceAll("&quot;", "\"");
		
		Map<String, Object> castMap = new HashMap<String, Object>();
		
		castMap = JsonUtil.JsonToMap(quotZero);
		
		adCustomJqgridVo.setSearchSelect((String) castMap.get("searchSelect"));
		adCustomJqgridVo.setSearchText((String) castMap.get("searchText"));
		
		List<EgovMap> jqGridList = adminCustomerService.selectJqNoticeList(adCustomJqgridVo);
		EgovMap jqGridListCnt = adminCustomerService.selectJqNoticeListCnt(adCustomJqgridVo);
		
		modifyDate(jqGridList, "boardDate");
		
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		
		resMap.put("records", jqGridListCnt.get("totaltotcnt"));
		resMap.put("rows", jqGridList);
		resMap.put("page", request.getParameter("page"));
		resMap.put("total", jqGridListCnt.get("totalpage"));
		
		out = response.getWriter();
		
		out.write(JsonUtil.HashMapToJson(resMap).toString());
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

	@RequestMapping(value = "deleteNotice.do")
	public @ResponseBody String deleteNotice(@RequestParam String param) throws Exception {
		
		String result = "";
		
		try{
			param = param.replaceAll("&quot;", "\"");
			
			JSONArray jsonArray = new JSONArray(param);
			
			adminCustomerService.deleteNotice(jsonArray);
			
			result ="SUCCESS";
			
		} catch(Exception e) {
			
			result ="FAIL";
			
		}
		
		return result;
	}

	@RequestMapping(value = "adminNoticeCreate.do")
	public String adminNoticeCreate() throws Exception {  
		
		return "adminCustomer/adminNoticeCreate.atiles";
	}
	
}
