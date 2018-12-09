package com.es.model;

import org.json.JSONException;
import org.json.JSONObject;

public class Administrator {
		private String anumber;
		//����
		private String apassword;
		//����
		private String aname;
		//���ù���
		public void setNumber(String number){
			anumber = number;
		}
		//��������
		public void setPassword(String password){
			apassword = password;
		}
		//��������
		public void setName(String name){
			aname = name;
		}
		//��ȡ����
		public String getNumber(){
			return anumber;
		}
		//��ȡ����
		public String getName(){
			return aname;
		}
		//��֤����
		public boolean isValid(String pwd){
			if(pwd.equals(apassword)){
				return true;
			}
			else return false;
		}
		public JSONObject toJsonObject() throws JSONException {
			JSONObject obj = new JSONObject();
			obj.put("u_number", anumber);
			obj.put("u_name", aname);
			return obj;
			// TODO Auto-generated method stub
		}

}
