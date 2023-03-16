package com.itz.dao;

import com.itz.model.Post;
import com.itz.model.PostImg;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface PostDao {
    int insertPost(Post post);

    List<Post> getPostList(@Param("userId") Integer userId);

    List<Post> getMyPostList(Post post);

    List<Post> getBarList(Integer barId);

    Map getBarInfo(@Param("barId") Integer barId,@Param("userId") Integer userId);

    @Delete("delete from post where post_id =#{postId} and user_id=#{userId}")
    int deletePost(Post post);

    @Update("update post set secret = #{secret} where post_id =#{postId} and user_id=#{userId}")
    int changePostSercet(Post post);

    List<Map> selectBar(String barName);

    Map selectByPostId(@Param("postId") Integer postId,@Param("userId")  Integer userId);

    List<PostImg> selectPostImg(Integer postId);

    @Select("select count(*) from history where post_id=#{postId} and user_id=#{userId} ")
    int isInsert(@Param("postId") Integer postId, @Param("userId")  Integer userId);

    @Insert("insert into history values(null,#{postId},#{userId},now())")
    void addHistory(@Param("postId") Integer postId, @Param("userId") Integer userId);

    @Select("select count(*) from follow_bar where bar_id=#{barId} and user_id=#{userId}")
    Integer isFollow(@Param("barId") Integer barId,@Param("userId") Integer userId);

    @Delete("delete from collection where user_id=#{userId} and post_id=#{postId}")
    int deleteCollection(Post post);

    @Select("select count(*) from collection where user_id=#{userId} and post_id=#{postId}")
    int isCollected(@Param("postId") Integer postId,@Param("userId")  Integer userId);

    @Insert("insert into collection values(null,#{postId},#{userId},now())")
    int collectPost(@Param("postId") Integer postId,@Param("userId")  Integer userId);

    @Delete("delete from collection where user_id=#{userId} and post_id=#{postId}")
    Integer delCollect(@Param("postId") Integer postId,@Param("userId")  Integer userId);
}
