package com.itz.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itz.util.FileUtils;
import com.itz.model.*;
import com.itz.service.BarService;
import com.itz.service.PostImgService;
import com.itz.service.PostService;
import com.itz.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/post")
public class PostController {
    @Autowired
    private PostService postService;
    @Autowired
    private PostImgService postImgService;
    @Autowired
    private BarService barService;
    @Autowired
    private UsersService usersService;


    @RequestMapping("/toPublish")
    public String toPublish(Model model){
        List<Bar> barList = barService.getBarAll();
        model.addAttribute("barList",barList);
        return "post/publish";
    }

    @RequestMapping("/toMyPostList")
    public String toPostList()
    {
        return "post/postList";
    }

    @RequestMapping("/toBar")
    public String toBar()
    {
        return "enter";
    }

    @GetMapping("/toBarInner/{barId}")
    public String toBarInner(@PathVariable String barId){
        return "bar/barinner";
    }

    @GetMapping("/toPublishtb/{barId}")
    public String toPublishtb(@PathVariable String barId) {
        return "bar/publishtb";
    }

    @GetMapping("/toSearch")
    public String toSearch() {
        return "bar/search";
    }

    @RequestMapping("/toPostInfo/{postId}")
    public String toPostInfo()
    {
        return "post/postInfo";
    }




    // 发布
    @PostMapping("/publish")
    @ResponseBody
    public ApiResult publish(@RequestParam("filename") List<MultipartFile> fileList, Post postVo, HttpSession session){
        Users users = (Users)session.getAttribute("userSession");
        ApiResult apiResult = new ApiResult();
        // 创建一个帖子
        Post post = new Post();
        post.setPostTitle(postVo.getPostTitle());
        post.setContent(postVo.getContent());
        post.setUserId(users.getUserId());
        post.setBarId(postVo.getBarId());
        int result = postService.insertPost(post);

        // 保存图片
        List<String> fileNameList = FileUtils.fileUploadBatch(fileList);
        // 添加帖子图片表
        for (String picName:fileNameList) {
            PostImg postImg = new PostImg();
            postImg.setPicName(picName);
            postImg.setPostId(post.getPostId());
            postImgService.insertPostImg(postImg);
        }
        apiResult.setCode(200);
        return apiResult;
    }
    // 删除帖子
    @GetMapping("deletePost")
    @ResponseBody
    public ApiResult deletePost(Integer postId,HttpSession session){
        Users users = (Users)session.getAttribute("userSession");
        Post post = new Post();
        post.setUserId(users.getUserId());
        post.setPostId(postId);

        int result = postService.deletePost(post);
        if(result>0)
            postService.deleteCollection(post);
        ApiResult apiResult = new ApiResult();
        if(result == 0){
            apiResult.setCode(400);
            apiResult.setMessage("删除失败");
        }
        return apiResult;
    }

    // 更改帖子公开或私密
    @GetMapping("changePostSercet")
    @ResponseBody
    public ApiResult changePostSercet(Integer postId,Integer secret, HttpSession session){
        Users users = (Users)session.getAttribute("userSession");
        Post post = new Post();
        post.setUserId(users.getUserId());
        post.setPostId(postId);
        post.setSecret(secret);

        int result = postService.changePostSercet(post);
        ApiResult apiResult = new ApiResult();
        if(result == 0){
            apiResult.setCode(400);
            apiResult.setMessage("设置失败");
        }
        return apiResult;
    }

    // 获取所有帖子列表
    @GetMapping("getPostList")
    @ResponseBody
    public ApiResult getPostList(Integer pageNum,Integer pageSize,HttpSession session){
        Users user = (Users) session.getAttribute("userSession");

        PageHelper.startPage(pageNum,pageSize); // pageNum当前页码，pageSize每页条数
        List<Post> list = postService.getPostList(user.getUserId());

        PageInfo pageInfo = new PageInfo(list);
        ApiResult apiResult = new ApiResult();
        apiResult.setData(pageInfo);
        return apiResult;
    }

