package com.itz.service.impl;

import com.itz.dao.PostImgDao;
import com.itz.model.PostImg;
import com.itz.service.PostImgService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PostImgServiceImpl implements PostImgService {

    @Autowired
    private PostImgDao postImgDao;

    @Override
    public int insertPostImg(PostImg postImg) {
        return postImgDao.insertPostImg(postImg);
    }
}
