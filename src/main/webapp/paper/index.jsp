<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>BAI文献系统</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/main.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/bootstrap-responsive.min.css">
    <link rel="stylesheet" href="<%=basePath%>/layui/css/layui.css">
    <script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
    <script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" type ="text/css" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
    <script src="<%=basePath%>/js/showtime.js"></script>
    <style type="text/css">
        a:link,a:hover,a:visited,a:active{
            text-decoration:none;
        }
    </style>
</head>
<body class="layui-layout-body" onload="ShowTime();">
<!-- 上 -->
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">BAI文献系统</div>
        <div class="TheTime" id="stime"></div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-right">

            <li class="layui-nav-item">
                <c:if test="${loginUsername.equals('admin')}">
                    <a href="javascript:;">
                        <img src="<%=basePath%>/images/1.gif" class="layui-nav-img"> 管理员
                    </a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="<%=basePath%>/paper/paperDataSearch.jsp" target="_blank">系统可视化数据</a>
                        </dd>
                        <dd>
                            <a href="<%=basePath%>/user/rectifypsw.jsp" target="_blank">密码修改</a>
                        </dd>
                        <dd>
                            <a href="<%=basePath%>/postgraduate/postgraduate.html" target="_blank">合作伙伴</a>
                        </dd>
                    </dl>
                </c:if>

                <c:if test="${loginUsername != 'admin'}">
                    <a href="javascript:;">
                        <img src="<%=basePath%>/images/1.gif" class="layui-nav-img">${loginUsername}
                    </a>
                    <dl class="layui-nav-child">
                        <dd>
                            <a href="<%=basePath%>/user/user_information.jsp" target="right">个人信息</a>
                        </dd>
                        <dd>
                            <a href="<%=basePath%>/user/rectifypsw_first.jsp" target="_blank">密码修改</a>
                        </dd>
                        <dd>
                            <a href="<%=basePath%>/paper/index.jsp">返回首页</a>
                        </dd>
                    </dl>
                </c:if>
            </li>
            <li class="layui-nav-item">
                <a href="<%=basePath%>/user/exit.do">安全退出</a>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <c:if test="${loginUsername.equals('admin')}">
                <ul class="layui-nav layui-nav-tree" lay-filter="test">
                    <li class="layui-nav-item layui-nav-itemed">
                        <a class="" href="javascript:;">文献管理</a>
                        <dl class="layui-nav-child">
                            <dd>
                                <a href="<%=basePath%>/paper/paper_upload_admin.jsp" target="right">文献上传</a>
                            </dd>
                            <dd>
                                <a href="<%=basePath%>/paper/paper_download_admin.jsp" target="right">文献下载</a>
                            </dd>
                            <dd>
                                <a href="<%=basePath%>/paper/paper_search_admin.jsp" target="right">文献查询</a>
                            </dd>
                        </dl>
                    </li>
                    <li class="layui-nav-item">
                        <a href="javascript:;">账户管理</a>
                        <dl class="layui-nav-child">
                            <dd>
                                <a href="<%=basePath%>/paper/user_list.jsp" target="right">账户列表</a>
                            </dd>
                            <dd>
                                <a href="<%=basePath%>/paper/log_list.jsp" target="right">流水日志</a>
                            </dd>
                        </dl>
                    </li>
                    <li class="layui-nav-item">
                        <a href="javascript:;">系统页面</a>
                        <dl class="layui-nav-child">
                            <dd>
                                <a href="<%=basePath%>/login.jsp" target="_blank">登录页面</a>
                            </dd>
                            <dd>
                                <a href="<%=basePath%>/user/register.jsp" target="_blank">注册页面</a>
                            </dd>
                            <dd>
                                <a href="<%=basePath%>/paper/paperDataSearch.jsp" target="_blank">数据可视化</a>
                            </dd>
                            <dd>
                                <a href="<%=basePath%>/user/rectifypsw_first.jsp" target="_blank">密码修改</a>
                            </dd>
                        </dl>
                    </li>

                    <li class="layui-nav-item">
                        <a href="https://me.csdn.net/weixin_43715601" target="_blank" class="nav-header">关于作者</a>
                    </li>
                </ul>
            </c:if>

            <c:if test="${loginUsername != 'admin'}">
                <ul class="layui-nav layui-nav-tree" lay-filter="test">
                    <li class="layui-nav-item layui-nav-itemed">
                        <a class="" href="javascript:;">文献管理</a>
                        <dl class="layui-nav-child">
                            <dd>
                                <a href="<%=basePath%>/paper/paper_upload_user.jsp" target="right">文献上传</a>
                            </dd>
                            <dd>
                                <a href="<%=basePath%>/paper/paper_download_user.jsp" target="right">文献下载</a>
                            </dd>
                            <dd>
                                <a href="<%=basePath%>/paper/paper_search_user.jsp" target="right">文献查询</a>
                            </dd>
                        </dl>
                    </li>
                    <li class="layui-nav-item">
                        <a href="javascript:;">系统页面</a>
                        <dl class="layui-nav-child">
                            <dd>
                                <a href="<%=basePath%>/login.jsp" target="_blank">登录页面</a>
                            </dd>
                            <dd>
                                <a href="<%=basePath%>/user/register.jsp" target="_blank">注册页面</a>
                            </dd>
                            <dd>
                                <a href="<%=basePath%>/paper/paperDataSearch.jsp" target="_blank">数据可视化</a>
                            </dd>
                            <dd>
                                <a href="<%=basePath%>/user/rectifypsw_first.jsp" target="_blank">密码修改</a>
                            </dd>
                        </dl>
                    </li>

                    <li class="layui-nav-item">
                        <a href="https://me.csdn.net/weixin_43715601" target="_blank" class="nav-header">关于作者</a>
                    </li>
                </ul>

            </c:if>

        </div>
    </div>


    <div class="layui-body" style="z-index: 0;">
        <!-- 内容主体区域 -->
        <div style="padding: 5px;">
            <iframe src="<%=basePath%>/indexCarousel.jsp" name="right" frameborder="0" width="100%" height="700px">
            </iframe>
        </div>
    </div>


</div>

<script type="text/javascript" src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/myplugs/js/plugs.js">
</script>
<script type="text/javascript">
    //添加编辑弹出层
    function updatePwd(title, id) {
        $.jq_Panel({
            title: title,
            iframeWidth: 500,
            iframeHeight: 300,
            url: "updatePwd.html"
        });
    }
</script>
<script src="<%=basePath%>/layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function() {
        var element = layui.element;

    });
</script>
</body>
</html>