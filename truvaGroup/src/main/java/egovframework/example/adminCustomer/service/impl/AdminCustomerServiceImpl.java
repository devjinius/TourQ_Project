package egovframework.example.adminCustomer.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import egovframework.example.adminCustomer.service.AdCustomJqgridVo;
import egovframework.example.adminCustomer.service.AdminCustomerService;
import egovframework.example.cmmn.JsonUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("adminCustomerService")
public class AdminCustomerServiceImpl extends EgovAbstractServiceImpl implements AdminCustomerService{
	
	@Resource(name = "adminCustomerMapper")
	private AdminCustomerMapper adminCustomerMapper;

//	notice
	@Override
	public List<EgovMap> selectJqNoticeList(AdCustomJqgridVo adCustomJqgridVo)
			throws Exception {
		
		return adminCustomerMapper.selectJqNoticeList(adCustomJqgridVo);
	}

	@Override
	public EgovMap selectJqNoticeListCnt(AdCustomJqgridVo adCustomJqgridVo)
			throws Exception {
		
		return adminCustomerMapper.selectJqNoticeListCnt(adCustomJqgridVo);
	}

	@Override
	public EgovMap noticeDetail(String noticeNumber) throws Exception {
		
		return adminCustomerMapper.noticeDetail(noticeNumber);
	}

	@Override
	public void noticeIU(Map<String, Object> castMap) throws Exception {

		if(castMap.get("gubun").equals("U")){
			
			adminCustomerMapper.updateNotice(castMap);
		} else if (castMap.get("gubun").equals("I")){
			
			adminCustomerMapper.insertNotice(castMap);
		}
	}

	@Override
	public void deleteNotice(JSONArray jsonArray) throws Exception {

		for (int i = 0; i < jsonArray.length(); i++) {
			
			adminCustomerMapper.deleteNotice(jsonArray.get(i));
		}
	}

//	faq
	@Override
	public List<EgovMap> selectJqFaqList(AdCustomJqgridVo adCustomJqgridVo)
			throws Exception {

		return adminCustomerMapper.selectJqFaqList(adCustomJqgridVo);
	}

	@Override
	public EgovMap selectJqFaqListCnt(AdCustomJqgridVo adCustomJqgridVo)
			throws Exception {

		return adminCustomerMapper.selectJqFaqListCnt(adCustomJqgridVo);
	}

	@Override
	public EgovMap faqDetail(String faqNumber) throws Exception {

		return adminCustomerMapper.faqDetail(faqNumber);
	}

	@Override
	public void faqIU(Map<String, Object> castMap) throws Exception {

		if(castMap.get("gubun").equals("U")){
			
			adminCustomerMapper.updateFaq(castMap);
		} else if (castMap.get("gubun").equals("I")){
			
			adminCustomerMapper.insertFaq(castMap);
		}
	}

	@Override
	public void deleteFaq(JSONArray jsonArray) throws Exception {

		for (int i = 0; i < jsonArray.length(); i++) {
			
			adminCustomerMapper.deleteFaq(jsonArray.get(i));
		}
	}

//	ask
	@Override
	public List<EgovMap> selectJqAskList(AdCustomJqgridVo adCustomJqgridVo) {

		return adminCustomerMapper.selectJqAskList(adCustomJqgridVo);
	}

	@Override
	public EgovMap selectJqAskListCnt(AdCustomJqgridVo adCustomJqgridVo) {

		return adminCustomerMapper.selectJqAskListCnt(adCustomJqgridVo);
	}
	
	@Override
	public EgovMap memberInfo(String memberNumber) throws Exception {

		return adminCustomerMapper.memberInfo(memberNumber);
	}

	@Override
	public EgovMap askInfo(String askNumber) throws Exception {

		return adminCustomerMapper.askInfo(askNumber);
	}
	
	@Override
	public void answerIU(Map<String, Object> castMap) throws Exception {
		
		if(castMap.get("gubun").equals("U")){
			
			adminCustomerMapper.updateAnswer(castMap);
		} else if (castMap.get("gubun").equals("I")){
			
			adminCustomerMapper.insertAnswer(castMap);
			adminCustomerMapper.updateAskYn(castMap);
		}
	}
	
	@Override
	public EgovMap answerInfo(String askNumber) throws Exception {

		return adminCustomerMapper.answerInfo(askNumber);
	}
	
//	coupon
	@Override
	public List<Map> selectadminCouponDetail(String number) throws Exception {
		// TODO Auto-generated method stub
		return adminCustomerMapper.selectadminCouponDetail(number);
	}

	@Override
	public List<Map> selectadCouponList() throws Exception {
		// TODO Auto-generated method stub
		return adminCustomerMapper.selectadCouponList();
	}

	@Override
	public List<EgovMap> selectJqCouponList(AdCustomJqgridVo adCustomJqgridVo)
			throws Exception {

		return adminCustomerMapper.selectJqCouponList(adCustomJqgridVo);
	}

	@Override
	public EgovMap selectJqCouponListCnt(AdCustomJqgridVo adCustomJqgridVo)
			throws Exception {

		return adminCustomerMapper.selectJqCouponListCnt(adCustomJqgridVo);
	}

	@Override
	public void saveJqgridTx(JSONArray jsonArray) throws Exception {

		int iLength1 = jsonArray.length();
		
		try{

			for (int i = 0; i < iLength1; i++) {
				
				JSONObject jsonObject = jsonArray.getJSONObject(i);

				Map<String, Object> param = JsonUtil.JsonToMap(jsonObject.toString());
				
				System.out.println(param);
				if("I".equals(param.get("editType"))) {
					
					adminCustomerMapper.insertJqgridCoupon(param);
				} else if ("U".equals(param.get("editType"))) {
					
					adminCustomerMapper.updateJqgridCoupon(param);
				}
			}
		} catch(Exception ex){
			throw ex;
		}
	}

}
