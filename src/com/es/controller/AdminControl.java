package com.es.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.es.model.Administrator;
import com.es.model.Course;
import com.es.model.Student;
import com.es.model.Teacher;
import com.es.service.AdminService;
import com.es.service.BaseService;

/**
 * Servlet implementation class AdminControl
 */
@WebServlet("/AdminControl")
public class AdminControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminControl() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/500.html").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("static-access")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		
		String method = request.getParameter("method");
        String username = request.getParameter("username");
        PrintWriter out = response.getWriter();
        
        Administrator u = new Administrator();
        u.setNumber(username);
        
        JSONArray jsonArray = new JSONArray();
        JSONObject jsonObject = new JSONObject();
        
        if (method.equals("deleteCourse")) {
        	System.out.println("< Cancle Course >");
        	String cno = request.getParameter("cno");
        	boolean ret = AdminService.deleteCourse(username, cno);
        	if (ret) {
        		out.println("{statuCode:1}");
				System.out.println("< Cancle Course success >");
			}else {
				out.println("{statuCode:0}");
				System.out.println("< Cancle Course failed >");
			}
		}
        else if (method.equals("updategrade")) {
        	System.out.println("< Update Grade >");
        	String coursename = request.getParameter("coursename");
            int score = Integer.parseInt(request.getParameter("score"));
            System.out.println("update grade: "+username);
            JSONArray statusCode = null;
			try {
				statusCode = AdminService.updategrade(username, coursename, score);
			} catch (SQLException | JSONException e) {
				e.printStackTrace();
			}finally {
				BaseService.closeConnect();
			}
            
            System.out.println("< update grade result> "+statusCode);
            out.println(statusCode);
		}
        else if(method.equals("insertstudent")){
        	System.out.println("insert student");
        	username = request.getParameter("username");
        	String sname = request.getParameter("user_name");//姓名
        	System.out.println("sno:"+username+"  name:"+sname);
        	int grade = Integer.parseInt(request.getParameter("grade"));//年级
            String major = request.getParameter("major");//专业
            String brith = request.getParameter("brith"); // 生日
            int age = Integer.parseInt(request.getParameter("age"));//年龄
            String sex = request.getParameter("sex"); //性别
            String politc = request.getParameter("politc"); //政治面貌
            String admission = request.getParameter("admission");
            String profile = request.getParameter("profile");//个人简介
            String familyaddress = request.getParameter("familyaddress");
            String postcode = request.getParameter("postcode");
           
        	Student u1 = new Student();
            u1.setNumber(username);
            u1.setName(sname);
            u1.setGrade(grade);
            u1.setMajor(major);
            u1.setBirth(brith);
            u1.setAge(age);
            u1.setSex(sex);
            u1.setPolitc(politc);
            u1.setAdmission(admission);
            u1.setProfile(profile);
            u1.setFamilyaddr(familyaddress);
            u1.setPostcode(postcode);
            u1.setPassword("000001");//学生的默认密码
            
        	try {
				jsonObject = AdminService.insertstudent(u1);
			} catch (SQLException | JSONException e) {
				
				e.printStackTrace();
			}
        	out.println(jsonObject);
        }
        else if(method.equals("insertteacher")){
        	System.out.println("insert teacher");
        	username = request.getParameter("username");
        	System.out.println(username);
        	String sname = request.getParameter("user_name");//姓名
        	System.out.println(sname);
        	Teacher u1 = new Teacher();
            u1.setNumber(username);
            u1.setName(sname);
            u1.setPassword("123456");//老师的默认密码
        	try {
				jsonObject = AdminService.insertteacher(u1);
			} catch (SQLException | JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	out.println(jsonObject);
        }
        else if(method.equals("insertCourse")){
        	System.out.println("insert course");
        	String cno = request.getParameter("cno");
        	String cname = request.getParameter("cname");//姓名
        	String cteacher = request.getParameter("cteacher");
        	String climit = request.getParameter("climit");
        	String cgrade = request.getParameter("cgrade");
        	Course c = new Course();
            c.setNumber(cno);
            c.setName(cname);
            c.setTeacherNum(cteacher);
            c.setLimitNum(Integer.parseInt(climit));
            c.setSemester(Integer.parseInt(cgrade));
        	try {
				jsonObject = AdminService.insertCourse(c);
			} catch (SQLException | JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	out.println(jsonObject);
        }
        else if(method.equals("selectAllStudent")){
        	try {
        		jsonArray = AdminService.getStudentList(u,"%");
    		} catch (SQLException | JSONException e) {
    			e.printStackTrace();
    		}
        	out.println(jsonArray);
        }
        else if(method.equals("searchStudent")){
        	String s_number = request.getParameter("s_number");
        	try {
				jsonArray = AdminService.getStudentList(u,s_number);
			} catch (SQLException | JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	out.println(jsonArray);
        	
        }
        else if(method.equals("deleteStudent")){
        	String s_number = request.getParameter("s_number");
        	try {
				jsonObject = AdminService.deleteStudent(u,s_number);
			} catch (SQLException | JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	out.println(jsonObject);
        }
        else if(method.equals("updateStudent")){
        	Student s = new Student();
        	s.setNumber(request.getParameter("s_number"));
        	s.setName(request.getParameter("s_name"));
        	s.setPassword(request.getParameter("s_password"));
        	s.setGrade(Integer.parseInt(request.getParameter("s_grade")));
        	s.setMajor(request.getParameter("s_major"));
        	s.setBirth(request.getParameter("s_birth"));
        	s.setAge(Integer.parseInt(request.getParameter("s_age")));
        	s.setSex(request.getParameter("s_sex"));
        	s.setPolitc(request.getParameter("s_politc"));
        	s.setAdmission(request.getParameter("s_admission"));
        	s.setProfile(request.getParameter("s_profile"));
        	s.setFamilyaddr(request.getParameter("s_familyaddress"));
        	s.setPostcode(request.getParameter("s_postcode"));
        	try {
				jsonObject = AdminService.updateStudent(u,s);
			} catch (JSONException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	out.println(jsonObject);
        }
        else if(method.equals("selectAllCourse")){
        	try {
        		jsonArray = AdminService.getCourseList(u,"%");
    		} catch (SQLException | JSONException e) {
    			e.printStackTrace();
    		}
        	out.println(jsonArray);
        }
        else if(method.equals("searchCourse")){
        	String c_number = request.getParameter("c_number");
        	try {
				jsonArray = AdminService.getCourseList(u,c_number);
			} catch (SQLException | JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	out.println(jsonArray);
        	
        }
/*        else if(method.equals("deleteCourse")){
        	String c_number = request.getParameter("c_number");
        	try {
				jsonObject = AdminService.deleteCourse(u,c_number);
			} catch (SQLException | JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	out.println(jsonObject);
        }*/
/*        else if(method.equals("updateCourse")){
        	Course c = new Course();
        	c.setNumber(request.getParameter("c_number"));
        	c.setName(request.getParameter("c_name"));
        	c.setTeacherNum(request.getParameter("c_teacher"));
        	c.setLimitNum(Integer.parseInt(request.getParameter("c_limit")));
        	c.setSemester(Integer.parseInt(request.getParameter("c_semester")));
        	try {
				jsonObject = AdminService.updateCourse(u,c);
			} catch (JSONException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	out.println(jsonObject);
        }*/
        else if(method.equals("selectTeacherList")){
        	try {
				jsonArray = AdminService.selectTeacherList(u);
			} catch (SQLException | JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	out.println(jsonArray);
        }
        else if(method.equals("selectAllTeacher")){
        	try {
        		jsonArray = AdminService.getTeacherList(u,"%");
    		} catch (SQLException | JSONException e) {
    			e.printStackTrace();
    		}
        	out.println(jsonArray);
        }
        else if(method.equals("searchTeacher")){
        	String s_number = request.getParameter("s_number");
        	try {
				jsonArray = AdminService.getTeacherList(u,s_number);
			} catch (SQLException | JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	out.println(jsonArray);
        	
        }
        else if(method.equals("deleteTeacher")){
        	String s_number = request.getParameter("s_number");
        	try {
				jsonObject = AdminService.deleteTeacher(u,s_number);
			} catch (SQLException | JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	out.println(jsonObject);
        }
        else if(method.equals("updateTeacher")){
        	Teacher s = new Teacher();
        	s.setNumber(request.getParameter("s_number"));
        	s.setName(request.getParameter("s_name"));
        	s.setPassword(request.getParameter("s_password"));
        	try {
				jsonObject = AdminService.updateTeacher(u,s);
			} catch (JSONException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	out.println(jsonObject);
        }
        out.close();
		return ;
	}

}
