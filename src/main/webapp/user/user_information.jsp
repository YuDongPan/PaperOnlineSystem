<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Profile Cards</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/amazeui.min.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/admin.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/main_raw.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/settings.css" >
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/common.css">
    <script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" type ="text/css" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
</head>

<body id="main-body">
<div class="header">
    <h1 align="center" class="page-title"><strong class="am-text-primary am-text-lg">个人信息</strong></h1>
</div>
<section class="container-fluid">
    <div class="container">
        <div class="row">
            <!--PROFILE6-->
            <div class="bg6">
                <div class="main_style_6">
                    <div id="profile2" class="profile2">
                        <a href="javascript:void(0)" class="closebtn3" onclick="closeNav3()">&times;</a>
                        <div class="row mt-5">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12" align="center">
                                <h5>NEWS</h5>
                            </div>
                        </div>
                        <div class="row border_btm2" id="news">
                            <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 pl-0 pr-0">
                                <div class="round6"></div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6 pl-0 pr-0">
                                <h5>Carina</h5>
                                <p>Women smear each other's faces with 'gulal' during Holi celebrations atHoli, the festival of colour, </p>
                            </div>
                            <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 pl-0 pr-0">
                                <h6 class="time">1hr ago</h6>
                            </div>
                        </div>
                        <div class="row border_btm2" id="news">
                            <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 pl-0 pr-0">
                                <div class="round6"></div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6 pl-0 pr-0">
                                <h5>Carina</h5>
                                <p>Women smear each other's faces with 'gulal' during Holi celebrations atHoli, the festival of colour, </p>
                            </div>
                            <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 pl-0 pr-0">
                                <h6 class="time">1hr ago</h6>
                            </div>
                        </div>
                        <div class="row border_btm2" id="news">
                            <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 pl-0 pr-0">
                                <div class="round6"></div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6 pl-0 pr-0">
                                <h5>Carina</h5>
                                <p>Women smear each other's faces with 'gulal' during Holi celebrations atHoli, the festival of colour, </p>
                            </div>
                            <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 pl-0 pr-0">
                                <h6 class="time">1hr ago</h6>
                            </div>
                        </div>
                        <div class="row border_btm2" id="news">
                            <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 pl-0 pr-0">
                                <div class="round6"></div>
                            </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6 pl-0 pr-0">
                                <h5>Carina</h5>
                                <p>Women smear each other's faces with 'gulal' during Holi celebrations atHoli, the festival of colour, </p>
                            </div>
                            <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-3 pl-0 pr-0">
                                <h6 class="time">1hr ago</h6>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                            <div class="img7">
                                <img src="<%=basePath%>/images/slide1.jpg" class="img-fluid">
                                <h4 class="name">Nathan Lesina<span class="title">Sound Advice</span></h4>
                            </div>
                        </div>
                    </div>
                    <div style="margin-top:20px"></div>
                    <!-- 姓名 -->
                    <div class="rowInfo">
                        <div class="textInfo">
                            姓名
                        </div>
                        <div class="iconInfo">
                            <i class="fa fa-user" aria-hidden="true"></i>
                        </div>
                        <div class="entityInfo">
                            ${loginUser.username}
                        </div>
                    </div>
                    <!-- 手机号-->
                    <div class="rowInfo">
                        <div class="textInfo">
                            移动电话
                        </div>
                        <div class="iconInfo">
                            <i class="fa fa-mobile" aria-hidden="true"></i>
                        </div>
                        <div class="entityInfo">
                            ${loginUser.phonenumber}
                        </div>
                    </div>
                    <!-- 邮箱 -->
                    <div class="rowInfo">
                        <div class="textInfo">
                            电子邮箱
                        </div>
                        <div class="iconInfo">
                            <i class="fa fa-envelope" aria-hidden="true"></i>
                        </div>
                        <div class="entityInfo">
                            ${loginUser.email}
                        </div>
                    </div>
                    <!-- 返回首页 -->
                    <div align="center">
                        <button type="button" class="snd" onclick="window.location.href='<%=basePath%>/indexCarousel.jsp'">
                            <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                            返回首页
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--/PROFILE6/-->
</section>
</body>
</html>