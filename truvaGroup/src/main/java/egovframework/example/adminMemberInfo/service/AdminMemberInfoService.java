package egovframework.example.adminMemberInfo.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface AdminMemberInfoService {

	List<EgovMap> selectJqgridList(AdminMemberVO adminMemberVO);

	EgovMap selectJqgridListCnt(AdminMemberVO adminMemberVO);

	void addRow(Map<String, Object> castMap) throws Exception;

}

