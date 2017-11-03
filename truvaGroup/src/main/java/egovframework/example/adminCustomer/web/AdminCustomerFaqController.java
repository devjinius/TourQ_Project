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
public class AdminCustomerFaqController {

	@Resource(name = "adminCustomerService")
	private AdminCustomerService adminCustomerService;
	
	@RequestMapping(value = "adminFaq.do")
	public String adminFAQ(HttpServletRequest request ,HttpServletResponse response, @ModelAttribute AdCustomJqgridVo adCustomJqgridVo, ModelMap model) throws Exception {  
		
		return "adminCustomer/adminFAQ.atiles";
	}
	
	@RequestMapping(value = "adminFaqCreate.do")
	public String adminFaqCreate() throws Exception {  
		
		return "adminCustomer/adminFAQCreate.atiles";
	}
	
	@RequestMapping(value = "adminJqFaq.do")
	public void adminJqFaq(HttpServletRequest request ,HttpServletResponse response, @ModelAttribute AdCustomJqgridVo adCustomJqgridVo, ModelMap model) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		String quotZero = request.getParameter("param");
		
		quotZero = quotZero.replaceAll("&quot;", "\"");
		
		Map<String, Object> castMap = new HashMap<String, Object>();
		
		castMap = JsonUtil.JsonToMap(quotZero);
		
		adCustomJqgridVo.setSearchSelect((String) castMap.get("searchSelect"));
		adCustomJqgridVo.setSearchText((String) castMap.get("searchText"));
		
		List<EgovMap> jqGridList = adminCustomerService.selectJqFaqList(adCustomJqgridVo);
		EgovMap jqGridListCnt = adminCustomerService.selectJqFaqListCnt(adCustomJqgridVo);
		
		modifyDate(jqGridList, "faqDate");
		
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

	@RequestMapping(value = "adminFaqDetail.do")
	public String adminFaqDetail(@RequestParam String faqNumber, ModelMap model, HttpServletRequest request) throws Exception {  
		
		EgovMap faqDetail = adminCustomerService.faqDetail(faqNumber);
		
		model.addAttribute("faqDetail", faqDetail);
		
		return "adminCustomer/adminFAQDetail.atiles";
	}
	
	@RequestMapping(value = "faqIU.do")
	public void faqIU(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {  
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		String quotZero = request.getParameter("param");
		
		quotZero = quotZero.replaceAll("&quot;", "\'");
		
		Map<String, Object> castMap = new HashMap<String, Object>();
		
		castMap = JsonUtil.JsonToMap(quotZero);

		out = response.getWriter();
		
		try {
			adminCustomerService.faqIU(castMap);
		} catch (Exception e) {
			
			out.write("FAIL");
		}
		
		out.write("SUCCESS");
	}
	
	@RequestMapping(value = "deleteFaq.do")
	public @ResponseBody String deleteFaq(@RequestParam String param) throws Exception {
		
		String result = "";
		
		try{
			param = param.replaceAll("&quot;", "\"");
			
			JSONArray jsonArray = new JSONArray(param);

			adminCustomerService.deleteFaq(jsonArray);
			
			result ="SUCCESS";
			
		} catch(Exception e) {
			
			result ="FAIL";
			
		}
		
		return result;
	}
}
