package com.pyd.paperonlinesystem.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pyd.paperonlinesystem.entity.Paper;
import com.pyd.paperonlinesystem.entity.User;
import com.pyd.paperonlinesystem.service.PaperService;
import com.pyd.paperonlinesystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: PaperController
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/22  23:27
 */
@Controller
@RequestMapping("/paper")
public class PaperController{
    private final String filePath = "E:\\literature_workspace\\";
    @Autowired
    private PaperService paperService;
    @Autowired
    private UserService userService;
    @RequestMapping("/selectUserList.do")
    @ResponseBody
    public Map<String,Object> selectUserList(@RequestParam(name="condition",required = false)String condition, @RequestParam(required=false,defaultValue="1") Integer page, @RequestParam(required=false,defaultValue="5") Integer limit){
        //使用PageHelper传入当前页面和页面显示条数会自动为我们的select语句加上limit查询
        //从下一条sql开始分页
        PageHelper.startPage(page,limit);
        List<User> users = null;
        if(condition == null){
            users = userService.queryAllUser();
        }
        else{
            condition = "%" + condition + "%";
            users = userService.queryUserByCondition(condition);
        }
        //使用pageInfo包装查询
        PageInfo<User> rolePageInfo = new PageInfo<>(users);
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("code",0);
        map.put("msg","");
        map.put("count", rolePageInfo.getTotal());
        map.put("data", rolePageInfo.getList());
        return map;
    }

    @RequestMapping("/insertPaper.do")
    @ResponseBody
    public Map<String, Object> insertPaper(HttpServletRequest request){
        Map<String, Object> map = new HashMap<String, Object>();
        String filename = request.getParameter("filename");
        String journal = request.getParameter("journal");
        String year = request.getParameter("year");
        String type = request.getParameter("type");
        String title = request.getParameter("title");
        Paper newPaper = new Paper(filename, journal, Integer.valueOf(year), type, filePath, title);
        if(paperService.insertPaper(newPaper) > 0) {
            map.put("msg_insert", "ok");
        }
        else {
            map.put("msg_insert", "error");
        }
        return map;
    }

    @RequestMapping("/selectPaperList.do")
    @ResponseBody
    public Map<String,Object> selectPaperList(@RequestParam(name="condition",required = false)String condition, @RequestParam(required=false,defaultValue="1") Integer page, @RequestParam(required=false,defaultValue="5") Integer limit){
        //使用PageHelper传入当前页面和页面显示条数会自动为我们的select语句加上limit查询
        //从下一条sql开始分页
        PageHelper.startPage(page,limit);
        List<Paper> papers = null;
        if(condition == null){
            papers = paperService.queryAllPaper();
        }
        else{
            condition = "%" + condition + "%";
            papers = paperService.queryPaperByCondition(condition);
        }
        //使用pageInfo包装查询
        PageInfo<Paper> rolePageInfo = new PageInfo<>(papers);
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("code",0);
        map.put("msg","");
        map.put("count", rolePageInfo.getTotal());
        map.put("data", rolePageInfo.getList());
        return map;
    }
}
