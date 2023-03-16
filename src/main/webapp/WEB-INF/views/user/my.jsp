<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link href="/css/mui.css" rel="stylesheet" />
		<link href="/css/common.css" rel="stylesheet" />
		<link href="/css/login.css" rel="stylesheet" />
		<link href="/fonts/iconfont.css" rel="stylesheet" />
		<link href="/css/my.css" rel="stylesheet" />
		<script src="/js/jquery-3.4.1.min.js"></script>
		<script src="/js/mui.js"></script>

	</head>

	<body>
		<header id="header" class="mui-bar mui-bar-nav">
			<h1 class="mui-title">我的</h1>
			<a class="mui-icon mui-icon-gear mui-pull-right" id="toSet"></a>
		</header>
		<div style="height: 50px;"></div>
		<div class="user-info">
            <c:choose>
                <c:when test="${empty userSession.avatar}">
                    <img class="avatar" src="/images/default.jpg">
                </c:when>
                <c:otherwise>
                    <img class="avatar" src="/filePath/${userSession.avatar}"/>
                </c:otherwise>
            </c:choose>
			<div class="info-middle">
				<div class="info-top">
					<span class="iconfont icon-crown"></span>
					<span class="nickname">${userSession.nickName}</span>
					<span class="iconfont icon-male gender"></span>
				</div>
				<div class="info-bottom">查看个人主页和编辑资料</div>
			</div>
			<div class="more" onclick="toUserHome()">
				<span class="iconfont icon-right"></span>
			</div>
		</div>

		<div class="menu">
			<div class="menu-item" onclick="toFollowUser()">
				<div class="item-num">${usercountMap.followCount}</div>
				<div class="item-name">关注</div>
			</div>
			<div class="menu-item" onclick="toFans()">
				<div class="item-num">${usercountMap.fansCount}</div>
				<div class="item-name">粉丝</div>
			</div>
			<div class="menu-item" onclick="toFollowBar()">
				<div class="item-num">${usercountMap.followBarCount}</div>
				<div class="item-name">关注的吧</div>
			</div>
			<div class="menu-item"  onclick="toMyPostList()">
				<div class="item-num">${usercountMap.barCount}</div>
				<div class="item-name">帖子</div>
			</div>
		</div>
		<div class="gap"></div>
		<ul class="mui-table-view">
			<li class="mui-table-view-cell"  onclick="toMyCollection()">
				<a class="mui-navigate-right">
					<span class="iconfont icon-favor"></span>我的收藏
				</a>
			</li>
			<li class="mui-table-view-cell"  onclick="toMyHistory()">
				<a class="mui-navigate-right">
					<span class="iconfont icon-time"></span>浏览历史
				</a>
			</li>
			<li class="mui-table-view-cell">
				<a class="mui-navigate-right">
					<span class="iconfont icon-service"></span>服务中心
				</a>
			</li>
		</ul>
		<div class="gap"></div>

<jsp:include page="../common/tabbar.jsp">
	<jsp:param name="tabIndex" value="5"/>
</jsp:include>

	</body>

	<script type="text/javascript">
		mui.init()
		$(function () {
			$("#toSet").click(function () {
						  window.location.href="/user/toSet"
					}
			);
		});

		var userName ="${userSession.userName}"
		$.ajax({
			url: "/user/selectUserByUserName",
			type: "get",
			data: {
				userName
			},
			success: function () {

			}
		})
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

		function toMyPostList() {
			window.location.href="/post/toMyPostList"
		}
		function toFollowUser(){
			window.location.href="/user/toFollowUser"
		}
		function toFans(){
			window.location.href="/user/toFans"
		}
		function toFollowBar(){
			window.location.href="/user/toFollowBar"
		}
		function toUserHome(){
			window.location.href="/user/toUserHome/"+"${userSession.userName}"
		}
		function toMyCollection(){
			window.location.href="/user/toMyCollection/"
		}
		function toMyHistory(){
			window.location.href="/user/toMyHistory/"
		}
	</script>

</html>