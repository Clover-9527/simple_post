<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>

	<head>
		<meta charset="utf-8">
		<title></title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link href="/css/mui.css" rel="stylesheet" />
		<link href="/css/common.css" rel="stylesheet" />
		<link href="/css/login.css" rel="stylesheet" />
		<link href="/fonts/iconfont.css" rel="stylesheet" />

	</head>

	<body>
		<div class="container">
			<header id="header" class="mui-bar mui-bar-nav">
				<a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
				<h1 class="mui-title">账号密码登录</h1>
			</header>
			<div class="content">
				<div class="title">登录账号 精彩永相随</div>
				<form method="post">
					<div class="mui-input-row">
						<input value="u1" type="text" name="userName" id="userName" class="mui-input-clear" maxlength="30" placeholder="请输入手机号/用户名/邮箱">
					</div>
					<div class="mui-input-row mui-password">
						<input value="1"  type="password" name="password" id="password" class="mui-input-password" maxlength="20" placeholder="请输入登录密码">
					</div>
					<div class="text-link">
						<div>更换设备登录</div>
						<div>忘记密码</div>
					</div>
					<div class="login-box">
						<button type="button" id="btnLogin" class="mui-btn mui-btn-primary mui-btn-block login-btn opacity-04">登 录</button>
					</div>
				</form>
			</div>
			<div class="bottom-link">
				<div class="text-box">
					<span class="text">换个账号</span>
					<span class="gap"></span>
					<span class="text" id="toRegister">注册</span>
					<span class="gap"></span>
					<span class="text">帮助</span>
				</div>
			</div>
		</div>
		
		<script src="/js/mui.js"></script>
		<script src="/js/jquery-3.4.1.min.js"></script>
		<script type="text/javascript">
			mui.init()
			$(function(){
				$("#username,#password").on("keyup",function(){
					checkBtn()
				});
				
				$("#username").on("blur",function(){
					checkBtn()
				});
				
				// 判断登录按钮是否可点击
				function checkBtn(){
					if($("#username").val()!="" && $("#password").val()!=""){
						$("#btnLogin").removeClass('opacity-04')
					}else{
						$("#btnLogin").addClass('opacity-04')
					}
				}

			});
			$("#btnLogin").click(function () {
				   // mui.alert("点击了按钮");
				$.ajax({
					url:"/user/login",
					type:"post",
					// data: {
					// 	userName: $("#userName").val(),
					// 	password: $("#password").val()
					// },
					data:$("form").serialize(),
					success:function (res) {
						if(res.code == 200){
							window.location.href = "/user/toMy";
						}else{
							alert(res.message);
						}

					}
				})

			});
			// 去注册页面
			$("#toRegister").click(function () {
				window.location.href="/user/toRegister";
			});

		</script>
	</body>

</html>