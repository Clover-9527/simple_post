package com.itz.service.impl;

import com.itz.dao.PostDao;
import com.itz.dao.PostImgDao;
import com.itz.model.Post;
import com.itz.model.PostImg;
import com.itz.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class PostServiceImpl implements PostService {

    @Autowired
    private PostDao postDao;
    @Autowired
    private PostImgDao postImgDao;

    @Override
    public int insertPost(Post post) {
        return postDao.insertPost(post);
    }

    @Override
    public List<Post> getPostList(Integer userId) {
        return postDao.getPostList(userId);
    }

    @Override
    public List<Post> getMyPostList(Post post) {
        return postDao.getMyPostList(post);
    }

    @Override
    public List<Post> getBarList(Integer barId) {
        return postDao.getBarList(barId);
    }

    @Override
    public Map getBarInfo(Integer barId, Integer userId) {
        return postDao.getBarInfo(barId,userId);
    }

    @Override
    @Transactional
    public int deletePost(Post post) {
        int result = postDao.deletePost(post);
        if(result>0){
            postImgDao.deletePostImg(post.getPostId());
        }
        return result;
    }

    @Override
    public int changePostSercet(Post post) {
        return postDao.changePostSercet(post);
    }

    @Override
    public void addHistory(Integer postId, Integer userId) {
        int isInsert = postDao.isInsert(postId,userId);
        if(isInsert==0){
            postDao.addHistory(postId,userId);
        }
    }

    @Override
    public List<Map> selectBar(String barName) {
        return postDao.selectBar(barName);
    }

    @Override
    public Map selectByPostId(Integer postId, Integer userId) {
        return postDao.selectByPostId(postId,userId);
    }

    @Override
    public Integer delCollect(Integer postId, Integer userId) {
        return postDao.delCollect(postId,userId);
    }

    @Override
    public Integer collectPost(Integer postId, Integer userId) {
        return postDao.collectPost(postId,userId);
    }

    @Override
    public int isCollected(Integer postId, Integer userId) {
        return postDao.isCollected(postId,userId);
    }

    @Override
    public int deleteCollection(Post post) {
        return postDao.deleteCollection(post);
    }

    @Override
    public Integer isFollow(Integer barId, Integer userId) {

        return postDao.isFollow(barId,userId)>0?1:0;
    }

    @Override
    public List<PostImg> selectPostImg(Integer postId) {
        return postDao.selectPostImg(postId);
    }
}
