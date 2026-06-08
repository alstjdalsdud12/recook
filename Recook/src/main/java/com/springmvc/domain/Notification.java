package com.springmvc.domain;

public class Notification {
    private int n_no;
    private int m_no;
    private String n_content;
    private int n_read;
    private String n_datetime;

    public int getN_no() { return n_no; }
    public void setN_no(int n_no) { this.n_no = n_no; }
    public int getM_no() { return m_no; }
    public void setM_no(int m_no) { this.m_no = m_no; }
    public String getN_content() { return n_content; }
    public void setN_content(String n_content) { this.n_content = n_content; }
    public int getN_read() { return n_read; }
    public void setN_read(int n_read) { this.n_read = n_read; }
    public String getN_datetime() { return n_datetime; }
    public void setN_datetime(String n_datetime) { this.n_datetime = n_datetime; }
}