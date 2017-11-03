package egovframework.example.memberJoin.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PrivacyController {
	
	@RequestMapping(value = "privacy.do")
	public String privacy() throws Exception {

		return "memberJoin/privacy.tiles";
	}
}
