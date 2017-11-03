package egovframework.example.adminReservation.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.example.adminReservation.service.AdminReservationVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("adminReservationMapper")
public interface AdminReservationMapper {
	
	@SuppressWarnings("rawtypes")
	List<Map> adminReservationMain(AdminReservationVO adminReservationVO) throws Exception;

	EgovMap adminReservationCnt(AdminReservationVO adminReservationVO) throws Exception;

	EgovMap resOrderInfo(String param1) throws Exception;

	void selectOrderCancel(String param1) throws Exception;

	void selectOrderSave(Map<String, Object> castMap) throws Exception;
	void selectResSave(Map<String, Object> castMap) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectAllCouseList(AdminReservationVO adminReservationVO) throws Exception;
	
	EgovMap selectStatusThisWeek(HashMap<String, Object> weekDate) throws Exception;

	EgovMap selectStatusPrevWeek(HashMap<String, Object> weekDate) throws Exception;

	EgovMap selectStatusTotal(HashMap<String, Object> weekDate) throws Exception;

	EgovMap selectStatusTotalReview(HashMap<String, Object> weekDate) throws Exception;

	EgovMap selectAllCouseListCnt(AdminReservationVO adminReservationVO) throws Exception;
}