package egovframework.example.adminReservation.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;


public interface AdminReservationService {
	
	@SuppressWarnings("rawtypes")
	List<Map> adminReservationMain(AdminReservationVO adminReservationVO) throws Exception;

	EgovMap adminReservationCnt(AdminReservationVO adminReservationVO) throws Exception;

	EgovMap resOrderInfo(String param1) throws Exception;

	String selectOrderCancel(String param1, String gubun) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectAdminStatus(AdminReservationVO adminReservationVO) throws Exception;

	EgovMap selectAllCouseListCnt(AdminReservationVO adminReservationVO) throws Exception;
}