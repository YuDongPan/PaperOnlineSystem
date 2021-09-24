<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>注册界面</title>

    <link rel="stylesheet" href="<%=basePath%>/css/register.css">
    <script type="text/javascript" src="<%=basePath%>/js/jquery.js"></script>
    <script src="<%=basePath%>/js/register.js"></script>
    <script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" type ="text/css" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
</head>
<body>

<c:if test="${msg_reg.equals('ok')}">
    <script>
    setTimeout(function(){swal({
    title: "注册成功，正在加载",
    text: "正在努力跳转中,2秒后自动关闭。",
    timer: 2000,
    showConfirmButton: false
    });},0);
    setTimeout(function(){window.location.href="<%=basePath%>/login.jsp";},2000);
    </script>
</c:if>
<c:if test="${msg_reg.equals('error')}">
    <script>
        swal("注册失败,请输入正确的信息!", "", "error");
    </script>
</c:if>

<div class="form" style="position:relative">

    <!--注册表单-->
    <div class="form_register" style="position:absolute">
        <form action="<%=basePath%>/user/insertUser.do" method="post" onsubmit="checkAll()">
            <h1>注册页面</h1>
            <div class="form_item">
                <label for="username">用户名：</label>
                <input type="text" name="username" id="username" onblur="checkUsername()" placeholder="请输入用户名" required>
            </div>
            <div class="regFeedback" id="Utext"></div>
            <div class="form_item">
                <label for="password">密码：</label>
                <input type="password" name="password" id="password" placeholder="请输入密码名" required>
            </div>
            <div class="form_item">
                <label for="email">邮箱：</label>
                <input type="email" name="email" id="email" onblur="checkEmail()" placeholder="请输入电子邮件" required>
            </div>
            <div class="regFeedback" id="Etext"></div>
            <div class="form_item">
                <label for="phonenumber">电话：</label>
                <input type="tel" name="phonenumber" id="phonenumber" onblur="checkPhoneNumber()" placeholder="请输入手机号码" required>
            </div>
            <div class="regFeedback" id="Ttext"></div>
            <div class="form_item">
                <input type="submit" onclick="checkAll()" value="注册">
            </div>
        </form>
        <div class="info">已有账号？点击<span><a class="switch_a" href="<%=basePath%>/login.jsp">登录</a></span></div>
    </div>
</div>
</body>
</html>
