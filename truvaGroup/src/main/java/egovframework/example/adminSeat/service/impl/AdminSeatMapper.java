package egovframework.example.adminSeat.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.example.adminSeat.service.AdminSeatVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("adminSeatMapper")
public interface AdminSeatMapper {

	void adminSeatSave(HashMap<String, Object> busInfo) throws Exception;

	@SuppressWarnings("rawtypes")
	List<Map> selectAdminSeat(AdminSeatVO adminSeatVO) throws Exception;

	EgovMap selectAdminSeatCnt(AdminSeatVO adminSeatVO) throws Exception;

	EgovMap getSeatData(String param) throws Exception;
}