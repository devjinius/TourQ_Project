package egovframework.example.reservation.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;


public interface ReservationService {

	@SuppressWarnings("rawtypes")
	List<Map> selectTemaList() throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectPayList() throws Exception;
	
	void saveReservationInfo(ReservationVO reservationVO) throws Exception;

	EgovMap selectresInfo(ReservationVO reservationVO) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectCoupon(String param) throws Exception;

	EgovMap selectMyPoint(String memberNum) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> getProductList(Map castMap) throws Exception;

	EgovMap selectGetBusSeat(String param) throws Exception;

	EgovMap getSeatInfo(String prodNm) throws Exception;
}