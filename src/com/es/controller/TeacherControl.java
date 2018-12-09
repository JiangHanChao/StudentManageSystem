package com.es.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;

import com.es.model.Teacher;
import com.es.service.TeacherService;

/**
 * Servlet implementation class ShowCourse
 */
@WebServlet("/ShowCourse")
public class TeacherControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TeacherControl() {
        super();
        // TODO Auto-generated constructor stub
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
        PrintWriter out = response.getWriter();  
        
        System.out.println("link success");
        
        String username = request.getParameter("username");
        String method = request.getParameter("method");
        
        Teacher u = new Teacher();
        u.setNumber(username);
        JSONArray jsonArray = new JSONArray();
        System.out.println("Load Course: "+username);
        //
        if(method.equals("loadCourse")){
        	try {
        		jsonArray = TeacherService.getCourseList(u);
    		} catch (SQLException | JSONException e) {
    			e.printStackTrace();
    		}
        }
        else if(method.equals("loadCourseStudent")){
        	String cno = request.getParameter("courseNumber");
        	try {
				jsonArray = TeacherService.getCourseStudentList(u,cno);
			} catch (JSONException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
        else if(method.equals("updateGrade")){
        	int courseCount = (request.getParameterMap().size()-3)/2;
        	String cno = request.getParameter("cno");
        	Map<String,String> CourseGradeList = new HashMap<String, String>();
        	for(int i=0;i<courseCount;i++){
        		System.out.println(request.getParameter("cno[" + i + "]")+" "+request.getParameter("grade[" + i + "]"));
        		CourseGradeList.put(request.getParameter("cno[" + i + "]"),request.getParameter("grade[" + i + "]"));
        	}
        	try {
				jsonArray = TeacherService.updateCourseGrade(u,cno,CourseGradeList);
			} catch (JSONException | SQLException e) {
				e.printStackTrace();
			}
        }
        out.println(jsonArray);  
        out.close();  
	}

}
