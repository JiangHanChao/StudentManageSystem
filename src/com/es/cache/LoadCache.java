package com.es.cache;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

/**
 * Servlet implementation class LoadCache
 * 启动时默认加载缓存数据类
 */
@WebServlet("/LoadCache")
public class LoadCache extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public void init() {
    	InitCache();
	}
    
	private void InitCache() {
		// 初始化Cache机制
		CacheMgr.getInstance();
	}
}
