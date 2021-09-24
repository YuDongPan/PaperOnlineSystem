package com.pyd.paperonlinesystem.entity;

import java.sql.Timestamp;

/**
 * @ClassName: Log
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/22  19:52
 */
public class Log {
    private Integer id;
    private String username;
    private String paper_name;
    private String paper_time;
    private String msg;
    private Timestamp deal_time;

    public Log() {
    }

    public Log(Integer id, String username, String paper_name, String paper_time, String msg, Timestamp deal_time) {
        this.id = id;
        this.username = username;
        this.paper_name = paper_name;
        this.paper_time = paper_time;
        this.msg = msg;
        this.deal_time = deal_time;
    }

    public Log(String username, String paper_name, String paper_time, String msg, Timestamp deal_time) {
        this.username = username;
        this.paper_name = paper_name;
        this.paper_time = paper_time;
        this.msg = msg;
        this.deal_time = deal_time;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public String getPaper_name() {
        return paper_name;
    }

    public void setPaper_name(String paper_name) {
        this.paper_name = paper_name;
    }

    public String getPaper_time() {
        return paper_time;
    }

    public void setPaper_time(String paper_time) {
        this.paper_time = paper_time;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Timestamp getDeal_time() {
        return deal_time;
    }

    public void setDeal_time(Timestamp deal_time) {
        this.deal_time = deal_time;
    }

}
