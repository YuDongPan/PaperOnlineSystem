package com.pyd.paperonlinesystem.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pyd.paperonlinesystem.entity.Log;
import com.pyd.paperonlinesystem.entity.Paper;
import com.pyd.paperonlinesystem.entity.User;
import com.pyd.paperonlinesystem.service.LogService;
import com.pyd.paperonlinesystem.service.PaperService;
import com.pyd.paperonlinesystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
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
    @Value("${springConfigs.params.filePaths}")
    private String filePath;
    @Autowired
    private PaperService paperService;
    @Autowired
    private UserService userService;
    @Autowired
    private LogService logService;
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

    @RequestMapping("/deletePaper/{id}/{type}")
    @Transactional(rollbackFor = Exception.class)
    public String deletePaper(@PathVariable("id") String id, @PathVariable("type") String type, Model model, HttpSession session){
        // 删除数据库里的文件记录
        Integer fid = Integer.valueOf(id);
        Paper newPaper = paperService.queryPaperById(fid);
        String fileName = newPaper.getName();
        String username = (String)session.getAttribute("loginUsername");
        if(paperService.deletePaperByName(fileName) > 0){
            model.addAttribute("msg_delete", "ok");
            String msg = "删除文献";
            Log log = new Log(username, fileName, type, msg);
            logService.insertLog(log);
        }
        else{
            model.addAttribute("msg_delete", "error");
        }
        // 删除本地磁盘上的文件记录
        File file = new File(filePath + fileName);
        if(file.exists() && file.isFile()){
            // 删除文件
            file.delete();
        }
        return "/paper/paper_search_admin";
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
        Map<String,Object> map = new HashMap<>();
        map.put("code",0);
        map.put("msg","");
        map.put("count", rolePageInfo.getTotal());
        map.put("data", rolePageInfo.getList());
        return map;
    }
}
