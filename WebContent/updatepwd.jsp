<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>

<html>


<!-- Mirrored from www.zi-han.net/theme/hplus/form_validate.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:19:15 GMT -->
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>修改密码</title>

    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min862f.css?v=4.1.0" rel="stylesheet">
	<link href="css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <script src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script>
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

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
	        <div class="col-sm-3">
	        </div>
            <div class="col-sm-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>修改密码</h5>
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
                        <!-- <form class="form-horizontal m-t"  id="signupForm"  role="form"> -->
                        <div class="form-horizontal m-t">   
                            <div class="form-group">
                                <label class="col-sm-3 control-label">原密码：</label>
                                <div class="col-sm-8">
                                    <input id="old_password" name="old_password" class="form-control" type="password">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">新密码：</label>
                                <div class="col-sm-8">
                                    <input id="password" name="password" class="form-control" type="password">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">确认密码：</label>
                                <div class="col-sm-8">
                                    <input id="confirm_password" name="confirm_password" class="form-control" type="password">
                                    <span class="help-block m-b-none"><i class="fa fa-info-circle"></i> 请再次输入您的密码</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-3">
                                    <button id="updatePwd" class="btn btn-primary" type="submit">提交</button>
                                </div>
                            </div>
                        <!-- </form> -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="js/jquery.min.js?v=2.1.4"></script>
    <script src="js/bootstrap.min.js?v=3.3.6"></script>
    <script src="js/content.min.js?v=1.0.0"></script>
    <script src="js/plugins/validate/jquery.validate.min.js"></script>
    <script src="js/plugins/validate/messages_zh.min.js"></script>
    <script src="js/demo/form-validate-demo.min.js"></script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
    <script type="text/javascript">
    function updatePwd(u_number,oldpwd,newpwd){
    	var msg=["密码修改失败","密码修改成功"];
    	var msgtype=["error","success"];
    	$.ajax({    
            url:"/EducationSystem/ESCommon",//servlet文件的名称  
            type:"POST",
            dataType:"json",
            data:{
                method:"updatePwd",
                username:u_number,
            	oldPassword:oldpwd,
            	newPassword:newpwd
            },
            success:function(data){
            	data = eval("("+jqXHR.responseText+")");
            	var statusCode = data["statusCode"];
            	console.log(data);
	            swal({
                    title: msg[statusCode],
                    type: msgtype[statusCode],
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确认",
                    closeOnConfirm: true
                },function(){
                	if(statusCode=="1"){
                		document.location.replace('login.html');
            	    }
                });
            },
            error:function(jqXHR, textStatus, errorThrown){
            	/*弹出jqXHR对象的信息*/
            	data = eval("("+jqXHR.responseText+")");
            	var statusCode = data["statusCode"];
            	console.log(data);
	            swal({
                    title: msg[statusCode],
                    type: msgtype[statusCode],
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确认",
                    closeOnConfirm: true
                },function(){
                	if(statusCode==1){
                		document.location.replace('login.html');
            	    }
                });
            }
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
    <script>
        $(document).ready(function(){
        	var name=getQueryString("u_number");
        	$("#updatePwd").on("click",function(){
            	var oldpwd = $("#old_password").val();
            	var newpwd = $("#password").val();
            	var confirmpwd = $("#confirm_password").val();
            	if(confirmpwd!=newpwd){
            		swal({
                        title: "输入的两次新密码必须一致！",
                        type: "warning",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确认",
                        closeOnConfirm: true
                    });
            	}
            	else{
            		updatePwd(name,oldpwd,newpwd);
            	}
            })
        })
    </script>
</body>


<!-- Mirrored from www.zi-han.net/theme/hplus/form_validate.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:19:16 GMT -->
</html>
