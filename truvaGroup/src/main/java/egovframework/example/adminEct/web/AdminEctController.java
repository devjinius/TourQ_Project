package egovframework.example.adminEct.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminEctController {
	
	@RequestMapping(value = "adminCode.do")
	public String adminCode() throws Exception {
		return "adminEct/adminCode.atiles";
	}
}
