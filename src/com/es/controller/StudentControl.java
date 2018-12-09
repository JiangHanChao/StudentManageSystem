package com.es.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import com.es.model.Student;
import com.es.service.StudentService;

/**
 * Servlet implementation class SelectCourse
 */
@WebServlet("/SelectCourse")
public class StudentControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentControl() {
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
        PrintWriter out = response.getWriter();  
        String method = request.getParameter("method");
        String username = request.getParameter("username");
        Student u = new Student();
        u.setNumber(username);
        JSONArray courseList = null;
        if(method.equals("loadCourse")){
        	System.out.println("Load Course: "+username);
            try {
    			courseList = StudentService.getCourseList(u);
    		} catch (SQLException | JSONException e) {
    			e.printStackTrace();
    		}
            out.println(courseList);
            
        }
        else if(method.equals("searchCourse")){
        	System.out.println("Search Course: "+username);
        	String courseName = request.getParameter("coursename");
            try {
    			courseList = StudentService.getCourseListName(u,courseName);
    		} catch (SQLException | JSONException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
            out.println(courseList);
        }
        else if(method.equals("submitCourse")){
        	System.out.println("submit Course: "+username);
        	int courseCount = request.getParameterMap().size()-3;
        	List<String> selectedCourseList = new ArrayList<>();
        	for(int i=0;i<courseCount;i++){
        		selectedCourseList.add(request.getParameter("selectedIDs["+i+"]"));
        	}
        
			try {
				courseList=StudentService.selectCourse(u,selectedCourseList);
			} catch (JSONException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            out.println(courseList);
        }
        else if(method.equals("selectgrade")){
        	JSONArray gradeList = null;
        	System.out.println("select grade: "+username);
            try {
    			gradeList = StudentService.selectgrade(u);
    		} catch (SQLException | JSONException e) {
    			e.printStackTrace();
    		}
            out.println(gradeList);
        }else if(method.equals("selectInfo")) {
        	JSONArray studentInfo = null;
        	System.out.println("<view student Info:"+username+">");
            try {
            	studentInfo = StudentService.selectInfo(u);
    		} catch (SQLException | JSONException e) {
    			e.printStackTrace();
    		}
            out.println(studentInfo);
        }
        
        out.close();  
        
        
	}

}
