package egovframework.example.adminSeat.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.example.adminSeat.service.AdminSeatService;
import egovframework.example.adminSeat.service.AdminSeatVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("adminSeatService")
public class AdminSeatServiceImpl extends EgovAbstractServiceImpl implements AdminSeatService{
	
	@Resource(name = "adminSeatMapper")
	private AdminSeatMapper adminSeatMapper;

	@Transactional(rollbackFor=Exception.class)
	@Override
	public void adminSeatSave(HashMap<String, Object> busInfo) throws Exception {
		
		adminSeatMapper.adminSeatSave(busInfo);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectAdminSeat(AdminSeatVO adminSeatVO) throws Exception {

		return adminSeatMapper.selectAdminSeat(adminSeatVO);
	}

	@Override
	public EgovMap selectAdminSeatCnt(AdminSeatVO adminSeatVO) throws Exception {

		return adminSeatMapper.selectAdminSeatCnt(adminSeatVO);
	}

	@Override
	public EgovMap getSeatData(String param) throws Exception {

		return adminSeatMapper.getSeatData(param);
	}
}