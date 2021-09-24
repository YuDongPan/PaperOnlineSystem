package com.pyd.paperonlinesystem.entity;

import java.sql.Timestamp;

/**
 * @ClassName: Paper
 * @Description: TODO
 * @author: Ethan_Hunt
 * @date: 2021/9/22  19:52
 */
public class Paper {
    private Integer id;
    private String name;
    private String journal;
    private Integer year;
    private String type;
    private String path;
    private Timestamp upload_time;
    private String title;

    public Paper() {
    }

    public Paper(String name, String journal, Integer year, String type, String path, Timestamp upload_time, String title) {
        this.name = name;
        this.journal = journal;
        this.year = year;
        this.type = type;
        this.path = path;
        this.upload_time = upload_time;
        this.title = title;
    }

    public Paper(String name, String journal, Integer year, String type, String path, String title) {
        this.name = name;
        this.journal = journal;
        this.year = year;
        this.type = type;
        this.path = path;
        this.title = title;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getJournal() {
        return journal;
    }

    public void setJournal(String journal) {
        this.journal = journal;
    }

    public Integer getYear() {
        return year;
    }

    public void setYear(Integer year) {
        this.year = year;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Timestamp getUpload_time() {
        return upload_time;
    }

    public void setUpload_time(Timestamp upload_time) {
        this.upload_time = upload_time;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Override
    public String toString() {
        return "Paper{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", journal='" + journal + '\'' +
                ", year=" + year +
                ", type='" + type + '\'' +
                ", path='" + path + '\'' +
                ", upload_time=" + upload_time +
                ", title='" + title + '\'' +
                '}';
    }
}
