package egovframework.example.adminMain.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminMainController {
	@RequestMapping(value = "adminMain.do")
	public String adminMain() throws Exception {
		return "adminMain/adminMain.atiles";
	}
}
