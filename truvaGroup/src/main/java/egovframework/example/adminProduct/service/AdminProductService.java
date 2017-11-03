package egovframework.example.adminProduct.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;


public interface AdminProductService {

	@SuppressWarnings("rawtypes")
	List<Map> selectGetCosList()throws Exception;
	
	@SuppressWarnings("rawtypes")
	List<Map> jqgridAdminProList(AdminProductVO adminProductVO) throws Exception;
	
	EgovMap selectAdminProdCnt(AdminProductVO adminProductVO) throws Exception;

	void saveAdminProduct(Map<String, Object> castMap) throws Exception;

	EgovMap selectGetCosNum(Map<String, Object> castMap) throws Exception;

	EgovMap selectGetTime(Map<String, Object> resMap) throws Exception;

	void deletAdminProduct(String quotZero) throws Exception;

	EgovMap selectGetTotal(Map<String, Object> resMap) throws Exception;

	EgovMap selectGetBusSeat(String param1) throws Exception;
}