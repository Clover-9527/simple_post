package com.itz.dao;

import com.itz.model.PostLike;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

@Repository
public interface PostLikeDao {
    @Update("update post set like_num = like_num+1 ,my_like = 1 where post_id = #{postId}")
    int addLike(PostLike postLike);
    @Insert("insert post_like values(#{userId},#{postId})")
    int insertPostLike(PostLike postLike);


    @Update("update post set like_num = like_num-1 ,my_like = 0 where post_id = #{postId}")
    int delLike(PostLike postLike);
    @Delete("delete from post_like where user_id=#{userId} and post_id = #{postId}")
    int deletePostLike(PostLike postLike);

}
