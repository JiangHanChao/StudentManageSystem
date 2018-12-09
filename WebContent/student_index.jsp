<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE>

<html>


<!-- Mirrored from www.zi-han.net/theme/hplus/ by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:16:41 GMT -->
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <title>学生教务系统主页</title>

    <link rel="shortcut icon" href="favicon.ico">
    <link href="css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min862f.css?v=4.1.0" rel="stylesheet">
</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
<div id="wrapper">
    <!--左侧导航开始-->
    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="nav-close"><i class="fa fa-times-circle"></i>
        </div>
        <div class="sidebar-collapse">
            <ul class="nav" id="side-menu">
                <li class="nav-header">
                    <div class="dropdown profile-element">
                        <span><img alt="image" class="img-circle" src="img/profile_small.jpg" /></span>
                        
                        <!-- 任成琨修改部分，2018.12.9 -->
                        <span class="block m-t-xs"><strong class="font-bold">${u_name} ${u_number}</strong></span>
                        <span class="block m-t-xs"><strong class="font-bold">${u_major}专业</strong></span>
                        <!-- <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <span class="clear">
                                <span class="block m-t-xs"><strong class="font-bold">${u_name} ${u_number}</strong></span>
                                <span class="block m-t-xs"><strong class="font-bold">${u_major}专业</strong></span>
                                <span class="text-muted text-xs block">修改<b class="caret"></b></span>
                                </span>
                        </a> -->
                        <!-- 修改部分至此结束 -->
                        
                        <ul class="dropdown-menu animated fadeInRight m-t-xs">
                            <li><a class="J_menuItem" href="form_avatar.html">修改头像</a>
                            </li>
                            <li class="divider"></li>
                            <li><a href="login.html">安全退出</a>
                            </li>
                        </ul>
                    </div>
                    <div class="logo-element">ES
                    </div>
                </li>
				<!-- 新增个人信息查看，任成琨修改于2018.12.9 -->
				<li>
                    <a class="J_menuItem" href="student_select_info.jsp?u_number=${u_number }"><i class="fa fa-files-o fa-fw"></i> <span class="nav-label">查看个人信息</span></a>
                </li>

                <li>
                    <a class="J_menuItem" href="updatepwd.jsp?u_number=${u_number }"><i class="fa fa-home"></i> <span class="nav-label">修改密码</span></a>
                </li>

                <li>
                    <a class="J_menuItem" href="student_select_course.jsp?u_number=${u_number }"><i class="fa fa-table fa-fw"></i> <span class="nav-label">选课</span></a>
                </li>

                <li>
                    <a class="J_menuItem" href="/EducationSystem/SelectedResult?u_number=${u_number }"><i class="fa fa fa-bar-chart-o"></i> <span class="nav-label">选课结果</span></a>
                </li>

                <li>
                    <a class="J_menuItem" href="student_select_grade.jsp?u_number=${u_number }"><i class="fa fa-edit"></i> <span class="nav-label">查询成绩</span></a>
                </li>

            </ul>
        </div>
    </nav>
    <!--左侧导航结束-->
    <!--右侧部分开始-->
    <div id="page-wrapper" class="gray-bg dashbard-1">
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
                    <form role="search" class="navbar-form-custom" method="post" action="http://www.zi-han.net/theme/hplus/search_results.html">
                        <div class="form-group">
                            <input type="text" placeholder="欢迎您登陆教务系统" class="form-control" name="top-search" id="top-search">
                        </div>
                    </form>
                </div>
            </nav>
        </div>
        <div class="row content-tabs">
            <button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i>
            </button>
            <nav class="page-tabs J_menuTabs">
                <div class="page-tabs-content">
                    <a href="javascript:;" class="active J_menuTab" data-id="index_v6.html">首页</a>
                </div>
            </nav>
            <button class="roll-nav roll-right J_tabRight"><i class="fa fa-forward"></i>
            </button>
            <div class="btn-group roll-nav roll-right">
                <button class="dropdown J_tabClose" data-toggle="dropdown">关闭操作<span class="caret"></span>

                </button>
                <ul role="menu" class="dropdown-menu dropdown-menu-right">
                    <li class="J_tabShowActive"><a>定位当前选项卡</a>
                    </li>
                    <li class="divider"></li>
                    <li class="J_tabCloseAll"><a>关闭全部选项卡</a>
                    </li>
                    <li class="J_tabCloseOther"><a>关闭其他选项卡</a>
                    </li>
                </ul>
            </div>
            <a href="login.html" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i> 退出</a>
        </div>
        <div class="row J_mainContent" id="content-main"><!-- 0%原为100%，2018.12.9，任成琨修改 -->
            <iframe class="J_iframe" name="iframe0" width="0%" height="0%" src="index.html" frameborder="0" data-id="index_v1.html" seamless></iframe>
        </div>
        <div class="footer">
            <div class="pull-right">&copy; 2018-2019 <a href="http://www.hnu.edu.cn" target="_blank">湖南大学</a>
            </div>
        </div>
    </div>
    <!--右侧部分结束-->
</div>
<script src="js/jquery.min.js?v=2.1.4"></script>
<script src="js/bootstrap.min.js?v=3.3.6"></script>
<script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="js/plugins/layer/layer.min.js"></script>
<script src="js/hplus.min.js?v=4.1.0"></script>
<script type="text/javascript" src="js/contabs.min.js"></script>
<script src="js/plugins/pace/pace.min.js"></script>

</body>


<!-- Mirrored from www.zi-han.net/theme/hplus/ by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:17:11 GMT -->
</html>
               