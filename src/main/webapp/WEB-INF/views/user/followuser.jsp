<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<head>
    <meta charset="utf-8">
    <title></title>
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <link href="/css/mui.css" rel="stylesheet"/>
    <link href="/css/my.css" rel="stylesheet"/>
    <link href="/fonts/iconfont.css" rel="stylesheet"/>
	<script src="/js/jquery-3.4.1.min.js"></script>

</head>
<style>
    .tab {
        display: flex;
        justify-content: space-between;
        padding: 2px 20px;
    }

    .tab span {
        font-size: 15px;
        color: #ababab;
    }

    .tabimg {
        border-radius: 50%;
        margin: 10px 20px 0 20px;
    }

    .followlist {
        display: flex;

    }

    .followinfo {
        display: flex;
        flex-direction: column;
        margin-top: 18px;
        width: 50%;
    }

    .fbtn {
        width: 80px;
        height: 40px;
        margin-top: 12px;
		margin-left: 13px;
		background-color: #ffffff;
		border: 1px solid #b39090;
    }
</style>

<body>
<header id="header" class="mui-bar mui-bar-nav">
    <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left" onclick="toMy()"></a>
    <h1 class="mui-title">我关注的人</h1>
</header>
<div style="height: 50px;"></div>
<div class="tab"><span>全部关注</span><span>全部关注</span></div>

<c:forEach items="${followList}" var="user" >
    <div class="followlist">
        <c:choose>
            <c:when test="${empty user.avatar}">
                <img  width="50px" height="50px" class="tabimg" src="/images/default.jpg">
            </c:when>
            <c:otherwise>
                <img src="/filePath/${user.avatar}" width="50px" height="50px" class="tabimg">
            </c:otherwise>
        </c:choose>

        <div class="followinfo">
            <span style="font-size: 15px;"><b>${user.nickName}</b></span>
            <span style="font-size: 10px;color: #ababab;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">${user.signature}</span>
        </div>
        <button class="fbtn" id="fbtn${user.userId}" onclick="follow(${user.userId})" >已关注</button>
    </div>
</c:forEach>


<div style="border-bottom: 1px solid #f5f5f5;margin: 10px 10px 0 10px;"></div>

<div style="height: 60px;background-color: #f5f5f5;padding-top: 20px;">
    <span style="padding:45px;color: #b7b7b7;">你已经碰到我的底线了(๑•_•๑)</span>
</div>


</body>

<script src="/js/mui.js"></script>
<script type="text/javascript">
	function follow(fuId){
		var status=0;
		var v =$("#fbtn"+fuId).text();

		if(v=="已关注") {
			$("#fbtn"+fuId).text("关注");
			status=1;
		}else{
			$("#fbtn"+fuId).text("已关注");
			status=0;
		}

		$.ajax({
			url: "/user/follow",
			type: "post",
			data: {
				fuId, status
			},
			success:function () {
			}
		})
	}

	window.onload=function(){
		$.ajax({
			url:"/user/selectFollow",
			type:"get",
			success:function (res) {
				// window.location="/user/toFollowUser";
			}
		})
	}


    function toMy(){
        window.location="/user/toMy"
    }
	reurl();
	function reurl(){
		url = location.href; //把当前页面的地址赋给变量 url
		var times = url.split("?"); //分切变量 url 分隔符号为 "?"
		if(times[times.length-1] != 1){ //如果?后的值不等于1表示没有刷新
			url += "?1"; //把变量 url 的值加入 ?1
			setTimeout(function(){
				self.location.replace(url); //刷新页面
			},100)
		}
	}


</script>


</html>
