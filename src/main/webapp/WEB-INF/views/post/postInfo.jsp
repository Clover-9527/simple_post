<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <link href="/css/mui.css" rel="stylesheet"/>
    <link href="/css/common.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/css/home.css">
    <link href="/fonts/iconfont.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/css/postInfo.css">
</head>

<body>

<header id="header" class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" href="/home/toHome"></a>
    <a class="mui-icon mui-icon-search mui-pull-right"></a>
</header>
<div class="comment">
    <input type="text" placeholder="说说你的看法...">
</div>

<div style="height: 70px;"></div>
<div style="margin-bottom: 20px">
    <span class="bartitle">${postInfo.postTitle}</span>
</div>



<div class="post-item">
    <div class="content">
        <div class="head" id="h">
            <div>
                <c:choose>
                    <c:when test="${empty postInfo.avatar}">
                        <a href="/user/toUserHome/${postInfo.userName}"><img class="headportrait" src="/images/default.jpg"></a>
                    </c:when>
                    <c:otherwise>
                        <img class="headportrait" src="/filePath/${postInfo.avatar}"/>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="info">
                <div class="top">
                    <span class="nickname">${postInfo.nickName}</span>
                    <span class="iconfont icon-game"></span>
                </div>
                <div class="bottom">
                    <span class="tbname">${postInfo.barName}</span>
                    <span class="a"> |</span>
                <span class="time">
                    <fmt:formatDate value="${postInfo.createTime}"  type="both" />
<%--                    ${postInfo.createTime}--%>
                </span>
                </div>
            </div>
            <div>
                <button type="button" id="editInfo" onclick="follow(${postInfo.userId})">+关注</button>
            </div>
        </div>
    </div>
<input  type="hidden" id="userName" value="${postInfo.userId}">
    <div class="postcontent">
        ${postInfo.content}
    </div>
</div>

    <c:forEach items="${postImgList}" var="list">

        <c:if test="${postImgList.size()==1}">
            <img class="post-img" src="/filePath/${list.picName}"/>
        </c:if>
        <c:if test="${postImgList.size()==2}">
            <img class="post-img" src="/filePath/${list.picName}"/>
        </c:if>
        <c:if test="${postImgList.size()>=3}">
            <img class="post-img" src="/filePath/${list.picName}"/>
        </c:if>
    </c:forEach>

<div style="height: 20px"></div>
<div class="like-btn">
    <button class="like-num" onclick="like()">${postInfo.myLike==1?'取消赞':'点赞'}</button>
</div>
<div class="collection-btn">
    <button class="collection" onclick="collection()">收藏</button>
</div>

<div class="barinfo">
<%--    <div><img src="/filePath/${barInfo[0].picName}"></div>--%>
    <div><img src="/filePath/${barInfo[0].picName}" width="90px" height="90px"></div>
    <div class="barinforight">
        <span style="margin: 15px 0px;font-size: 25px">${postInfo.barName}吧</span>
        <span style="color:#7b91b0">关注   ${barInfo[0].likeNum} &nbsp;帖子 ${barInfo[0].postNum}</span>
    </div>
    <div>
        <a class="iconfont icon-right" href="/post/toBarInner/${barInfo[0].barID}"></a>
    </div>
</div>


</body>
<script src="/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
    var pathname = window.location.pathname.split("/");
    var postId = pathname[3];
    var userName="${userSession.userName}"
    var barName;
    var postUserName="${postInfo.userName}"
    //查询发帖用户信息
    $.ajax({
        url: "/post/selectByPostId",
        type: "get",
        data: {
            postId: postId
        },
        success: function (res) {
            barName=res.barName;
            selectBar(barName)
        }
    })

    //查询帖子图片信息
    $.ajax({
        url: "/post/selectPostImg",
        type: "get",
        data: {
            postId: postId
        },
        success: function (res) {
        }
    })

    //添加浏览历史记录
    $.ajax({
        url: "/post/addHistory",
        type: "post",
        data: {
            postId: postId
        },
        success: function (res) {
        }
    })

    //查询是否收藏
    $.ajax({
        url: "/post/isCollected",
        type: "get",
        data: {
            postId: postId
        },
        success: function (res) {
            if(res>0){
                $(".collection").text("已收藏");
            }else{
                $(".collection").text("收藏");
            }
        }
    })

    reurl()

    //  收藏、取消收藏
    function collection() {
        if(  $(".collection").text()=="已收藏"){
            $.ajax({
                url: "/post/delCollect",
                type: "post",
                data: {
                    postId: postId
                },
                success: function (res) {
                    $(".collection").text("收藏");
                }
            })
        }else{
            $.ajax({
                url: "/post/collectPost",
                type: "post",
                data: {
                    postId: postId
                },
                success: function (res) {
                    $(".collection").text("已收藏");
                }
            })
        }



    }

    //查询贴吧信息
    function selectBar(barName){
        $.ajax({
            url: "/post/selectBar",
            type: "get",
            data: {
              barName
            },
            success: function (res) {
            }
        })
    }

    //点赞、取消赞
    function like() {
        if($('.like-num').text()=='取消赞'){
            $.ajax({
                url: "/post-like/deletePostLike",
                type: "post",
                data: {
                    postId
                },
                success: function (res) {
                    $('.like-num').text('点赞')
                }
            })
        }else{
            $.ajax({
                url: "/post-like/addPostLike",
                type: "post",
                data: {
                    postId
                },
                success: function (res) {
                    $('.like-num').text('取消赞')
                }
            })
        }

    }

    //关注、取消关注
    function follow(fuId) {
        if ($("#editInfo").text() == "编辑资料") {
            window.location = "/user/toUserInfo"
            return;
        }
        if (status == 1) {
            $("#editInfo").text("+关注");
        } else {
            $("#editInfo").text("取消关注");
        }

        $.ajax({
            url: "/user/follow",
            type: "post",
            data: {
                fuId, status
            },
            success: function () {
                if (status == 1)
                    status = 0;
                else
                    status = 1;
            }
        })
    }

    //查询是否关注
    function isFollow() {
        $.ajax({
            url: "/user/isFollow",
            type: "get",
            data: {
                userName:postUserName
            },
            success: function (res) {
                if (res == 1) {
                    status = 1;
                    $("#editInfo").text("取消关注");
                } else {
                    status = 0;
                    $("#editInfo").text("+关注");
                }
            }
        })
    }

    function reurl() {
        url = location.href; //把当前页面的地址赋给变量 url
        var times = url.split("?"); //分切变量 url 分隔符号为 "?"
        if (times[times.length - 1] != 1) { //如果?后的值不等于1表示没有刷新
            url += "?1"; //把变量 url 的值加入 ?1
            setTimeout(function () {
                self.location.replace(url); //刷新页面
            }, 100)
        }else{
            var status=0;
            var v = $("#editInfo").text();
            var s = $('#userName').val();
            if (s == userName) {
                $("#editInfo").text("编辑资料");
            } else {
                isFollow()  //检测关注状态
            }
        }
    }
</script>
</html>