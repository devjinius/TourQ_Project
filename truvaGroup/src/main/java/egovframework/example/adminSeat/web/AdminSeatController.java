package egovframework.example.adminSeat.web;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.adminSeat.service.AdminSeatService;
import egovframework.example.adminSeat.service.AdminSeatVO;
import egovframework.example.cmmn.JsonUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class AdminSeatController {
	
	@Resource(name = "adminSeatService")
	private AdminSeatService adminSeatService;
	
	@RequestMapping(value = "adminSeat.do")
	public String adminSeat() throws Exception {
		return "adminSeat/adminSeat.atiles";
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "adminSeatGrid.do")
	private void adminSeatGrid(@ModelAttribute AdminSeatVO adminSeatVO, HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");

		Map<String, Object> resMap = new HashMap<String, Object>();
		
		try {

			List<Map> adminSeat = adminSeatService.selectAdminSeat(adminSeatVO);
			
			EgovMap adminSeatCnt = adminSeatService.selectAdminSeatCnt(adminSeatVO);
			
			
			resMap = paging(adminSeatVO);
			
			resMap.put("rows", adminSeat);
			resMap.put("totalPage", adminSeatCnt.get("totalPage"));
			resMap.put("page", request.getParameter("page"));
			
			System.out.println(adminSeatCnt.get("totalPage"));
			
			
		} catch (Exception e) {
			throw e;
		}
		
		out = response.getWriter();
		
		out.write(JsonUtil.MapToJson(resMap));
	}
	
	/* 버스정보 저장하는 컨트롤러 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "seatSave.do")
	public void seatSave(@RequestParam String param, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		String quotZero = param.replaceAll("&quot;", "\"");
		
		List<Map<String, Object>> castList = new ArrayList<Map<String, Object>>();
		
		castList = JsonUtil.JsonToList(quotZero);
		
		String result = "";
		
		char rowNum = 'A';
		
		/* 전체 좌석정보가 담기는 List */
		List<Map> seat = new ArrayList<Map>();
		
		try {
			for (int i = 0; i < castList.size(); i++) {
				
				String[] seatLeft = castList.get(i).get("seatLeft").toString().split(",");
				
				/* 실수를 정수로 변경 */
				int seatTop = (int) Float.parseFloat(castList.get(i).get("seatTop").toString());

				rowNum = (char) (rowNum + i);
				
				for (int j = 0; j < seatLeft.length; j++) {
					
					HashMap<String, Object> seatInfo = new HashMap<String, Object>();
					
					seatInfo.put("rowNum", rowNum);
					seatInfo.put("seatTop", seatTop);
					seatInfo.put("seatLeft", seatLeft[j]);
					seatInfo.put("seatNum", rowNum + "0" + (j + 1));

					seat.add(seatInfo);
				}
				rowNum = 'A';
			}

			/* 생성한 버스의 정보가 모두 담길 Map */
			HashMap<String, Object> busInfo = new HashMap<String, Object>();
			
			try {
				busInfo.put("seat", JsonUtil.ListToJson(seat));	// 좌석정보
				busInfo.put("selectBus", request.getParameter("selectBus"));	// 버스종류
				busInfo.put("busName", request.getParameter("busName"));	// 버스이름
				busInfo.put("totalSeat", request.getParameter("totalSeat"));	// 총 좌석수
				
				adminSeatService.adminSeatSave(busInfo);
			} catch (Exception e) {
				result = "FALL";
				
				throw e;
			}
			result = "SUCESS";
		} catch (Exception e) {
			result = "FALL";
			
			throw e;
		}
		
		out = response.getWriter();
		
		out.write(result);
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "getSeatData.do")
	public void getSeatData(@RequestParam String param, HttpServletResponse response) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		EgovMap seatData = adminSeatService.getSeatData(param);
		
		out = response.getWriter();
		
		out.write(JsonUtil.MapToJson(seatData));
	}
	
	/* 어드민 페이지 페이징 */
	@SuppressWarnings("rawtypes")
	private Map paging(@ModelAttribute AdminSeatVO adminSeatVO) throws Exception {
		
			HashMap<String, Object> resMap = new HashMap<String, Object>();

			int pageGroup = (int) Math.ceil((double) adminSeatVO.getPage()/adminSeatVO.getPageScale());

			long startPage = ((pageGroup - 1) * adminSeatVO.getPageScale()) + 1;
			
			adminSeatVO.setStartPage(startPage);
			
			resMap.put("startPage", startPage);
			
			long endPage = startPage + adminSeatVO.getPageScale() - 1;
			
			adminSeatVO.setEndPage(endPage);
			
			resMap.put("endPage", endPage);
			
			long prevPage = (2 - pageGroup) * adminSeatVO.getPageScale() + 1;
			long nextPage = pageGroup * adminSeatVO.getPageScale() + 1;
			long pageScale = adminSeatVO.getPageScale();
			
			resMap.put("prevPage", prevPage);
			resMap.put("nextPage", nextPage);
			resMap.put("pageGroup", pageGroup);
			resMap.put("pageScale", pageScale);
			
		return resMap;
	}
}
