package com.es.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.es.common.Info;
import com.es.model.Administrator;
import com.es.model.Course;
import com.es.model.Student;
import com.es.model.Teacher;

public class AdministratorDAO extends BaseDAO {
	@SuppressWarnings("unused")
	private static final String TAG = AdministratorDAO.class.getSimpleName();
	
    public static boolean insert(Student u){
		if (u.getNumber()==null) {
			return false;
		}
		openConnection();
		String sql = "INSERT INTO ES_student values(?,?,?,?,?,? , ?,?,?,?,?,? , ?); ";
		pstmt = getPStatement(sql);
		String pwd = u.getPassword();
		if (pwd.isEmpty()) {
			pwd = Info.DefaultPassword;
		}
        try {
        	pstmt.setString(1,u.getNumber());  
			pstmt.setString(2,u.getName());
			pstmt.setString(3, pwd);
			pstmt.setString(4, u.getBirth());
			pstmt.setInt(5, u.getAge());
			pstmt.setString(6, u.getSex());
			pstmt.setString(7, u.getPolitc());
			pstmt.setString(8, u.getAdmission());
			pstmt.setString(9, u.getProfile());
			pstmt.setString(10, u.getFamilyaddr());
			pstmt.setString(11, u.getPostcode());
	    	pstmt.setInt(12,u.getGrade());
	    	pstmt.setString(13,u.getMajor());
			int ret = pstmt.executeUpdate();
			if (ret == 1) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
        finally {
			closeConnect();
		}
		
		return false;
	}
    
    public static boolean insert(Teacher u){
    	if (u.getNumber()==null) {
			return false;
		}
    	openConnection();
    	String sql = "INSERT INTO ES_teacher values(?, ?, ?); ";
		pstmt = getPStatement(sql);
		String pwd = u.gettPassword();
		if (pwd.isEmpty()) {
			pwd = Info.DefaultPassword;
		}
        try {
        	pstmt.setString(1,u.getNumber());  
			pstmt.setString(2,u.getName());
			pstmt.setString(3, pwd);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
        finally {
			closeConnect();
		}
		return true;
	}
    
    public static boolean insert(Course c){
    	if (c.getNumber()==null) {
			return false;
		}
    	openConnection();
    	String sql = "INSERT INTO ES_course values(?, ?, ?, ?, ?, ?)";
		pstmt = getPStatement(sql);
		
        try {
        	pstmt.setString(1,c.getNumber());
			pstmt.setString(2,c.getName());
			pstmt.setString(3, c.getTeacherNum());
			pstmt.setLong(4, c.getLimitNum());
			pstmt.setLong(5, c.getSelectedNum());
			pstmt.setLong(6, c.getSemester());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
        finally {
			closeConnect();
		}
		return true;
	}
    
    public static boolean delete(Student u) {
		if (u == null) {
			return false;
		}
    	openConnection();
    	String sql = "DELETE FROM ES_student where sno = ?;";
    	pstmt = getPStatement(sql);
    	
    	try {
			pstmt.setString(1, u.getNumber());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConnect();
		}
    	
    	return true;
	}
    
    public static boolean delete(Teacher u) {
    	if (u == null) {
			return false;
		}
    	openConnection();
    	String sql = "DELETE FROM ES_teacher where tno = ?;";
    	pstmt = getPStatement(sql);
    	
    	try {
			pstmt.setString(1, u.getNumber());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConnect();
		}
    	
    	return true;
	}
    
    public static boolean delete(Course c) {
    	if (c == null) {
			return false;
		}
    	openConnection();
    	String sql = "DELETE FROM ES_course where cno = ?;";
    	pstmt = getPStatement(sql);
    	
    	try {
			pstmt.setString(1, c.getNumber());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConnect();
		}
    	
    	return true;
	}
    
    public static boolean updata(Student u) {
    	String sql= "UPDATE ES_student SET sname =?,grade=?,major=?,sbirth=?,sage=?,ssex=?,spolitc=?,sadmission=?,sprofile=?,"
    			+ "sfamilyaddr=?,spostcode=?,spasswd=? WHERE sno = ?;";
    	
    	openConnection();
    	pstmt = getPStatement(sql);
    	
    	try {
	    		pstmt.setString(1, u.getName());
				pstmt.setLong(2, u.getGrade());
				pstmt.setString(3, u.getMajor());
				pstmt.setString(4, u.getBirth());
				pstmt.setInt(5, u.getAge());
				pstmt.setString(6, u.getSex());
				pstmt.setString(7, u.getPolitc());
				pstmt.setString(8, u.getAdmission());
				pstmt.setString(9, u.getProfile());
				pstmt.setString(10, u.getFamilyaddr());
				pstmt.setString(11, u.getPostcode());
				pstmt.setString(12, u.getPassword());
				pstmt.setString(13, u.getNumber());
    			int ret = pstmt.executeUpdate(); 
    			if(ret == 1) {
    				System.out.println("< 更新成功 >");
    				return true;  
    			}
    			 		
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}finally{
    		closeConnect();
    	}
    	System.out.println("< 更新失败 >");
    	return false;
    }
    
    public static boolean updata(Teacher u) {
    	
    	String sql= "UPDATE ES_teacher set tname=?,tpasswd=? WHERE tno=?; ";
    	openConnection();
    	pstmt = getPStatement(sql);
    	
    	try {
    			pstmt.setString(3, u.getNumber());
    			pstmt.setString(1,u.getName());
    			pstmt.setString(2,u.gettPassword());
    			pstmt.executeUpdate();    		
    			System.out.println("< 更新成功 >");
    			return true;   		
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}finally{
    		closeConnect();
    	}
    	System.out.println("< 更新失败 >");
    	return false;
    }
    
    public static boolean updata(Course u) {
    	
    	String sql= "UPDATE ES_course set cname=?,teacher_tno=?,limit_num=?,selected_num=?,semester=? WHERE cno=?; ";
    	openConnection();
    	pstmt = getPStatement(sql);
    	
    	try {
    			pstmt.setString(6, u.getNumber());
    			pstmt.setString(1,u.getName());
    			pstmt.setString(2,u.getTeacherNum());
    			pstmt.setInt(3,u.getLimitNum());
    			pstmt.setInt(4, u.getSelectedNum());
    			pstmt.setInt(5, u.getSemester());
    			pstmt.executeUpdate();    		
    			System.out.println("< 更新成功 >");
    			return true;
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}finally{
    		closeConnect();
    	}
    	System.out.println("< 更新失败 >");
    	return false;
    }
    
    public static boolean updatePwd(String anumber, String password, String newpwd){
    	anumber = ReformatBlank(anumber);
		password = ReformatBlank(password);
		newpwd = ReformatBlank(newpwd);
		
		String sql = "UPDATE ES_administrator SET apasswd= ? WHERE ano = ?";
		
		// 检查密码是否正确
		if (login(anumber, password) == null) {
			return false;
		}
		// 执行更新密码
		openConnection();
		pstmt = getPStatement(sql);
		
		try {
			pstmt.setString(1, newpwd);
			pstmt.setString(2, anumber);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {	
			closeConnect();
		}
		
		return true;
	}
    
    public static Administrator login(String name, String pwd){
    	//SQL查询模板
    	String sql = "SELECT * FROM ES_administrator WHERE ano=?;";
    	
    	Administrator u = new Administrator();
    	openConnection();
    	
    	try {
    		pstmt = getPStatement(sql);
    		pstmt.setString(1, name);
    		
    		ResultSet result = pstmt.executeQuery();
    		
    		if(result.next()){
    			String spwd = result.getString("apasswd");
    			u.setPassword(spwd);
    			
    			if(u.isValid(pwd)){
    				u.setNumber(name);
    				u.setName(result.getString("aname"));
    				System.out.println("User Login:"+result.getString("aname"));
    				setCacheMap(name, "admin");
    				
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
    
}
