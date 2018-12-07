<%--
  Created by IntelliJ IDEA.
  User: Power
  Date: 2018/12/4
  Time: 14:55
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
    <title>page1</title>
    <link href="<%=basePath%>/css/page1.css" rel="stylesheet">
    <link href="<%=basePath%>/css/main.css" rel="stylesheet">
    <link href="<%=basePath%>/layui/css/layui.css" rel="stylesheet">
    <style>
        .delete{
            cursor: pointer;
            float: right;
            display: block;
            width: 60px;
            height: 20px;
            line-height: 20px;
            text-align: center;
            background-color: red;
            color: white;
            margin-top: 5px;
            margin-right: 20px;
        }

        .modDiv{
            width: 100%;
            height: 30px;
            margin-top:5px;
            border:1px solid gray;
        }

        .modify{
            cursor: pointer;
            float: right;
            display: block;
            width: 60px;
            height: 20px;
            line-height: 20px;
            text-align: center;
            background-color: cornflowerblue;
            color: white;
            margin-top: 5px;
            margin-right: 10px;
        }

        .modTitle{
            float: left;
            height: 30px;
            display: block;
            line-height: 30px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="menu" id="menuL"></div>
<div class="back" onclick="turnBack()"><a><img class="back_btn" src="../../img/back.png" alt=""></a></div>
<div class="content" id="contentM"></div>
<div style="visibility: hidden;" onclick="MoD()" id="modid">修改/删除</div>

<script src="<%=basePath%>/layui/layui.all.js"></script>
<script src="<%=basePath%>/js/jquery-3.3.1.min.js"></script>
<script src="<%=basePath%>/js/wangEditor.min.js"/>
<script src="<%=basePath%>/js/editor.js"></script>
<script src="<%=basePath%>/js/main.js"></script>


<script>
    /*alert(sessionStorage.getItem("username"));*/

    if(sessionStorage.getItem("username") == "admin"){
        document.getElementById("modid").style.cssText = "color: white;font-size: 30px;float: right;margin-right: 100px;cursor: pointer;visibility: visible;";
    }

    var FIRSTCOUNT = 0;//用于标记一级分支共有几个
    var SECONDCOUNT = 0;//用于标记二级分支共有几个
    var SFLAG = ""//二级分支的标志位
    var EDITORF;//定义一个全局的editor
    var OLDTITLE = "";//用于标志修改删除中旧标题
    var BACKFLAG = "0";//用于标记是否进入第二级分支
    var BACKMENUFLAG = ""//用于标记进入第二级分支所属第一级分支的flag
    var loadFirstData = {"owner": "9"};
    request("POST", "<%=basePath%>/listContentByOwner", loadFirstData, loadSuccessCallBack, serverError, true, beforeSend)

    function loadSuccessCallBack(responseData) {
        var Ftitle = "";
        var FFlag = "";
        var ad = '<a onclick="addMore()"><div class="menu-button"><span class="title1">+</span></div></a>';
        var ads = '<a><div><span>.</span></div></a>';
        if(responseData.result == "1" && sessionStorage.getItem("username") == "admin"){
            document.getElementById("menuL").innerHTML = ad;
        }else{
            var html = '';
            var count = 0;
            for(var i in responseData){
                if(count == 0) {
                    BACKMENUFLAG = responseData[i].flag;
                    html = html + '<a id="'+responseData[i].flag+'"><p style="color:transparent;" class="flag">' + responseData[i].flag
                        + '</p><p style="color:transparent;" class="sub1">' + responseData[i].sub + '</p>'
                        + '<div class="menu-button active"><span class="title1">' + responseData[i].title + '</span></div></a>';
                    if(responseData[i].sub == "1"){
                        document.getElementById("contentM").innerHTML = responseData[i].content.replace(/\*/g, "\"");
                    }else{
                        Ftitle = responseData[i].title;
                        FFlag = responseData[i].flag;
                    }
                    count++;
                }else {
                    html = html + '<a id="'+responseData[i].flag+'"><p style="color:transparent;" class="flag">' + responseData[i].flag
                        + '</p><p style="color:transparent;" class="sub1">' + responseData[i].sub
                        +'</p><div class="menu-button"><span class="title1">' + responseData[i].title + '</span></div></a>';
                }
                FIRSTCOUNT++;
            }
            if(sessionStorage.getItem("username") == "admin"){
                html = html + ad;
            }
            html = html + ads;//设置点击颜色更改的标志位
            document.getElementById("menuL").innerHTML = html;

            if(Ftitle != ""){
                var SecondData = {"owner": FFlag};
                SFLAG = FFlag;
                request("POST", "<%=basePath%>/listContentByOwner", SecondData, function (responseDataS) {
                    var Shtml = '<h2 style="text-align: center;">'+ Ftitle + '</h2>';
                    if (responseDataS.result == "1") {
                    }else{
                        for(var k in responseDataS){
                            Shtml = Shtml + '<a><div class="cbtn_dan">'+ responseDataS[k].title +'</div></a>';
                            SECONDCOUNT++;
                        }
                    }
                    if(sessionStorage.getItem("username") == "admin")
                        Shtml = Shtml + '<a><div class="cbtn_dan" onclick="addSecondMore()">+</div></a>';
                    document.getElementById("contentM").innerHTML = Shtml;
                }, serverError, true, beforeSend);
            }
        }
    }

    function successCallBack(responseData){
        if(responseData.result == "0") {
            window.location.href = "<%=basePath%>/jsp/shehuijiandu/jijianjiandu.jsp";
        }else{
            alert("添加失败，请检查是否标题重复！")
        }
    }

    function addMore() {
        layer.open({
            type: 1 //Page层类型
            ,area: ['1200px', '600px']
            ,title: '请填写新增分支的信息'
            ,shade: 0.6 //遮罩透明度
            ,maxmin: true //允许全屏最小化
            ,anim: 1 //0-6的动画形式，-1不开启
            ,content: '<div class="login_right_div"><input id="account" type="text" class="login_input_text" placeholder="请输入新增分支的名称" value="" /></br>'
            + '<label>请选择分支是否有子分支</label><select id="sub"><option value="1" selected="selected">否</option><option value="2">是</option>'
            + '</select><p>如果有子分支，此项可不填，可留空...</p><div style="text-align:left;"><div id="divFirstDemo"></div></div><button onclick="btnFirst2()" id="Button2">显示编辑器</button>'
            + '</br><button onclick="btnFirst1()">预览</button><div id="htmlFirst"></div><div class="login_right_div">'
            + '<button id="login" class="login_input_submit" onclick="addNew()">提交新增</button></div></div>'
        });
        document.getElementById("Button2").click();
    }

    function addNew(){
        var accountInput = $("#account").val();
        var Flag = "9_" + (FIRSTCOUNT+1);
        if(accountInput == ""){
            alert("标题不能为空");
            return;
        }
        var fContentData = "";
        var subSelect = $("#sub option:selected").val();
        if(subSelect == "1"){
            fContentData = EDITORF.txt.html().replace(/\"/g, "*");
        }
        var sendData = {"title": accountInput, "sub": subSelect, "content": fContentData, "flag": Flag, "owner": "9"};
        request("POST", "<%=basePath%>/add", sendData, successCallBack, serverError, true, beforeSend);
    }

    function addSecondMore() {
        layer.open({
            type: 1 //Page层类型
            ,area: ['1200px', '600px']
            ,title: '请填写新增分支的信息'
            ,shade: 0.6 //遮罩透明度
            ,maxmin: true //允许全屏最小化
            ,anim: 1 //0-6的动画形式，-1不开启
            ,content: '<div class="login_right_div"><input id="account1" type="text" class="login_input_text" placeholder="请输入新增分支的名称" value="" /></br>'
            + '<div style="text-align:left;"><div id="divDemo"></div></div><button onclick="btn2()" id="Button1">显示编辑器</button></br><button onclick="btn1()">预览</button>'
            + '<div id="html"></div><div class="login_right_div"><button class="login_input_submit" onclick="addSecondNew()">提交新增</button></div></div>'
        });
        document.getElementById("Button1").click();
    }

    function addSecondNew() {
        var accountInput = $("#account1").val();
        var Flag = SFLAG + "_" + (SECONDCOUNT+1);
        if(accountInput == ""){
            alert("标题不能为空");
            return;
        }
        /*alert(EDITORF.txt.html().replace(/\"/g, "*"));*/
        var sContentData = EDITORF.txt.html().replace(/\"/g, "*");
        var sendData = {"title": accountInput, "sub": "1", "content": sContentData, "flag": Flag, "owner": SFLAG};
        request("POST", "<%=basePath%>/add", sendData, function (responseData) {
            if(responseData.result == "0") {
                alert("添加成功，正在为您跳转！")
                window.location.href = "<%=basePath%>/jsp/shehuijiandu/jijianjiandu.jsp";
            }else{
                alert("添加失败，请检查是否标题重复！");
            }
        }, serverError, true, beforeSend);


        //var sendData = {"title": accountInput, "sub": subSelect, "content": "", "flag": Flag, "owner": "1"};
        //request("POST", "/add", sendData, successCallBack, serverError, true, beforeSend);
    }

    function serverError(XMLHttpRequest, textStatus, errorThrown){
        alert("服务器错误， 请检查前后台控制台输出！");
    }
    function beforeSend(){
        //等待写动画效果
    }

    //为每个一级分支添加点击事件
    $("#menuL").on("click", "a", function () {
        SECONDCOUNT = 0;//初始化二级标志位
        var elem = this;
        var titleString = this.getElementsByClassName("title1")[0].innerHTML;
        if(titleString == "+") return; //判断是否为有效项

        var flagString = this.getElementsByClassName("flag")[0].innerHTML;
        BACKMENUFLAG = flagString;//标志目前正在那个一级分支中
        BACKFLAG = "0";//每次点击了一级分支，都要重置标记
        var subString = this.getElementsByClassName("sub1")[0].innerHTML;

        var divArray = document.getElementById("menuL").getElementsByTagName("a");
        for(var i in divArray){
            if(divArray[i].getElementsByTagName("span")[0].innerHTML == ".")
                break;
            divArray[i].getElementsByTagName("div")[0].setAttribute("class", "menu-button");
        }
        this.getElementsByTagName("div")[0].setAttribute("class", "menu-button active");
        var OwData = {"owner": flagString};
        var FlData = {"flag": flagString};
        SFLAG = flagString;//重置二级分支标志位
        if(subString == "1"){
            request("POST", "<%=basePath%>/listContentByFlag", FlData, function (responseData) {
                document.getElementById("contentM").innerHTML = responseData[0].content.replace(/\*/g, "\"");
            }, serverError, true, beforeSend);
        }else{
            request("POST", "<%=basePath%>/listContentByOwner", OwData, function (responseData) {
                var Shtml = '<h2 style="text-align: center;">'+ titleString + '</h2>';
                if (responseData.result == "1") {
                }else{
                    for(var k in responseData){
                        Shtml = Shtml + '<a><div class="cbtn_dan">'+ responseData[k].title +'</div></a>';
                        SECONDCOUNT++;
                    }
                }
                if(sessionStorage.getItem("username") == "admin")
                    Shtml = Shtml + '<a><div class="cbtn_dan" onclick="addSecondMore()">+</div></a>';
                document.getElementById("contentM").innerHTML = Shtml;
            }, serverError, true, beforeSend);
        }
    })

    $("#contentM").on("click", "a", function () {
        var elem = this;
        var titleString = this.getElementsByClassName("cbtn_dan")[0].innerHTML;
        if(titleString == "+") return;
        BACKFLAG = "1";
        var TiData = {"title": titleString};
        request("POST", "<%=basePath%>/listContentByTitle", TiData, function (responseData) {
            document.getElementById("contentM").innerHTML = responseData.content.replace(/\*/g, "\"");
        }, serverError, true, beforeSend);
    })

    function btn2() {
        var E = window.wangEditor;
        var editor = new E('#divDemo');
        EDITORF = editor;
        editor.customConfig.uploadImgMaxSize = 100 * 1024 * 1024;
        editor.customConfig.uploadImgShowBase64 = true;
        editor.create();
        document.getElementById("Button1").style.cssText = "visibility: hidden;";
    }

    function btnFirst2() {
        var E = window.wangEditor;
        var editor = new E('#divFirstDemo');
        EDITORF = editor;
        editor.customConfig.uploadImgMaxSize = 100 * 1024 * 1024;
        editor.customConfig.uploadImgShowBase64 = true;
        editor.create();
        document.getElementById("Button2").style.cssText = "visibility: hidden;";
    }

    function btn1(){
        document.getElementById('html').innerHTML = EDITORF.txt.html();
    }

    function btnFirst1() {
        document.getElementById('htmlFirst').innerHTML = EDITORF.txt.html();
    }

    function MoD() {
        var AllFlagData = {"ownerFlag": "9"};
        request("POST", "<%=basePath%>/listContentByOwnerFlag", AllFlagData, function (responseData) {
            var htmlData = '';
            for(var i in responseData){
                var responseDataTitle = responseData[i].title;
                htmlData = htmlData + '<div class="modDiv" id="' + responseDataTitle + '"><span class="modTitle">' + responseDataTitle
                    + '</span><span class="modFlag" style="visibility: hidden">'+ responseData[i].flag +'</span>'
                    + '<span class="delete" onclick="modDelete(' + responseDataTitle
                    + ')">删除</span><span class="modify" onclick="modModify(' + responseDataTitle + ')">修改</span></div>'
            }

            layer.open({
                type: 1 //Page层类型
                ,area: ['700px', '400px']
                ,title: '修改/删除已有分支'
                ,shade: 0.6 //遮罩透明度
                ,maxmin: true //允许全屏最小化
                ,anim: 1 //0-6的动画形式，-1不开启
                ,content: htmlData
            });
        }, serverError, true, beforeSend);
    }

    function modDelete(title) {
        var flagDataString = title.getElementsByClassName("modFlag")[0].innerHTML;
        /*alert(flagDataString);*/
        var deleteDataString = {"flag": flagDataString};
        request("POST", "<%=basePath%>/deleteContentByFlag", deleteDataString, function (responseData) {
            if(responseData.result == "1"){
                alert("删除失败！请检查网络");
            }else{
                alert("删除成功，成功重新载入");
                window.location.href = "<%=basePath%>/jsp/shehuijiandu/jijianjiandu.jsp"
            }
        }, serverError, true, beforeSend);
    }

    function modModify(title) {
        var titleDataString = title.getElementsByClassName("modTitle")[0].innerHTML;
        OLDTITLE = titleDataString;

        var sendData = {"title": titleDataString};
        request("POST", "<%=basePath%>/listContentByTitle", sendData, function (responseData) {
            layer.open({
                type: 1 //Page层类型
                ,area: ['1200px', '600px']
                ,title: '请填写新增分支的信息'
                ,shade: 0.6 //遮罩透明度
                ,maxmin: true //允许全屏最小化
                ,anim: 1 //0-6的动画形式，-1不开启
                ,content: '<div class="login_right_div"><input id="account2" type="text" class="login_input_text" value="'+titleDataString+'" /></br>'
                + '<div style="text-align:left;"><div id="divSecondDemo">'+responseData.content+'</div></div><button onclick="secondBtn2()" id="Button3">显示编辑器</button></br><button onclick="btnSecond1()">预览</button>'
                + '<div id="htmlSecond"></div><div class="login_right_div"><button class="login_input_submit" onclick="addThirdNew()">提交新增</button></div></div>'
            });
            document.getElementById("Button3").click();
        }, serverError, true, beforeSend)
    }

    function addThirdNew(){
        var accountInput = $("#account2").val();
        if(accountInput == ""){
            alert("标题不能为空");
            return;
        }
        var sContentData = EDITORF.txt.html().replace(/\"/g, "*");
        var sendData = {"newTitle": accountInput, "oldTitle": OLDTITLE, "content": sContentData};
        request("POST", "<%=basePath%>/updataContentByTitle", sendData, function (responseData) {
            if(responseData.result == "0") {
                alert("修改成功！正在重新载入数据");
                window.location.href = "<%=basePath%>/jsp/shehuijiandu/jijianjiandu.jsp"
            }else{
                alert("修改失败，请检查是否标题重复！");
            }
        }, serverError, true, beforeSend);
    }

    function secondBtn2() {
        var E = window.wangEditor;
        var editor = new E('#divSecondDemo');
        EDITORF = editor;
        editor.customConfig.uploadImgMaxSize = 100 * 1024 * 1024;
        editor.customConfig.uploadImgShowBase64 = true;
        editor.create();
        document.getElementById("Button3").style.cssText = "visibility: hidden;";
    }

    function btnSecond1() {
        document.getElementById('htmlSecond').innerHTML = EDITORF.txt.html();
    }

    function turnBack(){
        if(BACKFLAG == "0"){
            window.location.href = "<%=basePath%>/index.jsp";
        }else{
            /*alert(BACKMENUFLAG);*/
            document.getElementById(BACKMENUFLAG).click();
            BACKFLAG = "0";
        }
    }

</script>

</body>
</html>