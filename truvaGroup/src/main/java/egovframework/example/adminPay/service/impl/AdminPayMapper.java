package egovframework.example.adminPay.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.example.adminPay.service.AdminPayVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("adminPayMapper")
public interface AdminPayMapper {

	@SuppressWarnings("rawtypes")
	List<Map> jqgridAdminPayList(AdminPayVO adminPayVO) throws Exception;
	
	EgovMap adminPayCntList(AdminPayVO adminPayVO) throws Exception;

	void updateAdminPay(Map<String, Object> param1) throws Exception;

	void insertAdminPay(Map<String, Object> param1) throws Exception;

	void adminPayServiceUpdate(HashMap<String, Object> castMap) throws Exception;

}