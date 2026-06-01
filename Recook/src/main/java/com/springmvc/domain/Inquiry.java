package com.springmvc.domain;

public class Inquiry {
    private int i_no;
    private String i_title;
    private String i_email;
    private String i_content;
    private String i_datetime;
    private String i_reply;
    private String i_reply_datetime;
    
    public Inquiry() {}
    
    public Inquiry(String i_title, String i_email, String i_content) {
        this.i_title = i_title;
        this.i_email = i_email;
        this.i_content = i_content;
    }
    
    // getter, setter 추가
    public int getI_no() { return i_no; }
    public void setI_no(int i_no) { this.i_no = i_no; }
    
    public String getI_title() { return i_title; }
    public void setI_title(String i_title) { this.i_title = i_title; }
    
    public String getI_email() { return i_email; }
    public void setI_email(String i_email) { this.i_email = i_email; }
    
    public String getI_content() { return i_content; }
    public void setI_content(String i_content) { this.i_content = i_content; }
    
    public String getI_datetime() { return i_datetime; }
    public void setI_datetime(String i_datetime) { this.i_datetime = i_datetime; }
    
    public String getI_reply() { return i_reply; }
    public void setI_reply(String i_reply) { this.i_reply = i_reply; }
    
    public String getI_reply_datetime() { return i_reply_datetime; }
    public void setI_reply_datetime(String i_reply_datetime) { this.i_reply_datetime = i_reply_datetime; }
}