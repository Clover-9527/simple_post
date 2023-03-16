<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <link href="/css/mui.css" rel="stylesheet"/>
    <link href="/css/common.css" rel="stylesheet"/>
    <link href="/css/postList.css" rel="stylesheet"/>
    <link href="/fonts/iconfont.css" rel="stylesheet"/>
    <style>
        * { touch-action: none; }
        .red-color{
            color: #ff0405;
        }
    </style>
</head>

<body>
<div>
    <header id="header" class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
        <h1 class="mui-title">帖子</h1>
    </header>
    <div style="height: 30px;"></div>


    <!--下拉刷新容器-->
    <div id="pullrefresh" class="mui-content mui-scroll-wrapper">
        <div class="mui-scroll">
            <!--数据列表-->
            <div class="post-list">
            </div>
        </div>
    </div>


</div>

<div id="forward" class="mui-popover mui-popover-action mui-popover-bottom">
    <ul class="mui-table-view">
        <li class="mui-table-view-cell">
            <a href="#" id="publicPost">公开帖子</a>
        </li>
        <li class="mui-table-view-cell">
            <a href="#" id="delete">删除</a>
        </li>
    </ul>
    <ul class="mui-table-view">
        <li class="mui-table-view-cell">
            <a href="#forward"><b>取消</b></a>
        </li>
    </ul>
</div>


<script src="/js/jquery-3.4.1.min.js"></script>
<script src="/js/mui.js"></script>
<script type="text/javascript">
    var pageNum = 0;
    var postId = 0;
    var secret = 0;

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

    mui('body').on('tap', '.mui-popover-action li>a', function() {
        var a = this,
            parent;
        //根据点击按钮，反推当前是哪个actionsheet
        for (parent = a.parentNode; parent != document.body; parent = parent.parentNode) {
            if (parent.classList.contains('mui-popover-action')) {
                break;
            }
        }
        //关闭actionsheet
        mui('#' + parent.id).popover('toggle');
        //	mui.alert(a.innerHTML);

        if(this.getAttribute("id") == "delete"){
            deletePost();
        }else if(this.getAttribute("id") == "publicPost"){
            changePostSercet();
        }

    })

    // 更多...
    mui(".post-list").on('tap','.mui-tab-item',function(){
        //获取选中项id
        postId = this.getAttribute("data-id");
        secret = this.getAttribute("data-secret");
        if(secret == 0){
            $("#publicPost").text("设为私密");
        }else{
            $("#publicPost").text("公开帖子");
        }
    })
    // 更改帖子公开或私密
    function changePostSercet() {
        $.ajax({
            url: "/post/changePostSercet",
            type: "get",
            data: {
                postId: postId,
                secret: secret == 0 ? 1 : 0
            },
            success: function (res) {
                if(res.code == 200){
                    if(secret==0){
                        $("#post_"+postId+" .secret-text").text("私密");
                        $("#post_"+postId+" .secret-icon").removeClass("icon-unlock").addClass("icon-lock");
                        $("#post_"+postId+" .mui-tab-item").attr("data-secret",1);
                    }else{
                        $("#post_"+postId+" .secret-text").text("公开");
                        $("#post_"+postId+" .secret-icon").removeClass("icon-lock").addClass("icon-unlock");
                        $("#post_"+postId+" .mui-tab-item").attr("data-secret",0);
                    }
                }
            }
        })
    }
    // 删除
    function deletePost() {
        $.ajax({
            url: "/post/deletePost",
            type: "get",
            data: {
                postId: postId
            },
            success: function (res) {
                if (res.code == 200) {
                    $("#post_" + postId).remove();
                    mui.alert("删除成功");
                }
            }
        })
    }

    function getPostList() {
        pageNum++;
        $.ajax({
            url: "/post/getMyPostList",
            type: "get",
            data: {
                pageNum: pageNum,
                pageSize: 5,
                userName: "${userSession.userName}"
            },
            success: function (res) {
                if (res.code == 200) {
                    let pageInfo = res.data;
                    let data = res.data.list;

                    for (let i = 0; i < data.length; i++) {
                        let itemStr = '<div class="post-item" id="post_'+data[i].postId+'" data-id="'+data[i].postId+'" >'
                            +'<div class="item-top">'
                            +'<div class="top-left">'
                            +'<div class="post-name">'+data[i].barName+'吧</div>'
                            + '<div class="time">' + data[i].createTime + '</div>'
                            + '</div>'
                            + '<div class="top-right">';

                        let secretStr = ""
                        if (data[i].secret == 0) {
                            secretStr = '<span class="iconfont icon-unlock secret-icon"></span>'
                                + '<span class="secret-text">公开</span>';
                        } else {
                            secretStr = '<span class="iconfont icon-lock secret-icon"></span>'
                                + '<span class="secret-text">私密</span>';
                        }

                        let itemStr1 = '<a class="mui-tab-item" href="#forward" data-id="' + data[i].postId + '" data-secret="' + data[i].secret + '">'
                            + '<span class="iconfont icon-more_light">'
                            + '</span>'
                            + '</a>'
                            + '</div>'
                            + '</div>'
                            + '<div class="item-middle">'
                            + '<div class="post-title">' + data[i].postTitle + '</div>';

                        let itemStr2 = "";
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

                        let itemStr3 =`</div>
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
                            </div>`;

                        $(".post-list").append(itemStr+secretStr+itemStr1+itemStr2+itemStr3);
                        $("#post_" + data[i].postId +" .item-middle").click( function () {
                            window.location = "/post/toPostInfo/" + data[i].postId;
                        });
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
    mui(".post-list").on('tap','.like-btn',function(){
        postId = $(this).parents(".post-item").attr("data-id");
        let isLike = $(this).hasClass("red-color");
        if(isLike){
            // 取消点赞
            deletePostLike();
        }else{
            // 点赞
            addPostLike();
        }
    })
    // 点赞
    function addPostLike() {
        $.ajax({
            url:"/post-like/addPostLike",
            type:"post",
            data:{
                postId: postId
            },
            success:function (res) {
                if(res.code == 200){
                    //    mui.alert("点赞成功");
                    $("#post_"+postId+" .like-btn").toggleClass("red-color");
                    let num = $("#post_"+postId+" .like-num").text();
                    if(num == '点赞'){
                        $("#post_"+postId+" .like-num").text(1)
                    }else{
                        $("#post_"+postId+" .like-num").text(++num);
                    }
                }
            }
        })
    }
    // 取消点赞
    function deletePostLike() {
        $.ajax({
            url:"/post-like/deletePostLike",
            type:"post",
            data:{
                postId: postId
            },
            success:function (res) {
                if(res.code == 200){
                    //  mui.alert("取消成功");
                    $("#post_"+postId+" .like-btn").toggleClass("red-color");
                    let num = $("#post_"+postId+" .like-num").text();
                    num--;
                    if(num == 0){
                        $("#post_"+postId+" .like-num").text("点赞");
                    }else{
                        $("#post_"+postId+" .like-num").text(num);
                    }
                }
            }
        })
    }
</script>
</body>

</html>
