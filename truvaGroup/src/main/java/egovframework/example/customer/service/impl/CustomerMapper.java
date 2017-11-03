package egovframework.example.customer.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.example.customer.service.CustomerVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("customerMapper")
public interface CustomerMapper {

	List<Map> selectNoticeList(CustomerVO customerVO) throws Exception;

	List<Map> selectFaqList(CustomerVO customerVO) throws Exception;

	List<Map> selectManToManList() throws Exception;

	List<Map> selectManToManDetail(String number) throws Exception;

	EgovMap noticeDetail(String boardNumber) throws Exception;

	void updateCount(String boardNumber) throws Exception;

	EgovMap noticeListCnt(CustomerVO customerVO) throws Exception;

	void insertAsk(Map askMap);

	List<Map> faqTypeCnt() throws Exception;

	EgovMap faqTotCnt() throws Exception;
}
