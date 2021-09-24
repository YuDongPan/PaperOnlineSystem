package com.pyd.paperonlinesystem;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.pyd.paperonlinesystem.mapper")
public class PaperOnlineSystemApplication {

    public static void main(String[] args) {
        SpringApplication.run(PaperOnlineSystemApplication.class, args);
    }

}
