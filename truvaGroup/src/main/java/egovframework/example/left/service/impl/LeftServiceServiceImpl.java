package egovframework.example.left.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.left.service.LeftService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("leftService")
public class LeftServiceServiceImpl extends EgovAbstractServiceImpl implements LeftService {

	@Resource(name="leftMapper")
	private LeftMapper leftMapper;

	@Override
	public List<Map> menuList(String menuId) throws Exception {

		return leftMapper.menuList(menuId);
	}

	@Override
	public List<Map> adminMenuList(String menuId) throws Exception {

		return leftMapper.adminMenuList(menuId);
	}
}