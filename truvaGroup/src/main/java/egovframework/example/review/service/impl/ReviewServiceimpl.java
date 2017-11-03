package egovframework.example.review.service.impl;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import egovframework.example.review.service.ReviewService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

import javax.annotation.Resource;

@Service("reviewService")
public class ReviewServiceimpl extends EgovAbstractServiceImpl implements ReviewService {

	@Resource(name = "reviewMapper")
	private ReviewMapper reviewMapper;

	@Override
	public List<Map> beforeList(String memberNumber) throws Exception {

		return reviewMapper.beforeList(memberNumber);
	}

	@Override
	public void insertReview(HashMap<String, Object> res) throws Exception {

		reviewMapper.insertReview(res);
	}

	@Override
	public void updateOrderYN(String orderNumber) throws Exception {

		reviewMapper.updateOrderYN(orderNumber);

	}

	@Override
	public List<Map> themeList() throws Exception {

		return reviewMapper.themeList();
	}

	@Override
	public List<Map> reviewList() throws Exception {

		return reviewMapper.reviewList();
	}

	@Override
	public EgovMap selectReview(String quotZero) throws Exception {

		return reviewMapper.selectReview(quotZero);
	}

	@Override
	public EgovMap totCnt() throws Exception {

		return reviewMapper.totCnt();
	}

	@Override
	public List<Map> themeCnt() throws Exception {

		return reviewMapper.themeCnt();
	}

	@Override
	public EgovMap selectReviewNumber() throws Exception {

		return reviewMapper.selectReviewNumber();
	}

}