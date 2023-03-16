package com.itz.dao;

import com.itz.model.PostImg;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.springframework.stereotype.Repository;

@Repository
public interface PostImgDao {
    @Insert("insert into post_img(pic_name,post_id) values(#{picName},#{postId})")
    int insertPostImg(PostImg postImg);

    @Delete("delete from post_img where post_id =#{postId}")
    int deletePostImg(Integer postId);
}
