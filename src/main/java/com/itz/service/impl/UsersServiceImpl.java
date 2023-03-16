package com.itz.service.impl;

import com.itz.dao.UsersDao;
import com.itz.model.Users;
import com.itz.service.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UsersServiceImpl implements UsersService {

    @Autowired
    private UsersDao usersDao;

    @Override
    public Users findUsersByUserName(String userName) {
        return usersDao.findUsersByUserName(userName);
    }

    @Override
    public int insertUsers(Users usersVo) {
        return usersDao.insertUsers( usersVo);
    }

    @Override
    public int updateUser(Users user) {
        return usersDao.updateUser(user);
    }

    @Override
    public List<Users> selectFollowUsers(Integer userId) {
        List<Users> users = usersDao.selectFollowUsers(userId);
        return users;
    }

    @Override
    public int followById(Integer userId, String fuId,Integer status) {
        if(status==0) {
            usersDao.followById(userId, fuId);
            return 1;
        }else {
            usersDao.deleteFollowById(userId, fuId);
            return 0;
        }
    }

    @Override
    public List<Users> selectFans(Integer userId) {
        List<Users> users = usersDao.selectFans(userId);
        return users;
    }

    @Override
    public List<Map> selectFollowBar(Integer userId) {
        List<Map> barList = usersDao.selectFollowBar(userId);
        return barList;
    }

    @Override
    public void followBarById(Integer userId, String barId, Integer status) {

        if(status==0)
            usersDao.followBarById(userId,barId);
        else
            usersDao.deleteBarFollowByid(userId,barId);
    }

    @Override
    public Map selectCount(Integer userId) {
        int follow=usersDao.selectFollowCount(userId);
        int fans=usersDao.selectFansCount(userId);
        int followBar=usersDao.selectFollowBarCount(userId);
        int bar=usersDao.selectBarCount(userId);
        Map countMap = new HashMap();
        countMap.put("followCount",follow);
        countMap.put("fansCount",fans);
        countMap.put("followBarCount",followBar);
        countMap.put("barCount",bar);
        return countMap;
    }

    @Override
    public List<Map> selectMyCollection(Integer userId) {
        return usersDao.selectMyCollection(userId);
    }

    @Override
    public List<Map> selectHistory(Integer userId,Integer status) {
        return usersDao.selectHistory(userId,status);
    }

    @Override
    public int clearHistory(Integer userId) {
        int i =usersDao.clearHistory(userId);
        return i;
    }
}
