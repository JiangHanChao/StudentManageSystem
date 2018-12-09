package com.es.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.es.model.Teacher;

public class TeacherDAO extends BaseDAO {
	public static void match(Teacher u){
		
	}
    public static Teacher login(String name, String pwd){
    	//SQL model
    	String sql = "SELECT * FROM ES_teacher WHERE tno=?;";
    	openConnection();
    	
    	Teacher u = new Teacher();
    	
    	try {
    		pstmt = getPStatement(sql);
    		pstmt.setString(1, name);
    		ResultSet result = pstmt.executeQuery();
    		
    		if(result.next()){
    			String spwd = result.getString("tpasswd");
    			u.setPassword(spwd);
    			
    			if(u.isValid(pwd)){
    				u.setName(result.getString("tname"));
    				u.setNumber(name);
    				System.out.println("User Login:"+u.getName());
    				setCacheMap(name, "teacher");
    				
        			return u;
    			}
    		}
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}finally{
    		closeConnect();
    	}
    	return null;
	}
    public static boolean updatePwd(String tnumber, String password, String newpwd){
    	tnumber = ReformatBlank(tnumber);
		password = ReformatBlank(password);
		newpwd = ReformatBlank(newpwd);
		String sql = "UPDATE ES_teacher SET tpasswd= ? WHERE tno = ?";
		
		// 检查密码是否正确
		if (login(tnumber, password) == null) {
			return false;
		}
		
		// 执行更新密码
		openConnection();
		pstmt = getPStatement(sql);
		
		try {
			pstmt.setString(1, newpwd);
			pstmt.setString(2, tnumber);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {	
			closeConnect();
		}
		
		return true;
	}
}
