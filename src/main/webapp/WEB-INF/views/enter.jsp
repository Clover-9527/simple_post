<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <title></title>
    <script src="/js/mui.min.js"></script>
    <link href="/css/mui.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/fonts/iconfont.css">
    <link rel="stylesheet" href="/css/enter.css">


    <script type="text/javascript" charset="utf-8">
        mui.init();
    </script>
</head>

<body>
<!--导航栏 start-->
<header id="header" class="mui-bar mui-bar-nav">
    <h1 class="mui-title">进吧</h1>
    <img src="/images/qd.jpg">
</header>
<div style="height: 50px;"></div>
<!--导航栏 end-->

<div class="topsearch"  onclick="toSearch(this.value)">
    <div class="mui-input-row mui-search">
        <input type="search" class="mui-input-clear" placeholder="大家都在搜: 一群母猪排队掉进水沟里">
    </div>
</div>

<div class="lastenter">
    <div class="ltop">
        <div><span>最近逛的吧</span></div>
        <div><span class="iconfont icon-attention"></span></div>
    </div>

    <div class="limg">
        <c:forEach items="${historyList}" var="list">
            <div class="tbbox" onclick="toBarInner(${list.barId})">
                <img src="/filePath/${list.picName}" style="border-radius: 18px">
                <span>${list.barName}</span>
            </div>
        </c:forEach>
    </div>
</div>
<div class="myconcern">
    <span class="topspan">我关注的吧</span>
</div>

<div class="ba">
    <c:forEach items="${followBarList}" var="bar">
        <div class="content">
            <span onclick="toBarInner( ${bar.barId})">${bar.barName}</span>
            <img class="avatar" src="/images/lv${bar.level}.jpg"/>
        </div>
    </c:forEach>
</div>
<div style="clear: both"></div>

<div class="more">
    <span>+探索更多有趣内容</span>
</div>

<jsp:include page="common/tabbar.jsp">
    <jsp:param name="tabIndex" value="2"/>
</jsp:include>

</body>
<script src="/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
    $.ajax({
        url: "/user/selectHistory",
        type: "get",
        success: function (res) {
        }
    })

    $.ajax({
        url: "/post/getEnterBarInfo",
        type: "get",
        success: function (res) {
        }
    })

    reurl();
    function reurl() {
        url = location.href; //把当前页面的地址赋给变量 url
        var times = url.split("?"); //分切变量 url 分隔符号为 "?"
        if (times[times.length - 1] != 1) { //如果?后的值不等于1表示没有刷新
            url += "?1"; //把变量 url 的值加入 ?1
            setTimeout(function () {
                self.location.replace(url); //刷新页面
            }, 100)
        }
    }

    function toBarInner(barId) {
        var barId = barId;
        window.location = "/post/toBarInner/" + barId;
    }

    function toSearch(value) {
        window.location = "/post/toSearch/"
    }

</script>

</html>
