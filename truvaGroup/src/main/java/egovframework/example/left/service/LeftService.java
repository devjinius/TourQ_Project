package egovframework.example.left.service;

import java.util.List;
import java.util.Map;

public interface LeftService {

	List<Map> menuList(String menuId) throws Exception;

	List<Map> adminMenuList(String menuId) throws Exception;
}