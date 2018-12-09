package com.es.model;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * 
 * @author xutingting
 * 
 */
public class Student {
	
	private String snumber;
	
	private String spassword;
	
	private String sname;
    
	private int sgrade;
	
	private String smajor;
	
	private String spostcode;

	private String sfamilyaddr; 

	private String sprofile;

	private String sadmission;

	private String spolitc;

	private String ssex;

	private Integer sage;

	private String sbirth;
	
	public void setNumber(String number){
		snumber = number;
	}
	
	public void setPassword(String password){
		spassword = password;
	}
	
	public void setName(String name){
		sname = name;
	}
	
	public void setGrade(int grade){
		sgrade = grade;
	}
	
	public void setMajor(String major){
		smajor = major;
	}
	
	public void setPostcode(String postcode){
		spostcode =postcode;
	}

	public void setFamilyaddr(String familyaddr){
		sfamilyaddr = familyaddr;
	}

	public void setProfile(String profile){
		sprofile = profile;
	}
	
	public void setAdmission(String admission){
		sadmission = admission;
	}

	public void setPolitc(String politc){
		spolitc = politc;
	}

	public void setSex(String sex){
		ssex = sex;
	}
	
	public void setAge(int age){
		sage = age;
	}

	public void setBirth(String birth){
		sbirth = birth;
	}
	
	public String getNumber(){
		return snumber;
	}
	
	public String getName(){
		return sname;
	}
	
	public String getPassword() {
		return spassword;
	}
	
	public int getGrade(){
		return sgrade;
	}
	//��ȡרҵ
	public String getMajor(){
		return smajor;
	}
	
	public String getPostcode(){
		return spostcode;
	}

	public String getFamilyaddr(){
		return sfamilyaddr;
	}
	
	public String getProfile(){
		return sprofile;
	}
	
	public String getAdmission(){
		return sadmission;
	}
	
	public String getPolitc(){
		return spolitc;
	}

	public String getSex(){
		return ssex;
	}
	
	public Integer getAge(){
		return sage;
	}

	public String getBirth(){
		return sbirth;
	}

	//��֤����
	public boolean isValid(String pwd){
		if(pwd.equals(spassword)){
			return true;
		}
		else return false;
	}
	public JSONObject toJsonObject() throws JSONException {
		JSONObject obj = new JSONObject();
		obj.put("u_number", snumber);
		obj.put("u_name", sname);
		obj.put("u_grade", getGradeString());
		obj.put("u_major", smajor);
		return obj;
	}
	
	public String getGradeString() {
		return String.valueOf(sgrade);
	}

}
