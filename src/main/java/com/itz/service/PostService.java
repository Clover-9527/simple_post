package com.itz.service;

import com.itz.model.Post;
import com.itz.model.PostImg;

import java.util.List;
import java.util.Map;

public interface PostService {
    int insertPost(Post post);

    List<Post> getPostList(Integer userId);

    List<Post> getMyPostList(Post post);

    List<Post> getBarList(Integer barId);

    Map getBarInfo(Integer barId,Integer userId);

    int deletePost(Post post);

    int changePostSercet(Post post);

    void addHistory(Integer postId, Integer userId);

    List<Map> selectBar(String barName);

    Map selectByPostId(Integer postId, Integer userId);

    List<PostImg> selectPostImg(Integer postId);

    Integer isFollow(Integer barId, Integer userId);

    int deleteCollection(Post post);

    int isCollected(Integer postId, Integer userId);

    Integer collectPost(Integer postId, Integer userId);

    Integer delCollect(Integer postId, Integer userId);
}
