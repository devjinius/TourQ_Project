package egovframework.example.uploadPicture.web;

import java.io.File;
import java.io.PrintWriter;
import java.sql.Array;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import egovframework.example.adminCourse.service.AdminCourseService;
import egovframework.example.adminCourse.service.CourseVo;
import egovframework.example.cmmn.JsonUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class UploadPictureController {
	
	@RequestMapping(value = "uploadStory.do")
	public void uploadStory(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String fileName = "";
		try {
			//파일업로드 -> enum으로 변경 필요함
			MultipartHttpServletRequest multi = (MultipartHttpServletRequest)request;
			
			//첨부파일의 갯수가 여러개 -> Iterator
			Iterator<String> iterator = multi.getFileNames();
			
			while(iterator.hasNext()){
				
				MultipartFile mfile = multi.getFile(iterator.next()); //해당 첨부파일 정보를 얻어온다.
				
				String temp = mfile.getOriginalFilename();
				fileName = mfile.getOriginalFilename();
					
				File file = new File(request.getSession().getServletContext().getRealPath("/")+"/images/uploads/blog/"+temp);
				
				try {
					mfile.transferTo(file);//파일 업로드 실행
					
				} catch (Exception e) {
					System.out.println(e.toString());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		PrintWriter out = null;
		
		response.setCharacterEncoding("UTF-8");
		
		out = response.getWriter();

		String funcNum = request.getParameter("CKEditorFuncNum");
		String fileUrl = "images/uploads/blog/" + fileName;
		out.write("<script>window.parent.CKEDITOR.tools.callFunction(" + funcNum + ", '" + fileUrl + "');</script>");

	}
}
