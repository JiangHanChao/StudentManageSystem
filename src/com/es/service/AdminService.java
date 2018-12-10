package com.es.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.es.dao.CourseDAO;
import com.es.model.Administrator;
import com.es.model.Course;
import com.es.model.Selected;
import com.es.model.Student;
import com.es.model.Teacher;

public class AdminService extends BaseService {
	public static boolean deleteCourse(String sno, String cno) {
		Selected s = new Selected();
		s.setCno(cno);
		s.setSno(sno);
		return CourseDAO.DeleteCourse(s);
	}
	
	public static JSONArray updategrade(String sno, String cno, int score) throws SQLException, JSONException{
		JSONArray flag = new JSONArray();
		JSONObject obj = new JSONObject();
		Selected u = new Selected();
		u.setCno(cno);
		u.setSno(sno);
		u.setScore(score);
		
		String error1 = "0";
    	String error2 = "1";
    	String error3 = "2";
        String success = "3";
        
        int a = 0,b = 0,c = 0;
        
    	openConnection();
    	
    	String updategradeSql = "SELECT * FROM ES_student WHERE sno=?";
		pstmt = getPStatement(updategradeSql);
		pstmt.setString(1,u.getSno());
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()){
			a=1;
		}else{
			obj.put("statusCode",error1);
		}
		rs.close();
		
		System.out.println(obj);
    	
		updategradeSql = "SELECT * FROM ES_course WHERE cno=?";
		pstmt = getPStatement(updategradeSql);
		pstmt.setString(1,u.getCno());
		rs = pstmt.executeQuery();
		if(rs.next()){
			b=1;
		}else if(a==1){
			obj.put("statusCode",error2);
		}
		rs.close();
		
		System.out.println(obj);
		
		updategradeSql = "SELECT * FROM ES_selected WHERE student_sno=? AND course_cno=?";
		pstmt = getPStatement(updategradeSql);
		pstmt.setString(1,u.getSno());
		pstmt.setString(2,u.getCno());
		rs = pstmt.executeQuery();
		if(rs.next()){
			c = 1;
		}else if(a == 1 && b == 1){
			obj.put("statusCode",error3);
		}
		rs.close();
		
		System.out.println(obj);
		
		
    	updategradeSql = "UPDATE ES_selected SET score=? WHERE student_sno=? AND course_cno=?;";
		pstmt = getPStatement(updategradeSql);
		pstmt.setInt(1,u.getScore());
		pstmt.setString(2,u.getSno());
		pstmt.setString(3,u.getCno());
		if(a == 1 && b == 1 && c == 1 && pstmt.executeUpdate()==1){
			obj.put("statusCode",success);
		}else if(a == 1 && b == 1 && c == 1){
			obj.put("statusCode",error3);
		}
		
		
		flag.put(obj);
		System.out.println(obj);
		System.out.println(flag);
		
