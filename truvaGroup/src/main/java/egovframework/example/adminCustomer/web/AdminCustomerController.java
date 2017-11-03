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
public class AdminCustomerController {

	@Resource(name = "adminCustomerService")
	private AdminCustomerService adminCustomerService;

	@RequestMapping(value = "couponCreate.do")
	public String couponCreate() throws Exception {  
		return "adminCustomer/couponCreate.atiles";
	}
	
	@RequestMapping(value = "adminCoupon.do")
	public String adminCoupon(HttpServletRequest request ,HttpServletResponse response, @ModelAttribute AdCustomJqgridVo adCustomJqgridVo, ModelMap model) throws Exception {  
		
//		List<Map> adCouponList = adminCustomerService.selectadCouponList();
//		
//		System.out.println("adCouponList:"+adCouponList);
//		model.addAttribute("adCouponList", adCouponList);
		
		return "adminCustomer/adminCoupon.atiles";
	}
	
	@RequestMapping(value = "adminCouponDetail.do")
	public String adminCouponDetail(@RequestParam String number, HttpServletRequest request ,HttpServletResponse response, @ModelAttribute AdCustomJqgridVo adCustomJqgridVo, ModelMap model) throws Exception {  
		
//		List<Map> adminCouponDetail = adminCustomerService.selectadminCouponDetail(number);
//		
//	//	List<Map> adminCouponDetail = adminCustomerService.updateadminCouponDetail();
//		
//		
//		System.out.println("adminCouponDetail"+adminCouponDetail);
//		model.addAttribute("adminCouponDetail", adminCouponDetail);
		
		
		return "adminCustomer/adminCouponDetail.atiles";
	}
	
	@RequestMapping(value = "adminJqCoupon.do")
	public void adminJqNotice(HttpServletRequest request ,HttpServletResponse response, @ModelAttribute AdCustomJqgridVo adCustomJqgridVo, ModelMap model) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		String quotZero = request.getParameter("param");
		
		quotZero = quotZero.replaceAll("&quot;", "\"");
		
		Map<String, Object> castMap = new HashMap<String, Object>();
		
		castMap = JsonUtil.JsonToMap(quotZero);
		
//		adCustomJqgridVo.setSearchSelect((String) castMap.get("searchSelect"));
//		adCustomJqgridVo.setSearchText((String) castMap.get("searchText"));
		
		List<EgovMap> jqGridList = adminCustomerService.selectJqCouponList(adCustomJqgridVo);
		EgovMap jqGridListCnt = adminCustomerService.selectJqCouponListCnt(adCustomJqgridVo);
		
		modifyDate(jqGridList, "couponDate");
		
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
	
	@RequestMapping(value = "saveJqCoupon.do")
	public @ResponseBody String saveJqgrid(@RequestParam String param1) throws Exception {
		
		String result = "";
		
		try {
			param1 = param1.replaceAll("&quot;", "\"");
			
			JSONArray jsonArray = new JSONArray(param1);
			
			adminCustomerService.saveJqgridTx(jsonArray);
			
			result = "SUCCESS";
			
		} catch (Exception e) {
			result = "FAIL";
		}
		
		return result;
		
	}
	
	@RequestMapping(value = "adminCouponState.do")
	public String adminCouponState() throws Exception {  
		return "adminCustomer/adminCouponState.atiles";
	}
	
}
