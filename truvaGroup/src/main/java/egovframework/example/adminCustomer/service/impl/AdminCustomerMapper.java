package egovframework.example.adminCustomer.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.example.adminCustomer.service.AdCustomJqgridVo;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("adminCustomerMapper")
public interface AdminCustomerMapper {

//	notice
	List<EgovMap> selectJqNoticeList(AdCustomJqgridVo adCustomJqgridVo) throws Exception;

	EgovMap selectJqNoticeListCnt(AdCustomJqgridVo adCustomJqgridVo) throws Exception;

	EgovMap noticeDetail(String number)  throws Exception;

	void updateNotice(Map<String, Object> castMap) throws Exception;

	void deleteNotice(Object object) throws Exception;
	
	void insertNotice(Map<String, Object> castMap) throws Exception;
	
//	faq
	List<EgovMap> selectJqFaqList(AdCustomJqgridVo adCustomJqgridVo) throws Exception;

	EgovMap selectJqFaqListCnt(AdCustomJqgridVo adCustomJqgridVo) throws Exception;

	EgovMap faqDetail(String faqNumber) throws Exception;

	void updateFaq(Map<String, Object> castMap) throws Exception;

	void deleteFaq(Object object) throws Exception;

	void insertFaq(Map<String, Object> castMap) throws Exception;
	
//	ask
	List<EgovMap> selectJqAskList(AdCustomJqgridVo adCustomJqgridVo);

	EgovMap selectJqAskListCnt(AdCustomJqgridVo adCustomJqgridVo);
	
	EgovMap memberInfo(String memberNumber) throws Exception;

	EgovMap askInfo(String askNumber) throws Exception;
	
	void updateAnswer(Map<String, Object> castMap);
	
	void insertAnswer(Map<String, Object> castMap);
	
	void updateAskYn(Map<String, Object> castMap) throws Exception;
	
	EgovMap answerInfo(String askNumber) throws Exception;
	
//	coupon
	List<Map> selectadminCouponDetail(String number) throws Exception;

	List<Map> selectadCouponList() throws Exception;

	List<EgovMap> selectJqCouponList(AdCustomJqgridVo adCustomJqgridVo) throws Exception;

	EgovMap selectJqCouponListCnt(AdCustomJqgridVo adCustomJqgridVo) throws Exception;

	void insertJqgridCoupon(Map<String, Object> param) throws Exception;

	void updateJqgridCoupon(Map<String, Object> param) throws Exception;
	
}
