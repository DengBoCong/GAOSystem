<%--
  Created by IntelliJ IDEA.
  User: Power
  Date: 2018/12/3
  Time: 22:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" +
            request.getServerPort() + path;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登录</title>
    <link rel="stylesheet" href="css/index.css">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <style>
        .bottom-banner{
            position: fixed;
            bottom: 0;
            padding-bottom: 20px;
            width: 100%;
        }
        .bottom-banner p {
            font-weight: bolder;
            font-size: 30px;
            color: white;
        }
        .loginBg{
            background-color: #DCDCDC;
            width: 800px;
            height: 500px;
            margin-left: 700px;
            top: 50%;
            margin-top: 250px;
        }
        .login_right_div{
            float: left;
            width: 100%;
            height: 70px;
            text-align: center;
            line-height: 75px;
        }
        .loginF{
            margin-top: 130px;
        }
        .login_input_text{
            width: 340px;
            height: 40px;
            font-size: 15px;
            border: 1px solid gray;
        }

        .login_input_text:hover{
            border: 1px solid #1FC8E2;
        }
        .login_input_submit{
            width: 340px;
            height: 40px;
            border: none;
            color: white;
            font-size: 16px;
            font-family: "黑体";
            cursor: pointer;
            background-color: #1FC8E2;
            transition: background-color 0.3s ease-in;
        }

        .login_input_submit:hover{
            background-color: #14B9D3;
        }
        .login{
            float: right;
            color: white;
            font-size: 20px;
            margin-top: 190px;
            margin-right: 50px;
        }
        .login:hover{
            text-decoration: underline;
        }
        .a_login{
            color: white;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="loginBg">
    <div class="login_right_div loginF">
        <input id="account" type="text" class="login_input_text" placeholder="请输入你的账号" value="" />
    </div>
    <div class="login_right_div">
        <input id="password" type="password" class="login_input_text" placeholder="请输入你的登录密码" value="" /><div id="passwordI">sdf</div>
    </div>
    <div class="login_right_div">
        <button onclick="login()" class="login_input_submit">登录</button>
    </div>
</div>
<div class="login" onclick="backIndex()"><a class="a_login">返回主界面</a></div>
<div class="bottom-banner">
    <marquee  scrollamount="20">
        <p>
            坚持弘扬井冈山精神，争创一流工作业绩<span style="margin-left: 200px;">争全省首位，创南昌经验</span></p>
    </marquee>

</div>
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/main.js"></script>
<script>
    /*alert(sessionStorage.getItem("username"));*/
    function beforeSend(){
        $("#login").value = "正在登录...";
    }

    function successCallBack(responseData){
        if(responseData.result == "0") {
            sessionStorage.setItem("username", "admin");
            window.location.href = "<%=basePath%>/index.jsp";
        }
        if(responseData.result == "1") alert("账号输入错误");
        if(responseData.result == "2") alert("密码输入错误");

    }

    function login(){
        var accountInput = $("#account").val();
        var passwordInput = $("#password").val();
        var sendData = {"account": accountInput, "password": passwordInput};

        if(accountInput == ""){
            alert("账号不能为空");
            return;
        }else if(passwordInput == ""){
            alert("密码不能为空");
            return;
        }else{
            request("POST", "<%=basePath%>/login",sendData, successCallBack, serverError, true, beforeSend);
        }
    }

    function backIndex() {
        window.location.href = "<%=basePath%>/index.jsp";
    }


</script>
</body>
</html>