		return flag;
    }
	
	public static JSONArray getStudentList(Administrator u,String s_number) throws SQLException, JSONException {
		// TODO Auto-generated method stub
		JSONArray courseList = new JSONArray(); 	
    	String studentSql = "SELECT * FROM ES_student WHERE sno LIKE ?;";
    	openConnection();
		pstmt = getPStatement(studentSql);
		pstmt.setString(1, "%"+s_number+"%");
		ResultSet result = pstmt.executeQuery();
		while(result.next()){
			JSONObject obj= new JSONObject ();
			obj.put("u_no", result.getString("sno"));
			obj.put("u_name", result.getString("sname"));
			obj.put("u_grade", result.getString("grade"));
			obj.put("u_major", result.getString("major"));
			courseList.put(obj);
		}
		
		if(courseList.length()==0){
			JSONObject obj= new JSONObject ();
			obj.put("u_no", "-1");
			obj.put("u_name", "-1");
			obj.put("u_grade", "-1");
			obj.put("u_major", "-1");
			courseList.put(obj);
		}
		result.close();


		closeConnect();
		return courseList;
	}

	public static JSONObject deleteStudent(Administrator u, String s_number) throws SQLException, JSONException {
		// TODO Auto-generated method stub
		JSONObject obj= new JSONObject ();
    	String studentSql = "DELETE  FROM ES_student WHERE sno = ?;";
    	String selectedSql = "SELECT * FROM ES_selected WHERE student_sno = ?;";
    	openConnection();
    	pstmt = getPStatement(selectedSql);
		pstmt.setString(1, s_number);
		ResultSet result = pstmt.executeQuery(); 
		if(result.next()){
			obj.put("statusCode", 1);//外键约束问题
		}
		else{
			pstmt = getPStatement(studentSql);
			pstmt.setString(1, s_number);
			int ret = pstmt.executeUpdate();
			if(ret==1){
				obj.put("statusCode", 0);//删除成功
			}
			else{
				obj.put("statusCode", 2);//其他问题，删除失败
			}
		}
		result.close();
		closeConnect();
		return obj;
	}

	public static JSONObject updateStudent(Administrator u, Student s) throws JSONException, SQLException {
		
		JSONObject obj= new JSONObject ();
    	String studentSqlU1 = "UPDATE ES_student SET sname =?,grade=?,major=?,sbirth=?,sage=?,ssex=?,spolitc=?,sadmission=?,sprofile=?,"
    			+ "sfamilyaddr=?,spostcode=?,spasswd=? WHERE sno = ?;";
    	String studentSqlU2 = "UPDATE ES_student SET sname =?,grade=?,major=?,sbirth=?,sage=?,ssex=?,spolitc=?,sadmission=?,sprofile=?,"
    			+ "sfamilyaddr=?,spostcode=? WHERE sno = ?;";
    	String studentSqlQ = "SELECT * FROM ES_student WHERE sno = ?;";
    	openConnection();
    	pstmt = getPStatement(studentSqlQ);
		pstmt.setString(1, s.getNumber());
		ResultSet result = pstmt.executeQuery(); 
		int ret=0;
		if(result.next()){
			
			if((s.getPassword()).equals("")){
				pstmt = getPStatement(studentSqlU2);
				pstmt.setString(1, s.getName());
				pstmt.setLong(2, s.getGrade());
				pstmt.setString(3, s.getMajor());
				pstmt.setString(4, s.getBirth());
				pstmt.setInt(5, s.getAge());
				pstmt.setString(6, s.getSex());
				pstmt.setString(7, s.getPolitc());
				pstmt.setString(8, s.getAdmission());
				pstmt.setString(9, s.getProfile());
				pstmt.setString(10, s.getFamilyaddr());
				pstmt.setString(11, s.getPostcode());
				pstmt.setString(12, s.getNumber());
				ret = pstmt.executeUpdate();
			}else{
				pstmt = getPStatement(studentSqlU1);
				pstmt.setString(1, s.getName());
				pstmt.setLong(2, s.getGrade());
				pstmt.setString(3, s.getMajor());
				pstmt.setString(4, s.getBirth());
				pstmt.setInt(5, s.getAge());
				pstmt.setString(6, s.getSex());
				pstmt.setString(7, s.getPolitc());
				pstmt.setString(8, s.getAdmission());
				pstmt.setString(9, s.getProfile());
				pstmt.setString(10, s.getFamilyaddr());
				pstmt.setString(11, s.getPostcode());
				pstmt.setString(12, s.getPassword());
				pstmt.setString(13, s.getNumber());
				ret = pstmt.executeUpdate();
			}
			if(ret==1){
				obj.put("statusCode", 0);//更新成功
			}
			else{
				obj.put("statusCode", 2);//其他问题，更新失败
			}
			
		}
		else{
			obj.put("statusCode", 1);//学号不存在
		}
		result.close();
		closeConnect();
		return obj;
	}

	public static JSONArray selectTeacherList(Administrator u) throws SQLException, JSONException {
		// TODO Auto-generated method stub
		JSONArray teacherList = new JSONArray(); 	
    	String teacherSql = "SELECT tno,tname FROM ES_teacher;";
    	openConnection();
		pstmt = getPStatement(teacherSql);
		ResultSet result = pstmt.executeQuery();
		while(result.next()){
			JSONObject obj= new JSONObject ();
			obj.put("u_no", result.getString("tno"));
			obj.put("u_name", result.getString("tname"));
			System.out.println("u_no"+result.getString("tno"));
			teacherList.put(obj);
		}
		
		if(teacherList.length()==0){
			JSONObject obj= new JSONObject ();
			obj.put("u_no", "-1");
			obj.put("u_name", "-1");
			teacherList.put(obj);
		}
		result.close();


		closeConnect();
		return teacherList;
	}
	
	public static JSONObject insertstudent(Student u) throws SQLException, JSONException {
		// TODO Auto-generated method stub
		JSONObject obj= new JSONObject ();
		
		openConnection();
			
		String insertSql = "SELECT * FROM ES_student WHERE sno=?;";
		pstmt = getPStatement(insertSql);
    	pstmt.setString(1,u.getNumber());
    	ResultSet result = pstmt.executeQuery(); 
    	if(result.next()){
			obj.put("statusCode", 0);
		}
		else{
			insertSql = "INSERT INTO ES_student VALUES(?,?,?,?,?,? , ?,?,?,?,?,? , ?);";   	
	    	pstmt = getPStatement(insertSql);
	    	pstmt.setString(1,u.getNumber());
	    	pstmt.setString(2,u.getName());
	    	pstmt.setString(3,u.getPassword());
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
	    	if(pstmt.executeUpdate()==1) {
	    		obj.put("statusCode", 1);
	    	}else {
	    		obj.put("statusCode", 0);
	    	}
		}
    	result.close();
    	
    	System.out.println(obj);
		
		closeConnect();
		return obj;
	}
	
	public static JSONObject insertteacher(Teacher u) throws SQLException, JSONException {
		// TODO Auto-generated method stub
		JSONObject obj= new JSONObject ();
		
		openConnection();
			
		String insertSql = "SELECT * FROM ES_teacher WHERE tno=?;";
		pstmt = getPStatement(insertSql);
    	pstmt.setString(1,u.getNumber());
    	ResultSet result = pstmt.executeQuery(); 
    	if(result.next()){
			obj.put("statusCode", 0);
		}
		else{
			obj.put("statusCode", 1);
			insertSql = "INSERT INTO ES_teacher VALUES(?,?,?);";   	
	    	pstmt = getPStatement(insertSql);
	    	pstmt.setString(1,u.getNumber());
	    	pstmt.setString(2,u.getName());
	    	pstmt.setString(3,u.gettPassword());
	    	pstmt.execute(); 
		}
    	result.close();
    	
    	System.out.println(obj);
		
		closeConnect();
		return obj;
	}

	public static JSONObject insertCourse(Course c) throws SQLException, JSONException {
		// TODO Auto-generated method stub
		JSONObject obj= new JSONObject ();
		
		openConnection();
			
		String insertSql = "SELECT * FROM ES_course WHERE cno=?;";
		pstmt = getPStatement(insertSql);
    	pstmt.setString(1,c.getNumber());
    	ResultSet result = pstmt.executeQuery(); 
    	if(result.next()){
			obj.put("statusCode", 0);
		}
		else{
			
			insertSql = "INSERT INTO ES_course VALUES(?,?,?,?,?,?);";   	
	    	pstmt = getPStatement(insertSql);
	    	pstmt.setString(1,c.getNumber());
	    	pstmt.setString(2,c.getName());
	    	pstmt.setString(3,c.getTeacherNum());
	    	pstmt.setLong(4,c.getLimitNum());
	    	pstmt.setLong(5,0);
	    	pstmt.setLong(6,c.getSemester());
	    	if(pstmt.executeUpdate()==1){
	    		obj.put("statusCode", 1);
	    	}
	    	else{
	    		obj.put("statusCode", 0);
	    	}
		}
    	result.close();
    	
    	System.out.println(obj);
		
		closeConnect();
		return obj;
	}

	public static JSONArray getCourseList(Administrator u, String c_number) throws SQLException, JSONException {

		JSONArray courseList = new JSONArray(); 	
    	String courseSql = "SELECT cno,cname,tname,teacher_tno,limit_num,selected_num,semester FROM ES_course,ES_teacher WHERE cno LIKE ? AND teacher_tno=tno;";
    	openConnection();
		pstmt = getPStatement(courseSql);
		pstmt.setString(1, "%"+c_number+"%");
		ResultSet result = pstmt.executeQuery();
		while(result.next()){
			JSONObject obj= new JSONObject ();
			obj.put("c_no", result.getString("cno"));
			obj.put("c_name", result.getString("cname"));
			obj.put("c_teacher", result.getString("tname"));
			obj.put("c_tno", result.getString("teacher_tno"));
			obj.put("c_limit", result.getString("limit_num"));
			obj.put("c_selected", result.getString("selected_num"));
			obj.put("c_semester", result.getString("semester"));
			courseList.put(obj);
		}
		if(courseList.length()==0){
			JSONObject obj= new JSONObject ();
			obj.put("c_no", "-1");
			obj.put("c_name", "-1");
			obj.put("c_teacher", "-1");
			obj.put("c_tno", "-1");
			obj.put("c_limit", "-1");
			obj.put("c_selected", "-1");
			obj.put("c_semester", "-1");
			courseList.put(obj);
		}


		closeConnect();
		return courseList;
	}

	public static JSONArray getTeacherList(Administrator u,String s_number) throws SQLException, JSONException {
		// TODO Auto-generated method stub
		JSONArray courseList = new JSONArray(); 	
    	String teacherSql = "SELECT * FROM ES_teacher WHERE tno LIKE ?;";
    	openConnection();
		pstmt = getPStatement(teacherSql);
		pstmt.setString(1, "%"+s_number+"%");
		ResultSet result = pstmt.executeQuery();
		while(result.next()){
			JSONObject obj= new JSONObject ();
			obj.put("u_no", result.getString("tno"));
			obj.put("u_name", result.getString("tname"));
			courseList.put(obj);
		}
		
		if(courseList.length()==0){
			JSONObject obj= new JSONObject ();
			obj.put("u_no", "-1");
			obj.put("u_name", "-1");
			courseList.put(obj);
		}
		result.close();


		closeConnect();
		return courseList;
	}

	public static JSONObject deleteTeacher(Administrator u, String s_number) throws SQLException, JSONException {
		// TODO Auto-generated method stub
		JSONObject obj= new JSONObject ();
    	String teacherSql = "DELETE FROM ES_teacher WHERE tno = ?;";
    	String selectedSql = "SELECT * FROM ES_course WHERE teacher_tno = ?;";
    	openConnection();
    	pstmt = getPStatement(selectedSql);
		pstmt.setString(1, s_number);
		ResultSet result = pstmt.executeQuery(); 
		if(result.next()){
			obj.put("statusCode", 1);//外键约束问题
		}
		else{
			pstmt = getPStatement(teacherSql);
			pstmt.setString(1, s_number);
			int ret = pstmt.executeUpdate();
			if(ret==1){
				obj.put("statusCode", 0);//删除成功
			}
			else{
				obj.put("statusCode", 2);//其他问题，删除失败
			}
		}
		result.close();
		closeConnect();
		return obj;
	}

	public static JSONObject updateTeacher(Administrator u, Teacher s) throws JSONException, SQLException {
		// TODO Auto-generated method stub
		JSONObject obj= new JSONObject ();
    	String teacherSqlU1 = "UPDATE ES_teacher SET tname = ?,tpasswd = ? WHERE tno = ?;";
    	String teacherSqlU2 = "UPDATE ES_teacher SET tname = ? WHERE tno = ?;";
    	String teacherSqlQ = "SELECT * FROM ES_teacher WHERE tno = ?;";
    	openConnection();
    	pstmt = getPStatement(teacherSqlQ);
		pstmt.setString(1, s.getNumber());
		ResultSet result = pstmt.executeQuery(); 
		int ret=0;
		if(result.next()){
			
			
			if((s.gettPassword()).equals("")){
				pstmt = getPStatement(teacherSqlU2);
				pstmt.setString(1, s.getName());
				pstmt.setString(2, s.getNumber());
				ret = pstmt.executeUpdate();
			}
			else{
				pstmt = getPStatement(teacherSqlU1);
				pstmt.setString(1, s.getName());
				pstmt.setString(2, s.gettPassword());
				pstmt.setString(3, s.getNumber());
				ret = pstmt.executeUpdate();
			}
			if(ret==1){
				obj.put("statusCode", 0);//更新成功
			}
			else{
				obj.put("statusCode", 2);//其他问题，更新失败
			}
			
		}
		else{
			obj.put("statusCode", 1);//职工号不存在
		}
		result.close();
		closeConnect();
		return obj;
	}

}
