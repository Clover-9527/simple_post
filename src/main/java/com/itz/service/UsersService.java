package com.itz.service;

import com.itz.model.Users;

import java.util.List;
import java.util.Map;

public interface UsersService {
    // 根据用户名查询用户信息
    Users findUsersByUserName(String userName);

    //修改用户信息
    int updateUser(Users user);

    int insertUsers(Users usersVo);

    List<Users> selectFollowUsers(Integer userId);

    int followById(Integer userId, String fuId,Integer status);

    List<Users> selectFans(Integer userId);

    List<Map> selectFollowBar(Integer userId);

    void followBarById(Integer userId, String barId, Integer status);

    Map selectCount(Integer userId);

    List<Map> selectMyCollection(Integer userId);

    List<Map> selectHistory(Integer userId,Integer status);

    int clearHistory(Integer userId);

}
