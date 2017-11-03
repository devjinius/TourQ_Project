package egovframework.example.main.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface MainService {

	List<Map> themeList() throws Exception;

	List<Map> courseAllList() throws Exception;

	void courseLikeID(HashMap<String, Object> paramMap);

	List<Map> selectWishList(HashMap wishMap) throws Exception;

	List<Map> reviewInfoList(ArrayList<String> cNumberList) throws Exception;

}

