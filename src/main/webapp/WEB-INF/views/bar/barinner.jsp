<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <title></title>
    <script src="/js/mui.min.js"></script>
    <link href="/css/mui.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/fonts/iconfont.css">
    <link rel="stylesheet" href="/css/userhome.css">
    <link rel="stylesheet" href="/css/home.css">
    <link rel="stylesheet" href="/css/barinner.css">
    <script src="/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" charset="utf-8">
        mui.init();
    </script>

</head>

<body>
<header id="header" class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" href="/post/toBar"></a>
    <a class="mui-icon mui-icon-search mui-pull-right"></a>
</header>
<div style="height: 70px;"></div>
<div class="top">
    <img src="/filePath/${bar.picName}">
    <div class="center">
        <span class="barname">${bar.barName}吧</span>
        <span class="levelinfo">LV${bar.level} /123</span>
        <span style="border: 2px solid #f6bd6a;"></span>
    </div>
    <button class="signbtn">签到</button>
</div>

<div style="border: 5px solid #f5f5f5; margin-top:10px"></div>

<div class="middle">
    <div style="margin: 10px;border-bottom: 2px solid black;"><strong>全部</strong></div>
    <div style="margin: 10px;">吧主推荐</div>


</div>
<div class="middle">
    <div style="margin:0 10px;color: #5a80b4;font-family: '黑体';">置顶
    </div>
    <span>故法撒旦个是打发人撒地方刚杀个</span>
</div>
<div class="middle">
    <div style="margin:0 10px;color: #5a80b4;font-family: '黑体';">公告
    </div>
    <span>故法撒旦个是打发人撒地方刚杀个</span>
</div>

<div style="border: 5px solid #f5f5f5; margin-top:10px"></div>


<div style="display: flex; justify-content: space-between;">
    <span style="margin: 15px;">智能排序</span>
    <span style="margin: 15px;">排序</span>
</div>
<div style="border:0.5px solid #f5f5f5"></div>

<div class="post-list">
    <c:forEach items="${barList}" var="list">
        <div class="content" id="post_${list.postId}" data-id="${list.postId}">
            <div class="head" id="h">
                <c:choose>
                    <c:when test="${list.postUser.avatar}==''">
                        <img src="/filePath/${list.postUser.avatar} " class="headportrait" onclick="toUserHome(${list.postUser.userName})"/>
                    </c:when>
                    <c:otherwise>
                        <img src="/images/default.jpg" class="headportrait"
                             onclick="toUserHome(${list.postUser.userName})"/>
                    </c:otherwise>
                </c:choose>


                <div class="info">
                    <div class="top">
                        <div style="display: flex;justify-content: flex-start">
                            <span class="nickname">${list.postUser.nickName}</span>
                            <span class="iconfont icon-game"></span>
                        </div>
                        <span class="iconfont icon-close"></span>
                    </div>
                    <div class="bottom">
                        <span class="time">
                             <fmt:parseDate value="${list.createTime}" pattern="yyyy-MM-dd HH:mm:ss" var="receiveDate"/>
                              <fmt:formatDate value="${receiveDate}" type="time" timeStyle="short"/>
                        </span>

                    </div>
                </div>
            </div>
            <div class="onlyline" onclick="toPostInfo(${list.postId})">
                <span>${list.postTitle}</span>
            </div>

            <c:choose>
            <c:when test="${empty list.postImgList}">
            </c:when>

            <c:otherwise>
            <div class="imgbox">
                </c:otherwise>
                </c:choose>

                <c:forEach items="${list.postImgList}" var="img">

                    <c:if test="${list.postImgList.size()==1}">
                        <img class="post-img img" src="/filePath/${img.picName}"/>
                    </c:if>
                    <c:if test="${list.postImgList.size()==2}">
                        <img class="post-img-2" src="/filePath/${img.picName}"/>
                    </c:if>
                    <c:if test="${list.postImgList.size()>=3}">
                        <img class="post-img-3" src="/filePath/${img.picName}"/>
                    </c:if>
                </c:forEach>

                <c:choose>
                <c:when test="${empty list.postImgList}">
                </c:when>
                <c:otherwise>
            </div>
            </c:otherwise>
            </c:choose>


            <div class="item-bottom">
                <div class="b-item">
                    <span class="iconfont icon-comment"></span>
                    <span>评论</span>
                </div>
                <div class="b-item like-btn ${list.myLike==1? 'red-color':''}">
                    <span class="iconfont icon-appreciate"></span>
                    <span class="like-num">${list.likeNum==0?'点赞':list.likeNum}</span>
                </div>
            </div>
        </div>
    </c:forEach>
</div>


<div class="adddiv" onclick="toPublishtb()">
    <img src="/images/add.jpg">
</div>

<div style="height: 75px"></div>
</body>


<script src="/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
    var pathname = window.location.pathname.split("/");
    var barId = pathname[3];

    $.ajax({
        url: "/post/getBarList",
        type: "get",
        data: {barId},
        success: function () {
        }
    })

    $.ajax({
        url: "/post/getBarInfo",
        type: "get",
        data: {barId},
        success: function () {
        }
    })


    //去用户主页
    function toUserHome(username) {
        var userName = username;
        window.location = "/user/toUserHome/" + userName;
    }

    //去发帖页面
    function toPublishtb() {
        window.location = "/post/toPublishtb/" + barId;
    }

    //去帖子详情
    function toPostInfo(postId) {
        var postId = postId;
        window.location = "/post/toPostInfo/" + postId;
    }


    reurl();

    function reurl() {
        url = location.href; //把当前页面的地址赋给变量 url
        var times = url.split("?"); //分切变量 url 分隔符号为 "?"
        if (times[times.length - 1] != "t") { //如果?后的值不等于1表示没有刷新
            url += "?t"; //把变量 url 的值加入 ?1
            setTimeout(function () {
                self.location.replace(url); //刷新页面
            }, 200)
        }
    }

    // 点赞
    mui(".post-list").on('tap', '.like-btn', function () {
        postId = $(this).parents(".content").attr("data-id");
        let isLike = $(this).hasClass("red-color");
        if (isLike) {
            // 取消点赞
            deletePostLike(postId);
        } else {
            // 点赞
            addPostLike(postId);
        }
    })

    // 点赞
    function addPostLike(postId) {
        $.ajax({
            url: "/post-like/addPostLike",
            type: "post",
            data: {
                postId: postId
            },
            success: function (res) {
                if (res.code == 200) {
                    $("#post_" + postId + " .like-btn").toggleClass("red-color");
                    let num = $("#post_" + postId + " .like-num").text();
                    if (num == '点赞') {
                        $("#post_" + postId + " .like-num").text(1)
                    } else {
                        $("#post_" + postId + " .like-num").text(++num);
                    }
                }
            }
        })
    }

    // 取消点赞
    function deletePostLike() {
        $.ajax({
            url: "/post-like/deletePostLike",
            type: "post",
            data: {
                postId: postId
            },
            success: function (res) {
                if (res.code == 200) {
                    //  mui.alert("取消成功");
                    $("#post_" + postId + " .like-btn").toggleClass("red-color");
                    let num = $("#post_" + postId + " .like-num").text();
                    num--;
                    if (num == 0) {
                        $("#post_" + postId + " .like-num").text("点赞");
                    } else {
                        $("#post_" + postId + " .like-num").text(num);
                    }
                }
            }
        })
    }
</script>

</html>