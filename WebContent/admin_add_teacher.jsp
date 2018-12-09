<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE>

<html>


<!-- Mirrored from www.zi-han.net/theme/hplus/form_validate.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:19:15 GMT -->
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>添加老师</title>

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
                        <h5>添加老师</h5>
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
                            	
                                <label class="col-sm-3 control-label"><span style="color:red"></span>职工号：</label>
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
                                <div class="col-sm-8 col-sm-offset-6">
                                    <button id="insertteacher" class="btn btn-primary" type="submit">提交</button>
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
        	function insertteacher(tno,tname){  
        	var msg=["老师添加失败，您输入的职工号已存在","老师添加成功"];
        	var msgtype=["error","success"];
            $.ajax({
                url:"/EducationSystem/ESAdmin",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                	method:"insertteacher",
                	username:tno,
                	user_name:tname,
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
        	$("#insertteacher").on("click",function(){
            	var tno = $("#userno").val();
            	var tname = $("#user_name").val();
            	if(tno==""){//null是空字符串，""是没有填写该信息
            		swal({
                        title: "职工号不能为空",
                        type: "warning",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确认",
                        closeOnConfirm: true
                    });
            	}
            	else if(tname==""){
            		swal({
                        title: "姓名不能为空",
                        type: "warning",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确认",
                        closeOnConfirm: true
                    });
            	}
            	else{
            		insertteacher(tno,tname);
            	}
            	
            })
        })
    </script>
</body>


<!-- Mirrored from www.zi-han.net/theme/hplus/form_validate.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:19:16 GMT -->
</html>
    