<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

	<head>
		<meta charset="utf-8">
		<title></title>
		<meta name="viewport"
			content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link href="/css/mui.css" rel="stylesheet" />
		<link href="/css/setting.css" rel="stylesheet" />
		<link href="/fonts/iconfont.css" rel="stylesheet" />
	</head>

	<body>
		<header id="header" class="mui-bar mui-bar-nav">
			<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" href="/user/toMy"></a>
			<h1 class="mui-title">设置</h1>
		</header>
			<div style="height: 70px;"></div>
		
		<ul class="mui-table-view mui-table-view-chevron">
			<li class="mui-table-view-cell">
				<a href="#account" class="mui-navigate-right">账号与安全</a>
			</li>
		</ul>

		<ul class="mui-table-view mui-table-view-chevron">
			<li class="mui-table-view-cell" style="position: relative;" >
				<a href="/user/toUserInfo" class="mui-navigate-right">
					个人资料
				<span  style="position: absolute;right: 40px;top: 5px;">
					<c:choose>
						<c:when test="${empty userSession.avatar}">
							<img class="avatar"  src="/images/default.jpg" width="30px" height="30px">
						</c:when>
						<c:otherwise>
							<img src="/filePath/${userSession.avatar}" width="30px" height="30px">
						</c:otherwise>
					</c:choose>

				</span>
				</a>
				<div style="width: 115%; border-bottom: 1px solid #d2d2d2;margin: 10px 0;"></div>
				<a href="#" class="mui-navigate-right">
					账号管理
				</a>
			</li>
		</ul>

		<ul class="mui-table-view mui-table-view-chevron">
			<li class="mui-table-view-cell">
				<a href="#" class="mui-navigate-right">	<span>浏览设置</span> <span class="r">图片显示、字号等</span></a>
				<div style="width: 115%; border-bottom: 1px solid #d2d2d2;margin: 10px 0;"></div>
				<a href="#" class="mui-navigate-right">消息提醒</a>
				<div style="width: 115%; border-bottom: 1px solid #d2d2d2;margin: 10px 0;"></div>
				<a href="#" class="mui-navigate-right">隐私设置</a>
				<div style="width: 115%; border-bottom: 1px solid #d2d2d2;margin: 10px 0;"></div>
				<a href="#" class="mui-navigate-right">辅助功能</a>
			</li>
		</ul>
		
		<ul class="mui-table-view mui-table-view-chevron">
			<li class="mui-table-view-cell">
				<a href="#account" class="mui-navigate-right"><span>版本信息</span><span class="r">9.1.0.0</span></a>
				<div style="width: 115%; border-bottom: 1px solid #d2d2d2;margin: 10px 0;"></div>
				<a href="#account" class="mui-navigate-right">意见反馈</a>
				<div style="width: 115%; border-bottom: 1px solid #d2d2d2;margin: 10px 0;"></div>
				<div style="height: 30px;display: flex;justify-content: center;">
					<a href="/user/logout" style="line-height: 35px;">退出</a>
				</div>
			</li>
		</ul>
	</body>
</html>
