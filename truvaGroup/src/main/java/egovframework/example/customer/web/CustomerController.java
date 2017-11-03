package egovframework.example.customer.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.example.adminCustomer.service.AdCustomJqgridVo;
import egovframework.example.adminCustomer.service.AdminCustomerService;
import egovframework.example.customer.service.CustomerService;
import egovframework.example.customer.service.CustomerVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Controller
public class CustomerController {
	
	@Resource(name = "customerService")
	private CustomerService customerService;
	
	@Resource(name = "adminCustomerService")
	private AdminCustomerService adminCustomerService;
	
	@RequestMapping(value = "notice.do")
	public String notice(ModelMap model, HttpServletRequest request, @ModelAttribute CustomerVO customerVO) throws Exception {  
		
		// 페이징 처리
		customerVO.setRows(10);
		
		List<Map> noticeList = customerService.selectNoticeList(customerVO);
		EgovMap noticeListCnt = customerService.noticeListCnt(customerVO);
		
		// 페이징에 필요한 처리
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		resMap.put("page", customerVO.getPage());
		resMap.put("totalPage", noticeListCnt.get("totalPage"));
		resMap.put("pageScale", customerVO.getPageScale());
		
		int pageGroup = (int) Math.ceil((double) customerVO.getPage() / customerVO.getPageScale() );
		
		long startPage = (pageGroup - 1) * customerVO.getPageScale() + 1;

		customerVO.setStartPage(startPage);
		
		resMap.put("startPage", customerVO.getStartPage());
		
		long endPage = startPage + customerVO.getPageScale() - 1;
		
		customerVO.setEndPage(endPage);
		
		resMap.put("endPage", endPage);
		
		long prePage = (pageGroup-2) * customerVO.getPageScale() + 1 + (customerVO.getPageScale()-1);
						//여기는 이전 그룹의 처음숫자 						// 여길 추가하면 이전그룹의 마지막숫자 
		
		long nextPage = pageGroup * customerVO.getPageScale() + 1;
		
		resMap.put("pageGroup", pageGroup);
		resMap.put("prePage", prePage);
		resMap.put("nextPage", nextPage);

		modifyDate(noticeList);
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("noticeListCnt", noticeListCnt);
		model.addAttribute("resMap", resMap);
		
		return "customer/notice.tiles";
	}
	
	@RequestMapping(value = "noticeDetail.do")
	public String noticeDetail(ModelMap model, HttpServletRequest request, @RequestParam String boardNumber) throws Exception {  
		
		EgovMap noticeDetail = customerService.noticeDetail(boardNumber);
		
		modifyDate(noticeDetail);

		// 조회수 추가
		customerService.updateCount(boardNumber);
		
		// 특수문자 처리
		String contents = (String) noticeDetail.get("boardContent");
		contents = contents.replaceAll("&lt;", "<");
		contents = contents.replaceAll("&gt;", ">");
		contents = contents.replaceAll("&quot;", "\'");
		contents = contents.replaceAll("&nbsp;", " ");
		contents = contents.replaceAll("&amp;", "&");

		noticeDetail.put("boardContent", contents);

		model.addAttribute("noticeDetail", noticeDetail);
		
		return "customer/noticeDetail.tiles";
	}
	
	private Map modifyDate(Map map) {
			
		String datetime = String.valueOf(map.get("boardDate"));
		
		String date = datetime.split(" ")[0];
		
		map.replace("boardDate", date);
		
		return map;
	}

	// courseDate를 YYYY-MM-DD형식으로 변형하는 메서드
	@SuppressWarnings("unchecked")
	private List<Map> modifyDate(List<Map> noticeList) {
		
		for (Map map : noticeList) {
			
			String datetime = String.valueOf(map.get("boardDate"));
			
			String date = datetime.split(" ")[0];
			
			map.replace("boardDate", date);
		}
		
		return noticeList;
	}
	
	@RequestMapping(value = "howToUse.do")
	public String HowToUse() throws Exception {  
		
		return "customer/howToUse.tiles";
	}
	@RequestMapping(value = "advertisement.do")
	public String Advertisement() throws Exception {  
		
		return "customer/advertisement.tiles";
	}
	
	@RequestMapping(value = "faq.do")
	public String faq(HttpServletRequest request, ModelMap model, @ModelAttribute CustomerVO customerVO) throws Exception {  

		List<Map> faqList = customerService.selectFaqList(customerVO);

		List<Map> faqTypeCnt = customerService.faqTypeCnt();
		EgovMap totCnt = customerService.faqTotCnt();
		
		System.out.println(faqTypeCnt);
		System.out.println(totCnt);
		model.addAttribute("faqList", faqList);
		model.addAttribute("faqTypeCnt", faqTypeCnt);
		model.addAttribute("totCnt", totCnt);
		
		return "customer/faq.tiles";
	}
	
	@RequestMapping(value = "usingTerms.do")
	public String UsingTerms() throws Exception {  
		
		return "customer/usingTerms.tiles";
	}
	
	@RequestMapping(value = "mantoMan.do")
	public String MantoMan(HttpServletRequest request ,HttpServletResponse response, ModelMap model) throws Exception {  
		
		List<Map> MantoManList = customerService.selectManToManList();

		model.addAttribute("MantoManList", MantoManList);
		
		return "customer/mantoMan.tiles";
	}
	
	@RequestMapping(value = "detailManToMan.do")
	public String DetailManToMan(@RequestParam String number, HttpServletRequest request ,HttpServletResponse response, ModelMap model) throws Exception {  
		
		/*List<Map> mantoManDetail = customerService.selectManToManDetail(number);
		
		model.addAttribute("mantoManDetail", mantoManDetail);
		*/
		return "customer/detailManToMan.tiles";
	}
	
	@RequestMapping(value = "createAsk.do")
	public String CreateAsk(HttpServletRequest request) throws Exception {  
		
		if (request.getSession().getAttribute("memberSession")!=null) {
			
			return "customer/createAsk.tiles";
		} else {
			
			return "loginCheck/memberLogin.tiles";
		}
	}
	
	@RequestMapping(value = "event.do")
	public String Event() throws Exception {  
		
		return "customer/event.tiles";
	}
	
	@RequestMapping(value = "anouncement.do")
	public String Anouncement() throws Exception {  
		
		return "customer/anouncement.tiles";
	}
	
	@RequestMapping(value = "CloseEvent.do")
	public String CloseEvent() throws Exception {  
		
		return "customer/closeEvent.tiles";
	}
	
	
	@RequestMapping(value = "writeReview.do")
	public String WriteReview() throws Exception {  
		
		return "customer/writeReview.tiles";
	}
	
	@RequestMapping(value = "eventView.do")
	public String eventView() throws Exception {  
		
		return "customer/eventView.tiles";
	}
	
	@RequestMapping(value = "mantoMan_modal.do")
	public String MantoMan_modal() throws Exception {  
		
		return "customer/mantoMan_modal.tiles";
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "insertAsk.do")
	public String insertAsk(HttpServletRequest request, HttpSession session) throws Exception {  
		
		Map sessionMap = (Map) session.getAttribute("memberSession");
		
		Map askMap = new HashMap<String, Object>();
		
		askMap.put("title", request.getParameter("title"));
		askMap.put("contents", request.getParameter("contents"));
		askMap.put("memberNumber", sessionMap.get("memberNumber"));

		try {
			customerService.insertAsk(askMap);
		} catch (Exception e) {
		}
		
		return "customer/insertAsk.tiles";
	}
	
	


}
