var E = window.wangEditor;
var editor = new E('#divDemo');
editor.customConfig.uploadImgMaxSize = 100 * 1024 * 1024;
editor.customConfig.uploadImgShowBase64 = true;
editor.create();

function btn(){
    alert("我靠");
    console.log(editor.txt.html());
    document.getElementById('html').innerHTML = editor.txt.html();
}