package com.springmvc.domain;

public class Notice {
    private int n_no;
    private String n_title;
    private String n_content;
    private String n_datetime;
    
    // 기본 생성자
    public Notice() {}
    
    // 전체 생성자
    public Notice(int n_no, String n_title, String n_content, String n_datetime) {
        this.n_no = n_no;
        this.n_title = n_title;
        this.n_content = n_content;
        this.n_datetime = n_datetime;
    }
    
    // Getter, Setter
    public int getN_no() {
        return n_no;
    }
    
    public void setN_no(int n_no) {
        this.n_no = n_no;
    }
    
    public String getN_title() {
        return n_title;
    }
    
    public void setN_title(String n_title) {
        this.n_title = n_title;
    }
    
    public String getN_content() {
        return n_content;
    }
    
    public void setN_content(String n_content) {
        this.n_content = n_content;
    }
    
    public String getN_datetime() {
        return n_datetime;
    }
    
    public void setN_datetime(String n_datetime) {
        this.n_datetime = n_datetime;
    }
    
    @Override
    public String toString() {
        return "Notice [n_no=" + n_no + ", n_title=" + n_title + ", n_content=" + n_content
                + ", n_datetime=" + n_datetime + "]";
    }
}