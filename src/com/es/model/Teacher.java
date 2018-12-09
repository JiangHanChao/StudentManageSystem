package com.es.model;

import org.json.JSONException;
import org.json.JSONObject;

public class Teacher {
	//�û���
	private String tnumber;
	//����
	private String tpassword;
	//����
	private String tname;
	//���ù���
	public void setNumber(String number){
		tnumber = number;
	}
	//��������
	public void setPassword(String password){
		tpassword = password;
	}
	//��������
	public void setName(String name){
		tname = name;
	}
	//��ȡ����
	public String getNumber(){
		return tnumber;
	}
	//��ȡ����
	public String getName(){
		return tname;
	}
	
	public String gettPassword() {
		return tpassword;
	}
	
	public boolean isValid(String pwd){
		if(pwd.equals(tpassword)){
			return true;
		}
		else return false;
	}
	public JSONObject toJsonObject() throws JSONException {
		JSONObject obj = new JSONObject();
		obj.put("u_number", tnumber);
		obj.put("u_name", tname);
		return obj;
		// TODO Auto-generated method stub
	}

}
