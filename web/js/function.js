function MoD() {
    var AllFlagData = {"ownerFlag": "1"};
    request("POST", "<%=basePath%>/listContentByOwnerFlag", AllFlagData, function (responseData) {
        var htmlData = '';
        for(var i in responseData){
            htmlData = htmlData + '<div class="modDiv"><span class="modTitle">' + responseData[i].title + '</span>'
                + '<span class="delete">删除</span><span class="modify">修改</span></div>'
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