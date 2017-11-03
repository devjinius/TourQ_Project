package egovframework.example.adminPay.web;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.example.adminPay.service.AdminPayService;
import egovframework.example.adminPay.service.AdminPayVO;
import egovframework.example.cmmn.JsonUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class AdminPayController {
	
	@Resource(name = "adminPayService")
	private AdminPayService adminPayService;
	
	@RequestMapping(value = "adminPay.do")
	public String adminPay() throws Exception {
		return "adminPay/adminPay.atiles";
	}
	
	/* 첫페이지 그리드 로딩 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "jqgridAdminPayMain.do")
	public void jqgridAdminPayMain(HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute AdminPayVO adminPayVO, ModelMap model) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		

		System.out.println(request.getSession().getServletContext().getRealPath("/"));
		
		try {
			
			// 검색조건을 VO에 담음
			adminPayVO.setSurchSelect(request.getParameter("param"));

			List<Map> jqgridAdminPayMain = adminPayService.jqgridAdminPayList(adminPayVO);

			EgovMap adminPayCnt = adminPayService.adminPayCnt(adminPayVO);

			resMap = (HashMap<String, Object>) paging(adminPayVO);
			
			resMap.put("rows", jqgridAdminPayMain);
			resMap.put("page", request.getParameter("page"));
			resMap.put("totalPage", adminPayCnt.get("totalPage"));
			
		} catch (Exception e) {
			
			throw e;
		}
		
		out = response.getWriter();
		
		out.write(JsonUtil.HashMapToJson(resMap));
	}
	
	/* 이미지 저장을 위한 컨트롤러 */
	@RequestMapping(value = "savePayIcon.do")
	public void savePayIcon(MultipartHttpServletRequest payImg, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		try {
			Iterator<String> getName = payImg.getFileNames();	// 파일이름을 가져오고
			
			MultipartFile getFile = payImg.getFile(getName.next());	//멀티파트 파일로 파일을 가져오고?
			
			String OriFile = getFile.getOriginalFilename();	// 저장을 위해 실제 이름을 가져옴
			
			String saveFile = request.getSession().getServletContext().getRealPath("/")+"images/payIcon/"+ OriFile; // 서버 경로와 실제이름을 합침
			
			getFile.transferTo(new File(saveFile));	// 이게 서버에 저장
			
			PrintWriter out = null;
			
			response.setCharacterEncoding("UTF-8");
			
			out = response.getWriter();
			
			out.write("");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/* 텍스트 저장을 위한 컨트롤러 */
	@RequestMapping(value = "jqgridAdminPaySave.do")
	public @ResponseBody String jqgridAdminPaySave(@RequestParam String param1) throws Exception {
		
		String result = "";
		
		try {
		
			param1 = param1.replaceAll("&quot;", "\"");
			
			JSONArray jsonArr = new JSONArray(param1);
			
			System.out.println(jsonArr);
			
			adminPayService.adminPaySaveList(jsonArr);
			
			result = "SUCCESS";
		} catch (Exception e) {
			
			result = "FALL";
		}

		return result;
	}
	
	/* 노출여부 변경시 타는 컨트롤러 */
	@RequestMapping(value = "jqgridAdminPayUpdate.do")
	public @ResponseBody String jqgridAdminPayUpdate(@RequestParam String updateData) throws Exception {
		
		String result = "";
		
		try {
			
			String quotZero = updateData.replaceAll("&quot;", "\"");
			
			HashMap<String, Object> castMap = new HashMap<String, Object>(JsonUtil.JsonToMap(quotZero));
			
			adminPayService.adminPayServiceUpdate(castMap);
			
			result = "SUCCESS";
			
		} catch (Exception e) {
			
			result = "FALL";
		}
		
		return result;
	}

	/* 어드민 페이 페이지 페이징 */
	@SuppressWarnings("rawtypes")
	private Map paging(@ModelAttribute AdminPayVO adminPayVO) throws Exception {
		
			HashMap<String, Object> resMap = new HashMap<String, Object>();

			int pageGroup = (int) Math.ceil((double) adminPayVO.getPage()/adminPayVO.getPageScale());

			long startPage = ((pageGroup - 1) * adminPayVO.getPageScale()) + 1;
			
			adminPayVO.setStartPage(startPage);
			
			resMap.put("startPage", startPage);
			
			long endPage = startPage + adminPayVO.getPageScale() - 1;
			
			adminPayVO.setEndPage(endPage);
			
			resMap.put("endPage", endPage);
			
			long prevPage = (2 - pageGroup) * adminPayVO.getPageScale() + 1;
			long nextPage = pageGroup * adminPayVO.getPageScale() + 1;
			long pageScale = adminPayVO.getPageScale();
			
			resMap.put("prevPage", prevPage);
			resMap.put("nextPage", nextPage);
			resMap.put("pageGroup", pageGroup);
			resMap.put("pageScale", pageScale);
			
		return resMap;
	}
}