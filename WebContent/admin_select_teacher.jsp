<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE>
<html>


<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>老师信息查询</title>

    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <script src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script>
        function load(){
        	var name =getQueryString("u_number");
        	
        	selectAllTeacher(name);
        }
        function selectAllTeacher(name){
        	$.ajax({
    			url:"/EducationSystem/ESAdmin",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                    method:'selectAllTeacher',
                    u_number:name
                },
                success:function(data){
                	console.log("reload");
                },
                error:function(jqXHR, textStatus, errorThrown){
                	/*弹出jqXHR对象的信息*/
                	
                    dealTeacherData(name,jqXHR.responseText);
                }
    		});
        }
        function searchTeacher(name,s_num){
        	$.ajax({
    			url:"/EducationSystem/ESAdmin",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                    method:'searchTeacher',
                    u_number:name,
                    s_number:s_num
                },
                success:function(data){
                	console.log("reload");
                },
                error:function(jqXHR, textStatus, errorThrown){
                	/*弹出jqXHR对象的信息*/
                	
                    dealTeacherData(name,jqXHR.responseText);
                	
                    
                }
    		});
        }
        function deleteTeacher(name,s_num,s_name){
        	swal({
                title: "您确定要删除这条信息吗",
                text: "删除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "删除",
                closeOnConfirm: false
            }, function () {
            	var msg=["删除成功","选课表中存在信息","删除失败"];
            	var msgtype=["success","error","error"];
            	$.ajax({
        			url:"/EducationSystem/ESAdmin",//servlet文件的名称  
                    type:"POST",
                    dataType:"json",
                    data:{
                        method:'deleteTeacher',
                        u_number:name,
                        s_number:s_num
                    },
                    success:function(data){
                    	console.log("reload");
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
                        },function(){
                        	selectAllTeacher(name);
                        });
                        
                    }
        		});
            });
        	
        }
        function updateTeacher(name,s_num,s_name,s_major,s_grade){
        	$("#userno").val(s_num);
        	$("#userno").attr("disabled",true);
        	$("#username").val(s_name);
        	$("#updatePlace").show();
        	$("#submitUpdate").on("click",function(){
        		if($("#username").val()==null){
        			swal({
                        title: "老师姓名不能为空",
                        text: "",
                        type: "warning",
                    })
        		}else{
        			$.ajax({
            			url:"/EducationSystem/ESAdmin",//servlet文件的名称  
                        type:"POST",
                        dataType:"json",
                        data:{
                            method:'updateTeacher',
                            u_number:name,
                            s_number:$("#userno").val(),
                            s_name:$("#username").val(),
                            s_password:($("#pwd").val()==null)?"":$("#pwd").val(),
                        },
                        success:function(data){
                        	console.log("reload");
                        },
                        error:function(jqXHR, textStatus, errorThrown){
                        	var msg=["更新成功","职工号不存在","更新失败"];
                        	var msgtype=["success","error","error"];
                            data = eval("("+jqXHR.responseText+")");
                    		var statusCode = data["statusCode"];
                            swal({
                                title: msg[statusCode],
                                type: msgtype[statusCode],
                                confirmButtonColor: "#DD6B55",
                                confirmButtonText: "确认",
                                closeOnConfirm: true
                            },function(){
                            	searchTeacher(name,s_num);
                            	$("#updatePlace").hide();
                            });
                            
                        }
            		});
        		}
        		
        	})
        	
        	
        }
        function dealTeacherData(name,data){
        	data = eval("("+data+")");
        	$("#insertPlace").html("");
        	if(data[0].u_no!="-1"){
        		$.each(data, function (index) {  
                    //循环获取数据    
                    var u_no = data[index].u_no;  
                    var u_name = data[index].u_name;  
                    tt =  "<tr>"
    	            	+"<td>"+u_no+"</td>"
    	                +"<td>"+u_name+"</td>"
    	                +"<td><button onclick='updateTeacher("+name+","+u_no+",\""+u_name+"\")' class='btn btn-primary btn-sm demo4'>修改</button></td>"
    	                +"<td><button onclick='deleteTeacher("+name+","+u_no+")' class='btn btn-danger btn-sm demo4'>删除</button></td></tr>";
                    $("#insertPlace").append(tt);
                });
        	}
        	else{
        		swal({
                    title: "老师不存在",
                    type: "error",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确认",
                    closeOnConfirm: true
                },function(){
                	selectAllTeacher(name);
                });
        	}
        	
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
        	
            <div class="col-sm-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>查询老师</h5>
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
                        <div class="form-horizontal m-t"  id="signupForm" >
                            <div class="form-group">
                                <label class="col-sm-3 control-label">职工号：</label>
                                <div class="col-sm-6">
                                    <input id="numberInput" class="form-control" type="text" >
                                </div>
                            	<span class="input-group-btn">
                                	<button id="selectBut" class="btn btn btn-primary"> <i class="fa fa-search"></i> 查询</button>
                             	</span>
                             </div>                               
                        </div>
                    </div>
                </div>
            </div>
            <div id="updatePlace" class="col-sm-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>修改老师信息</h5>
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
                        <div class="form-horizontal m-t"  id="signupForm"  >
                            <div class="form-group">
                            	
                                <label class="col-sm-3 control-label"><span style="color:red">*</span>职工号：</label>
                                <div class="col-sm-8">
                                    <input id="userno" name="userno" class="form-control" type="text" required aria-invalid="true" class="error"  value="">    
                                </div>
                            </div>
                             <div class="form-group">
                             	
                                <label class="col-sm-3 control-label"><span style="color:red">*</span>姓名：</label>
                                <div class="col-sm-8">
                                    <input id="username" name="username" class="form-control" type="text" required aria-invalid="true" class="error"  value="">    
                                </div>
                            </div>
                             <div class="form-group">
                                <label class="col-sm-3 control-label">密码：</label>
                                <div class="col-sm-8">
                                    <input id="pwd" name="pwd" class="form-control" type="text">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-6">
                                    <button id="submitUpdate" class="btn btn-primary" >提交</button>
                                </div>
                            </div>
                        </div>
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
            	<td class="">职工号</td>
                <td class="">姓名</td>
                <td class="">修改</td>
                <td class="">删除</td>
            </tr>
            </thead>
            <tbody id="insertPlace">
            </tbody>
       	</table>
    </div>
    <script src="js/jquery.min.js?v=2.1.4"></script>
    <script src="js/bootstrap.min.js?v=3.3.6"></script>
    <script src="js/content.min.js?v=1.0.0"></script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
    <script type="text/javascript" >
        $(document).ready(function(){
    		var name =getQueryString("u_number");
			$("#selectBut").on("click",function(){
				var s_number = $("#numberInput").val();
				searchTeacher(name,s_number);
			})
			$("#updatePlace").hide();
    	})
    		
    </script>
</body>

</html>
    