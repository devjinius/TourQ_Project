package egovframework.example.customer.service.impl;
import org.springframework.stereotype.Service;













import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import egovframework.example.customer.service.CustomerService;
import egovframework.example.customer.service.CustomerVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("customerService")
public class CustomerServiceimpl extends EgovAbstractServiceImpl implements CustomerService {

	@Resource(name = "customerMapper")
	private CustomerMapper customerMapper;

	@Override
	public List<Map> selectNoticeList(CustomerVO customerVO) throws Exception {
		
		return customerMapper.selectNoticeList(customerVO);
	}

	@Override
	public List<Map> selectFaqList(CustomerVO customerVO) throws Exception {
		
		return customerMapper.selectFaqList(customerVO);
	}

	@Override
	public List<Map> selectManToManList() throws Exception {
		// TODO Auto-generated method stub
		return customerMapper.selectManToManList();
	}

	@Override
	public List<Map> selectManToManDetail(String number) throws Exception {
		return customerMapper.selectManToManDetail(number);
	}

	@Override
	public EgovMap noticeDetail(String boardNumber) throws Exception {

		return customerMapper.noticeDetail(boardNumber);
	}

	@Override
	public void updateCount(String boardNumber) throws Exception {

		customerMapper.updateCount(boardNumber);
	}

	@Override
	public EgovMap noticeListCnt(CustomerVO customerVO) throws Exception {

		return customerMapper.noticeListCnt(customerVO);
	}

	@Override
	public void insertAsk(Map askMap){

		customerMapper.insertAsk(askMap);
	}

	@Override
	public List<Map> faqTypeCnt() throws Exception {

		return customerMapper.faqTypeCnt();
	}

	@Override
	public EgovMap faqTotCnt() throws Exception {

		return customerMapper.faqTotCnt();
	}

}