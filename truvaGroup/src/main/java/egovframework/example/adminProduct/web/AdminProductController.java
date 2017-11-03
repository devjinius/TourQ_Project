package egovframework.example.adminProduct.web;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.adminProduct.service.AdminProductService;
import egovframework.example.adminProduct.service.AdminProductVO;
import egovframework.example.cmmn.JsonUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class AdminProductController {
	
	@Resource(name = "adminProductService")
	private AdminProductService adminProductService;
	
	/* 메뉴이동시 코스리스트를 뿌려줌 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "adminProduct.do")
	public String adminProduct(ModelMap model) throws Exception {
		
		List<Map> getCosList = adminProductService.selectGetCosList();
		
		model.addAttribute("getCosList", getCosList);
		
		return "adminProduct/adminProduct.atiles";
	}
	
	/* 메인 그리드 실행 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "jqgridAdminProMain.do")
	public void jqgridAdminProMain(HttpServletRequest request, HttpServletResponse response,
			ModelMap model, @ModelAttribute AdminProductVO adminProductVO) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		Map<String, Object> resMap = new HashMap<String, Object>();

		try {
			// 검색조건 설정
			adminProductVO.setCouseNumber(request.getParameter("param"));
			
			List<Map> prodGrid = adminProductService.jqgridAdminProList(adminProductVO);
			
			EgovMap adminProdCnt = adminProductService.selectAdminProdCnt(adminProductVO);
			
			try {
				
				/* 날짜 및 시간 스트링으로 변경 */
				for (Map i : prodGrid) {
					
					String startDate = i.get("departureDay").toString().replaceAll("[.]0", "");
					String dateTime = i.get("departureTime").toString().replaceAll("[:]00[.]0", "");
					
					startDate = startDate.split(" ")[0];
					dateTime = dateTime.split(" ")[1];
					
					i.put("departureDay", startDate);
					i.put("departureTime", dateTime);
				}
			} catch (Exception e) {
			}
			
			resMap = paging(adminProductVO);

			resMap.put("rows", prodGrid);
			resMap.put("page", request.getParameter("page"));
			resMap.put("totalPage", adminProdCnt.get("totalPage"));
			
		} catch (Exception e) {

			throw e;
		}
		
		out = response.getWriter();
		
		out.write(JsonUtil.MapToJson(resMap));
	}
	
	/* 상품등록 */
	@RequestMapping(value = "adminNewProduct.do")
	public @ResponseBody String adminNewProduct(HttpServletRequest request, @RequestParam String param1,
			@ModelAttribute AdminProductVO adminProductVO) throws Exception{
		
		String result = "";
		
		String quotZero = param1.replaceAll("&quot;", "\"");
		
		try {
			
			if (request.getParameter("gubun").equals("I")) {

				Map<String, Object> castMap = new HashMap<String, Object>(JsonUtil.JsonToMap(quotZero));
				
				castMap.put("gubun", request.getParameter("select"));

				/* 코스넘버를 가져온다 */
				EgovMap courseNumber = new EgovMap();
				
				try {
					
					courseNumber = adminProductService.selectGetCosNum(castMap);
				} catch (Exception e) {
					
					throw e;
				}
				
				castMap.put("courseNumber", courseNumber.get("courseNumber"));
				
				adminProductService.saveAdminProduct(castMap);

				result = "SUCCESS";
			} else {
				
				adminProductService.deletAdminProduct(quotZero);
				
				result = "SUCCESS";
			}
		} catch (Exception e) {

			result = "FALL";
		}
		
		return result;
	}
	
	/* 상품 생성시 코스에 해당하는 출발시간 가져오기 */
	@RequestMapping(value = "adminProductGetTime.do")
	public void adminProductGetTime(@RequestParam String param1, HttpServletResponse response,
			HttpServletRequest request) throws Exception {

		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		String quotZero = param1.replaceAll("&quot;", "");
		
		String[] getTime = null;

		Map<String, Object> selectData = new HashMap<String, Object>();
		
		try {
			Map<String, Object> resMap = new HashMap<String, Object>();
			
			resMap.put("courseName", quotZero);
			resMap.put("courseGubun", request.getParameter("gubun"));
			
			try {
				EgovMap getTimeList = adminProductService.selectGetTime(resMap);
				
				getTime = getTimeList.get("courseStartTime").toString().split("[_]");
			} catch (Exception e) {
				throw e;
			}
			
			try {
				if (request.getParameter("gubun").equals("버스")) {
					
					EgovMap getTotal = adminProductService.selectGetTotal(resMap);

					selectData.put("busSitcount", getTotal.get("busSitcount"));
				}
			} catch (Exception e) {
				throw e;
			}
		} catch (Exception e) {
			throw e;
		}
		
		JSONArray getTimes = new JSONArray(getTime);
		
		selectData.put("getTimes", getTimes.toString());
		
		out = response.getWriter();
		
		out.write(JsonUtil.MapToJson(selectData));
	}
	
	@RequestMapping(value = "prodShowSeat.do")
	public void prodShowSeat(@RequestParam String param1, HttpServletResponse response) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		EgovMap getBusSeat = adminProductService.selectGetBusSeat(param1);
		
		out = response.getWriter();
		
		out.write(JsonUtil.MapToJson(getBusSeat));
	}
	
	/* 어드민 프로덕트 페이지 페이징 */
	@SuppressWarnings({ "rawtypes" })
	private Map paging(@ModelAttribute AdminProductVO adminProductVO) throws Exception {
		
			HashMap<String, Object> resMap = new HashMap<String, Object>();

			int pageGroup = (int) Math.ceil((double) adminProductVO.getPage()/adminProductVO.getPageScale());

			long startPage = ((pageGroup - 1) * adminProductVO.getPageScale()) + 1;
			
			adminProductVO.setStartPage(startPage);
			
			resMap.put("startPage", startPage);
			
			long endPage = startPage + adminProductVO.getPageScale() - 1;
			
			adminProductVO.setEndPage(endPage);
			
			resMap.put("endPage", endPage);
			
			long prevPage = (2 - pageGroup) * adminProductVO.getPageScale() + 1;
			long nextPage = pageGroup * adminProductVO.getPageScale() + 1;
			long pageScale = adminProductVO.getPageScale();
			
			resMap.put("prevPage", prevPage);
			resMap.put("nextPage", nextPage);
			resMap.put("pageGroup", pageGroup);
			resMap.put("pageScale", pageScale);
			
		return resMap;
	}
}