package com.es.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.es.common.DBUtil;
import com.es.dao.AdministratorDAO;
import com.es.dao.BaseDAO;
import com.es.dao.StudentDAO;
import com.es.dao.TeacherDAO;

/**
 * Servlet implementation class BaseControl
 */
@WebServlet("/BaseControl")
public class BaseControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String error = "0";
    private static final String success = "1";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BaseControl() {
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
        JSONObject obj = new JSONObject();
    	
        String method       = request.getParameter("method");
        String number       = request.getParameter("username");			//学号、教师号、管理员号
        number = DBUtil.ReformatBlank(number);
		
		if(method.equals("updatePwd")){
			System.out.println("< modify password >");
			String role = BaseDAO.getCacheFlag(number);
			String oldPassword = request.getParameter("oldPassword");		//原密码
			String password     = request.getParameter("newPassword");		//新密码
			boolean ret = false;
			
			System.out.println("User: " + number + " will modify: "+oldPassword+" to: "+password);
			System.out.println("modify Type: "+role);
			
			if(role.equals("student")){
				ret = StudentDAO.updatePwd(number, oldPassword, password);
			}
			else if(role.equals("teacher")){
				ret = TeacherDAO.updatePwd(number, oldPassword, password);
			}
			else if(role.equals("admin")){
				ret = AdministratorDAO.updatePwd(number, oldPassword, password);
			}else {
				System.out.println("Type not found.");
				ret = false;
			}
			
			if (ret) {
				System.out.println("< modify success >");
				try {
					obj.append("statusCode", success);
				} catch (JSONException e) {
					e.printStackTrace();
				}
			}else{
				System.out.println("< modify failed >");
				try {
					obj.append("statusCode", error);
				} catch (JSONException e) {
					e.printStackTrace();
				}
			}
			out.println(obj);
			out.close();
		}
	}

}
