<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>选课结果</title>
    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min862f.css?v=4.1.0" rel="stylesheet">
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content  animated fadeInRight">
        <div class="row">
            <div class="col-sm-8">
                <div class="ibox">
                    <div class="ibox-content">
                        <span class="text-muted small pull-right">最后更新：<i class="fa fa-clock-o"></i> 2018-06-10 12:00</span>
                        <h2>选课结果</h2>
                        <p>
                            你已选的课程如下
                        </p>
                        <div class="clients-list">
                            <ul class="nav nav-tabs">
                                <li class="active">
                                <a data-toggle="tab" href="#tab-1"><i class="fa fa-user"></i>课程列表</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane active">
                                    <div class="full-height-scroll">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-hover">
                                                <tbody>
                                                <c:forEach items="${list }" var="n">
                                                    <tr>
                                                        <td class="client-avatar"><img alt="image" src="img/csee.jpg"> </td>
                                                        <td><a data-toggle="tab" href="#contact-1" class="client-link">${n.courseName }</a>
                                                        </td>
                                                        <td> ${n.teacherName }</td>
                                                                                                             
                                                        <td class="client-status"><span class="label label-primary">已选</span>
                                                        </td>
                                                    </tr>
                                                 </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                               
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
               <img src="img/hunanu.jpg" alt="湖大校徽" width="250" height="250">
               <p style="font-family:verdana;font-size:300%;color:000000;left: 60px; position: absolute; top: 300px;"><b>选课系统</b></p>
            </div>
        </div>
    </div>
    <script src="js/jquery.min.js?v=2.1.4"></script>
    <script src="js/bootstrap.min.js?v=3.3.6"></script>
    <script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
    <script src="js/content.min.js?v=1.0.0"></script>
    <script>
        $(function(){$(".full-height-scroll").slimScroll({height:"100%"})});
        
        function loadSCResult(u_number){
        	$.ajax({
                url:"/EducationSystem/SelectedResult",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                	username:u_number
                },
                success:function(data){
                	console.log(data);
                },
                error:function(jqXHR, textStatus, errorThrown){
                	console.log("error");
                }
            });
        }
    </script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
</body>


<!-- Mirrored from www.zi-han.net/theme/hplus/clients.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:19:44 GMT -->
</html>
    