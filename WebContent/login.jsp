<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>


<!-- Mirrored from www.zi-han.net/theme/hplus/login.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:18:23 GMT -->
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>ES 登录</title>

    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">

    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
    <script>if(window.top !== window.self){ window.top.location = window.location;}</script>
    <script>
	    function check(){                 
	        var ids = document.getElementsByName("role");                  
	        var flag = false ;                
	        for(var i=0;i<ids.length;i++){  
	            if(ids[i].checked){  
	                flag = true ;  
	                break ;  
	            }  
	        }  
	        if(!flag){  
	            alert("请选择身份！");  
	            return false ;  
	        }  
	    }
	    
    </script>
</head>

<body class="gray-bg">

    <div class="middle-box text-center loginscreen  animated fadeInDown">
        <div>
            <div>

                <h1 class="logo-name">ES</h1>

            </div>
            <h3>教务系统</h3>

            <form id="esform" class="m-t" role="form" action="/EducationSystem/ESLogin" method="post" onsubmit="return check();">
                <div class="form-group">
                    <input type="radio" name="role" value="student">学生
                    <input type="radio" name="role" value="teacher">教师
                    <input type="radio" name="role" value="admin">管理员
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="用户名" required name="es_number">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control" placeholder="密码" required name="es_pwd">
                </div>
                <div id="" class="alert alert-info"><%if(((String)request.getAttribute("u_error")).equals("-1")){%>用户名或密码错误
                	 <%} %>
                </div>
                <button type="submit" class="btn btn-primary block full-width m-b">登录</button>

            </form>
        </div>
    </div>
    
    <script src="js/jquery.min.js?v=2.1.4"></script>
    <script src="js/bootstrap.min.js?v=3.3.6"></script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
</body>


<!-- Mirrored from www.zi-han.net/theme/hplus/login.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:18:23 GMT -->
</html>