package egovframework.example.adminReservation.web;

import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.adminReservation.service.AdminReservationService;
import egovframework.example.adminReservation.service.AdminReservationVO;
import egovframework.example.cmmn.JsonUtil;
import egovframework.example.myPage.service.MyPageVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@SuppressWarnings("unused")
@Controller
public class AdminReservationController {
	
	@Resource(name = "adminReservationService")
	private AdminReservationService adminReservationService;

	/* 날짜형식 변환 구분이 D일경우 날짜, H일경우 시간까지 노출 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private List<Map> date(List<Map> listData, String gubun) {
		
		for (Map<String, Object> i : listData) {
			
			String dateTime = String.valueOf(i.get("resDate"));
			
			String date = "";
			
			if (gubun == "D") {
				
				date = dateTime.split(" ")[0];
			}
			
			i.replace("resDate", date);
		}
		
		return listData;
	}

	/* 예약현황 페이지로 이동 */
	@RequestMapping(value = "adminStatus.do")
	public String adminStatus() throws Exception {
		
		return "adminReservation/adminStatus.atiles";
	}
	
	/* 예약현황 페이지로 이동 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "adminStatusList.do")
	public void adminStatusList(HttpServletResponse response, HttpServletRequest request,
			@ModelAttribute AdminReservationVO adminReservationVO) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		
		try {
			//검색조건 VO에 저장
			adminReservationVO.setSurchSelect(request.getParameter("param"));

			List<Map> statusList = adminReservationService.selectAdminStatus(adminReservationVO);

			EgovMap statusListCnt = adminReservationService.selectAllCouseListCnt(adminReservationVO);

			resMap = (HashMap<String, Object>) paging(adminReservationVO);

			resMap.put("rows", statusList);
			resMap.put("totalPage", statusListCnt.get("totalPage"));
			resMap.put("page", adminReservationVO.getPage());
			
			
		} catch (Exception e) {
			throw e;
		}
		out = response.getWriter();
		
		out.write(JsonUtil.MapToJson(resMap));
	}

	/* 어드민 예약관리 페이지로 이동 */
	@RequestMapping(value = "adminReservation.do")
	public String adminReservation() throws Exception {
		return "adminReservation/adminReservation.atiles";
	}
	
	/* 예약관리 페이지 jqGrid 호출 및 검색 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "jqgridAdminReservationMain.do")
	public void jqgridAdminReservationMain(HttpServletResponse response, HttpServletRequest request,
			ModelMap model, @ModelAttribute AdminReservationVO adminReservationVO) throws Exception, InvocationTargetException {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		try {
			/* 그리드에서 보낸 폼 데이터 가 있을경우 Map 형식으로 파싱 */
			if (request.getParameter("resFrm") != null) {
				
				String quotZero = request.getParameter("resFrm").replaceAll("&quot;", "\"");

				/* 파싱한 데이터를 담을 맵 */
				HashMap<String, Object> castMap = new HashMap<String, Object>(JsonUtil.JsonToMap(quotZero));
				
				/* VO의 메소드들을 담음 */
		        Method[] methods = adminReservationVO.getClass().getDeclaredMethods();
				
		        try {
					for (String key : castMap.keySet()) {
						
						/* 검색을 했다면 */
						if (!(castMap.get(key).equals(""))) {
							
							String getKey = key.substring(0,1).toUpperCase();
							
							/* key의 첫글자를 대문자로 변경해서 저장 */
							getKey += key.substring(1);

							/* VO의 메서드 갯수만큼 반복한다. */
					        for (int i = 0; i < methods.length; i++) {
								
					        	/* VO메서드의 이름을 담는다. */
					        	String setVo = methods[i].getName();
					        	
					        	/* key와 동일한 이름을 가진 setter 메서드를 찾아 그 값을 VO에 저장한다. */
					        	if (setVo.equals("set" + getKey)) {
					        		
					        		methods[i].invoke(adminReservationVO, castMap.get(key));
								}
							}
						}
					}
				} catch (Exception ex) {

					throw ex;
				}
			}
		} catch (Exception e) {
			
			throw e;
		}
		
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		
		/* 첫화면(검색X)시 타는 MVC */
		try {

			List<Map> adminReservationMain = adminReservationService.adminReservationMain(adminReservationVO);
			
			EgovMap adminReservationCnt = adminReservationService.adminReservationCnt(adminReservationVO);
			
			String gubun = "D";
			
			adminReservationMain = date(adminReservationMain, gubun);
			
			resMap = (HashMap<String, Object>) paging(adminReservationVO);
			
			resMap.put("rows", adminReservationMain);
			resMap.put("page", request.getParameter("page"));
			resMap.put("totalPage", adminReservationCnt.get("totalPage"));
		} catch (Exception e) {
			
			throw e;
		}
		
		out = response.getWriter();
		
		out.write(JsonUtil.HashMapToJson(resMap));
	}

	/* 주문 상세보기를 누를경우 결제정보를 조회해오는 컨트롤러 */
	@SuppressWarnings({ "unchecked" })
	@RequestMapping(value = "/jqgridAdminReservationMore.do")
	public void jqgridAdminReservationMore(@RequestParam String param1, HttpServletResponse response) throws Exception {

		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		EgovMap orderInfo = adminReservationService.resOrderInfo(param1);
		
		String dateTime = orderInfo.get("orDate").toString();

		String date = dateTime.replaceAll("[.]0", "");
		
		orderInfo.put("orDate", date);
		
		out = response.getWriter();
		
		out.write(JsonUtil.MapToJson(orderInfo));
	}
	
	@RequestMapping(value = "jqgridAdminReservationChange.do")
	public void jqgridAdminReservationChange(@RequestParam String param1, String gubun, HttpServletResponse response) throws Exception{
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		String orderChange = adminReservationService.selectOrderCancel(param1, gubun);
		
		out = response.getWriter();
		
		out.write(JsonUtil.OneStringToJson(orderChange));
	}

	/* 어드민 예약 페이지 페이징 */
	@SuppressWarnings("rawtypes")
	private Map paging(@ModelAttribute AdminReservationVO adminReservationVO) throws Exception {
		
			HashMap<String, Object> resMap = new HashMap<String, Object>();

			int pageGroup = (int) Math.ceil((double) adminReservationVO.getPage()/adminReservationVO.getPageScale());

			long startPage = ((pageGroup - 1) * adminReservationVO.getPageScale()) + 1;
			
			adminReservationVO.setStartPage(startPage);
			
			resMap.put("startPage", startPage);
			
			long endPage = startPage + adminReservationVO.getPageScale() - 1;
			
			adminReservationVO.setEndPage(endPage);
			
			resMap.put("endPage", endPage);
			
			long prevPage = (2 - pageGroup) * adminReservationVO.getPageScale() + 1;
			long nextPage = pageGroup * adminReservationVO.getPageScale() + 1;
			long pageScale = adminReservationVO.getPageScale();
			
			resMap.put("prevPage", prevPage);
			resMap.put("nextPage", nextPage);
			resMap.put("pageGroup", pageGroup);
			resMap.put("pageScale", pageScale);
			
		return resMap;
	}
}