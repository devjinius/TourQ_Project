package egovframework.example.adminProduct.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.example.adminProduct.service.AdminProductVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("adminProductMapper")
public interface AdminProductMapper {

	@SuppressWarnings("rawtypes")
	List<Map> selectGetCosList() throws Exception;
	
	@SuppressWarnings("rawtypes")
	List<Map> jqgridAdminProList(AdminProductVO adminProductVO) throws Exception;
	
	EgovMap selectAdminProdCnt(AdminProductVO adminProductVO) throws Exception;

	void saveAdminProduct(Map<String, Object> castMap) throws Exception;

	EgovMap selectGetCosNum(Map<String, Object> castMap) throws Exception;

	EgovMap selectGetTime(Map<String, Object> resMap) throws Exception;

	void deletAdminProduct(String prodNum) throws Exception;

	EgovMap selectGetTotal(Map<String, Object> resMap) throws Exception;

	EgovMap selectGetBusSeat(String param1) throws Exception;
}