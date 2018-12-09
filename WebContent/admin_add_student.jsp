<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE>

<html>


<!-- Mirrored from www.zi-han.net/theme/hplus/form_validate.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:19:15 GMT -->
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>添加学生</title>

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
                        <h5>添加学生</h5>
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
                            	
                                <label class="col-sm-3 control-label"><span style="color:red"></span>学号：</label>
                                <div class="col-sm-8">
                                    <input id="userno" name="userno" class="form-control" type="text" required aria-invalid="true" class="error"  value="">    
                                </div>
                            </div>
                             <div class="form-group">
                             	
                                <label class="col-sm-3 control-label"><span style="color:red"></span>姓名：</label>
                                <div class="col-sm-8">
                                    <input id="user_name" name="user_name" class="form-control" type="text" required aria-invalid="true" class="error"  value="">    
                                </div>
                            </div>
                            <div class="form-group">
                            	
                                <label class="col-sm-3 control-label"><span style="color:red"></span>生日：</label>
                                <div class="col-sm-8">
                                    <input id="userbir" name="userbir" class="form-control" type="text" required aria-invalid="true" class="error"  value="">    
                                </div>
                            </div>
                            <div class="form-group">
                            	
                                <label class="col-sm-3 control-label"><span style="color:red"></span>年龄：</label>
                                <div class="col-sm-8">
                                    <input id="userage" name="userage" class="form-control" type="text" required aria-invalid="true" class="error"  value="">    
                                </div>
                            </div>
                            <div class="form-group">
                            	
                                <label class="col-sm-3 control-label"><span style="color:red" ></span>性别：</label>
                                <div class="col-sm-8">
                                    
                                    <select id="usersex" class="input-sm form-control input-lg inline">
	                                    <option value="0">男</option>
	                                    <option value="1">女</option>
	                                </select>
                                </div>
                            </div>
                            <div class="form-group">
                            	
                                <label class="col-sm-3 control-label"><span style="color:red"></span>政治面貌：</label>
                                <div class="col-sm-8">
                                    <input id="userpol" name="userpol" class="form-control" type="text" required aria-invalid="true" class="error"  value="">    
                                </div>
                            </div>
                            <div class="form-group">
                            	
                                <label class="col-sm-3 control-label"><span style="color:red"></span>入学时间：</label>
                                <div class="col-sm-8">
                                    <input id="usertime" name="usertime" class="form-control" type="text" required aria-invalid="true" class="error"  value="">    
                                </div>
                            </div>
                            <div class="form-group">
                            	
                                <label class="col-sm-3 control-label"><span style="color:red"></span>个人介绍：</label>
                                <div class="col-sm-8">
                                    <input id="userpro" name="userpro" class="form-control" type="text" required aria-invalid="true" class="error"  value="">    
                                </div>
                            </div>
                            <div class="form-group">
                            	
                                <label class="col-sm-3 control-label"><span style="color:red"></span>家庭住址：</label>
                                <div class="col-sm-8">
                                    <input id="useraddr" name="useraddr" class="form-control" type="text" required aria-invalid="true" class="error"  value="">    
                                </div>
                            </div>
                            <div class="form-group">
                            	
                                <label class="col-sm-3 control-label"><span style="color:red"></span>邮政编码：</label>
                                <div class="col-sm-8">
                                    <input id="userpost" name="userpost" class="form-control" type="text" required aria-invalid="true" class="error"  value="">    
                                </div>
                            </div>                         
                             <!-- <div class="form-group">
                                <label class="col-sm-3 control-label">密码：</label>
                                <div class="col-sm-8">
                                    <input id="pwd" name="pwd" class="form-control" type="text">
                                </div>
                            </div> -->
                            <div class="form-group">
                            	
                                <label class="col-sm-3 control-label"><span style="color:red"></span>年级：</label>
                                <div class="col-sm-8">
                                    <select id="userge" class="input-sm form-control input-lg inline">
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
                            	
                                <label class="col-sm-3 control-label"><span style="color:red" ></span>专业：</label>
                                <div class="col-sm-8">
                                    
                                    <select id="usermj" class="input-sm form-control input-lg inline">
	                                    <option value="0">计算机科学与技术</option>
	                                    <option value="1">物联网工程</option>
	                                    <option value="2">软件工程</option>
	                                    <option value="3">信息安全</option>
	                                    <option value="4">通信工程</option>
	                                    <option value="5">数字媒体</option>
	                                </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-6">
                                    <button id="insertstudent" class="btn btn-primary" type="submit">提交</button>
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
        	function insertstudent(sno,sname,grade,major,sbrith,sage,ssex,spolitc,sadmission,sprofile,sfamilyaddress,spostcode){  
            	var majorF = ["计算机科学与技术","物联网工程","软件工程","信息安全","通信工程","数字媒体"];
            	var gradeF = ['2014','2015','2016','2017','2018','2019'];
            	var sexF = ["男","女"];
            	
        	var msg=["学生添加失败，您输入的学号已存在","学生添加成功"];
        	var msgtype=["error","success"];
            $.ajax({
                url:"/EducationSystem/ESAdmin",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                	method:"insertstudent",
                	username:sno,
                	user_name:sname,
                	grade:gradeF[grade],
                	major:majorF[major],
                	brith:sbrith,
                	age:sage,
                	sex:sexF[ssex],
                	politc:spolitc,
                	admission:sadmission,
                	profile:sprofile,
                	familyaddress:sfamilyaddress,
                	postcode:spostcode
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
        	$("#insertstudent").on("click",function(){
            	var sno = $("#userno").val();
            	//console.log($("#userno").val());
            	var sname = $("#user_name").val();
            	var grade = $("#userge").val();
            	var major = $("#usermj").val();
            	var sbrith = $("#userbir").val();
            	var sage = $("#userage").val();
            	var ssex = $("#usersex").val();
            	var spolitc = $("#userpol").val();
            	var sadmission = $("#usertime").val();
            	var sprofile = $("#userpro").val();
            	var sfamilyaddress = $("#useraddr").val();
            	var spostcode = $("#userpost").val();
            	if(sno==""){//null是空字符串，""是没有填写该信息
            		swal({
                        title: "学号不能为空",
                        type: "warning",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确认",
                        closeOnConfirm: true
                    });
            	}
            	else if(sname==""){
            		swal({
                        title: "姓名不能为空",
                        type: "warning",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确认",
                        closeOnConfirm: true
                    });
            	}
            	else{
            		insertstudent(sno,sname,grade,major,sbrith,sage,ssex,spolitc,sadmission,sprofile,sfamilyaddress,spostcode);
            	}
            	
            })
        })
    </script>
</body>


<!-- Mirrored from www.zi-han.net/theme/hplus/form_validate.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:19:16 GMT -->
</html>
    