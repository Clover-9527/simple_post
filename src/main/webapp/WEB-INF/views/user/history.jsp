<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<meta name="viewport"
			content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link href="/fonts/iconfont.css" rel="stylesheet" />
		<link href="/css/mui.css" rel="stylesheet" />
		<link href="/css/common.css" rel="stylesheet" />
	</head>

	<style>

	</style>
	<body style="background-color:#fff;">
	<div class="myinfo" style="display: flex;justify-content: space-between;height: 50px">
		<div  style="margin-top: 20px;margin-left: 10px;">
			<a href="/user/toMy" style="text-decoration: none;"><span class="iconfont icon-back" style="font-size: 31px;color: #333"></span></a>
		</div>
		<div  style="margin-top: 20px;font-size: 20px;color: #333333">浏览历史</div>
		<div  style="margin-right: 20px;margin-top: 10px;" >
			<button style="font-size: 22px;color: #333333" id="clearbtn" class="mui-btn mui-btn-blue mui-btn-link mui-pull-right">清空</button>
		</div>
	</div>

	<div class="historyList">
		<c:forEach items="${historyList}" var="list" >
            <div style="border-bottom: 1px solid #ebebeb;margin-top: 6px"> </div>
			<div style="margin: 10px 5px"><span style="font-family: '黑体'; font-size: 25px;">${list.postTitle}</span></div>
			<div style="display: flex;justify-content: space-between;margin: 0 10px; ">
				<span style="color: #9c9c9c;font-size: 18px">${list.barName}</span>

				<span style="color: #9c9c9c;margin-right: 10px">
                    <fmt:parseDate value="${list.createTime}" pattern="yyyy-MM-dd HH:mm:ss" var="receiveDate" />
                    <fmt:formatDate value="${receiveDate}"  type="time" timeStyle="short"/>
                </span>
			</div>
            <div style="border-bottom: 1px solid #ebebeb;margin-top: 6px"> </div>
		</c:forEach>
	</div>
	</body>

	<script src="/js/mui.js"></script>
	<script src="/js/jquery-3.4.1.min.js"></script>
	<script type="text/javascript">
		mui.init()

        //清空浏览历史
        $("#clearbtn").click(function () {
            if(confirm("确定清空吗？"))
            {
                $.ajax({
                    url:"/user/clearHistory",
                    type:"get",
                    success:function (res) {
                        if(res=="success") {
                            location.reload()
                        }
                    }
                })
            }

        })

		//查询浏览历史
		$.ajax({
			url:"/user/selectHistory",
			type:"get",
			data:{status:0},
			success:function (res) {
				reurl();
			}
		})


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
