<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<meta name="viewport"
			content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link href="/fonts/iconfont.css" rel="stylesheet" />
		<style>
			.avatar{
				position: relative;
				width: 100px;
				height: 120px;
			}
			#img_1{
				position: absolute;
				top: 20px;
				left: 140%;
				width: 100px;
				height: 100px;
			}
			.inputFile{
				position: absolute;
				top: 20px;
				left: 140%;
				width: 100px;
				height: 100px;
				opacity: 0;
			}
			.uploadbtn{
				position: absolute;
				top: 130px;
				left: 145%;
			}
			.file-img{
				max-width: 100px;
			}
			#img_2{
				position: absolute;
				top: 88px;
				left: 210px;
				width: 50px;
				height: 50px;
			}
		</style>


	</head>

	<body style="background-color: #ffffff;">
		<div class="myinfo" style="display: flex;justify-content: space-between;">
			<div  style="margin-top: 20px;margin-left: 20px;">
				<a href="/user/toSet" style="text-decoration: none;"><span class="iconfont icon-close" style="font-size: 28px;"></span></a>
			</div>
			<div  style="margin-top: 20px;">我的资料</div>
			<div  style="margin-right: 20px;margin-top: 20px;color: #3b8aff;" id="save">
				保存
			</div>
		</div>
		<%--修改资料--%>
		<form action="/file/avatarUpload" method="post" id="#avatarform" enctype="multipart/form-data" onsubmit="return formSubmit()">
			<%--上传头像--%>
			<div class="avatar">
					<c:choose>
						<c:when test="${empty userSession.avatar}">
							<img id="img_1" class="file-img" src="/images/default.jpg">
							<img id="img_2" src="/images/camera.png">
						</c:when>
						<c:otherwise>
							<img id="img_1" class="file-img" src="/filePath/${userSession.avatar}">
							<img id="img_2" src="/images/camera.png">
						</c:otherwise>
					</c:choose>
					<input id="inputFile1" class="inputFile" type="file" name="filename" multiple="multiple"   onchange="changeImg(this,1)"/>
<%--				<input type="submit" class="uploadbtn" id="submitBtn" value="上传头像" />--%>
			</div>
			<%--修改信息--%>
			<div id="updateInfo" style="padding: 30px">
				<div style="margin: 30px 0;">
					<span style="margin-left: 30px;margin-right: 40px;color: #b1b1b1;font-family: '黑体';">用户名</span>
					<span style="color: #b1b1b1;">${userSession.userName}</span>
				</div>
				<div style="margin-bottom: 30px;">
					<span style="margin-left: 30px;margin-right: 60px;color: #b1b1b1;font-family: '黑体';">昵称</span>
					<input type="text" value="${userSession.nickName}" style="border: 0" name="nickName">
				</div>
				<div style="margin-bottom: 30px;">
					<span style="margin-left: 30px;margin-right: 60px;color: #b1b1b1;font-family: '黑体';">性别</span>
					<select name="gender"  value="${userSession.gender}">
						<option value="1" <c:if test="${ userSession.gender eq '1' }">selected</c:if> >男</option>
						<option value="2" <c:if test="${ userSession.gender eq '2' }">selected</c:if> >女</option>
					</select>
				<%--					<input type="text" value="${userSession.gender}" name="gender" style="border: 0">--%>
				</div>
				<div style="margin-bottom: 30px;">
					<span style="margin-left: 30px;margin-right: 30px;color: #b1b1b1;font-family: '黑体';">个性签名</span>
					<input type="text" value="${userSession.signature}" name="signature" style="border: 0;" >
				</div>
					<input type="hidden" name="avatar" value="/filePath/${userSession.avatar}">
			</div>
		</form>

	</body>

	<script src="/js/jquery-3.4.1.min.js"></script>
	<script type="text/javascript">
		function formSubmit() {
			var val = document.getElementById("inputFile1").value;
			if(val == null || val == ""){
				return false;
			}else{
				return true;
			}
		}


		function changeImg(file,index){
			var reader = new FileReader();    // 实例化一个FileReader对象，用于读取文件
			var img = document.getElementById('img_'+index);     // 获取要显示图片的标签
			//读取File对象的数据
			reader.onload = function(evt){
				img.src = evt.target.result;
			}
			reader.readAsDataURL(file.files[0]);
		}


		$("#submitBtn").click(function () {
			$.ajax({
				url:"/user/updateUser",
				type:"post",
				data:$("form").serialize(),
				success:function (res) {
					if(res.code == 200){
						window.location.href = "/user/toSet";
					}else{
						alert(res.message);
					}
				}
			})
		});

		$("#save").click(function () {
			var formData = new FormData($('form')[0]);
			$.ajax({
				url:"/user/updateUser",
				type:"post",
				data: formData,
				contentType : false,
				processData : false,
				success:function (res) {
					if(res.code == 200){
						alert("修改成功!");
							window.location.href = "/user/toSet";
					}else{
							alert(res.message);
						}
					}
			})
		});


	</script>

</html>
