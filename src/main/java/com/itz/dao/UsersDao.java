package com.itz.dao;

import com.itz.model.Users;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface UsersDao {
    // 根据用户名查询用户信息
    Users findUsersByUserName(String userName);

    @Update("update users set user_name=#{userName},nick_name=#{nickName},gender=#{gender},signature=#{signature},avatar=#{avatar} where user_id = #{userId}")
    int updateUser(Users user);

    @Insert("insert into users(user_name,password,nick_name) values (#{userName},#{password},#{nickName})")
    int insertUsers(Users users);

    List<Users> selectFollowUsers(Integer userId);

    @Insert("insert into follow_users values( null, #{userId}, #{fuId} )")
    void followById(@Param("userId") Integer userId,@Param("fuId") String fuId);

    @Delete("delete from follow_users where user_id = #{userId} and follow_user_id = #{fuId}")
    void deleteFollowById(@Param("userId") Integer userId,@Param("fuId") String fuId);


    List<Users> selectFans(Integer userId);

    List<Map> selectFollowBar(Integer userId);

    @Insert("insert into follow_bar values( #{userId},#{barId},6,1,0 )")
    void followBarById(@Param("userId")Integer userId,@Param("barId") String barId);

    @Delete("delete from follow_bar where user_id = #{userId} and bar_id = #{barId}")
    void deleteBarFollowByid(@Param("userId") Integer userId,@Param("barId") String barId);

    Integer selectFollowCount(Integer userId);
    Integer selectFansCount(Integer userId);
    Integer selectFollowBarCount(Integer userId);
    Integer selectBarCount(Integer userId);

    List<Map> selectMyCollection(Integer userId);

    List<Map> selectHistory(@Param("userId")Integer userId,@Param("status")Integer status);

    @Delete("delete from history where user_id=#{userId}")
    int clearHistory(Integer userId);
}
