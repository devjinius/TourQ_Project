package egovframework.example.adminPay.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;

import egovframework.rte.psl.dataaccess.util.EgovMap;


public interface AdminPayService {

	@SuppressWarnings("rawtypes")
	List<Map> jqgridAdminPayList(AdminPayVO adminPayVO) throws Exception;
	
	EgovMap adminPayCnt(AdminPayVO adminPayVO) throws Exception;

	void adminPaySaveList(JSONArray jsonArr) throws Exception;

	void adminPayServiceUpdate(HashMap<String, Object> castMap) throws Exception;

}