package com.pyd.paperonlinesystem.mapper;

import com.pyd.paperonlinesystem.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @ClassName: UserMapper
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/21  0:29
 */
@Repository
public interface UserMapper {
    int insertUser(User user);
    User queryByUser(User user);
    User queryUserByName(String username);
    User queryUserByEmail(String email);
    User queryUserByTel(String phonenumber);
    List<User> queryUserByCondition(String condition);
    List<User> queryAllUser();
    int updateUser(User user);
}
