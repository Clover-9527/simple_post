<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>

<head>
    <meta charset="utf-8">
    <title>首页</title>
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <link rel="stylesheet" href="/fonts/iconfont.css">
    <link rel="stylesheet" href="/css/home.css">
    <link href="/css/common.css" rel="stylesheet"/>
    <link href="/css/postList.css" rel="stylesheet"/>
    <link href="/fonts/iconfont.css" rel="stylesheet"/>
    <style>
        .post-img-2 {
            margin: 0 55px;
        }

        .post-img-2 img {
            height: 125px;
        }

        .post-img-3 img {
            height: 120px;
        }

        .red-color {
            color: #ff0405;
        }
    </style>
</head>

<body>
<div>
    <!--导航栏 start-->
    <header id="header" class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-search mui-pull-left" href="/post/toSearch/"></a>
        <h1 class="mui-title">推荐</h1>
    </header>
    <div style="height: 50px;"></div>
    <!--导航栏 end-->

    <!--下拉刷新容器-->
    <div id="pullrefresh" class="mui-content mui-scroll-wrapper">
        <div class="mui-scroll">
            <!--数据列表-->
            <div class="post-list">
            </div>
        </div>
    </div>


</div>
<jsp:include page="../common/tabbar.jsp">
    <jsp:param name="tabIndex" value="1"/>
</jsp:include>


<script src="/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
    var pageNum = 0;
    mui.init({
        pullRefresh: {
            container: '#pullrefresh',
            down: {
                style: 'circle',
                callback: pulldownRefresh
            },
            up: {
                auto: true,
                contentrefresh: '正在加载...',
                callback: pullupRefresh
            }
        }
    });

    /**
     * 下拉刷新具体业务实现
     */
    function pulldownRefresh() {
        setTimeout(function () {
            pageNum = 0;
            $(".post-list").empty();
            getPostList();
            mui('#pullrefresh').pullRefresh().endPulldownToRefresh();
            // 启用上拉刷新
            mui('#pullrefresh').pullRefresh().refresh(true);
        }, 1000);
    }

    // 上拉加载更多
    function pullupRefresh() {
        setTimeout(function () {
            getPostList();
        }, 1000);
    }


    let barId, username;

    function getPostList() {
        pageNum++;
        $.ajax({
            url: "/post/getPostList",
            type: "get",
            data: {
                pageNum: pageNum,
                pageSize: 5
            },
            success: function (res) {
                if (res.code == 200) {
                    let pageInfo = res.data;
                    let data = res.data.list;
                    let itemStr = '';
                    let itemStr2 = '';
                    let i;
                    for (i = 0; i < data.length; i++) {
                        itemStr2 = "";

                        itemStr = `<div class="post-item" id="post_` + data[i].postId + `" data-id="` + data[i].postId + `" ><div class="content">
                               <div class="head" id="h">
                                <div class="avatar`+data[i].postUser.userId+`" >
            <img src="/filePath/` + data[i].postUser.avatar + `" class="headportrait" onclick="toUserHome('` + data[i].postUser.userName + ` ')"/>
                               </div>
                               <div class="info">
                               <div class="top">
                               <span class="nickname">` + data[i].postUser.nickName + `</span>
                               <span class="iconfont icon-game"></span>
                               <span class="iconfont icon-close" onclick="deletePost(` + data[i].postId + `)"></span>
                               </div>
                               <div class="bottom">
                               <span class="tbname">` + data[i].barName + `</span>
                               <span class="a"> |</span>
                               <span class="time">` + data[i].createTime + `</span>
                               </div>
                               </div>
                               </div>
       <div class="onlyline" onclick="toPostInfo('` + data[i].postId + ` ')" >
                               <span>` + data[i].postTitle + `</span>
                               </div><div class="box" onclick="toPostInfo('` + data[i].postId + ` ')">`;

                        if (data[i].postImgList != null) {
                            if (data[i].postImgList.length == 1) {
                                itemStr2 = '<div class="post-img">'
                                    + '<img src="/filePath/' + data[i].postImgList[0].picName + '"/>'
                                    + '</div>';
                            } else if (data[i].postImgList.length == 2) {
                                itemStr2 = '<div class="post-img-2">'
                                    + '<img src="/filePath/' + data[i].postImgList[0].picName + '"/>'
                                    + '<img src="/filePath/' + data[i].postImgList[1].picName + '"/>'
                                    + '</div>';
                            } else if (data[i].postImgList.length >= 3) {
                                itemStr2 = '<div class="post-img-3">'
                                    + '<img src="/filePath/' + data[i].postImgList[0].picName + '"/>'
                                    + '<img src="/filePath/' + data[i].postImgList[1].picName + '"/>'
                                    + '<img src="/filePath/' + data[i].postImgList[2].picName + '"/>'
                                    + '</div>';
                            }
                        }

                        let itemStr3 = `</div></div>
                            <div class="item-bottom">
                            <div class="b-item">
                            <span class="iconfont icon-comment"></span>
                            <span>评论</span>
                            </div>
                            <div class="b-item like-btn \${data[i].myLike==1? 'red-color':''}" >
                                <span class="iconfont icon-appreciate"></span>
                                <span class="like-num">\${data[i].likeNum==0?'点赞':data[i].likeNum}</span>
                            </div>
                            </div>
                            </div></div>`;

                        $(".post-list").append(itemStr + itemStr2 + itemStr3);

                            if((data[i].postUser.avatar)=='')
                            $(".avatar" + data[i].postUser.userId+" img").attr("src","/images/default.jpg")
                    }
                    // 判断是否有下一页
                    if (pageInfo.isLastPage) {
                        mui('#pullrefresh').pullRefresh().endPullupToRefresh(true); //参数为true代表没有更多数据了。
                    } else {
                        mui('#pullrefresh').pullRefresh().endPullupToRefresh(false); //参数为true代表没有更多数据了。
                    }
                }

            }
        })
    }


    // 点赞
    mui(".post-list").on('tap', '.like-btn', function () {
        postId = $(this).parents(".post-item").attr("data-id");
        let isLike = $(this).hasClass("red-color");
        if (isLike) {
            deletePostLike(postId); // 取消点赞
        } else {
            addPostLike(postId);    // 点赞
        }
    })

    //删除
    mui(".post-list").on('tap', '.icon-close', function () {
        postId = $(this).parents(".post-item").attr("data-id");
        var msg = "您确定要删除吗？";
        if (confirm(msg) === true) {
            $.ajax({
                url: "/post/deletePost",
                type: "get",
                data: {
                    postId: postId
                },
                success: function (res) {
                    if (res.code == 200) {
                        $("#post_" + postId).remove();
                        mui.alert("删除成功!");
                    }else{
                        mui.alert("删除失败，无法删除他人的帖子!");
                    }
                }
            })
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


    function toUserHome(username) {
        var userName = username;
        window.location = "/user/toUserHome/" + userName;
    }

    function toPostInfo(postId) {
        var postId = postId;
        window.location = "/post/toPostInfo/" + postId;
    }
</script>
</body>

</html>
