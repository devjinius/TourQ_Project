package egovframework.example.reservation.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.example.reservation.service.ReservationVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("reservationMapper")
public interface ReservationMapper {

	@SuppressWarnings("rawtypes")
	List<Map> getSelectTemaList() throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> getSelectPayList() throws Exception;
	
	void saveReservation(ReservationVO reservationVO) throws Exception;
	void saveOrder(ReservationVO reservationVO) throws Exception;
	void updateProd(ReservationVO reservationVO) throws Exception;
	void useMyPoint(ReservationVO reservationVO) throws Exception;
	void updateSeat(ReservationVO reservationVO) throws Exception;
	void useCoupon(ReservationVO reservationVO) throws Exception;

	EgovMap resInfo(ReservationVO reservationVO) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> getSelectCoupon(String param) throws Exception;

	EgovMap selectMyPoint(String memberNum) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> getProductList(Map castMap) throws Exception;

	EgovMap selectGetBusSeat(String param) throws Exception;

	EgovMap getSeatInfo(String prodNm) throws Exception;

}