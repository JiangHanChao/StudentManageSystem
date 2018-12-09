package com.es.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.es.dao.BaseDAO;
import com.es.dao.StudentDAO;
import com.es.model.Selected;

/**
 * Servlet implementation class SelectedCourseResult
 */
@WebServlet("/SelectedCourseResult")
public class SelectedCourseResult extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectedCourseResult() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("< view Selected Course Result >");
		response.setCharacterEncoding("utf-8");
		String number = request.getParameter("u_number");
		String role = request.getParameter("role");
		System.out.println("Student sno:"+number);
		List<Selected> list = null;
		
		try {
			list = StudentDAO.selectedCourseResult(number);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			BaseDAO.closeConnect();
		}
		
		if (list == null) {
			list = new ArrayList<>();
			list.add(new Selected());
			System.out.println("selected result is null");
		}else {
			System.out.println("selected result is getted");
		}
		
		request.setAttribute("list", list);
		
		System.out.println("< Selected Course Results success >");
		if (role == null) {
			getServletContext().getRequestDispatcher("/student_select_result.jsp").forward(request, response);
			return ;
		}else if (role.equals("admin")) {
			request.setAttribute("sno", number);
			getServletContext().getRequestDispatcher("/admin_delete_course.jsp").forward(request, response);
			return ;
		}else {
			getServletContext().getRequestDispatcher("/student_select_result.jsp").forward(request, response);
			return ;
		}
	}

}
