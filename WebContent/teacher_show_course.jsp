<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>

<!-- Mirrored from www.zi-han.net/theme/hplus/table_data_tables.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:20:01 GMT -->
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>开设的课程</title>

    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">

    <!-- Data Tables -->
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min862f.css?v=4.1.0" rel="stylesheet">
    
    <link href="css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <script src="js/plugins/sweetalert/sweetalert.min.js"></script>
    
    <script type="text/javascript">    
        function loadCourseTable(name){  
            $.ajax({
                url:"/EducationSystem/ESTeacher",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                	method:"loadCourse",
                	username:name
                },
                success:function(data){  
                	data = eval("("+data+")"); //数组     
                	if(data[0].cno=="-1"){
                		swal({
                            title: "暂无开课",
                            type: "",
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "确认",
                            closeOnConfirm: true
                        });
                	}
                	else{
                		$.each(data, function (index) {  
                            //循环获取数据    
                            var c_no = data[index].c_no;  
                            var c_name = data[index].c_name;  
                            var c_limitnum = data[index].c_limitnum; 
                            var c_selectednum = data[index].c_selectednum;
                            var c_semester = data[index].c_semester;  
                            tt =  "<tr class='gradeX odd'>"
                                +"<td>"+c_no+"</td>"
                                +"<td>"+c_name+"</td>"
                                +"<td>"+c_limitnum+"</td>"
                                +"<td class='center'>"+c_selectednum+"</td>"
                                +"<td class='center'>"+c_semester+"</td></tr>";
                            $("#insertPlace").append(tt);
                        });
                	}
                     
                },
                error:function(jqXHR, textStatus, errorThrown){
                	/*弹出jqXHR对象的信息*/
                	
                	data = eval("("+jqXHR.responseText+")");
                	if(data[0].c_no=="-1"){
                		swal({
                            title: "暂无开课",
                            type: "",
                            confirmButtonColor: "#DD6B55",
                            confirmButtonText: "确认",
                            closeOnConfirm: true
                        });
                	}
                	else{
                		$.each(data, function (index) {  
                            //循环获取数据    
                            var c_no = data[index].c_no;  
                            var c_name = data[index].c_name;  
                            var c_limitnum = data[index].c_limitnum; 
                            var c_selectednum = data[index].c_selectednum;
                            var c_semester = data[index].c_semester;  
                            tt =  "<tr class='gradeX odd'>"
                                +"<td>"+c_no+"</td>"
                                +"<td>"+c_name+"</td>"
                                +"<td>"+c_limitnum+"</td>"
                                +"<td class='center'>"+c_selectednum+"</td>"
                                +"<td class='center'>"+c_semester+"</td></tr>";
                            $("#insertPlace").append(tt);
                        });
                	}
                }
            });   
        }  
   </script> 

</head>

<body class="gray-bg" onload="loadCourseTable(<%=request.getQueryString() %>)">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>开设的课程</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="dropdown-toggle" data-toggle="dropdown" href="table_data_tables.html#">
                                <i class="fa fa-wrench"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">

                        <table class="table table-striped table-bordered table-hover dataTables-example">
                            <thead>
                                <tr>
                                    <th>课程号</th>
                                    <th>课程名</th>
                                    <th>限选人数</th>
                                    <th>已选人数</th>
                                    <th>学期</th>
                                </tr>
                            </thead>
                            <tbody id="insertPlace">
                            </tbody>
                        </table>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="js/jquery.min.js?v=2.1.4"></script>
    <script src="js/bootstrap.min.js?v=3.3.6"></script>
    <script src="js/plugins/jeditable/jquery.jeditable.js"></script>
    <script src="js/plugins/dataTables/jquery.dataTables.js"></script>
    <script src="js/plugins/dataTables/dataTables.bootstrap.js"></script>
    <script src="js/content.min.js?v=1.0.0"></script>
    <script>
        
    </script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>

</body>


<!-- Mirrored from www.zi-han.net/theme/hplus/table_data_tables.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:20:02 GMT -->
</html>