function request(method,url,data,successCallBack,errorCallBack,async,beforeSendF){
    $.ajax({
        url: url,
        type: method,
        data: data,
        dataType: "json",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        async: async,
        beforeSend: beforeSendF,
        success: successCallBack,
        error: errorCallBack
    });
}

function showMessage(responseData){
	console.log("showMessage", responseData);
	alert(responseData.description);
}
function serverError(XMLHttpRequest, textStatus, errorThrown){
	alert("服务器错误， 请检查前后台控制台输出！");
}