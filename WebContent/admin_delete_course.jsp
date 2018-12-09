<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE>
<html>


<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>学生退课</title>

    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <script src="js/plugins/sweetalert/sweetalert.min.js"></script>

</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
        	<div class="col-sm-3">
            </div>
            <div class="col-sm-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>查询学生</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="form_basic.html#">
                                <i class="fa fa-wrench"></i>
   						    </a>
  						</div>
                 	</div>
                    <div class="ibox-content">
                        <form class="form-horizontal m-t"  id="signupForm"  role="form" action="/EducationSystem/SelectedResult" method="post" >
                            <div class="form-group">
                            	<input type="hidden" id="role" name="role" value="admin" />
                                <label class="col-sm-3 control-label">学号：</label>
                                <div class="col-sm-6">
                                    <input id="u_number" name="u_number" class="form-control" type="text" aria-required="true" aria-invalid="true" class="error"  value="">
                                </div>
                            	<span class="input-group-btn">
                                	<button type="submit" class="btn btn btn-primary"> <i class="fa fa-search"></i> 查询</button>
                             	</span>
                             </div>                               
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="mail-box">
        <ul id="msgInsertPlace"></ul>
        	<table class="table table-hover table-mail">
            <thead>
            <tr>
            	<td class="">课程编号</td>
                <td class="">课程名</td>
                <td class="">任课老师</td>
                <td class="">退课</td>
            </tr>
            </thead>
            <tbody id="insertPlace">
            <c:forEach items="${list }" var="n" varStatus="s">
            <tr>
            	<td>${n.cno }</td>
                <td>${n.courseName }</td>
                <td>${n.teacherName }</td>
                <td><button onclick="deleteCourse(this)" class="btn btn-danger btn-sm demo4" id="${n.cno}">退选</button></td>
            </tr>
            </c:forEach>
            </tbody>
       	</table>
    </div>
    <script src="js/jquery.min.js?v=2.1.4"></script>
    <script src="js/bootstrap.min.js?v=3.3.6"></script>
    <script src="js/content.min.js?v=1.0.0"></script>
    <script src="js/plugins/validate/jquery.validate.min.js"></script>
    <script src="js/plugins/validate/messages_zh.min.js"></script>
    <script src="js/demo/form-validate-demo.min.js"></script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
    <script type="text/javascript">
    	function deleteCourse(obj){
    		var msg=["退选失败","退选成功！"];
        	var msgtype=["error","success"];
    		var btn = $(obj);
    		var cid = btn.attr("id");
    		var num = $("#u_number").val();
    		$.ajax({
    			url:"/EducationSystem/ESAdmin",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                    method:"deleteCourse",
                    username:"${sno }",
                	cno:cid
                },
                success:function(data){
                	console.log("miss");
                },
                error:function(jqXHR, textStatus, errorThrown){
                	data = eval("("+jqXHR.responseText+")");
                	var statusCode = data["statuCode"];
                	console.log(statusCode);
    	            swal({
                        title: msg[statusCode],
                        type: msgtype[statusCode],
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确认",
                        closeOnConfirm: true
                    },function(){
                    	if(statusCode=="1"){
                    		$.ajax({
                    			url:"/EducationSystem/SelectedResult",//servlet文件的名称  
                                type:"POST",
                                dataType:"json",
                                data:{
                                    role:"admin",
                                    u_number:"${sno }"
                                },
                                success:function(data){
                                	console.log("reload");
                                },
                                error:function(){
                                	console.log("reload start");
                                	location.reload();
                                }
                    		});
                	    }
                    });
                }
    		});
    	}
    </script>
</body>

</html>
    