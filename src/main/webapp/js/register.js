var validateUser = false;
var validatePassword = false;
var validateEmail = false;
var validatePhonenumber = false;
function checkUsername(){
    var regUsername = /[\u4E00-\u9FA5\uF900-\uFA2D_a-zA-Z0-9_]{2,15}/;
    if(!regUsername.test($('#username').val())){
        $("#Utext").text("用户名仅支持2-15位由中英文字符、数字、下划线组成的字符串");
    }
    else{
        $("#Utext").text("");
        $.ajax({
            type: "POST",
            url:"../user/checkUsername.do",
            data:{
                username:$("#username").val(),
            },
            dataType:"json",
            success: function(data) {
                if(data.msg_username == "ok"){
                    $("#Utext").text("");
                    validateUser = true;
                }
                else if(data.msg_username == "error"){
                    $("#Utext").text("该用户名已存在");
                    validateUser = false;
                }
            }
        });
    }
}

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

function checkEmail(){
    var regEmail = new RegExp("^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$");
    if(!regEmail.test($('#email').val())){
        $("#Etext").text("邮箱格式错误");
    }
    else{
        $("#Etext").text("");
        $.ajax({
            type: "POST",
            url:"../user/checkEmail.do",
            data:{
                email:$("#email").val(),
            },
            dataType:"json",
            success: function(data) {
                if(data.msg_email == "ok"){
                    validateEmail = true;
                    $("#Etext").text("");
                }
                else if(data.msg_email == "error"){
                    validateEmail = false;
                    $("#Etext").text("该电子邮箱已被其他使用");
                }
            }
        });
    }
}

function checkPhoneNumber(){
    var regPhoneNumber = new RegExp("^[0-9]{11}$");
    if(!regPhoneNumber.test($('#phonenumber').val())){
        $("#Ttext").text("请输入11位数字字符");
    }
    else{
        $("#Ttext").text("");
        $.ajax({
            type: "POST",
            url:"../user/checkTel.do",
            data:{
                phonenumber:$("#phonenumber").val(),
            },
            dataType:"json",
            success: function(data) {
                if(data.msg_phonenumber == "error"){
                    $("#Ttext").text("");
                    validatePhonenumber = true;
                }
                else if(data.msg_phonenumber == "ok"){
                    $("#Ttext").text("该手机号已被其他用户使用");
                    validatePhonenumber = false;
                }
            }
        });
    }
}


function checkAll(){
    var form = document.getElementById("myForm");
    if(validateUser && validatePassword && validatePhonenumber && validateEmail){
        //form.submit();
        return true;
    }
    else{
        swal("请输入正确的注册信息","","error");
        return false;
    }
}