package com.es.common;

import org.json.Test;

import com.es.dao.AdministratorDAO;
import com.es.model.Course;
import com.es.model.Student;
import com.es.model.Teacher;

public class test extends Test {
	public test() {
	}

	public static void main(String[] args) {
		testAdminADO();
	}
	
	private static void testAdminADO() {
		// test insert
		Student u = new Student();
		u.setNumber("201508010306");
		u.setName("PZW");
		u.setPassword("123456");
		u.setMajor("计算机科学与技术");
		u.setGrade(2015);
		AdministratorDAO.insert(u);
		System.out.println("insert student success");
		Teacher t = new Teacher();
		t.setNumber("200001");
		t.setName("王东");
		AdministratorDAO.insert(t);
		System.out.println("insert teacher success");
		Course c = new Course();
		c.setNumber("2");
		c.setName("计算机网络");
		c.setTeacherNum("200001");
		c.setLimitNum(50);
		c.setSelectedNum(0);
		c.setSemester(2015);
		AdministratorDAO.insert(c);
		System.out.println("insert course success");
		// test delete
		
		// ALERT: 一定要先删  course 再删其他.
		AdministratorDAO.delete(c);
		System.out.println("delete course success");
		AdministratorDAO.delete(t);
		System.out.println("delete teacher success");
		AdministratorDAO.delete(u);
		System.out.println("delete student success");
		System.out.println("test success");
	}
}
