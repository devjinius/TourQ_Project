package egovframework.example.adminCourse.web;

import java.io.File;
import java.sql.Array;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import egovframework.example.adminCourse.service.AdminCourseService;
import egovframework.example.adminCourse.service.CourseVo;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class AdminCourseIUDController {
	
	@Resource(name = "adminCourseService")
	private AdminCourseService adminCourseService;
	
	@RequestMapping(value = "courseIUD.do")
	public String courseIUD(HttpServletRequest request, @ModelAttribute CourseVo courseVo) throws Exception {

		courseVo.setStartTime(request.getParameterValues("startTime"));

		adminCourseService.courseDetailIUD(courseVo);
		
		String courseNumber = "";
		if (courseVo.getCourseNumber().equals("")) {

			EgovMap courseMap = adminCourseService.selectCourseNumber();
			courseNumber = String.valueOf(courseMap.get("seq"));
		} else if (courseVo.getCourseNumber() != null) {
			
			courseNumber = courseVo.getCourseNumber(); 
		}
		
		try {
			//파일업로드 -> enum으로 변경 필요함
			MultipartHttpServletRequest multi = (MultipartHttpServletRequest)request;
			
			//첨부파일의 갯수가 여러개 -> Iterator
			Iterator<String> iterator = multi.getFileNames();
			int index = 0;
			
			while(iterator.hasNext()){
				
				MultipartFile mfile = multi.getFile(iterator.next()); //해당 첨부파일 정보를 얻어온다.
				
				String temp = mfile.getOriginalFilename();
				if(index == 0) {
					
					temp = courseNumber + "_" + "1.jpg";
				} else {
					
					temp = courseNumber + "-" + index + ".jpg";
				}
				File file = new File(request.getSession().getServletContext().getRealPath("/")+"/images/uploads/course/"+temp);
				
				try {
					mfile.transferTo(file);//파일 업로드 실행
					index++;
				} catch (Exception e) {
					System.out.println(e.toString());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/adminCourse.do";
	}
	
	@RequestMapping(value = "adminCourseDelete.do")
	public String adminCourseDelete(HttpServletRequest request) throws Exception {

		Enumeration<String> attr = request.getParameterNames();
		
		while (attr.hasMoreElements()) {
			
			String attrName = (String) attr.nextElement();

			if (attrName.equals("checkbox")) {
				
				String[] values = request.getParameterValues("checkbox");
				
				adminCourseService.deleteCourse(values);
			}
			
		}
		
		return "redirect:/adminCourse.do";
	}
	
	@RequestMapping(value = "adminThemeDelete.do")
	public String adminThemeDelete(HttpServletRequest request) throws Exception {

		Enumeration<String> attr = request.getParameterNames();
		
		while (attr.hasMoreElements()) {
			
			String attrName = (String) attr.nextElement();

			if (attrName.equals("checkbox")) {
				
				String[] values = request.getParameterValues("checkbox");
				
				//adminCourseService.deleteTheme(values);
			}
			
		}
		
		return "redirect:/adminTheme.do";
	}
}