    // 获取我的帖子列表
    @GetMapping("getMyPostList")
    @ResponseBody
    public ApiResult getMyPostList(Integer pageNum,Integer pageSize, String userName,HttpSession session){
        Users user = usersService.findUsersByUserName(userName);
        Post post = new Post();
        post.setUserId(user.getUserId());

        PageHelper.startPage(pageNum,pageSize); // pageNum当前页码，pageSize每页条数
        List<Post> list = postService.getMyPostList(post);
        session.setAttribute("myPostList",list);
        PageInfo pageInfo = new PageInfo(list);
        ApiResult apiResult = new ApiResult();
        apiResult.setData(pageInfo);
        return apiResult;
    }
    // 根据帖子Id获取贴吧信息
    @GetMapping("selectByPostId")
    @ResponseBody
    public Map selectByPostId(Integer postId, HttpSession session){
        Users user = (Users) session.getAttribute("userSession");
        Map postInfo = postService.selectByPostId(postId,user.getUserId());
        session.setAttribute("postInfo",postInfo);
        return postInfo;
    }

    //获取进吧页面信息
    @GetMapping("/getEnterBarInfo")
    @ResponseBody
    public List<Map> getEnterBarInfo(HttpSession session){
        Users user = (Users) session.getAttribute("userSession");
        Integer userId = user.getUserId();
        List<Map> followBarList = usersService.selectFollowBar(userId);
        session.setAttribute("followBarList",followBarList);
        return followBarList;
    }

    // 根据贴吧Id获取帖子列表
    @GetMapping("getBarList")
    @ResponseBody
    public List<Post> getBarList(Integer barId,HttpSession session){
        List<Post> barList = postService.getBarList(barId);
        session.setAttribute("barList",barList);
        return barList;
    }

    // 根据贴吧Id获取贴吧信息
    @GetMapping("getBarInfo")
    @ResponseBody
    public Map getBarInfo(Integer barId, HttpSession session){
        Users user = (Users) session.getAttribute("userSession");
        Map bar = postService.getBarInfo(barId,user.getUserId());
        session.setAttribute("bar",bar);
        return bar;
    }

    //搜索贴吧
    @GetMapping("selectBar")
    @ResponseBody
    public List<Map> selectBar(String barName, HttpSession session){
        List<Map> barInfo = postService.selectBar(barName);
        session.setAttribute("barInfo",barInfo);
        return barInfo;
    }

    //查询帖子图片
    @GetMapping("selectPostImg")
    @ResponseBody
        public List<PostImg> selectPostImg(Integer postId, HttpSession session){
        List<PostImg> postImgList = postService.selectPostImg(postId);
        session.setAttribute("postImgList",postImgList);
        return postImgList;
    }

    //添加历史记录
    @PostMapping("addHistory")
    @ResponseBody
    public void addHistory(Integer postId, HttpSession session){
        Users user = (Users) session.getAttribute("userSession");
        postService.addHistory(postId,user.getUserId());
    }

    //查询是否关注
    @GetMapping("/isFollow")
    @ResponseBody
    public Integer isFollow(Integer barId,HttpSession session) {
        Users user = (Users) session.getAttribute("userSession");
        return postService.isFollow(barId, user.getUserId());
    }

    //查询是否收藏
    @GetMapping("/isCollected")
    @ResponseBody
    public Integer isCollected(Integer postId,HttpSession session) {
        Users user = (Users) session.getAttribute("userSession");
        return postService.isCollected(postId,user.getUserId())>0?1:0;
    }

    //收藏帖子
    @PostMapping("/collectPost")
    @ResponseBody
    public Integer collectPost(Integer postId,HttpSession session) {
        Users user = (Users) session.getAttribute("userSession");
        return postService.collectPost(postId,user.getUserId());
    }

    //删除收藏
    @PostMapping("/delCollect")
    @ResponseBody
    public Integer delCollect(Integer postId,HttpSession session) {
        Users user = (Users) session.getAttribute("userSession");
        return postService.delCollect(postId,user.getUserId());
    }
}