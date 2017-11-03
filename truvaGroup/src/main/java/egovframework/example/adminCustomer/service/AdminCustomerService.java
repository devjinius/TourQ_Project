package egovframework.example.adminCustomer.service;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface AdminCustomerService {

//	notice
	List<EgovMap> selectJqNoticeList(AdCustomJqgridVo adCustomJqgridVo) throws Exception;

	EgovMap selectJqNoticeListCnt(AdCustomJqgridVo adCustomJqgridVo) throws Exception;

	void noticeIU(Map<String, Object> castMap) throws Exception;
	
	void deleteNotice(JSONArray jsonArray) throws Exception;
	
	EgovMap noticeDetail(String noticeNumber) throws Exception;
	
//	faq
	List<EgovMap> selectJqFaqList(AdCustomJqgridVo adCustomJqgridVo) throws Exception;

	EgovMap selectJqFaqListCnt(AdCustomJqgridVo adCustomJqgridVo) throws Exception;

	EgovMap faqDetail(String faqNumber) throws Exception;

	void faqIU(Map<String, Object> castMap) throws Exception;

	void deleteFaq(JSONArray jsonArray) throws Exception;

	EgovMap answerInfo(String askNumber) throws Exception;
	
//	ask & answer
	List<EgovMap> selectJqAskList(AdCustomJqgridVo adCustomJqgridVo);

	EgovMap selectJqAskListCnt(AdCustomJqgridVo adCustomJqgridVo);

	EgovMap memberInfo(String memberNumber) throws Exception;
	
	EgovMap askInfo(String askNumber) throws Exception;
	
	void answerIU(Map<String, Object> castMap) throws Exception;

//	coupon
	List<Map> selectadminCouponDetail(String number) throws Exception;
	
	List<Map> selectadCouponList() throws Exception;

	List<EgovMap> selectJqCouponList(AdCustomJqgridVo adCustomJqgridVo) throws Exception;

	EgovMap selectJqCouponListCnt(AdCustomJqgridVo adCustomJqgridVo) throws Exception;

	void saveJqgridTx(JSONArray jsonArray) throws Exception;

}
