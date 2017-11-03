package egovframework.example.memberJoin.web;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PasswordSearchController {

	@RequestMapping(value = "passwordSearchController.do")
	public String InitpasswordSearch() throws Exception {

		return "memberJoin/passwordSearch.tiles";
	}
}
