package egovframework.example.adminSeat.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;


public interface AdminSeatService {

	void adminSeatSave(HashMap<String, Object> busInfo) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectAdminSeat(AdminSeatVO adminSeatVO) throws Exception;

	EgovMap selectAdminSeatCnt(AdminSeatVO adminSeatVO) throws Exception;

	EgovMap getSeatData(String param) throws Exception;
}