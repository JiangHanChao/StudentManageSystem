package com.es.model;

public class Course {
	// 课程号
	private String cnumber;
	// 课程名
	private String cname;
	// 授课教师职工号
	private String teacher_number;
	// 限选人数
	private Integer limit_num;
	// 已选人数
	private Integer selected_num;
	// 学期
	private int semester;
	
	public void setNumber(String number) {
		cnumber = number;
	}
	
	public void setName(String name) {
		cname = name;
	}
	
	public void setTeacherNum(String teacherNumber) {
		teacher_number = teacherNumber;
	}
	
	public void setLimitNum(Integer limit) {
		limit_num = limit;
	}
	
	public void setSelectedNum(Integer selected) {
		selected_num = selected;
	}
	
	public void setSemester(int semest) {
		semester = semest;
	}
	
	public String getNumber() {
		return cnumber;
	}
	
	public String getName() {
		return cname;
	}
	
	public String getTeacherNum() {
		return teacher_number;
	}
	
	public Integer getLimitNum() {
		return limit_num;
	}
	
	public Integer getSelectedNum() {
		return selected_num;
	}
	
	public int getSemester() {
		return semester;
	}
}
