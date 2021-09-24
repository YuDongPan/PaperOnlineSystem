<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <meta charset="utf-8" />
    <title>在线文献系统</title>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/login.css" />
    <script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css"/>
    <script type="text/javascript" src="<%=basePath%>/js/jquery.js"></script>
</head>
<body class="bg_img">
<c:if test="${msg_login.equals('error')}">
   <script>swal("用户名或密码错误", "", "error");</script>
</c:if>
<div class="page-login2">
    <div class="contant">
        <div class="bg">
        </div>
        <div class="box">
            <div class="title">
            </div>
            <form id="myForm" action="<%=basePath%>/user/login.do" method="post" class="tel-login">
                <div class="inputs">
                    <div class="user">
                        <input type="text" id="uName" name="username" placeholder="用户名" />
                        <!-- 如果验证正确就是加ture,否则就是加false -->
                        <p class="Error">
                        </p>
                    </div>
                    <div class="pass">
                        <input type="password" id="pwd" name="password" placeholder="密码"/>
                        <p class="Error">
                        </p>
                    </div>
                    <div class="verification">
                        <input type="text" id="vdCode" name="code" placeholder="请输入验证码"/>
                        <span class="img">
                            <img src="<%=basePath%>/kaptcha/render" alt="图片看不清？点击重新得到验证码" name="verifypic" align="middle"
                                 id="verifypic" onclick="this.src='<%=basePath%>/kaptcha/render'" /></span>
                        <p class="Error js_vdCode">
                        </p>
                    </div>
                    <div class="chexbox">
                        <div class="switch_register"> <a href="<%=basePath%>/user/register.jsp">立即注册</a></div>
                        <div class="autologin_forget">
                            <label>
                                <div class="checkboxFour">
                                    <input value="1" id="jizhumima" name="" type="checkbox">
                                    <label for="jizhumima">
                                    </label>
                                </div>
                                <span>7天免登录</span>
                            </label>
                            <a href="<%=basePath%>/user/rectifypsw_first.jsp" target="_blank">忘记密码？</a>
                        </div>
                    </div>
                    <input type="button" value="登录" class="btn" onclick="Checklogin()" />
                </div>
            </form>
        </div>
    </div>
</div>
<div class="page-footer">

</div>
<script type="text/javascript" src="<%=basePath%>/js/canvas-particle.js"></script>
<script type="text/javascript">
    window.onload = function () {
        var config = {
            vx: 4,
            vy: 4,
            height: 2,
            width: 2,
            count: 90,
            color: "255,255,255",
            stroke: "145, 168, 198",
            dist: 0,
            e_dist: 6000,
            max_conn: 5
        }
        CanvasParticle(config);
    }

    function Checklogin(){
        //用户名
        let username = $('#uName');

        //密码
        let password = $('#pwd');

        //验证码
        let inputCode = $('#vdCode');

        console.log(inputCode);
        //验证码
        $.ajax({
            type: "POST",
            url: "<%=basePath%>/kaptcha/validTime",
            data: {
                username:username.val(),
                password:password.val(),
                code:inputCode.val(),
            },
            dataType: "json",
            success: function(data) {
                console.log('1111111111111111111');
                console.log(data);
                if (data.msg_code == "ok") {
                    console.log('222222222222222');
                    $('#myForm').submit();
                   // swal("验证码正确", "", "success");
                } else{
                    console.log('3333333333333333');
                    inputCode.val("");
                    swal(data.msg_code, "", "error");
                }
            }
        });
    }

</script>
</body>
</html>
