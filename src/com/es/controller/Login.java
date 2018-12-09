package com.es.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.es.dao.AdministratorDAO;
import com.es.dao.StudentDAO;
import com.es.dao.TeacherDAO;
import com.es.model.Administrator;
import com.es.model.Student;
import com.es.model.Teacher;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final String errorCode = "-1";
    private final String successCode = "0";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		System.out.println("< Login >");
		
    	response.setContentType("application/json");
    	response.setCharacterEncoding("utf-8");
        response.setStatus(response.SC_MOVED_TEMPORARILY);
    	
    	String role = request.getParameter("role");
		String username = request.getParameter("es_number");
		String password = request.getParameter("es_pwd");
		
		System.out.println("Tologin User: "+username+" pwd: "+password);
		
		if (role.equals("student")) {
			Student user = StudentDAO.login(username, password);
			if (user == null) {
				System.out.println("login failed :"+username);
				request.setAttribute("u_error", errorCode);
				getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
				return ;
			}else{
				request.setAttribute("u_error", successCode);
				request.setAttribute("u_number", user.getNumber());
		    	request.setAttribute("u_name", user.getName());
		    	request.setAttribute("u_grade", user.getGradeString());
		    	request.setAttribute("u_major", user.getMajor());
		    	getServletContext().getRequestDispatcher("/student_index.jsp").forward(request, response);
		    	return;
			}
	    	
		}else if(role.equals("teacher")){
			Teacher user = TeacherDAO.login(username, password);
			if (user == null) {
				System.out.println("login failed :"+username);
				request.setAttribute("u_error", errorCode);
				getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
				return ;
			}
			else{
				request.setAttribute("u_error", successCode);
				request.setAttribute("u_number", user.getNumber());
		    	request.setAttribute("u_name", user.getName());
		    	getServletContext().getRequestDispatcher("/teacher_index.jsp").forward(request, response);
		    	return;
			}
		}else if (role.equals("admin")) {
			Administrator user = AdministratorDAO.login(username, password);
			if (user == null) {
				System.out.println("login failed :"+username);
				request.setAttribute("u_error", errorCode);
				getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
				return ;
			}
			else{
				request.setAttribute("u_error", successCode);
				request.setAttribute("u_number", user.getNumber());
		    	request.setAttribute("u_name", user.getName());
		    	getServletContext().getRequestDispatcher("/admin_index.jsp").forward(request, response);
		    	return;
			}
			
		}else {
			getServletContext().getRequestDispatcher("/404.html").forward(request, response);
		}
	}

}
