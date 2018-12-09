package com.es.model;

public class Selected {
	private String sno;
	
	private String cno;
	
	private int score;
	
	private String teacherName;
	
	private String courseName;
	
	public void setSno(String number) {
		sno = number;
	}
	
	public void setCno(String number) {
		cno = number;
	}
	
	public void setScore(int grade) {
		score = grade;
	}
	
	public void setTeacherName(String name) {
		teacherName = name;
	}
	
	public void setCourseName(String name) {
		courseName = name;
	}
	
	public String getSno() {
		return sno;
	}
	
	public String getCno() {
		return cno;
	}
	
	public int getScore() {
		return score;
	}
	
	public String getTeacherName() {
		return teacherName;
	}
	
	public String getCourseName() {
		return courseName;
	}
}

