<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<%String s1=(String)request.getAttribute("u_number");%>

<!-- Mirrored from www.zi-han.net/theme/hplus/mailbox.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:18:21 GMT -->
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>ES选课</title>
    
    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min862f.css?v=4.1.0" rel="stylesheet">
    
    <link href="css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <script src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript">  
        function dealResult(data){
        	var result=[":选择成功","：选课人数上限","：选课失败"];
        	data = eval("("+data+")");
        	var tt="";
        	$.each(data, function (index) {  
                //循环获取数据    
                var c_no = data[index].c_no;  
                var c_name = data[index].c_name;  
                var c_result = result[data[index].c_result];  
                tt += ""+c_name+"  "+c_result+"\n"; 
                
            });
            swal({
                title: "选课结果",
                text: tt,
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "确定",
                closeOnConfirm: false
            });
        }
        function searchCourse(name,searchText){
        	$.ajax({    
                url:"/EducationSystem/ESStudent",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                	method:"searchCourse",
                	username:name,
                	coursename:searchText,
                },
                success:function(data){  
                	dealData(data); 
                },
                error:function(jqXHR, textStatus, errorThrown){
                	/*弹出jqXHR对象的信息*/
                    dealData(jqXHR.responseText);
                }
            });
        }
        function loadCourseTable(name){  
            $.ajax({    
                url:"/EducationSystem/ESStudent",//servlet文件的名称  
                type:"POST",
                dataType:"json",
                data:{
                	method:"loadCourse",
                	username:name
                },
                success:function(data){  
                	dealData(data); 
                },
                error:function(jqXHR, textStatus, errorThrown){
                	/*弹出jqXHR对象的信息*/
                    dealData(jqXHR.responseText);
                }
            });   
        }
        function dealData(data){
        	data = eval("("+data+")"); //数组     
            $("#insertPlace").html("");
            var tt ="<tr class='unread'>"
                +"<td class='check-mail'>选择</td>"
                +"<td class=''>课程编号</td>"
                +"<td class=''>课程名</td>"
                +"<td class=''>任课老师</td>"
                +"<td class='text-center'>已选人数</td>"
                +"<td class='text-center'>限选人数</td></tr>";
            $("#insertPlace").append(tt);
            if(data[0].c_no!=-1){
            	$.each(data, function (index) {  
                    //循环获取数据    
                    var c_no = data[index].c_no;  
                    var c_name = data[index].c_name;  
                    var c_teacher = data[index].c_teacher;  
                    var c_limitnum = data[index].c_limitnum; 
                    var c_selectednum = data[index].c_selectednum;
                    var c_isselected = (data[index].c_isselected==1)?true:false;
                    tt = "<tr class="+(c_isselected?"unread":"read")+">"
                        +"<td class='check-mail'>"
                        +"<input type='checkbox' name='selectedCourse' value='"+c_no+"' class='i-checks' "+(c_isselected?"disabled='disabled' checked='checked'":"")+"></td>"
                        +"<td class='mail-subject'>"+(c_isselected?"<span class='label label-warning pull-right'>已选</span>":"")+"<span class=''>"+c_no+"</span></td>"
                        +"<td class=''>"+c_name+"</td>"
                        +"<td class=''>"+c_teacher+"</td>"
                        +"<td class='text-center'>"+c_selectednum+"</td>"
                        +"<td class='text-center'>"+c_limitnum+"</td></tr>"; 
                    $("#insertPlace").append(tt);
                });
            }
            else{
            	tt = "<tr class='unread'>"
	                +"<td colspan='6' class='text-center' >没有课程可以选~</td>"
	                +"</tr>"; 
            	$("#insertPlace").append(tt);
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

<body class="gray-bg" >
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-12 animated fadeInRight">
                <div class="mail-box-header">
                    <div class="mail-tools tooltip-demo m-t-md">
                        <div>
                            <div class="pull-right mail-search">
		                        <div class="input-group">
		                            <input id="searchText" type="text" class="form-control input-sm" name="search" placeholder="课程名称">
		                            <div class="input-group-btn">
		                                <button id="searchButton" class="btn btn-sm btn-primary">搜索</button>
		                            </div>
		                        </div>
		                   </div>
                        </div>
                        
                        <button class="btn btn-white btn-sm" id="freshTable" data-toggle="tooltip" data-placement="top" title="刷新列表"><i class="fa fa-refresh"></i> 刷新</button>
                        <button class="btn btn-white btn-sm" id="submitCourse" data-toggle="tooltip" data-placement="top" title="提交选课"><i class="fa fa-exclamation"> 提交</i>
                        </button>
                        <div class="btn-group">
                            <button class="btn btn-white btn-sm" data-placement="top" title="上一页"><i class="fa fa-arrow-left"></i>
                            </button>
                            <button class="btn btn-white btn-sm" data-placement="top" title="下一页"><i class="fa fa-arrow-right"></i>
                            </button>

                        </div>

                    </div>
                </div>
                <div class="mail-box">
                    <ul id="msgInsertPlace"></ul>

                    <table class="table table-hover table-mail">
                        <tbody id="insertPlace">
                            <tr class="unread">
                                <td class="check-mail">选择</td>
                                <td class="">课程编号</td>
                                <td class="">课程名</td>
                                <td class="">任课老师</td>
                                <td class="text-center">已选人数</td>
                                <td class="text-center">限选人数</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script src="js/jquery.min.js?v=2.1.4"></script>
    <script src="js/bootstrap.min.js?v=3.3.6"></script>
    <script src="js/content.min.js?v=1.0.0"></script>
    <script src="js/plugins/iCheck/icheck.min.js"></script>
    <script>
    	$(document).ready(loadCourseTable(getQueryString("u_number")));
        $(document).ready(function(){$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",})});
        /*fresh course table */
        $("#freshTable").on("click",function(){loadCourseTable(getQueryString("u_number"));});
        /*search course  */
        $("#searchButton").on("click",function(){searchCourse(getQueryString("u_number"),$("#searchText").val());});
        /*submit course table  */
        $("#submitCourse").on("click",function(){
        	var u_name = getQueryString("u_number");
        	var selectedItems = new Array();
        	$("input[name='selectedCourse']:checked").each(function() {disabled='disabled'
        		if(!($(this).attr("disabled"))){
        			selectedItems.push($(this).val());
        		}
        	});
        	

        	if (selectedItems.length == 0)
        	    alert("Please select one course.");
        	else{
        		var _list = {};  
        		_list["method"] = "submitCourse";
        		_list["username"] = u_name;
        		_list["selectedCount"] = selectedItems.length;
        		for (var i = 0; i < selectedItems.length; i++) {  
        		    _list["selectedIDs[" + i + "]"] = selectedItems[i];  
        		}  
        		$.ajax({
	        		type: "POST",
	        		url: "/EducationSystem/ESStudent",
	        		data:_list,
	        		dataType: "json",
	        		success: function (request) {
	        		    document.location.reload();
	        		},
	        		error: function(jqXHR, textStatus, errorThrown){
	        		    dealResult(jqXHR.responseText);
	        		    loadCourseTable(getQueryString("u_number"))
	        		}
        		})
        	}
        	    
        })
    </script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
</body>


<!-- Mirrored from www.zi-han.net/theme/hplus/mailbox.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:18:22 GMT -->
</html>
