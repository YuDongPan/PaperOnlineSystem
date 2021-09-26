package com.pyd.paperonlinesystem.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pyd.paperonlinesystem.entity.Log;
import com.pyd.paperonlinesystem.entity.User;
import com.pyd.paperonlinesystem.service.LogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: LogController
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/25  18:32
 */
@RestController
@RequestMapping("/log")
public class LogController {
    @Autowired
    private LogService logService;
    @RequestMapping("/selectLogList.do")
    public Map<String, Object> selectLogList(@RequestParam(name="condition",required = false)String condition, @RequestParam(required=false,defaultValue="1") Integer page, @RequestParam(required=false,defaultValue="10") Integer limit){
        //使用PageHelper传入当前页面和页面显示条数会自动为我们的select语句加上limit查询
        //从下一条sql开始分页
        PageHelper.startPage(page,limit);
        List<Log> logs = null;
        if(condition == null){
            logs = logService.queryAllLog();
        }
        else{
            condition = "%" + condition + "%";
            logs = logService.queryLogByCondition(condition);
        }
        //使用pageInfo包装查询
        PageInfo<Log> rolePageInfo = new PageInfo<>(logs);
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("code",0);
        map.put("msg","");
        map.put("count", rolePageInfo.getTotal());
        map.put("data", rolePageInfo.getList());
        return map;
    }

}
