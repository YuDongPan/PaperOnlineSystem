<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
          + path + "/";
%>
<!DOCTYPE>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/psw1.css">
  <script src="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.min.js"></script>
  <link rel="stylesheet" type ="text/CSS" href="<%=basePath%>/sweetalert-1.1.3/dist/sweetalert.css">
  <title>手机号验证</title>
  <style type="text/css">
  </style>
</head>
<body class="body-item1">
<div class="layout" id="noOp">
  <form id="myForm" class="valform" method="post">
    <h1 align="center" class="form-signin-heading">手机号验证</h1>
    <div class="phone" align="center">
      <label for="phoneNumber">手机号:</label>
      <input class="phone_input" type="text" id="phonenumber" name="phonenumber" placeholder="请输入11位手机号" onblur="checkInTel()">
    </div>
    <div class="feedback" id="Ptext">
    </div>
    <div class="code">
      <label for="valCode">验证码:</label>
      <input class="code_input" type="text" id="valCode" name="valCode" placeHolder="请输入6位验证码">
      <button id="send" class="btn_code">发送验证码</button>
    </div>
    <div class="ok">
      <button class="btn_ok" onclick="return CodeSubmit()">确定</button>
    </div>
  </form>
</div>

<!-- 发送验证码 -->
<script src="<%=basePath%>/js/jquery-1.8.1.min.js"></script>
<script>
  var checkInPhone = false;
  $("#send").click(function(){
    var tel = $("#phonenumber").val();
    if(checkInPhone){
      $.ajax({
        type:"POST",
        data:{tel:$("#phonenumber").val()},
        dataType:"json",
        url:"<%=basePath%>/user/send.do",
        success: function(res){
          console.log(res);
          console.log(typeof(res));
          if(res.code == 0){
            swal("发送成功,注意查收","","success");
            checkCode(60);
          }
          else{
            console.log(res.data);
            swal("发送失败,注意错误码","","error");
          }
        }
      });
    }
    else{
      swal("请填写正确的手机号码！","","error");
    }
    return false;
  });

  function checkTel(tel){
    var regPhoneNumber = new RegExp('^[0-9]{11}$');
    return regPhoneNumber.test(tel);
  }

  function checkInTel(){
    var tel = $("#phonenumber").val();
    if(checkTel(tel)){
      $.ajax({
        type:"POST",
        data:{
          phonenumber:$("#phonenumber").val()
        },
        url:"<%=basePath%>/user/checkTel.do",
        dataType:"json",
        success:function(data){
          if(data.msg_phonenumber == "ok"){
            $("#Ptext").text("");
            checkInPhone = true;
          }
          else if(data.msg_phonenumber == "error"){
            $("#Ptext").text("该手机号不存在");
            checkInPhone = false;
          }
        }
      });
    }
    else{
      $("#Ptext").text("手机号必须由11位数字组成");
    }

  }
  function checkCode(time){
    if(time == 0){
      $('#send').removeAttr("disabled");
      $('#send').html("重新发送");
      $('#send').css("background-color","#FFD700");
    }
    else{
      time--;
      $('#send').attr('disabled',true);
      $('#send').css('color','#FF8000');
      $('#send').html(time + "s");
      setTimeout(function(){
        checkCode(time);
      },1000)
    }
  }


  function CodeSubmit(){
    $.ajax({
      type:"POST",
      data:{
        phonenumber:$("#phonenumber").val(),
        inputCode:$("#valCode").val()},
      dataType:"json",
      url:"<%=basePath%>/user/validate.do",
      success:function(res){
        if(res){
          setTimeout(function(){swal({
            title: "验证成功，正在加载",
            text: "正在努力跳转中,2秒后自动关闭。",
            timer: 2000,
            showConfirmButton: false
          });},0);
          setTimeout(function(){
            window.location.href="<%=basePath%>/user/rectifypsw.jsp";
          },2000);
        }
        else{
          swal("验证码错误！","","error");
          $("#valCode").val("");
        }
      }
    });
    return false;
  }
</script>
</body>
</html>