<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script src="/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" charset="utf-8">
        mui.init();
    </script>

</head>

<body>
<div class="header">
    <img src="/images/bg.png"/>
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" href="/user/toMy"></a>
    <h1 class="mui-title">我的主页</h1>

    <div class="yin">
        <span>印</span>
    </div>
    <div class="add">
        <span>+</span>
    </div>

    <div class="userinfo">
        <c:choose>
            <c:when test="${empty personInfo.avatar}">
                <img class="userimg" src="/images/default.jpg">
            </c:when>
            <c:otherwise>
                <img class="userimg" src="/filePath/${personInfo.avatar}"/>
            </c:otherwise>
        </c:choose>

        <button id="editInfo" value="编辑资料" class="editinfo" onclick="follow()"></button>


        <span class="iconfont icon-crownfill"></span>
        <span class="username" name="username"><b>${personInfo.nickName}</b></span>
        <span class="iconfont icon-male gender"></span>
    </div>
    <div class="middle1">
        <span class="num">${usercountMap.fansCount}</span><span class="fs">粉丝</span><span>|</span>
        <span class="num">${usercountMap.followCount}</span><span class="fs">关注</span><span>|</span>
        <span class="gzbnum">${usercountMap.followBarCount}</span><span class="gzb">我关注的吧</span><br/>
    </div>
    <div class="middle2">
        <span class="num">吧龄:</span><span class="fs">14.8年</span>
    </div>
    <div class="recommend">
        <span class="fs">简介:</span><span class="tex">${personInfo.signature}</span>
    </div>
</div>

<div style="clear:both"></div>

<div id="forward" class="mui-popover mui-popover-action mui-popover-bottom">
    <ul class="mui-table-view">
        <li class="mui-table-view-cell">
            <a href="#">公开帖子</a>
        </li>
        <li class="mui-table-view-cell">
            <a href="#">删除</a>
        </li>
    </ul>
    <ul class="mui-table-view">
        <li class="mui-table-view-cell">
            <a href="#forward"><b>取消</b></a>
        </li>
    </ul>
</div>

<c:forEach items="${myPostList}" var="post">
    <div class="article"  id="post_${post.postId}" data-id="${post.postId}" >
        <div class="releaseyear"><span>2022年</span></div>
        <div class="releaseday">
            <span class="day">23</span>
            <span class="tbname">${post.barName}吧</span>
            <span class="iconfont icon-more_light"></span>
        </div>
        <div class="releasemonth"><span>九月</span></div>
        <div class="contentd">
            <span class="content">${post.postTitle}</span><br/>


            <c:choose>
                <c:when test="${empty post.postImgList}">
                </c:when>

                <c:otherwise>
                    <div class="imgbox">
                </c:otherwise>
            </c:choose>

                <c:forEach items="${post.postImgList}" var="img">
                    <c:if test="${post.postImgList.size()==1}">
                        <img class="post-img" src="/filePath/${img.picName}"/>
                    </c:if>
                    <c:if test="${post.postImgList.size()==2}">
                        <img class="post-img-2" src="/filePath/${img.picName}"/>
                    </c:if>
                    <c:if test="${post.postImgList.size()>=3}">
                        <img class="post-img-3" src="/filePath/${img.picName}"/>
                    </c:if>
                </c:forEach>

            <c:choose>
            <c:when test="${empty post.postImgList}">
            </c:when>
            <c:otherwise>
                </div>
            </c:otherwise>
            </c:choose>

        </div>

        <div class="foot">
            <span class="iconfont icon-comment"></span>
            <span class="commnetNum">评论</span>

            <div class="b-item like-btn ${post.myLike==1? 'red-color':''}" >
                <span class="iconfont icon-appreciate_light"></span>
                <span class="likeNum">${post.likeNum==0?'点赞':post.likeNum}</span>
            </div>
        </div>

    </div>
</c:forEach>

</body>


<script type="text/javascript">
    var pathname = window.location.pathname.split("/");
    var userName = pathname[3];

    var fuId;
    //获取用户信息
    $.ajax({
        url: "/user/selectUserByUserName",
        type: "get",
        data: {
            userName
        },
        success: function () {
            fuId = ${personInfo.userId};
        }
    })

    //获取帖子列表
    $.ajax({
        url: "/post/getMyPostList",
        type: "get",
        data: {
            pageNum: 0,
            pageSize: 2,
            userName
        },
        success: function (res) {
        }
    })


    var v = $("#editInfo").text();
    var s = "${userSession.userName}"
    if (s == userName) {
        $("#editInfo").text("编辑资料");
    } else {
        isFollow()  //检测关注状态
    }


    var status = 0;

    function isFollow() {
        $.ajax({
            url: "/user/isFollow",
            type: "get",
            data: {
                userName
            },
            success: function (res) {
                if (res == 1) {
                    status = 1;
                    $("#editInfo").text("取消关注");
                } else {
                    status = 0;
                    $("#editInfo").text("关注");
                }
            }
        })
    }

    function follow() {
        if ($("#editInfo").text() == "编辑资料") {
            window.location = "/user/toUserInfo"
            return;
        }
        if (status == 1) {
            $("#editInfo").text("关注");
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

    reurl();
    function reurl() {
        url = location.href; //把当前页面的地址赋给变量 url
        var times = url.split("?"); //分切变量 url 分隔符号为 "?"
        if (times[times.length - 1] != "t") { //如果?后的值不等于1表示没有刷新
            url += "?t"; //把变量 url 的值加入 ?1
            setTimeout(function () {
                self.location.replace(url); //刷新页面
            }, 100)
        }
    }


    // 点赞监听
    mui(".article").on('tap', '.like-btn', function () {
        postId = $(this).parents(".article").attr("data-id");
        let isLike = $(this).hasClass("red-color");
        if (isLike) {
            deletePostLike(postId); // 取消点赞
        } else {
            addPostLike(postId);    // 点赞
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
                        $("#post_" + postId + " .likeNum").text(1)
                    } else {
                        $("#post_" + postId + " .likeNum").text(++num);
                    }
                }
            }
        })
    }

    // 取消点赞
    function deletePostLike(postId) {
        $.ajax({
            url: "/post-like/deletePostLike",
            type: "post",
            data: {
                postId: postId
            },
            success: function (res) {
                if (res.code == 200) {
                    $("#post_" + postId + " .like-btn").toggleClass("red-color");
                    let num = $("#post_" + postId + " .likeNum").text();
                    num--;
                    if (num == 0) {
                        $("#post_" + postId + " .likeNum").text("点赞");
                    } else {
                        $("#post_" + postId + " .likeNum").text(num);
                    }
                }
            }
        })
    }
</script>


</html>


