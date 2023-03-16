<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<meta name="viewport"
			content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<link href="/fonts/iconfont.css" rel="stylesheet" />
		<link href="/css/publish.css" rel="stylesheet" />
		<link href="/css/mui.css" rel="stylesheet" />
		<link href="/css/common.css" rel="stylesheet" />
	</head>

	<style>
		#postTitle{
			margin-left: 5px;
			line-height: 40px;
		}
	</style>
	<body>
		<div class="myinfo" style="display: flex;justify-content: space-between;">
			<div  style="margin-top: 20px;margin-left: 20px;">
				<a href="/post/toBarInner/${bar.barId}" style="text-decoration: none;"><span class="iconfont icon-close" style="font-size: 28px;"></span></a>
			</div>
			<div  style="margin-top: 20px;">发布到${bar.barName}吧</div>
			<div  style="margin-right: 20px;margin-top: 20px;color: #3b8aff;" id="save">
				<button class="mui-btn mui-btn-blue mui-btn-link mui-pull-right" onclick="publish()">发布</button>
			</div>
		</div>


		<div class="mui-content">
			<form class="my-form" method="post" enctype="multipart/form-data">
				<input type="hidden" name="barId" value="${bar.barId}">
				<div class="mui-input-group">
					<div class="mui-input-row">
						<input pype="text" id="postTitle" name="postTitle" placeholder="加一个标题呦~" />
					</div>
				</div>

				<div class="mui-input-row" style="margin: 10px 5px;">
					<textarea id="content" name="content" rows="5" placeholder="填写帖子内容..."></textarea>
				</div>
				<div style="margin-left: 10px;">添加图片</div>
				<p id='upload'>
					<a class='pro_img' id='a1' >
						<input type='file' id='file1'  accept='image/*' multiple='multiple' name='filename' onchange='t1(1)'/>
						<img class='pic' src="/images/upload.png" id='img1'>
						<img id='close1' onclick="closePic(event,1)" class='img-close' style='display:none;' src='/images/close.png'>
					</a>
					<img id='hidden1' style='display:none;'>
				<div style="clear: both;"></div>
				</p>

			</form>
		</div>

	</body>


	<script src="/js/mui.js"></script>
	<script src="/js/jquery-3.4.1.min.js"></script>
	<script type="text/javascript">
		mui.init()

		var picNum = 9; // 最多选择图片数
		var name_pic=1;
		function t1(o){

			if(o==1 || name_pic!=1){
				var file="file"+o;
				var img="img"+o;
				var hid="hidden"+o;
				var aa="a"+o;
				var close="close"+o;
			}else{
				var file="file"+name_pic;
				var img="img"+name_pic;
				var hid="hidden"+name_pic;
				var aa="a"+name_pic;
				var close="close"+name_pic;
			}
			var docObj = document.getElementById(file);
			var imgObjPreview = document.getElementById(img);
			var hidden=document.getElementById(hid);
			// alert(hidden);
			if (docObj.files && docObj.files[0]) {
				hidden.src=window.URL.createObjectURL(docObj.files[0]); //获取file文件的路径
				$("#"+close).show();
				hidden.onload=function(){
					var width=hidden.width;
					var height=hidden.height;
					var a=document.getElementById(aa);
					if(width>height){
						imgObjPreview.style.cssText='width:100%';   //重写css样式
					}else{
						imgObjPreview.style.cssText='height:100%;width:auto;';
					}
					imgObjPreview.src = window.URL.createObjectURL(docObj.files[0]);
					imgObjPreview.style.display = 'block';
				}
			}else{
				return false;
			}
			if(o==name_pic){
				addImg();
			}
		}

		// 添加图片样式
		function addImg(){
			var count=$('.pro_img').length;
			if(count<picNum){
				name_pic++;
				var pic_p="<a class='pro_img' id='a"+name_pic+"' ><input type='file' id='file"+name_pic+"'  accept='image/*' multiple='multiple' name='filename' onchange='t1("+name_pic+")'/><img class='pic' src='/images/upload.png' id='img"+name_pic+"'><img id='close"+name_pic+"' style='display:none;' class='img-close' src='/images/close.png' onclick='closePic(event,"+name_pic+")'></a><img  id='hidden"+name_pic+"' style='display:none;'>";
				$('#upload').append(pic_p);
			}
		}


		function closePic(e,index){
			e.stopPropagation();
			var count=$('.img-close:visible').length;
			$("#a"+index).remove();
			if(count==9){
				addImg();
			}
		}

		// 发布
		function publish() {
			var barId = ${bar.barId}

			if($("#postTitle").val() == ""){
				mui.alert("请填写标题");
				return;
			}

			var content = $("#content").val();
			if(content == "" || content == undefined){
				mui.alert("请填写内容");
				return;
			}

			var formData = new FormData($('form')[0]);
			$.ajax({
				url:"/post/publish",
				type:"post",
				data: formData,
				contentType:false,
				processData:false,
				success:function (res) {
					if(res.code == 200){
						mui.alert('发布成功！', '提示', function() {
							window.location.href="/post/toBarInner/"+${bar.barId};
						});

					}else{
						mui.alert(res.message);
					}
				}
			})
		}
	</script>

</html>
