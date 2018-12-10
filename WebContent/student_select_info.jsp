<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>

<!-- Mirrored from www.zi-han.net/theme/hplus/table_data_tables.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:20:01 GMT -->
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生信息</title>

    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">

    <!-- Data Tables -->
    <link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min862f.css?v=4.1.0" rel="stylesheet">
    
    <script type="text/javascript">    
        function loadInfoTable(name){
            $.ajax({
                url:"/EducationSystem/ESStudent",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                	method:"selectInfo",
                	username:name
                },
                success:function(data){  
                	data = eval("("+data+")"); //数组     
                    $.each(data, function (index) {  
                        //循环获取数据    
                    	var stu_no = data[index].stu_no;
                        var stu_name = data[index].stu_name;
                        var stu_bir = data[index].stu_bir;
                        var stu_age = data[index].stu_age;
                        var stu_sex = data[index].stu_sex;
                        var stu_pol = data[index].stu_pol;
                        var stu_time = data[index].stu_time;
                        var stu_addr = data[index].stu_addr;
                        var stu_post = data[index].stu_post;
                        var stu_grade = data[index].stu_grade;
                        var stu_major = data[index].stu_major;
                        tt =  "<tr class='gradeX odd'>"
                            +"<td>"+stu_no+"</td>"
                            +"<td>"+stu_name+"</td>"
                            +"<td>"+stu_bir+"</td>"
                            +"<td>"+stu_age+"</td>"
                            +"<td>"+stu_sex+"</td>"
                            +"<td>"+stu_pol+"</td>"
                            +"<td>"+stu_time+"</td>"
                            +"<td>"+stu_addr+"</td>"
                            +"<td>"+stu_post+"</td>"
                            +"<td>"+stu_grade+"</td>"
                            +"<td>"+stu_major+"</td></tr>";
                        $("#insertPlace").append(tt);
                    }); 
                },
                error:function(jqXHR, textStatus, errorThrown){
                	/*弹出jqXHR对象的信息*/
                	data = eval("("+jqXHR.responseText+")");
                    $.each(data, function (index) {  
                        //循环获取数据      
                         var stu_no = data[index].stu_no;
                         var stu_name = data[index].stu_name;
                         var stu_bir = data[index].stu_bir;
                         var stu_age = data[index].stu_age;
                         var stu_sex = data[index].stu_sex;
                         var stu_pol = data[index].stu_pol;
                         var stu_time = data[index].stu_time;
                         var stu_addr = data[index].stu_addr;
                         var stu_post = data[index].stu_post;
                         var stu_grade = data[index].stu_grade;
                         var stu_major = data[index].stu_major;
                         tt =  "<tr class='gradeX odd'>"
                             +"<td>"+stu_no+"</td>"
                             +"<td>"+stu_name+"</td>"
                             +"<td>"+stu_bir+"</td>"
                             +"<td>"+stu_age+"</td>"
                             +"<td>"+stu_sex+"</td>"
                             +"<td>"+stu_pol+"</td>"
                             +"<td>"+stu_time+"</td>"
                             +"<td>"+stu_addr+"</td>"
                             +"<td>"+stu_post+"</td>"
                             +"<td>"+stu_grade+"</td>"
                             +"<td>"+stu_major+"</td></tr>";
                         $("#insertPlace").append(tt);
                    });  
                }
            });   
        }  
   </script> 

</head>

<body class="gray-bg" onload="loadInfoTable(<%=request.getQueryString() %>)">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>个人信息</h5>
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
                                    <th>学号</th>
                                    <th>姓名</th>
                                    <th>出生年月</th>
                                    <th>年龄</th>
                                    <th>性别</th>
                                    <th>政治面貌</th>
                                    <th>入学时间</th>
                                    <th>家庭住址</th>
                                    <th>邮编</th>
                                    <th>年级</th>
                                    <th>专业</th>
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