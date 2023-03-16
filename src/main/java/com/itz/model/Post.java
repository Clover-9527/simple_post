package com.itz.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Post {
    private Integer postId;
    private String postTitle;
    private String content;
    private Integer barId;
    private String PicName;
    private Integer userId;
    private String createTime;
    private String barName;
    private Integer secret;
    private List<PostImg> postImgList;
    private Integer likeNum; // 点赞数
    private Integer myLike; // 我是否点赞  0-未点赞，1-已点赞
    private Users postUser;


}
