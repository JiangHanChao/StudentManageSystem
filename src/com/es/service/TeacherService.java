package com.es.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.es.model.Teacher;


public class TeacherService extends BaseService {
	
    public static JSONArray getCourseList(Teacher u) throws SQLException, JSONException {
    	JSONArray courseList = new JSONArray(); 	
    	String teacherSql = "SELECT cno,cname,limit_num,selected_num,semester FROM ES_course WHERE teacher_tno=?;";
    	openConnection();
		pstmt = getPStatement(teacherSql);
		pstmt.setString(1,u.getNumber());
		ResultSet result = pstmt.executeQuery();
		while(result.next()){
			JSONObject obj= new JSONObject ();
			obj.append("c_no", result.getString("cno"));
			obj.append("c_name", result.getString("cname"));
			obj.append("c_limitnum", result.getString("limit_num"));
			obj.append("c_selectednum", result.getString("selected_num"));
			obj.append("c_semester", result.getString("semester"));
			courseList.put(obj);
		}
		
		if(courseList.length()==0){
			JSONObject obj= new JSONObject ();
			obj.append("c_no", "-1");
			obj.append("c_name", "-1");
			obj.append("c_limitnum","-1");
			obj.append("c_selectednum", "-1");
			obj.append("c_semester", "-1");
			courseList.put(obj);
		}
		result.close();
		closeConnect();
		return courseList;
	}

	public static JSONArray getCourseStudentList(Teacher u, String cno) throws  JSONException, SQLException {
		JSONArray studentList = new JSONArray(); 	
    	String selectedSql = "SELECT sno,sname,score FROM ES_selected,ES_student WHERE course_cno=? AND sno=student_sno;";
    	openConnection();
		pstmt = getPStatement(selectedSql);
		
		ResultSet result;
		pstmt.setString(1,cno);
		result = pstmt.executeQuery();
		while(result.next()){
			JSONObject obj= new JSONObject ();
			obj.append("u_no", result.getString("sno"));
			obj.append("u_name", result.getString("sname"));
			obj.append("u_score", result.getInt("score"));
			studentList.put(obj);
		}
		
		if(studentList.length()==0){
			JSONObject obj= new JSONObject ();
			obj.append("u_no", "-1");
			obj.append("u_name", "-1");
			obj.append("u_score", "-1");
			studentList.put(obj);
		}
		result.close();
		closeConnect();
		return studentList;
	}

	public static JSONArray updateCourseGrade(Teacher u, String cno, Map<String, String> courseGradeList) throws JSONException, SQLException {
		// TODO Auto-generated method stub
		JSONArray result = new JSONArray();
    	//更新selected表中成绩
    	String selectedSql = "UPDATE ES_selected SET score=? WHERE course_cno=? AND student_sno=?;";
    	new HashMap<String, Integer>();
    	openConnection();
    	pstmt = getPStatement(selectedSql);
    	for (Map.Entry<String, String> entry : courseGradeList.entrySet()) {  
    		JSONObject obj= new JSONObject();
    		
    	    System.out.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());  
    	    pstmt.setLong(1,Integer.parseInt(entry.getValue()));
    	    pstmt.setString(2, cno);
    	    pstmt.setString(3, entry.getKey());
    	    if(pstmt.executeUpdate()==1){//对selected表插入成功
    	    	obj.put("c_no", entry.getKey());
    	    	obj.put("c_result", 0);//更新成功0
			}
			else{
				obj.put("c_no", entry.getKey());
    	    	obj.put("c_result", 1);//更新失败1
			}
    	    result.put(obj);
    	}
    	closeConnect();
		return result;
	}
}

