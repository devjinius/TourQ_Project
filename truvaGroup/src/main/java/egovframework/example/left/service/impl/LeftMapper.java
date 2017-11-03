package egovframework.example.left.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("leftMapper")
public interface LeftMapper {

	List<Map> menuList(String menuId) throws Exception;

	List<Map> adminMenuList(String menuId) throws Exception;
}