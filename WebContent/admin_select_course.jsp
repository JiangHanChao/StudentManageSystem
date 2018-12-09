<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE>
<html>


<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>学生信息查询</title>

    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <script src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script>
        function load(){
        	var name =getQueryString("u_number");
        	selectAllCourse(name);
        	/* loadTeacher(name); */
        }
        function selectAllCourse(name){
        	$.ajax({
    			url:"/EducationSystem/ESAdmin",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                    method:'selectAllCourse',
                    u_number:name
                },
                success:function(data){
                	console.log("reload");
                },
                error:function(jqXHR, textStatus, errorThrown){
                	/*弹出jqXHR对象的信息*/
                	console.log(jqXHR.responseText);
                    dealCourseData(name,jqXHR.responseText);
                }
    		});
        }
        function searchCourse(name,c_num){
        	$.ajax({
    			url:"/EducationSystem/ESAdmin",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                    method:'searchCourse',
                    u_number:name,
                    c_number:c_num
                },
                success:function(data){
                	console.log("reload");
                },
                error:function(jqXHR, textStatus, errorThrown){
                	/*弹出jqXHR对象的信息*/
                	
                    dealCourseData(name,jqXHR.responseText);
                	
                    
                }
    		});
        }
        /* function deleteCourse(name,c_num,c_name){
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
                        method:'deleteCourse',
                        u_number:name,
                        c_number:c_num
                    },
                    success:function(data){
                    	console.log("reload");
                    },
                    error:function(jqXHR, textStatus, errorThrown){
                        data = eval("("+jqXHR.responseText+")");
                    	
                		var statusCode = data["statusCode"];
                        swal({
                            title: msg[statusCode],
                            type: msgtype[statusCode],
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "确认",
                            closeOnConfirm: true
                        },function(){
                        	selectAllCourse(name);
                        });
                        
                    }
        		});
            });
        	
        } */
        /* function updateCourse(name,c_num,c_name,teacher,limit_num,selected,semester){
        	
        	var semesterF = ['2014','2015','2016','2017','2018','2019'];
        	$("#cno").val(c_num);
        	$("#cno").attr("disabled",true);
        	$("#cname").val(c_name);
        	$("#teacher").val(teacher);
        	$("#selected").val(selected);
        	$("#limit").val(limit_num);
        	$("#semester").val(semester);
        	$("#selected").attr("disabled",true);
        	$("#limit").attr("disabled",true);
        	console.log($("#semester").val(semester));
        	$("#semester").attr("disabled",true);
        	$("#updatePlace").show();
        	$("#submitUpdate").on("click",function(){
        		if($("#cname").val()==null){
        			swal({
                        title: "课程名不能为空",
                        text: "",
                        type: "warning",
                    })
        		}else{
        			$.ajax({
            			url:"/EducationSystem/ESAdmin",//servlet文件的名称  
                        type:"POST",
                        dataType:"json",
                        data:{
                            method:'updateCourse',
                            u_number:name,
                            c_number:$("#cno").val(),
                            c_name:$("#cname").val(),
                            c_teacher:$("#teacher").val(),
                            c_limit:$("#limit").val(),
                            c_semester:semesterF[$("#semester").val()],
                        },
                        success:function(data){
                        	console.log("reload");
                        },
                        error:function(jqXHR, textStatus, errorThrown){
                        	var msg=["更新成功","课程号不存在","更新失败"];
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
                            	searchCourse(name,c_num);
                            	$("#updatePlace").hide();
                            });
                            
                        }
            		});
        		}
        		
        	})
        	
        	
        } */
        function dealCourseData(name,data){
        	data = eval("("+data+")");
        	$("#insertPlace").html("");
        	if(data[0].c_no!="-1"){
        		$.each(data, function (index) {  
                    //循环获取数据    
                    var c_no = data[index].c_no;  
                    var c_name = data[index].c_name; 
                    var c_teacher = data[index].c_teacher; 
                    var c_tno = data[index].c_tno;
                    var c_limit = data[index].c_limit; 
                    var c_selected = data[index].c_selected; 
                    var c_semester = data[index].c_semester; 
                    tt =  "<tr>"
    	            	+"<td>"+c_no+"</td>"
    	                +"<td>"+c_name+"</td>"
    	                +"<td>"+c_teacher+"</td>"
    	                +"<td>"+c_limit+"</td>"
    	                +"<td>"+c_selected+"</td>"
    	                +"<td>"+c_semester+"</td></tr>";
                    $("#insertPlace").append(tt);
                });
        	}
        	else{
        		swal({
                    title: "课程不存在",
                    type: "error",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确认",
                    closeOnConfirm: true
                },function(){
                	selectAllCourse(name);
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
        /* function loadTeacher(name){
        	$.ajax({
                url:"/EducationSystem/ESAdmin",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                	method:"selectTeacherListCourse",
                	username:name
                },
                success:function(data){  
                	dealTeacherList(name,data)
                },
                error:function(jqXHR, textStatus, errorThrown){
                	dealTeacherList(name,jqXHR.responseText);
    	            
                }
            });
        } */
        
        /* function dealTeacherList(name,data){
        	data = eval("("+data+")");
        	$("#teacher").html("");
        	var tt = "";
        	
        	$.each(data, function (index) {  
                //循环获取数据    
                var u_no = data[index].u_no;  
                var u_name = data[index].u_name; 
                tt =  "<option value='"+u_no+"'>"+u_name+"</option>";
                $("#teacher").append(tt);
            });
        } */
    </script>

</head>
<body class="gray-bg" onload="load()">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
        	
            <div class="col-sm-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>查询课程信息</h5>
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
                                <label class="col-sm-3 control-label">课程号：</label>
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
                        <h5>修改课程信息</h5>
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
                            	
                                <label class="col-sm-3 control-label"><span style="color:red">*</span>课程号：</label>
                                <div class="col-sm-8">
                                    <input id="cno" name="userno" class="form-control" type="text" >    
                                </div>
                            </div>
                             <div class="form-group">
                             	
                                <label class="col-sm-3 control-label"><span style="color:red">*</span>课程名：</label>
                                <div class="col-sm-8">
                                    <input id="cname" name="username" class="form-control" type="text" >    
                                </div>
                            </div>
                             <div class="form-group">
                                <label class="col-sm-3 control-label">任课老师：</label>
                                <div class="col-sm-8">
                                    <select id="teacher" class="input-sm form-control input-lg inline">
	                                    
	                                </select>
                                </div>
                            </div>
                            <div class="form-group">
                            	
                                <label class="col-sm-3 control-label"><span style="color:red">*</span>已选人数：</label>
                                <div class="col-sm-8">
                                    <input id="selected" name="username" class="form-control" type="number" >
                                </div>
                            </div>
                            <div class="form-group">
                            	
                                <label class="col-sm-3 control-label"><span style="color:red">*</span>限选人数：</label>
                                <div class="col-sm-8">
                                    <input id="limit" name="username" class="form-control" type="number">
                                       
                                </div>
                            </div>
                            <div class="form-group">
                            	
                                <label class="col-sm-3 control-label"><span style="color:red" >*</span>开课年级：</label>
                                <div class="col-sm-8">
                                    <select id="semester" class="input-sm form-control input-lg inline">
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
            	<td class="">课程号</td>
                <td class="">课程名</td>
                <td class="">任课老师</td>
                <td class="">限选人数</td>
                <td class="">已选人数</td>
                <td class="">开课年级</td>
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
				var c_number = $("#numberInput").val();
				searchCourse(name,c_number);
			})
			$("#updatePlace").hide();
    	})
    		
    </script>
</body>

</html>
    