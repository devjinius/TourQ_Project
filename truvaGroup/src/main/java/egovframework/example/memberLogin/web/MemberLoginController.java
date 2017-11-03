package egovframework.example.memberLogin.web;

import java.io.PrintWriter;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import egovframework.example.memberLogin.service.LoginVO;
import egovframework.example.memberLogin.service.MemberLoginService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class MemberLoginController {
	
	@Resource(name = "memberLoginService")
	private MemberLoginService memberLoginService; 
	
	@RequestMapping(value = "memberLogin.do")
	public String memberLogin() throws Exception {

		return "loginCheck/memberLogin.tiles";
	}
	
	@RequestMapping(value = "memberLogout.do")
	public String memberLogout(HttpServletRequest request, HttpSession session) throws Exception {
		
		// logout을 눌렀을 때 memberSession값이 있다면
		if(session.getAttribute("memberSession")!=null) {
			
			// 세션에서 memberSession을 지웁니다.
			session.removeAttribute("memberSession");
			session.removeAttribute("memberNumber");
		}
		
		return "redirect:/main.do";
	}
	
	@RequestMapping(value = "loginOk.do")
	public void loginOk(HttpServletRequest request, HttpSession session, HttpServletResponse response) throws Exception {
		
		PrintWriter out = null;
		response.setCharacterEncoding("UTF-8");
		out = response.getWriter();
		
		// 아이디와 패스워드를 받아옵니다.
		String memberId = request.getParameter("memberId");
		String memberPw = request.getParameter("memberPw");
		
		// 아이디로 member.*을 조회해 옵니다.
		// 메서드명은 getPw지만 실제로는 한 줄 다 가져옵니다.
		EgovMap memberInfo = memberLoginService.getPw(memberId);
		
		// 입력한 id가 db에없으면 memberInfo가 null입니다.
		if(memberInfo != null){
			
			// null이 아니니까 id가 db에 있는경우
			
			// 받아온 memberInfo에서 비밀번호만 꺼냅니다.
			String dbPw = (String) memberInfo.get("memberPw");
			
			// 입력받은 비밀번호와 DB의 비밀번호가 일치하는지 검사합니다.
			if (dbPw.equals(memberPw)) {
				
				//같다면 세션에 저장하고 SUCCESS를 반환합니다.
				session.setAttribute("memberSession", memberInfo);
				session.setAttribute("memberNumber", memberInfo.get("memberNumber"));
				System.out.println(session.getAttribute("memberSession"));
				
				out.write("SUCCESS");
			} else {

				// 비밀번호가 다르다면 FAIL을 반환합니다.
				out.write("FAIL");
			}
		} else {
			
			//입력한 id가 DB에는 있으나 비밀번호가 틀리면 FAIL을 반환합니다.
			out.write("FAIL");
		}
		
	}
	
	// LOGIN시도 후 SUCCESS를 반환하고 여기로 옵니다.
	@RequestMapping(value = "logingo.do")
	public String logingo() throws Exception {

		return "redirect:/main.do";
	}
	
	
	@RequestMapping(value = "memberJoin.do")
	public String memberJoin() throws Exception {

		return "memberJoin/memberJoin.tiles";
	}
	
	@RequestMapping(value = "validateDup.do")
	public void validateDup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		PrintWriter out = null;
		response.setCharacterEncoding("UTF-8");
		out = response.getWriter();
		
		EgovMap memberInfo = memberLoginService.getPw(request.getParameter("memberId"));

		// null이 아니면(중복되는 id가 있으면)
		if (memberInfo != null) {	
			
			out.write("DUPLICATE");
		} else {
			
			// null이면(중복값이 없다면)
			out.write("OK");
		}
	}
	
	@RequestMapping(value = "register.do")
	public String register(HttpServletRequest request, @ModelAttribute LoginVO loginVO) throws Exception {
		
		// 회원번호가 있다면 회원정보 수정을 합니다.
		if (request.getParameter("memberNumber") != null) {
			
			loginVO.setMemberPw(request.getParameter("memberPwRe"));
			loginVO.setMemberNumber(request.getParameter("memberNumber"));
			
			memberLoginService.updateMemberInfo(loginVO);
			
			return "redirect:/myInfo.do"; 
		} else {
			
			// 회원번호가 없다면 회원가입 처리를 합니다.(insert)
			try {
				
				loginVO.setMemberPw(request.getParameter("memberPwRe"));
				memberLoginService.register(loginVO);
				
				EgovMap memberNumberMap = memberLoginService.selectRecMn();
				
				//회원가입을 하면 포인트 5000점을 줍니다.
				memberLoginService.insertPoint(memberNumberMap);
			} catch (Exception e) {
				
				// 이상이있으면 회원가입에 문제가있으니 에러 페이지로 이동합니다.
				e.printStackTrace();
				return "memberJoin/memberJoinNotComplete.tiles";
			}

			// 이상없으면 회원가입 완료 페이지로 이동합니다.
			return "memberJoin/memberJoinComplete.tiles";
		}
		
	}
}
