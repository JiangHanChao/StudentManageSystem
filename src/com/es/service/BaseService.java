package com.es.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

import com.es.common.DBUtil;

public class BaseService {
	private static Connection conn = null;
    protected static  PreparedStatement pstmt = null;
    
    public static Connection getConnect() {
    	return conn;
    }
    
    public static PreparedStatement getPStatement(String sql) {
    	try {
			pstmt = conn.prepareStatement(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pstmt;
	}
    
    public static void openConnection() {
    	Properties prop = new Properties();
		
		String driver = null;
		String url = null;
		String username = null;
		String password = null;
		try{
			prop.load(DBUtil.class.getClassLoader().getResourceAsStream("DBConfig.properties"));
			
		    driver = prop.getProperty("driver");
		    url = prop.getProperty("url");
		    username = prop.getProperty("username");
		    password = prop.getProperty("password");
		    Class.forName(driver);
		    
		    conn = DriverManager.getConnection(url,username,password);
		}catch(Exception e){
			e.printStackTrace();
		}
		System.out.println("Connect Database Success.");
		
		return ;
	}
    
    public static void closeConnect() {
    	try {
    		if (conn != null) {
    			conn.close();
    			conn = null;
			}
    		if (pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
		} catch (SQLException e) {
			System.out.println("Close Connect Failed.");
			e.printStackTrace();
		}
	}
}
