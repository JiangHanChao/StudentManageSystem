
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!DOCTYPE html>
<html>


<!-- Mirrored from www.zi-han.net/theme/hplus/table_basic.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:20:01 GMT -->
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>上传成绩</title>


    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <script src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script>
        function load(){
        	loadCourseList(getQueryString('u_number'));
        	
        }
        function loadCourseList(name){
        	$.ajax({    
                url:"/EducationSystem/ESTeacher",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                	method:"loadCourse",
                	username:name
                },
                success:function(data){  
                	dealCourseData(name,data); 
                },
                error:function(jqXHR, textStatus, errorThrown){
                	/*弹出jqXHR对象的信息*/
                    dealCourseData(name,jqXHR.responseText);
                    
                }
            });
        }
        function dealCourseData(name,data){
        	data = eval("("+data+")"); //数组     
        	$("#selectList").html("");
        	if(data[0].c_no!="-1"){
        		$.each(data, function (index) {  
                    //循环获取数据    
                    var c_no = data[index].c_no;  
                    var c_name = data[index].c_name; 
                    tt =  "<option id='courseCno"+c_no+"' value='"+c_no+"'>"+c_name+"</option>";
                    $("#selectList").append(tt);
                });
        		/* console.log(data[0].c_no); */
        		getCourseStudent(getQueryString('u_number'),""+data[0].c_no);
        	}
        	else{
        		swal({title:"",text: "暂无开课"});
        	}
            
        }
        function getCourseStudent(name,c_no){
        	
        	if(c_no!="-1" && c_no!=null){
        		$.ajax({    
                    url:"/EducationSystem/ESTeacher",//servlet文件的名称  
                    type:"POST",
                    dataType:"json",
                    data:{
                    	method:"loadCourseStudent",
                    	username:name,
                    	courseNumber:c_no,
                    },
                    success:function(data){  
                    	dealCourseStudent(data); 
                    },
                    error:function(jqXHR, textStatus, errorThrown){
                    	/*弹出jqXHR对象的信息*/
                        dealCourseStudent(jqXHR.responseText);
                    }
                });
        	}
        	
        }
        function dealCourseStudent(data){
        	data = eval("("+data+")"); //数组     
        	$("#studentList").html("");
        	if(data!=null && data[0].u_no!="-1"){
        		$.each(data, function (index) {  
                    //循环获取数据    
                    var u_no = data[index].u_no;  
                    var u_name = data[index].u_name;
                    var u_score = data[index].u_score;
                    var str = (u_score!=0?"disabled='disabled'":" ");
                    tt = "<tr>"
                        +"<td class='text-center'>"+u_no+"</td>"
                        +"<td class='text-center'>"+u_name+"</td>"
                        +"<td class='text-center'><input class='form-control'  style='width:40px;margin:0 auto;padding:2px' name='gradeText' uno='"+u_no+"' "+str+" type='number' value='"+u_score+"' ></td>"
                        +"</tr>";
                    $("#studentList").append(tt);
                });
        	}
        	else{
        		swal({title:"",text: "暂无人选"});
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
        function validateGrade(){
        	console.log("yanz");
        	var flag = true;
        	$("input[name='gradeText']").each(function(){
        		var val = $(this).val();
                var uno = $(this).attr("uno");
                var reg = new RegExp(/^(?:[1-9]?\d|100)$/);
                if(!reg.test(val)){
               	 	swal({
                        title: "",
                        text: uno+"成绩不合法",
                        type: "warning"
                    });
               		flag=false;
            		return flag;
                }
        	});
        	return flag;
        }
        
        function dealUpdateResult(data){
        	var result=[":上传成功","：上传失败"];
        	data = eval("("+data+")");
        	var tt="";
        	$.each(data, function (index) {  
                //循环获取数据    
                var c_no = data[index].c_no;  
                var c_result = result[data[index].c_result];  
                tt += ""+c_no+"  "+c_result+"\n"; 
                
            });
            swal({
                title: "上传结果",
                text: tt,
                type: "success"
            });
        }
    </script>

</head>

<body class="gray-bg" onload="load()">
    <div class="wrapper wrapper-content animated fadeInRight">
        
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>选课情况</h5>
                        <div class="ibox-tools">
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-3 m-b-xs">
                                <select id="selectList" class="input-sm form-control input-lg inline">
                                    <option value="-1">选择课程</option>
                                </select>
                            </div>
                            <div class="col-sm-7"></div>
                            <div class="col-sm-2">
                                <div class="input-group">
                                    <button id="gradeSubmit" type="button" class="btn btn-lg btn-primary">提交成绩</button>
                                </div>
                            </div>
                        </div>
                        <div class="table-responsive" class="row">
                            <div class="col-sm-12">
	                            <table class="table table-striped" class="text-center">
	                                <thead>
	                                    <tr >
	                                        <th class="text-center ">学号</th>
	                                        <th class="text-center ">姓名</th>
	                                        <th class="text-center ">成绩</th>
	                                    </tr>
	                                </thead>
	                                <tbody id="studentList">
	                                   
	                                </tbody>
	                            </table>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </div>
    <script src="js/jquery.min.js?v=2.1.4"></script>
    <script src="js/bootstrap.min.js?v=3.3.6"></script>
    <script src="js/plugins/peity/jquery.peity.min.js"></script>
    <script src="js/content.min.js?v=1.0.0"></script>
    <script src="js/plugins/iCheck/icheck.min.js"></script>
    <script src="js/demo/peity-demo.min.js"></script>
    <script>
        $(document).ready(function(){
        	var u_number = getQueryString('u_number');
        	
        	$("#selectList").change(function(){
        		if($("#selectList").val()!=null){
        			getCourseStudent(getQueryString("u_number"),$("#selectList").val());
        		}
        	});
        	
        	$("#gradeSubmit").on("click",function(){
        		var c_no=$('#selectList').val();
        		console.log(c_no);
        		if(validateGrade()&&c_no!=null){
        			var u_name = getQueryString("u_number");
        			swal({
            	        title: "您确定要上传成绩吗？",
            	        text: "上传后将无法修改，请谨慎操作！",
            	        type: "warning",
            	        showCancelButton: true,
            	        confirmButtonColor: "#DD6B55",
            	        confirmButtonText: "上传",
            	        closeOnConfirm: false
            	    }, function() {
            	    	var ItemsName = new Array();
                    	var ItemsValue = new Array();
                    	$("input[name='gradeText']").each(function() {
                    		if(!($(this).attr("disabled"))&&($(this).val()!='0')){
                    			ItemsName.push($(this).attr("uno"));
                        		ItemsValue.push($(this).val());
                    		}
                    		
                    	});
                    	if (ItemsValue.length == 0){
                    		swal({
                                title: "",
                                text: "无内容更新",
                                type: "warning",
                            });
                    	}
                    	else{
                    		var _list = {};  
                    		_list["method"] = "updateGrade";
                    		_list["username"] = u_number;
                    		_list["cno"] = c_no;
                    		for (var i = 0; i < ItemsName.length; i++) {  
                    		    _list["cno[" + i + "]"] = ItemsName[i];  
                    		    _list["grade[" + i + "]"] = ItemsValue[i];
                    		    /* console.log(_list["cno[" + i + "]"]+" "+_list["grade[" + i + "]"]); */
                    		}  
                    		$.ajax({
            	        		type: "POST",
            	        		url: "/EducationSystem/ESTeacher",
            	        		data:_list,
            	        		dataType: "json",
            	        		success: function (request) {
            	        		    document.location.reload();
            	        		},
            	        		error: function(jqXHR, textStatus, errorThrown){
            	        		    dealUpdateResult(jqXHR.responseText);
            	        		    /* console.log(jqXHR.responseText); */
            	        		    
            	        		    getCourseStudent(u_number,c_no);
            	        		    /* loadCourseTable(getQueryString("u_number")) */
            	        		}
                    		})
                    	}
            	    });
        			
        		}
        		
        		
        	});
        });
    </script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
</body>


<!-- Mirrored from www.zi-han.net/theme/hplus/table_basic.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:20:01 GMT -->
</html>
    