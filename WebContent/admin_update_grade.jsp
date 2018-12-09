<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>


<!-- Mirrored from www.zi-han.net/theme/hplus/form_validate.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:19:15 GMT -->
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>修改成绩</title>

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
                        <h5>修改成绩</h5>
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
                        <div class="form-horizontal m-t"> 
                            <div class="form-group">
                                <label class="col-sm-3 control-label">学号：</label>
                                <div class="col-sm-8">
                                    <input id="sno"name="sno" type="text" class="form-control" required aria-required="true" value="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">课程号：</label>
                                <div class="col-sm-8">
                                    <input id="cno" name="cno"  type="text" class="form-control" required aria-required="true" value="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">成绩：</label>
                                <div class="col-sm-8">
                                    <input id="score" name="score" type="text" class="form-control" required aria-required="true" value="">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-4 col-sm-offset-3">
                                    <button id="updategrade" class="btn btn-primary" type="submit">修改</button>
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
    <script src="js/plugins/validate/jquery.validate.min.js"></script>
    <script src="js/plugins/validate/messages_zh.min.js"></script>
    <script src="js/demo/form-validate-demo.min.js"></script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
    <script type="text/javascript">    
        	function updategrade(sno,cno,score){  
        	var msg=["成绩修改失败，学生不存在","成绩修改失败，课程不存在","成绩修改失败，学生没有选这门课","成绩修改成功"];
        	var msgtype=["error","error","error","success"];
            $.ajax({
                url:"/EducationSystem/ESAdmin",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                	method:"updategrade",
                	username:sno,
                	coursename:cno,
                	score:score
                },
                success:function(data){  
                	/*弹出jqXHR对象的信息*/
                	 data = eval("("+jqXHR.responseText+")");
                	var statusCode = data[0]["statusCode"];
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
                	var statusCode = data[0]["statusCode"];
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
        	$("#updategrade").on("click",function(){
            	var sno = $("#sno").val();
            	var cno = $("#cno").val();
            	var score = $("#score").val();
            	if(sno==""){
            		swal({
                        title: "学号不能为空",
                        type: "",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确认",
                        closeOnConfirm: true
                    });
            	}
            	else if(cno==""){
            		swal({
                        title: "课程号不能为空",
                        type:"",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确认",
                        closeOnConfirm: true
                    });
            	}
            	else if(score==""){
            		swal({
                        title: "成绩不能为空",
                        type:"",
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "确认",
                        closeOnConfirm: true
                    });
            	}
            	else{
            		var reg = new RegExp(/^(?:[1-9]?\d|100)$/);
            		if(!reg.test(score)){
            			swal({
                            title: "成绩输入不合法",
                            type:"",
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "确认",
                            closeOnConfirm: true
                        });
            		}
            		else{
            			updategrade(sno,cno,score);
            		}
            	}
            	
            })
        })
    </script>
</body>


<!-- Mirrored from www.zi-han.net/theme/hplus/form_validate.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:19:16 GMT -->
</html>