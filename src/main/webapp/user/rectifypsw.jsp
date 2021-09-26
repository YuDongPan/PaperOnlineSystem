<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>修改密码</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="<%=basePath%>/layui/css/layui.css" type="text/css" >
    <link rel="stylesheet" href="<%=basePath%>/css/main_raw.css" type="text/css">
    <link rel="stylesheet" href="<%=basePath%>/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="<%=basePath%>/css/bootstrap-responsive.min.css" type="text/css">
    <link rel="stylesheet" href="<%=basePath%>/css/register.css" type="text/css">
    <link rel="stylesheet" href="<%=basePath%>/font-awesome-4.7.0/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="<%=basePath%>/css/rectifypsw.css" type="text/css">
    <script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" type ="text/css" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
</head>
<body>
<c:if test="${msg.equals('no')}">
    <script>
        swal("用户不存在,修改失败", "", "error");
    </script>
</c:if>
<c:if test="${msg.equals('yes')}">
    <script>
        setTimeout(function(){swal({
            title: "修改成功，正在加载",
            text: "正在努力跳转中,2秒后自动关闭。",
            timer: 2000,
            showConfirmButton: false
        });},0);
        setTimeout(function(){window.location.href="<%=basePath%>/login.jsp";},2000);
    </script>
</c:if>
<div class="container" id="in">
    <form name="myForm" class="layui-form form-signin " style="max-width:400px" action="<%=basePath%>/user/updatepsw.do" method="post">
        <h1 align="center">密码修改</h1>
        <!-- 手机号 -->
        <div class="layui-form-item pdAdd">
            <div class="icon-style">
                <i class="fa fa-phone" aria-hidden="true"></i>
            </div>
            <div class="input-style">
                <input id="phonenumber" type="text" class="input-block-level inputArea" placeholder="手机号" id="phonenumber"  name="phonenumber" value="${phonenumber}" readonly="readonly" >
            </div>
        </div>
        <div class="regFeedback"  id="Ttext"></div>
        <!-- 密码 -->
        <div class="layui-form-item pdAdd">
            <div class="icon-style">
                <i class="fa fa-lock" aria-hidden="true"></i>
            </div>
            <div class="input-style">
                <input id="password" type="password" class="input-block-level inputArea" placeholder="密码"  required name="password" onblur="checkPassword()">
            </div>
        </div>
        <div class="pswFeedback"  id="Ptext"></div>
        <!-- 重复密码 -->
        <div class="layui-form-item pdAdd">
            <div class="icon-style">
                <i class="fa fa-lock" aria-hidden="true"></i>
            </div>
            <div class="input-style">
                <input id="repassword" type="password" class="input-block-level inputArea" placeholder="重复密码"  required name="repassWord"  onblur="checkRePassword()">
            </div>
        </div>
        <div class="pswFeedback"  id="rPtext"></div>
        <div class="layui-form-item">
            <button class="layui-btn layui-btn-normal" style="width:100%" type="submit" onclick="rectify()">修改</button>
        </div>
    </form>
</div>
</body>
<script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
<script src="<%=basePath%>/js/bootstrap.min.js"></script>
<script>
    var validatePassword = false;
    var validateRePassword = false;
    function checkPassword(){
        var regCheckPassword = new RegExp("^[a-zA-z_0-9]{6,20}$");
        if(!regCheckPassword.test($('#password').val())){
            $("#Ptext").text("请输入6-20位英文字母、数字或符号");
            validatePassword = false;
        }
        else{
            $("#Ptext").text("");
            validatePassword = true;
        }
    }
    function checkRePassword(){
        var password = $("#password").val();
        var repassword = $("#repassword").val();
        if(password != repassword){
            $("#rPtext").text("两次密码输入的不一致");
            validateRePassword = false;
        }
        else{
            $("#rPtext").text("");
            validateRePassword = true;
        }
    }
    function rectify(){
        if(validatePassword && validateRePassword){
            var form = document.getElementById("myform");
            form.submit();
        }
        else swal("请输入正确的密码信息","","error");
    }
</script>
</html>
