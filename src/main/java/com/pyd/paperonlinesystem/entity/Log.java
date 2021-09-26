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
    private String paper_type;
    private String msg;
    private Timestamp deal_time;

    public Log() {
    }

    public Log(String username, String paper_name, String paper_type, String msg) {
        this.username = username;
        this.paper_name = paper_name;
        this.paper_type = paper_type;
        this.msg = msg;
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

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPaper_name() {
        return paper_name;
    }

    public void setPaper_name(String paper_name) {
        this.paper_name = paper_name;
    }

    public String getPaper_type() {
        return paper_type;
    }

    public void setPaper_type(String paper_type) {
        this.paper_type = paper_type;
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

    @Override
    public String toString() {
        return "Log{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", paper_name='" + paper_name + '\'' +
                ", paper_type='" + paper_type + '\'' +
                ", msg='" + msg + '\'' +
                ", deal_time=" + deal_time +
                '}';
    }
}
