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
        	
        	selectAllStudent(name);
        }
        function selectAllStudent(name){
        	$.ajax({
    			url:"/EducationSystem/ESAdmin",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                    method:'selectAllStudent',
                    u_number:name
                },
                success:function(data){
                	console.log("reload");
                },
                error:function(jqXHR, textStatus, errorThrown){
                	/*弹出jqXHR对象的信息*/
                	
                    dealStudentData(name,jqXHR.responseText);
                }
    		});
        }
        function searchStudent(name,s_num){
        	$.ajax({
    			url:"/EducationSystem/ESAdmin",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                    method:'searchStudent',
                    u_number:name,
                    s_number:s_num
                },
                success:function(data){
                	console.log("reload");
                },
                error:function(jqXHR, textStatus, errorThrown){
                	/*弹出jqXHR对象的信息*/
                	
                    dealStudentData(name,jqXHR.responseText);
                	
                    
                }
    		});
        }
        function deleteStudent(name,s_num,s_name){
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
                        method:'deleteStudent',
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
                        	selectAllStudent(name);
                        });
                        
                    }
        		});
            });
        	
        }
        function updateStudent(name,s_num,s_name,s_major,s_grade){
        	var major = new Map([['计算机科学与技术', 0], ['物联网工程', 1], ['软件工程', 2],['信息安全', 3],['通信工程', 4],['数字媒体', 5]]);
        	var majorF = ["计算机科学与技术","物联网工程","软件工程","信息安全","通信工程","数字媒体"];
        	var grade = new Map([['2014', 0], ['2015', 1], ['2016', 2],['2017', 3],['2018', 4],['2019', 5]]);
        	var gradeF = ['2014','2015','2016','2017','2018','2019'];
        	$("#userno").val(s_num);
        	$("#userno").attr("disabled",true);
        	$("#username").val(s_name);
        	$("#userge").val(grade.get(s_grade));
        	$("#usermj").val(major.get(s_major));
        	$("#updatePlace").show();
        	$("#submitUpdate").on("click",function(){
        		if($("#username").val()==null){
        			swal({
                        title: "学生姓名不能为空",
                        text: "",
                        type: "warning",
                    })
        		}else{
        			$.ajax({
            			url:"/EducationSystem/ESAdmin",//servlet文件的名称  
                        type:"POST",
                        dataType:"json",
                        data:{
                            method:'updateStudent',
                            u_number:name,
                            s_number:$("#userno").val(),
                            s_name:$("#username").val(),
                            s_password:($("#pwd").val()==null)?"":$("#pwd").val(),
                            s_grade:gradeF[$("#userge").val()],
                            s_major:majorF[$("#usermj").val()]
                        },
                        success:function(data){
                        	console.log("reload");
                        },
                        error:function(jqXHR, textStatus, errorThrown){
                        	var msg=["更新成功","学号不存在","更新失败"];
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
                            	searchStudent(name,s_num);
                            	$("#updatePlace").hide();
                            });
                            
                        }
            		});
        		}
        		
        	})
        	
        	
        }
        function dealStudentData(name,data){
        	data = eval("("+data+")");
        	$("#insertPlace").html("");
        	if(data[0].u_no!="-1"){
        		$.each(data, function (index) {  
                    //循环获取数据    
                    var u_no = data[index].u_no;  
                    var u_name = data[index].u_name; 
                    var u_major = data[index].u_major; 
                    var u_grade = data[index].u_grade; 
                    tt =  "<tr>"
    	            	+"<td>"+u_no+"</td>"
    	                +"<td>"+u_name+"</td>"
    	                +"<td>"+u_major+"</td>"
    	                +"<td>"+u_grade+"</td>"
    	                +"<td><button onclick='updateStudent("+name+","+u_no+",\""+u_name+"\",\""+u_major+"\",\""+u_grade+"\")' class='btn btn-primary btn-sm demo4'>修改</button></td>"
    	                +"<td><button onclick='deleteStudent("+name+","+u_no+")' class='btn btn-danger btn-sm demo4'>删除</button></td></tr>";
                    $("#insertPlace").append(tt);
                });
        	}
        	else{
        		swal({
                    title: "学生不存在",
                    type: "error",
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确认",
                    closeOnConfirm: true
                },function(){
                	selectAllStudent(name);
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
                        <div class="form-horizontal m-t"  id="signupForm" >
                            <div class="form-group">
                                <label class="col-sm-3 control-label">学号：</label>
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
                        <h5>修改学生信息</h5>
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
                            	
                                <label class="col-sm-3 control-label"><span style="color:red">*</span>学号：</label>
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
                            	
                                <label class="col-sm-3 control-label"><span style="color:red">*</span>年级：</label>
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
                            	
                                <label class="col-sm-3 control-label"><span style="color:red" >*</span>专业：</label>
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
            	<td class="">学号</td>
                <td class="">姓名</td>
                <td class="">专业</td>
                <td class="">年级</td>
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
				searchStudent(name,s_number);
			})
			$("#updatePlace").hide();
    	})
    		
    </script>
</body>

</html>
    