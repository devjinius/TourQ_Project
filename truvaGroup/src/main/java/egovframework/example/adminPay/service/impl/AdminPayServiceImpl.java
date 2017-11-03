package egovframework.example.adminPay.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.example.adminPay.service.AdminPayService;
import egovframework.example.adminPay.service.AdminPayVO;
import egovframework.example.cmmn.JsonUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("adminPayService")
public class AdminPayServiceImpl extends EgovAbstractServiceImpl implements AdminPayService {

	@Resource(name = "adminPayMapper")
	private AdminPayMapper adminPayMapper;

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> jqgridAdminPayList(AdminPayVO adminPayVO)
			throws Exception {

		return adminPayMapper.jqgridAdminPayList(adminPayVO);
	}

	@Override
	public EgovMap adminPayCnt(AdminPayVO adminPayVO) throws Exception {
		
		return adminPayMapper.adminPayCntList(adminPayVO);
	}
	
	@Override
	public void adminPaySaveList(JSONArray jsonArr) throws Exception {
		
		int jsonArrLength = jsonArr.length();
		
		try {
			
			for (int i = 0; i < jsonArrLength; i++) {
				
				JSONObject jsonObj = jsonArr.getJSONObject(i);
				
				Map<String, Object> param1 = JsonUtil.JsonToMap(jsonObj.toString());
				
				/* 새로생성된 줄을 저장한다면 인서트하고, 기존 줄을 수정했다면 업데이트 한다. */
				if ("I".equals(param1.get("editType"))) {
					
					adminPayMapper.insertAdminPay(param1);
				} else if ("U".equals(param1.get("editType"))) {
					
					adminPayMapper.updateAdminPay(param1);
				}
			}
			
		} catch (Exception e) {

			throw e;
		}
	}

	@Override
	public void adminPayServiceUpdate(HashMap<String, Object> castMap)
			throws Exception {
		
		adminPayMapper.adminPayServiceUpdate(castMap);
	}

}