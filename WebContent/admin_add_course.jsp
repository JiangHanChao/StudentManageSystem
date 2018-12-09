<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE>

<html>


<!-- Mirrored from www.zi-han.net/theme/hplus/form_validate.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:19:15 GMT -->
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>添加课程</title>

    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <script src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script>
        function load(){
        	var name = getQueryString("u_number");
        	loadTeacher(name);
        }
        function loadTeacher(name){
        	$.ajax({
                url:"/EducationSystem/ESAdmin",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                	method:"selectTeacherList",
                	username:name
                },
                success:function(data){  
                	/*弹出jqXHR对象的信息*/
                	dealTeacherList(name,data)
                },
                error:function(jqXHR, textStatus, errorThrown){
                    /*弹出jqXHR对象的信息*/
                    console.log(jqXHR.responseText);
                	dealTeacherList(name,jqXHR.responseText);
    	            
                }
            });
        }
        
        function dealTeacherList(name,data){
        	data = eval("("+data+")");
        	$("#cteacher").html("");
        	var tt = "";
        	
        	$.each(data, function (index) {  
                //循环获取数据    
                var u_no = data[index].u_no;  
                var u_name = data[index].u_name; 
                tt =  "<option value='"+u_no+"'>"+u_name+"</option>";
                $("#cteacher").append(tt);
            });
        }
        function getQueryString(name) {
        	var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
        	var r = window.location.search.substr(1).match(reg);
        	if (r != null) {
        		return unescape(r[2]);
        	}
        	return null;
        }
    </script>

</head>

<body class="gray-bg" onload="load()">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
         <div class="col-sm-3">
            </div>
            <div class="col-sm-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>添加课程</h5>
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
                        <div class="form-horizontal m-t"  id="signupForm"  role="form">
                            <div class="form-group">
                            	
                                <label class="col-sm-3 control-label"><span style="color:red"></span>课程号：</label>
                                <div class="col-sm-8">
                                    <input id="cno" name="userno" class="form-control" type="text" >    
                                </div>
                            </div>
                             <div class="form-group">
                             	
                                <label class="col-sm-3 control-label"><span style="color:red"></span>课程名：</label>
                                <div class="col-sm-8">
                                    <input id="cname" name="user_name" class="form-control" type="text" >    
                                </div>
                            </div>
                             <!-- <div class="form-group">
                                <label class="col-sm-3 control-label">密码：</label>
                                <div class="col-sm-8">
                                    <input id="pwd" name="pwd" class="form-control" type="text">
                                </div>
                            </div> -->
                            <div class="form-group">
                            	
                                <label class="col-sm-3 control-label"><span style="color:red"></span>任课老师：</label>
                                <div class="col-sm-8">
                                    <select id="cteacher" class="input-sm form-control input-lg inline">
	                                    
	                                </select>
                                </div>
                            </div>
                            
                            <div class="form-group">
                             	
                                <label class="col-sm-3 control-label"><span style="color:red"></span>限选人数：</label>
                                <div class="col-sm-8">
                                    <input id="climit" name="user_name" class="form-control" type="number">    
                                </div>
                            </div>
                            <div class="form-group">
                            	
                                <label class="col-sm-3 control-label"><span style="color:red" ></span>开课年级：</label>
                                <div class="col-sm-8">
                                    
                                    <select id="cgrade" class="input-sm form-control input-lg inline">
	                                    <option value="0">2014级</option>
	                                    <option value="1">2015级</option>
	                                    <option value="2">2016级</option>
	                                    <option value="3">2017级</option>
	                                    <option value="4">2018级</option>
	                                    <option value="5">2019级</option>
	                                </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-6">
                                    <button id="insertCourse" class="btn btn-primary" type="submit">提交</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="js/jquery.min.js?v=2.1.4"></script>
    <script src="js/bootstrap.min.js?v=3.3.6"></script>
    <script src="js/content.min.js?v=1.0.0"></script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
    <script type="text/javascript">    
        	function insertCourse(cno,cname,cteacher,climit,cgrade){  
            var gradeF = ['2014','2015','2016','2017','2018','2019'];
            	
        	var msg=["课程添加失败，您输入的课程号已存在","课程添加成功"];
        	var msgtype=["error","success"];
            $.ajax({
                url:"/EducationSystem/ESAdmin",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                	method:"insertCourse",
                	cno:cno,
                	cname:cname,
                	cteacher:cteacher,
                	climit:climit,
                	cgrade:gradeF[cgrade]
                },
                success:function(data){  
                	/*弹出jqXHR对象的信息*/
                	data = eval("("+jqXHR.responseText+")");
                	var statusCode = data["statusCode"];
    	            swal({
                        title: msg[statusCode],
                        type: msgtype[statusCode],
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确认",
                        closeOnConfirm: true
                    });
                },
                error:function(jqXHR, textStatus, errorThrown){
                    /*弹出jqXHR对象的信息*/
                    data = eval("("+jqXHR.responseText+")");
                	var statusCode = data["statusCode"];
    	            swal({
                        title: msg[statusCode],
                        type: msgtype[statusCode],
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确认",
                        closeOnConfirm: true
                    });
    	            
                }
            });   
        }	
   </script>
   <script>
        $(document).ready(function(){
        	$("#insertCourse").on("click",function(){
            	var cno = $("#cno").val();
            	console.log($("#userno").val());
            	var cname = $("#cname").val();
            	var cteacher = $("#cteacher").val();
            	var climit = $("#climit").val();
            	var cgrade = $("#cgrade").val();
            	if(cno==""){//null是空字符串，""是没有填写该信息
            		swal({
                        title: "课程号不能为空",
                        type: "warning",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确认",
                        closeOnConfirm: true
                    });
            	}
            	else if(cname==""){
            		swal({
                        title: "课程名不能为空",
                        type: "warning",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确认",
                        closeOnConfirm: true
                    });
            	}
            	else{
            		insertCourse(cno,cname,cteacher,climit,cgrade);
            	}
            	
            })
        })
    </script>
</body>


<!-- Mirrored from www.zi-han.net/theme/hplus/form_validate.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:19:16 GMT -->
</html>
    