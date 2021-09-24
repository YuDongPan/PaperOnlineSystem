package com.pyd.paperonlinesystem.service;

import com.pyd.paperonlinesystem.entity.Log;
import com.pyd.paperonlinesystem.mapper.LogMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @ClassName: LogService
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/22  20:32
 */
@Service
public class LogService {
    @Resource
    LogMapper logMapper;
    public int insertLog(Log log){
        return logMapper.insertLog(log);
    }
    public List<Log> queryLogByCondition(String condition){
        return logMapper.queryLogByCondition(condition);
    }
    public List<Log> queryLogByUsername(String username){
        return logMapper.queryLogByUsername(username);
    }
    public List<Log> queryLogByUsernameType(Log log){
        return logMapper.queryLogByUsernameType(log);
    }
}
