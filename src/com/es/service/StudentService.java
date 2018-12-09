package com.es.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.es.model.Student;


public class StudentService extends BaseService {
	
    public static JSONArray getCourseList(Student u) throws SQLException, JSONException {
		return getCourseListName(u,"%");
	}
    public static JSONArray getCourseListName(Student u,String CourseName) throws SQLException, JSONException{
    	
    	JSONArray courseList = new JSONArray();
    	String studentSql = "SELECT grade FROM ES_student WHERE sno=?;";
    	String courseSql = "SELECT cno,cname,tname,limit_num,selected_num FROM ES_course,ES_teacher WHERE semester=? AND cname LIKE ? AND teacher_tno=tno;";
    	String selectedSql = "SELECT course_cno FROM ES_selected WHERE student_sno=?;";
    	openConnection();
    	//执行studentSql在ES_student表中找出学号对应的年级grade
		pstmt = getPStatement(studentSql);
		pstmt.setString(1,u.getNumber());
		ResultSet result = pstmt.executeQuery();
		if(result.next()){
			int grade = result.getInt("grade");
			u.setGrade(grade);
		}
		result.close();
		
		//执行selectedSql在ES_selected表中找出学号已选的课程的课程号course_cno
		pstmt = getPStatement(selectedSql);
		pstmt.setString(1,u.getNumber());
		result = pstmt.executeQuery();
		List<String> selectedCourseNum =new ArrayList<String>();
		while(result.next()){
			selectedCourseNum.add(result.getString("course_cno"));
		}
		result.close();
		
		//执行courseSql在ES_course表中找出学号可选的课程信息
		pstmt = getPStatement(courseSql);
		pstmt.setLong(1,u.getGrade());
		pstmt.setString(2,"%"+CourseName+"%");
		System.out.println("%"+CourseName+"%");
		result = pstmt.executeQuery();
//		Course course=null;
		while(result.next()){
			JSONObject obj= new JSONObject();
			obj.append("c_no", result.getString("cno"));
			obj.append("c_name", result.getString("cname"));
			obj.append("c_teacher", result.getString("tname"));
			obj.append("c_limitnum", result.getString("limit_num"));
			obj.append("c_selectednum", result.getString("selected_num"));
			if(selectedCourseNum.indexOf(result.getString("cno"))==-1){
				obj.append("c_isselected", 0);
			}
			else obj.append("c_isselected", 1);
			courseList.put(obj);
			
		}
		if(courseList.length()==0){
			JSONObject obj= new JSONObject();
			obj.append("c_no", "-1");
			obj.append("c_name", "-1");
			obj.append("c_teacher", "-1");
			obj.append("c_limitnum", "-1");
			obj.append("c_selectednum", "-1");
			obj.append("c_isselected", 0);
			courseList.put(obj);
		}
		closeConnect();
		return courseList;
    }
	public static JSONArray selectCourse(Student u, List<String> selectedCourseList) throws SQLException, JSONException {
		// TODO Auto-generated method stub
		JSONArray result = new JSONArray();
		//向selected表插入选课选课信息
    	String selectedSql = "INSERT INTO ES_selected VALUES(?,?,null);";
    	//更新course表中数据
    	String courseSqlA = "UPDATE ES_course SET selected_num=selected_num+1 WHERE cno=?;";
    	String courseSqlD = "UPDATE ES_course SET selected_num=selected_num-1 WHERE cno=?;";
    	//更新信息
    	String courseSqlI = "SELECT cno,cname FROM ES_course WHERE cno=?;";
    	//记录选择情况即课程号及对应的选择结果
    	Map<String,Integer> selectedResult = new HashMap<String, Integer>();
    	openConnection();
		for(int i=0;i<selectedCourseList.size();i++){
			pstmt = getPStatement(courseSqlA);
			pstmt.setString(1,selectedCourseList.get(i));
			if(pstmt.executeUpdate()==1){//对course表执行成功
				pstmt = getPStatement(selectedSql);
				pstmt.setString(1,u.getNumber());
				pstmt.setString(2,selectedCourseList.get(i));
				if(pstmt.executeUpdate()==1){//对selected表插入成功
					selectedResult.put(selectedCourseList.get(i), 0);//选课成功0
				}
				else{
					selectedResult.put(selectedCourseList.get(i), 1);//插入选课表失败1
					//恢复course表
					pstmt = getPStatement(courseSqlD);
					pstmt.setString(1,selectedCourseList.get(i));
					pstmt.executeUpdate();//可能有bug
				}
			}
			else{
				selectedResult.put(selectedCourseList.get(i), 0);//达到选课人数上限2
			}
		}
		for(int i=0;i<selectedCourseList.size();i++){
			pstmt = getPStatement(courseSqlI);
			pstmt.setString(1,selectedCourseList.get(i));
			ResultSet resultSet = pstmt.executeQuery();
			while(resultSet.next()){
				JSONObject obj= new JSONObject();
				//添加课程与结果键值对
				obj.append("c_no",selectedCourseList.get(i));
				obj.append("c_name", resultSet.getString("cname"));
				obj.append("c_result", selectedResult.get(resultSet.getString("cno")));
				result.put(obj);
			}
			
		}
		closeConnect();
		
    	return result;
	}
	
	public static JSONArray selectgrade(Student u) throws SQLException, JSONException{	
    	JSONArray gradeList = new JSONArray();
    	String gradeSql = "SELECT cno,cname,score FROM ES_course,ES_selected WHERE ES_course.cno=ES_selected.course_cno AND score IS NOT NULL AND student_sno=?;";
    	openConnection();
		pstmt = getPStatement(gradeSql);
		pstmt.setString(1,u.getNumber());
		System.out.println(u.getNumber());
		ResultSet result = pstmt.executeQuery();
		while(result.next()){
			JSONObject obj= new JSONObject ();
			obj.append("c_no", result.getString("cno"));
			obj.append("c_name", result.getString("cname"));
			obj.append("c_score", result.getString("score"));
			gradeList.put(obj);
		}
		closeConnect();
		return gradeList;
		
    }

}
