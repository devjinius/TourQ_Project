package egovframework.example.reservation.web;

import java.io.PrintWriter;
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

import egovframework.example.cmmn.JsonUtil;
import egovframework.example.reservation.service.ReservationService;
import egovframework.example.reservation.service.ReservationVO;
import egovframework.rte.psl.dataaccess.util.EgovMap;


@Controller
public class ReservationController {
	
	@Resource(name = "reservationService")
	private ReservationService reservationService;
	
	/* 예약페이지 버튼을 눌렀을경우 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "memberReservation.do")
	public String memberReservation(ModelMap model, HttpSession session) throws Exception {
		
		/* 페이지의 기본적인 테마리스트, 결제리스트, 상품리스트를 불러옵니다. */
		List<Map> temaList = reservationService.selectTemaList();
		List<Map> payList = reservationService.selectPayList();
		
		model.addAttribute("temaList", temaList);
		model.addAttribute("payList", payList);
		
		/* 로그인이 되어있지 않으면 로그인체크 페이지로 이동하고 로그인이 되어있으면 예약페이지로 이동 */
		if (session.getAttribute("memberSession") == null) {

			return "loginCheck/loginCheck.tiles";
		} else {

			/* 해당 회원이 소지한 마일리지를 조회 */
			String memberNum = session.getAttribute("memberNumber").toString();

			EgovMap myPoint = reservationService.selectMyPoint(memberNum);
			
			model.addAttribute("pointTotalmile", myPoint.get("pointTotalmile"));
			
			return "reservation/memberReservation.tiles";
		}
	}
	
	/* 로그인 예약페이지에서 비회원 예약하기를 누를경우 약관동의 페이지로 이동 */
	@RequestMapping(value = "reservationAgree.do")
	public String reservationAgree() throws Exception {

		return "loginCheck/reservationAgree.tiles";
	}

	/* 비회원 약관동의 후 예약페이지로 이동 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "nMemberReservation.do")
	public String nMemberReservation(ModelMap model) throws Exception {
		
		/* 페이지의 기본적인 테마리스트, 결제리스트, 상품리스트를 불러옵니다. */
		List<Map> temaList = reservationService.selectTemaList();
		List<Map> payList = reservationService.selectPayList();
		
		model.addAttribute("temaList", temaList);
		model.addAttribute("payList", payList);
		
		return "reservation/nMemberReservation.tiles";
	}
	
	/* 고객이 기입한 예약정보를 저장하는 컨트롤러 */
	@RequestMapping(value = "saveReservationInfo.do")
	public String saveReservationInfo(HttpServletRequest request, @ModelAttribute ReservationVO reservationVO, 
			HttpSession session, ModelMap model) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		String result = "";
		String orderKind = reservationVO.getOrderKind();
		
		/* 예약정보를 저장하는 도중 오류가 나면 롤백을 하고 FALL, 완료되면 SUCCESS 한다 */
		try {
			
			// 회원이면
			if (session.getAttribute("memberNumber") != null) {
				
				reservationVO.setMemberNumber(session.getAttribute("memberNumber").toString());
				reservationVO.setMemberYn("Y");
			}
			
			// 카드나 핸드폰 결제일경우 결제완료로 표시한다
			if (orderKind.equals("payCard") || orderKind.equals("payPhone")) {
				 
				reservationVO.setPayment("payCompleted");
			}
			
			/* 버스 상품을 예약할경우 기존 예약된 좌석을 불러온후 VO에 다시 저장한다. */
			if (reservationVO.getProdGubun().equals("버스")) {
				
				String prodNm = reservationVO.getProductNumber();
				
				EgovMap soldOutSeat = reservationService.getSeatInfo(prodNm);
				
				if (soldOutSeat != null) {
					
					String getSeat = reservationVO.getResSeat();
					reservationVO.setResSeat(getSeat+","+soldOutSeat.get("resSeat"));
				}
			}
			
			reservationService.saveReservationInfo(reservationVO);
			
			result = "SUCCESS";
		} catch (Exception e) {
			
			result = "FALL";
		}
		
		/* 저장 결과에따라 정상적으로 완료되면 완료페이지로 가고, 오류가 났을경우 다시 예약페이지로 간다. */
		if (result.equals("SUCCESS")) {

			EgovMap resInfo = reservationService.selectresInfo(reservationVO);
			
			String orDate = resInfo.get("orDate").toString().split(" ")[0];
			
			resInfo.put("orDate", orDate);
			
			model.addAttribute("resInfo", resInfo);
			
			return "reservation/reservationComplete.tiles";
		} else {
			
			/* 이부분 시간 남으면 오류페이지를 만들어서 오류페이지로 가게 수정할것 */
			return "reservation/memberReservation.tiles";
		}
	}
	
	/* 쿠폰정보와 예약에 필요한 정보를 가져오는 컨트롤러 */
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "getReservationInfo.do")
	public void getReservationInfo(@RequestParam String param, HttpServletResponse response) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		/* 쿠폰번호를 조회하여 가지고있는 쿠폰번호일경우 SUCCESS, 없는쿠폰번호일경우 FALL과 함께 정보를 리턴 */
		List<Map> couponInfo = reservationService.selectCoupon(param);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		result.put("success", (couponInfo.size() == 0)? "FALL" : "SUCCESS");
		
		couponInfo.add(result);
		
		out = response.getWriter();
		
		out.write(JsonUtil.ListToJson(couponInfo));
	}
	
	/* 기간 검색시 상품 리스트를 가져온다. */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "getProductList.do")
	public void getProductList(@RequestParam String param, HttpServletResponse response) throws Exception {

		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		String optionList[] = param.split(",");
		String serchTime[] = null;
		List<Map> productList;
		
		Map castMap = new HashMap();
		
		// all 이 아닐경우 검색되는 시간을 구분한다.
		try {
			for (String i : optionList) {
				
				String getKey[] = i.split("=");
				
				castMap.put(getKey[0], getKey[1]);
			}
			
			if (!(castMap.get("startTime").equals("All"))) {
				serchTime = castMap.get("startTime").toString().split(" ~ ");
				
				castMap.put("endTime", serchTime[1]);
				castMap.replace("startTime", serchTime[0]);
			}
			
			productList = reservationService.getProductList(castMap);
			
			// 가져온 상품 리스트의 시간에서 초에 대한 정보를 뺀다.
			for (Map i : productList) {
				
				String departureDay = i.get("departureDay").toString().split(" ")[0];
				String departureTime = i.get("departureTime").toString().split(" ")[1].replaceAll("[:]00[.]0", "");
				String courseDetail = i.get("courseDetail").toString().split(" - ")[0];

				i.replace("departureDay", departureDay);
				i.replace("departureTime", departureTime);
				i.replace("courseDetail", courseDetail);
			}
			
		} catch (Exception e) {

			throw e;
		}
		
		out = response.getWriter();
		
		out.write(JsonUtil.ListToJson(productList));
	}
	
	/* 좌석정보를 가져오는 컨트롤러 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "resMainBusSeat.do")
	public void resMainBusSeat(@RequestParam String param, HttpServletResponse response) throws Exception {
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		EgovMap getBusSeat = reservationService.selectGetBusSeat(param);
		
		out = response.getWriter();

 		out.write(JsonUtil.MapToJson(getBusSeat));
	}
}
