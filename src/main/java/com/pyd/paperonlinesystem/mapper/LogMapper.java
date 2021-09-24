package com.pyd.paperonlinesystem.mapper;

import com.pyd.paperonlinesystem.entity.Log;

import java.util.List;

/**
 * @ClassName: LogMapper
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/22  20:25
 */
public interface LogMapper {
    int insertLog(Log log);
    List<Log> queryLogByCondition(String condition);
    List<Log> queryLogByUsername(String username);
    List<Log> queryLogByUsernameType(Log log);
}
