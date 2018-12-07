<%--
  Created by IntelliJ IDEA.
  User: Power
  Date: 2018/11/30
  Time: 15:19
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
  <title>Title</title>
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
<div class="button-bg">
  <div class="div-button first-row first-col">
    <div class="content" data-href="jsp/qingshanhu/qingshanhuyinxiang.jsp"></div>
  </div>
  <div class="div-button first-row second-col">
    <div class="content" data-href="jsp/court_situation/court_introduction.jsp"></div>
  </div>
  <div class="div-button first-row third-col">
    <div class="content" data-href="jsp/executive_affairs/dishonesty_people.jsp"></div>
  </div>
  <div class="div-button second-row first-col">
    <div class="content" data-href="jsp/duiwujianshe/dangjiangongzuo.jsp"></div>
  </div>
  <div class="div-button second-row second-col">
    <div class="content" data-href="jsp/litigation_service_centre/centre_introdution.jsp"></div>
  </div>
  <div class="div-button second-row third-col">
    <div class="content" data-href="jsp/jurisdiction/territorial_jurisdiction.jsp"></div>
  </div>
  <div class="div-button third-row first-col">
    <div class="content" data-href="jsp/zhengxianchuangxiu/liangxingguifanhuagaige.jsp"></div>
  </div>
  <div class="div-button third-row second-col">
    <div class="content" data-href="jsp/sifagongkai/kaitinggonggao.jsp"></div>
  </div>
  <div class="div-button third-row third-col">
    <div class="content" data-href="jsp/shehuijiandu/jijianjiandu.jsp"></div>
  </div>
</div>
<div id="in"></div>
<div class="bottom-banner">
  <marquee  scrollamount="20">
    <p>
      坚持弘扬井冈山精神，争创一流工作业绩<span style="margin-left: 200px;">争全省首位，创南昌经验</span></p>
  </marquee>

</div>
<script src="js/index.js"></script>
<script src="js/jquery-3.3.1.min.js"></script>
<script>
    /*alert(sessionStorage.getItem("username"));*/
    if(sessionStorage.getItem("username") != "admin"){
        document.getElementById("in").innerHTML = '<div class="login"><a class="a_login" href="login.jsp">登录后台</a></div>';
    }else{
        document.getElementById("in").innerHTML = '<div class="login" onclick="loginout()">退出后台</div>';
    }
    function loginout(){
        sessionStorage.setItem("username", "s");
        window.location.href = "<%=basePath%>/index.jsp";
    }
</script>
</body>
</html>
