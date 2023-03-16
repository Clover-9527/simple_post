package com.itz.controller;


import com.itz.model.*;
import com.itz.service.PostLikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/post-like")
public class PostLikeController {
    @Autowired
    private PostLikeService postLikeService;

    // 点赞
    @PostMapping("addPostLike")
    @ResponseBody
    public ApiResult addPostLike(Integer postId,HttpSession session){
        Users users = (Users)session.getAttribute("userSession");
        PostLike postLike = new PostLike();
        postLike.setUserId(users.getUserId());
        postLike.setPostId(postId);

        int result = postLikeService.insertPostLike(postLike);
        ApiResult apiResult = new ApiResult();
        if(result == 0){
            apiResult.setCode(400);
            apiResult.setMessage("点赞失败");
        }
        return apiResult;
    }

    // 取消
    @PostMapping("deletePostLike")
    @ResponseBody
    public ApiResult deletePostLike(Integer postId,HttpSession session){
        Users users = (Users)session.getAttribute("userSession");
        PostLike postLike = new PostLike();
        postLike.setUserId(users.getUserId());
        postLike.setPostId(postId);

        int result = postLikeService.deletePostLike(postLike);
        ApiResult apiResult = new ApiResult();
        if(result == 0){
            apiResult.setCode(400);
            apiResult.setMessage("取消赞失败");
        }
        return apiResult;
    }
}
