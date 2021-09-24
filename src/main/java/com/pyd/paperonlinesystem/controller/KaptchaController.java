package com.pyd.paperonlinesystem.controller;

import com.baomidou.kaptcha.Kaptcha;
import com.baomidou.kaptcha.exception.KaptchaException;
import com.baomidou.kaptcha.exception.KaptchaIncorrectException;
import com.baomidou.kaptcha.exception.KaptchaNotFoundException;
import com.baomidou.kaptcha.exception.KaptchaTimeoutException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * @ClassName: KaptchaController
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/21  16:53
 */
@RestController
@RequestMapping("/kaptcha")
public class KaptchaController {

    @Autowired
    private Kaptcha kaptcha;

    @GetMapping("/render")
    public void render() {
        kaptcha.render();
    }

    @PostMapping("/valid")
    public void validDefaultTime(@RequestParam String code) {
        //default timeout 900 seconds
        kaptcha.validate(code);
    }

    @PostMapping("/validTime")
    public @ResponseBody Map<String, Object> validCustomTime(@RequestParam String code) {
        System.out.println("111111");
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            kaptcha.validate(code, 300);
            System.out.println("2222222");
            map.put("msg_code", "ok");
        }
        catch(KaptchaException kaptchaException){
            System.out.println("33333333");
            if (kaptchaException instanceof KaptchaIncorrectException) {
                map.put("msg_code", "验证码错误");
            } else if (kaptchaException instanceof KaptchaNotFoundException) {
                map.put("msg_code", "验证码未找到");
            } else if (kaptchaException instanceof KaptchaTimeoutException) {
                map.put("msg_code", "验证码已过期");
            } else {
                map.put("msg_code", "加载验证码失败");
            }
        }
        return map;
    }

}
