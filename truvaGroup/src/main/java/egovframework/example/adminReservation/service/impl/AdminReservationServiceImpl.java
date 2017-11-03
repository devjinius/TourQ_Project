package egovframework.example.adminReservation.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.example.adminReservation.service.AdminReservationService;
import egovframework.example.adminReservation.service.AdminReservationVO;
import egovframework.example.cmmn.JsonUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("adminReservationService")
public class AdminReservationServiceImpl extends EgovAbstractServiceImpl implements AdminReservationService{
	
	@Resource(name = "adminReservationMapper")
	private AdminReservationMapper adminReservationMapper;

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> adminReservationMain(AdminReservationVO adminReservationVO)
			throws Exception {
		
		return adminReservationMapper.adminReservationMain(adminReservationVO);
	}

	@Override
	public EgovMap adminReservationCnt(AdminReservationVO adminReservationVO)
			throws Exception {

		return adminReservationMapper.adminReservationCnt(adminReservationVO);
	}

	@Override
	public EgovMap resOrderInfo(String param1) throws Exception {

		return adminReservationMapper.resOrderInfo(param1);
	}
	
	/* 결제취소시 타는 매퍼 */
	@Transactional(rollbackFor=Exception.class)
	private void orderCancel(String param1) throws Exception{
		
		try {
			
			adminReservationMapper.selectOrderCancel(param1);
		} catch (Exception e) {
			
			throw e;
		}
	}

	/* 그리드 수정시 타는 매퍼 */
	@Transactional(rollbackFor=Exception.class)
	private void orderSave(String param1) throws Exception {
		
		String quotZero = param1.replaceAll("&quot;", "\"");
		
		/* 선택된 줄이 여러줄일경우 배열로 저장 */
		JSONArray jsonArr = new JSONArray(quotZero);
		
		Map<String, Object> castMap = new HashMap<String, Object>();
		
		try {

			/* 한줄씩 JSONObject에 저장하여 업데이트 한다. */
			for (int i = 0; i < jsonArr.length(); i++) {
				
				JSONObject jsonObj = jsonArr.getJSONObject(i);

				castMap = JsonUtil.JsonToMap(jsonObj.toString());

				adminReservationMapper.selectOrderSave(castMap);
				adminReservationMapper.selectResSave(castMap);
			}
		} catch (Exception e) {

			throw e;
		}
	}
	
	@Override
	public String selectOrderCancel(String param1, String gubun) throws Exception {

		String result = "";
		try {
			
			if (gubun == "C") {

				orderCancel(param1);
			} else {

				orderSave(param1);
			}
			
			result = "SUCCESS";
		} catch (Exception e) {
			
			result = "FALL";
		}
		
		return result;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List<Map> selectAdminStatus(AdminReservationVO adminReservationVO)
			throws Exception {

		List<Map> allCouse = new ArrayList<Map>();
		
		try {

			// 날짜 정보를 담을 맵
			HashMap<String, Object> weekDate = new HashMap<String, Object>();
			
			// 데이트 포멧을 지정하여 현재 날짜 기준의 0시로 기준을 설정
			SimpleDateFormat dateFm = new SimpleDateFormat("yyyy-MM-dd");
			
			String dateString = dateFm.format(new Date());
			
			Date today = dateFm.parse(dateString);
			
			int todayYoil = today.getDay();	// 현재요일
			int getYoil = 0;	// 현재 주의 월요일 까지 차이
			long todayTime = today.getTime();	// 현재일의 시간
			long oneDay = 24 * 60 * 60 * 1000;	// 하루 시간
			long getThisWeek = 0;	// 이번주 월요일지정
			long prevWeekMon = 0;	// 저번주 월요일 지정
			long prevWeekSun = 0;	// 저번주 일요일 지정
			
			getYoil = (todayYoil == 0) ? 7 : todayYoil - 1;
			
			getThisWeek = todayTime - (oneDay * getYoil);
			
			prevWeekMon = getThisWeek - (oneDay * 7);
			
			prevWeekSun = getThisWeek - 1 ;
			
			weekDate.put("getThisWeek", dateFm.format(getThisWeek));
			weekDate.put("prevWeekMon", dateFm.format(prevWeekMon));
			weekDate.put("prevWeekSun", dateFm.format(prevWeekSun));
			
			try {

				allCouse = adminReservationMapper.selectAllCouseList(adminReservationVO);
				
				for (Map i : allCouse) {

					weekDate.put("courseNumber", i.get("courseNumber"));
					
					EgovMap thisWeek = adminReservationMapper.selectStatusThisWeek(weekDate);
					EgovMap prevWeek = adminReservationMapper.selectStatusPrevWeek(weekDate);
					EgovMap total = adminReservationMapper.selectStatusTotal(weekDate);
					EgovMap totalReview = adminReservationMapper.selectStatusTotalReview(weekDate);
					
					i.put("thisWeek", (thisWeek == null) ? 0 : Integer.parseInt(thisWeek.get("weekCount").toString()));
					i.put("prevWeek", (prevWeek == null) ? 0 : Integer.parseInt(prevWeek.get("weekCount").toString()));
					i.put("total", (total == null) ? 0 : Integer.parseInt(total.get("totalCount").toString()));
					i.put("totalReview", (totalReview == null) ? 0 : Integer.parseInt(totalReview.get("totalReview").toString()));
				}
				
			} catch (Exception e) {

				throw e;
			}

		} catch (Exception e) {

			throw e;
		}
		
		return allCouse;
	}

	@Override
	public EgovMap selectAllCouseListCnt(AdminReservationVO adminReservationVO)
			throws Exception {

		return adminReservationMapper.selectAllCouseListCnt(adminReservationVO);
	}
}