package com.pyd.paperonlinesystem.utils;

import com.baomidou.kaptcha.exception.KaptchaException;
import com.baomidou.kaptcha.exception.KaptchaIncorrectException;
import com.baomidou.kaptcha.exception.KaptchaNotFoundException;
import com.baomidou.kaptcha.exception.KaptchaTimeoutException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * @ClassName: GlobalExceptionFilter
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/21  20:54
 */
@RestControllerAdvice
public class GlobalExceptionHander {
    @ExceptionHandler(value = KaptchaException.class)
    public String kaptchaExceptionHandler(KaptchaException kaptchaException) {
        if (kaptchaException instanceof KaptchaIncorrectException) {
            return "VerfifyCode Incorrect";
        } else if (kaptchaException instanceof KaptchaNotFoundException) {
            return "VerifyCode Not Found";
        } else if (kaptchaException instanceof KaptchaTimeoutException) {
            return "VerifyCode Expire";
        } else {
            return "Loading VerifyCode Failed";
        }

    }
}
