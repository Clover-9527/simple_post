<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <link href="/css/mui.css" rel="stylesheet" />
</head>
    <style>
        .mui-bar-tab{
            background-color: #fff;
        }
    </style>
<body>

<nav class="mui-bar mui-bar-tab">
    <a class="mui-tab-item" id="tabbar1"  onclick="switchTabbar(1)">
        <span class="mui-icon mui-icon-home"></span>
        <span class="mui-tab-label">首页</span>
    </a>
    <a class="mui-tab-item" id="tabbar2" onclick="switchTabbar(2)">
        <span class="mui-icon mui-icon mui-icon-compose"></span>
        <span class="mui-tab-label">进吧</span>
    </a>
    <a class="mui-tab-item" id="tabbar3" onclick="switchTabbar(3)">
        <span class="mui-icon mui-icon-plusempty"></span>
        <span class="mui-tab-label">发布</span>
    </a>
    <a class="mui-tab-item" id="tabbar4" onclick="switchTabbar(4)">
        <span class="mui-icon mui-icon-email"></span>
        <span class="mui-tab-label">消息</span>
    </a>
    <a class="mui-tab-item" id="tabbar5" onclick="switchTabbar(5)">
        <span class="mui-icon mui-icon-contact"></span>
        <span class="mui-tab-label">我的</span>
    </a>
</nav>
<script src="/js/mui.js"></script>
<script src="/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
    mui.init()

    $(function () {
        var tabIndex = "${param.tabIndex}";
        $("#tabbar"+tabIndex).addClass("mui-active");
    });



    // 切换选项卡
    function switchTabbar(index) {
        if(index == 1){
            window.location.href = "/home/toHome";
        }else if(index == 2){
            window.location.href = "/post/toBar";
        }else if(index == 3){
            window.location.href = "/post/toPublish";
        }else if(index == 5){
            window.location.href = "/user/toMy";
        }
    }
</script>
</body>

</html>
