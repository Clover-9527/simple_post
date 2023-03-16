package com.itz.service.impl;

import com.itz.dao.PostLikeDao;
import com.itz.model.PostLike;
import com.itz.service.PostLikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PostLikeServiceImpl implements PostLikeService {

    @Autowired
    private PostLikeDao postLikeDao;

    @Transactional
    @Override
    public int insertPostLike(PostLike postLike) {
        int a = postLikeDao.addLike(postLike);
        if(a>0){
           return postLikeDao.insertPostLike(postLike);
        }
        return 0;
    }

    @Transactional
    @Override
    public int deletePostLike(PostLike postLike) {
        int b =postLikeDao.delLike(postLike);
        if(b>0){
            return postLikeDao.deletePostLike(postLike);
        }
        return 0;
    }
}
