var buttons = document.getElementsByClassName("div-button");
for (var i = 0; i < buttons.length; i++) {
    buttons[i].addEventListener("click", function () {
        var target = this.getElementsByClassName("content")[0].getAttribute("data-href");
        if (target !== null) {
            location.href = target;
        } else {
            alert("开发中...")
        }
    })
}
