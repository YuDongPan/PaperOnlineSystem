package com.pyd.paperonlinesystem.controller;

import com.pyd.paperonlinesystem.entity.User;
import com.pyd.paperonlinesystem.service.UserService;
import com.zhenzi.sms.ZhenziSmsClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

/**
 * @ClassName: UserController
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/20  20:56
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/insertUser.do")
    public String insertUser(User user, Model model){
        if(userService.insertUser(user)){
            model.addAttribute("msg_reg", "ok");
        }
        else{
            model.addAttribute("msg_reg", "error");
        }
        return "user/register";
    }

    @RequestMapping("/login.do")
    public String loginByUser(User user, HttpServletRequest request, HttpSession session, Model model){
        Map<String, Object> map = new HashMap<String, Object>();
        String username = request.getParameter("username");
        User loginUser = userService.queryByUser(user);
        if(loginUser != null){
            session.setAttribute("loginUsername", username);
            session.setAttribute("loginUser", loginUser);
            model.addAttribute("msg_login", "success");
        }
        else{
            model.addAttribute("msg_login", "error");
            return "login";
        }
        return "paper/index";
    }


    //判别用户名是否存在
    @RequestMapping(value = "/checkUsername.do", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> registerCheckUsername(HttpServletRequest request) throws IOException {
        String username = request.getParameter("username");
        System.out.println(username);
        User user = userService.queryUserByName(username);
        // 返回map数组 spring的@ResponseBody会帮我们自动转换成json类型
        Map<String, Object> map = new HashMap<String, Object>();
        if(user != null){
            map.put("msg_username", "error");
        }
        else{
            map.put("msg_username", "ok");
        }
        return map;
    }

    //判别手机号是否存在
    @RequestMapping(value = "/checkTel.do", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> registerCheckTel(HttpServletRequest request) throws IOException {
        String phonenumber = request.getParameter("phonenumber");
        System.out.println(phonenumber);
        User user = userService.queryUserByTel(phonenumber);
        // 返回map数组 spring的@ResponseBody会帮我们自动转换成json类型
        Map<String, Object> map = new HashMap<String, Object>();
        if(user != null){
            map.put("msg_phonenumber", "ok");
        }
        else{
            map.put("msg_phonenumber", "error");
        }
        return map;
    }

    //判别电子邮件是否存在
    @RequestMapping(value = "/checkEmail.do", method = RequestMethod.POST)
    public @ResponseBody Map<String, Object> registerCheckEmail(HttpServletRequest request) throws IOException {
        String email = request.getParameter("email");
        User user = userService.queryUserByEmail(email);
        // 返回map数组 spring的@ResponseBody会帮我们自动转换成json类型
        Map<String, Object> map = new HashMap<String, Object>();
        if(user != null){
            map.put("msg_email", "error");
        }
        else{
            map.put("msg_email", "ok");
        }
        return map;
    }

    //用户发送手机验证码
    @RequestMapping(value="/send.do",produces = "application/json;charset=utf8")
    public @ResponseBody String sendSMS(HttpServletRequest request, HttpServletResponse response) throws Exception{
        //ZhenziSmsClient client = new ZhenziSmsClient(apiUrl,appId,appSecret);
        //apiUrl为请求地址,其余两个参数可在榛子云官网查询
        ZhenziSmsClient client = new ZhenziSmsClient("https://sms_developer.zhenzikj.com","108166","bb028ce3-1dfc-4f51-b710-75ac8a577006");
        String tel = request.getParameter("tel");
        String templateId = "3749";
        String verifyCode = String.valueOf(new Random().nextInt(899999) + 100000);
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("number", tel);
        params.put("templateId", templateId);
        String[] templateParams = new String[2];
        templateParams[0] = verifyCode;
        templateParams[1] = "1";
        params.put("templateParams", templateParams);
        String result = client.send(params);
        //将验证码存入session
        HttpSession session = request.getSession();
        session.removeAttribute("verifyCode");
        session.setAttribute("verifyCode", verifyCode);
        System.out.println("verifyCode:" + (String)session.getAttribute("verifyCode"));
        return result;
/*			Object jsonObj = JSONUtils.parse(result);
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("result", jsonObj);
			return map;	*/
    }

    //验证码校对
    @RequestMapping("/validate.do")
    public @ResponseBody boolean Validate(HttpSession session,HttpServletRequest request,Model model){
        String phonenumber = request.getParameter("phonenumber");
        System.out.println(phonenumber);
        String inputCode = request.getParameter("inputCode");
        String verifyCode = (String)session.getAttribute("verifyCode");
        if(inputCode.equals(verifyCode)){
            session.setAttribute("phonenumber", phonenumber);
            return true;
        }
        return false;
    }

    //修改密码
    @RequestMapping("/updatepsw.do")
    public String updatepsw(HttpServletRequest request,HttpSession session, Model model){
        String phonenumber = request.getParameter("phonenumber");
        String newpassword = request.getParameter("password");
        User checkUser = userService.queryUserByTel(phonenumber);
        //用户存在
        if (checkUser != null) {
            User newuser = new User();
            newuser.setPhonenumber(phonenumber);
            newuser.setPassword(newpassword);
            userService.updateUser(newuser);
            //修改成功
            model.addAttribute("msg", "yes");
            session.removeAttribute("phonenumber");
        } else {
            //用户不存在，修改失败
            model.addAttribute("msg","no");
        }
        return "user/rectifypsw";
    }

    //用户退出
    @RequestMapping("/exit.do")
    public String exit(HttpSession session,Model model){
        session.removeAttribute("loginUsername");
        session.removeAttribute("loginUser");
        return "/login";
    }

}
