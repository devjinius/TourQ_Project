package egovframework.example.review.service.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("reviewMapper")
public interface ReviewMapper {

	List<Map> beforeList(String memberNumber) throws Exception;

	void insertReview(HashMap<String, Object> res) throws Exception;

	void updateOrderYN(String orderNumber) throws Exception;

	List<Map> themeList() throws Exception;

	List<Map> reviewList() throws Exception;

	EgovMap selectReview(String quotZero) throws Exception;

	EgovMap totCnt() throws Exception;

	List<Map> themeCnt() throws Exception;

	EgovMap selectReviewNumber() throws Exception;

}
