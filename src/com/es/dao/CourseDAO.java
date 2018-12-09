package com.es.dao;

import java.sql.SQLException;

import com.es.model.Selected;

public class CourseDAO extends BaseDAO{
	
	public static boolean DeleteCourse(Selected selected) {
		String sql = "delete from ES_selected where student_sno = ? and course_cno=? ";
		openConnection();
		pstmt = getPStatement(sql);
		
		try {
			pstmt.setString(1, selected.getSno());
			pstmt.setString(2, selected.getCno());
			int ret =  pstmt.executeUpdate();
			if (ret==1) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}finally {
			closeConnect();
		}
		return false;
	}
	
}
