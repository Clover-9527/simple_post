<%--
  Created by IntelliJ IDEA.
  User: TF
  Date: 2022/10/10
  Time: 14:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>
    <meta charset="utf-8">
    <title></title>
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <link href="/css/mui.css" rel="stylesheet" />
    <link href="/css/common.css" rel="stylesheet" />
    <link href="/css/register.css" rel="stylesheet" />
    <link href="/fonts/iconfont.css" rel="stylesheet" />
</head>

<body>
<div class="container">
    <header id="header" class="mui-bar mui-bar-nav">
        <a class="mui-action-back mui-icon mui-icon-left-nav mui-pull-left"></a>
        <h1 class="mui-title">注册</h1>
    </header>
    <div class="content">
        <div class="title">欢迎注册账号</div>
        <form>
            <div class="mui-input-row">
                <input type="text" id="username" name="userName" class="mui-input-clear" maxlength="20" placeholder="请输入手机号/用户名/邮箱">
                <span id="usernameMsg" style="color: red;display: none">用户名已存在！</span>
            </div>
            <div class="mui-input-row mui-password">
                <input type="password" id="password" name="password" class="mui-input-password" maxlength="20" placeholder="请输入登录密码">
            </div>
            <div class="mui-input-row">
                <input type="text" id="nickName" name="nickName" class="mui-input-clear" maxlength="20" placeholder="请输入昵称">
            </div>
            <div class="login-box">
                <button type="button" id="btnRegister" class="mui-btn mui-btn-primary mui-btn-block login-btn opacity-04">立即注册</button>
            </div>

            <div class="agreement">
                <div class="mui-input-row mui-checkbox mui-left">
                    <input id="agreementbox" name="checkbox" value="Item 1" type="checkbox" >
                    <label>请您阅读并同意<span>用户协议</span>和<span>隐私政策</span></label>
                </div>
            </div>
        </form>
    </div>

</div>

<script src="/js/mui.js"></script>
<script src="/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
    mui.init()
    var checkBoxValue = false;
    var userNameExist = false;
    $(function(){

        $("#username,#password,#nickName").on("keyup",function(){
            checkBtn()
        });

        $("#username").on("blur",function(){
            checkBtn()
            // 判断用户名是否已存在
            $.ajax({
                url:"/user/userNameExist",
                type:"get",
                data:{
                    userName:$("#username").val()
                },
                success:function (res) {
                    if(res.code == 200){
                        // 用户名已存在
                        if(res.data==1){
                            $("#usernameMsg").show();
                            userNameExist = true;
                        }else{
                            $("#usernameMsg").hide();
                            userNameExist = false;
                        }
                    }

                }
            })

        });

        // 判断登录按钮是否可点击
        function checkBtn(){
            if($("#username").val()!="" && $("#password").val()!="" && $("#nickName").val()!="" && checkBoxValue){
                $("#btnRegister").removeClass('opacity-04')
            }else{
                $("#btnRegister").addClass('opacity-04')
            }
        }

        mui('.agreement').on('change', 'input', function() {
            checkBoxValue = this.checked?true:false;
            checkBtn();
        });

        // 点击注册按钮
        $("#btnRegister").click(function () {
            if(!$("#agreementbox").is(':checked')){
                mui.alert("请先勾选用户协议！");
                return;
            }
            // 用户已存在
            if(userNameExist){
                return;
            }

            $.ajax({
                url:"/user/register",
                type:"post",
                data:$("form").serialize(),
                success:function (res) {
                    if(res.code == 200){
                        mui.alert('注册成功！去登录', '提示', function() {
                            window.location.href = "/user/toLogin";
                        });
                    }else{
                        mui.alert(res.message);
                    }

                }
            })
        });
    });

</script>
</body>

</html>
