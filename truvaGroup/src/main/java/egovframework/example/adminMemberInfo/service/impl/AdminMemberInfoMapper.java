package egovframework.example.adminMemberInfo.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.example.adminMemberInfo.service.AdminMemberVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("adminMemberInfoMapper")
public interface AdminMemberInfoMapper {

	List<EgovMap> selectJqgridList(AdminMemberVO adminMemberVO);

	EgovMap selectJqgridListCnt(AdminMemberVO adminMemberVO);

	void insertPlusPoint(Map<String, Object> castMap) throws Exception;

	void insertMinusPoint(Map<String, Object> castMap) throws Exception;

}
