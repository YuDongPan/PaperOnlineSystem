package com.pyd.paperonlinesystem.service;

import com.pyd.paperonlinesystem.entity.User;
import com.pyd.paperonlinesystem.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ClassName: userService
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/21  0:28
 */
@Service
public class UserService {
    @Autowired
    UserMapper userMapper;
    public boolean insertUser(User user){
        return userMapper.insertUser(user) > 0;
    }

    public User queryByUser(User user){
        return userMapper.queryByUser(user);
    }

    public User queryUserByName(String username){ return userMapper.queryUserByName(username); }

    public User queryUserByEmail(String email){
        return userMapper.queryUserByEmail(email);
    }

    public User queryUserByTel(String phonenumber){
        return userMapper.queryUserByTel(phonenumber);
    }

    public List<User> queryUserByCondition(String condition){
        return userMapper.queryUserByCondition(condition);
    }

    public List<User> queryAllUser(){
        return userMapper.queryAllUser();
    }
    public boolean updateUser(User user){
        return userMapper.updateUser(user) > 0;};
}
