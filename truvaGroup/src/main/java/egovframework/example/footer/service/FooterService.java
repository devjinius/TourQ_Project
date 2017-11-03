package egovframework.example.footer.service;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface FooterService {

	EgovMap storyRecent() throws Exception;

	EgovMap reviewRecent() throws Exception;

}