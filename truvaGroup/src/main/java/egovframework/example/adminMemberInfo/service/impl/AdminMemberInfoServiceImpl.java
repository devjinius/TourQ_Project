package egovframework.example.adminMemberInfo.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.adminMemberInfo.service.AdminMemberInfoService;
import egovframework.example.adminMemberInfo.service.AdminMemberVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("adminMemberInfoService")
public class AdminMemberInfoServiceImpl extends EgovAbstractServiceImpl implements AdminMemberInfoService {

	@Resource(name = "adminMemberInfoMapper")
	private AdminMemberInfoMapper adminMemberInfoMapper;

	@Override
	public List<EgovMap> selectJqgridList(AdminMemberVO adminMemberVO) {

		return adminMemberInfoMapper.selectJqgridList(adminMemberVO);
	}

	@Override
	public EgovMap selectJqgridListCnt(AdminMemberVO adminMemberVO) {

		return adminMemberInfoMapper.selectJqgridListCnt(adminMemberVO);
	}

	@Override
	public void addRow(Map<String, Object> castMap) throws Exception {
		
		// point가 0보다 크다면
		ArrayList array = (ArrayList) castMap.get("array");
		
		if(Integer.parseInt((String) castMap.get("point")) > 0) {
			
			for (Object str : array) {
				
				castMap.put("memberNumber", str);

				adminMemberInfoMapper.insertPlusPoint(castMap);
			}
		} else {// 0보다 작다면
			
			String point = ((String) castMap.get("point")).replace("-", "");
			
			castMap.replace("point", point);
			
			for (Object str : array) {
				
				castMap.put("memberNumber", str);

				adminMemberInfoMapper.insertMinusPoint(castMap);
			}
		}
	}

}