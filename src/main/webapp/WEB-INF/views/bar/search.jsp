<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <title></title>
    <script src="/js/mui.min.js"></script>
    <link href="/css/mui.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/fonts/iconfont.css">
    <link rel="stylesheet" href="/css/search.css">
    <script type="text/javascript" charset="utf-8">
        mui.init();
    </script>
</head>

<body>
<div style="height: 20px;"></div>

<div class="topsearch" style="margin-left: 10px">
    <div class="mui-input-row mui-search searchinput">
        <input type="search" class="mui-input-clear" placeholder="大家都在搜: 世界杯"
               style=" white-space: nowrap; overflow: hidden;text-overflow: ellipsis;" id="searchinput">
    </div>
    <a href="/post/toBar" class="cancel">取消</a>
</div>

<div id="rank">

    <div class="hotsearchrank" style="margin-top: 20px">
        <img src="/images/hotsearch.jpg" style="width: 60px;margin: 0px 0 0 10px;">
        <span>热吧榜</span>
        <span>热搜榜</span>
    </div>

    <div class="list">
        <div class="rank">
            <span>1</span>
        </div>
        <span style="margin: 10px 10px 0px 10px;">S12赛程</span>
        <div style="margin: 10px 10px 0px 0;background-color: #ff392c;border-radius:30px/50px; padding: 1px;">热</div>
        <span style="margin-top: 10px;text-align: right;">509.1w</span>
    </div>
    <div class="list">
        <div class="rank">
            <span>2</span>
        </div>
        <span style="margin: 10px 10px 0px 10px;">S12赛程</span>
        <div style="margin: 10px 10px 0px 0;background-color: #ff392c;border-radius:30px/50px; padding: 1px;">热</div>
        <span style="margin-top: 10px;text-align: right;">509.1w</span>
    </div>
    <div class="list">
        <div class="rank">
            <span>3</span>
        </div>
        <span style="margin: 10px 10px 0px 10px;">S12赛程</span>
        <div style="margin: 10px 10px 0px 0;background-color: #ff392c;border-radius:30px/50px; padding: 1px;">热</div>
        <span style="margin-top: 10px;text-align: right;">509.1w</span>
    </div>
    <div class="list">
        <div class="rank">
            <span>4</span>
        </div>
        <span style="margin: 10px 10px 0px 10px;">S12赛程</span>
        <div style="margin: 10px 10px 0px 0;background-color: #ff392c;border-radius:30px/50px; padding: 1px;">热</div>
        <span style="margin-top: 10px;text-align: right;">509.1w</span>
    </div>
</div>

<div id="result"></div>
</body>


<script src="/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
    $(".resultbg").hide()
    $("#searchinput").keydown(function (event) { //监听键盘按下时的事件
        if (event.code == "Enter" || event.code == "NumpadEnter") {
            if( $("#result").children().length!=0)
                $("#result").children().remove();
            var barName = $("#searchinput").val();
            $.ajax({
                url: "/post/selectBar",
                type: "get",
                data: {barName},
                success: function (data) {
                    $("#rank").remove();
                    $(".resultbg").show()
                   if(data[0].barName==null){
                       return;
                   }

                    for (let i = 0; i < data.length; i++) {
                        let str = `<div class="resultbg" onclick="toBarInner(`+ data[i].barID+`)">
                        <div><img src="/filePath/` + data[i].picName + `" class="resultimg"/></div>
                        <div class="resultinfo">
                            <span class="resulttitle">` + data[i].barName + `吧</span>
                            <span style="color:#7b91b0">关注` + data[i].likeNum + `  &nbsp;&nbsp;&nbsp;帖子` + data[i].postNum + ` </span>
                        </div>
                        <input id="barId" type="hidden" value="`+ data[i].barID+`">
                        <div>
                             <button class="likebtn" id="fbtn" onclick="follow(`+ data[i].barID+`)" >关注</button>
                        </div>
                    </div> `;
                        $("#result").append(str);

                        var status=0;
                        $.ajax({
                            url: "/post/isFollow",
                            type: "get",
                            data: {
                                barId:$('#barId').val(),status
                            },
                            success: function (res) {
                                if (res == 1) {
                                    status = 1;
                                    $("#fbtn").text("已关注");
                                } else {
                                    status = 0;
                                    $("#fbtn").text("关注");
                                }
                            }
                        })
                    }
                }
            })

        }
    });






    //进入贴吧
    function toBarInner(barId) {
        var v =$("#fbtn").text();
        if(v=="关注"){
            alert("未关注!")
            return;
        }
        var barId = barId;
        window.location = "/post/toBarInner/" + barId;
    }

    //关注贴吧
    function follow(barId){
        var v =$("#fbtn").text();

        if(v=="已关注") {
            $("#fbtn").text("关注");
            status=1;
        }else{
            $("#fbtn").text("已关注");
            status=0;
        }

        $.ajax({
            url: "/user/followbar",
            type: "post",
            data: {
                barId, status
            },
            success:function () {
            }
        })
    }

    function reurl() {
        url = location.href; //把当前页面的地址赋给变量 url
        var times = url.split("?"); //分切变量 url 分隔符号为 "?"
        if (times[times.length - 1] != 1) { //如果?后的值不等于1表示没有刷新
            url += "?1"; //把变量 url 的值加入 ?1
            setTimeout(function () {
                self.location.replace(url); //刷新页面
            }, 100)
        }
    }

</script>
</html>
