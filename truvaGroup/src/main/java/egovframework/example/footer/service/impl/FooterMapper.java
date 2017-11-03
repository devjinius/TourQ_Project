package egovframework.example.footer.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Mapper("footerMapper")
public interface FooterMapper {

	EgovMap storyRecent() throws Exception;

	EgovMap reviewRecent() throws Exception;

}