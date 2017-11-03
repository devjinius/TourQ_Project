package egovframework.example.footer.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.footer.service.FooterService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("footerService")
public class FooterServiceServiceImpl extends EgovAbstractServiceImpl implements FooterService {

	@Resource(name="footerMapper")
	private FooterMapper footerMapper;

	@Override
	public EgovMap storyRecent() throws Exception {

		return footerMapper.storyRecent();
	}

	@Override
	public EgovMap reviewRecent() throws Exception {

		return footerMapper.reviewRecent();
	}

}