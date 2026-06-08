package com.springmvc.domain;

public class RecipeReport {
    private int rp_no;
    private int r_no;
    private int m_no;
    private String rp_reason;
    private String rp_datetime;
    private int rp_status;
    private String r_title;
    private String m_nickname;

    public int getRp_no() { return rp_no; }
    public void setRp_no(int rp_no) { this.rp_no = rp_no; }
    public int getR_no() { return r_no; }
    public void setR_no(int r_no) { this.r_no = r_no; }
    public int getM_no() { return m_no; }
    public void setM_no(int m_no) { this.m_no = m_no; }
    public String getRp_reason() { return rp_reason; }
    public void setRp_reason(String rp_reason) { this.rp_reason = rp_reason; }
    public String getRp_datetime() { return rp_datetime; }
    public void setRp_datetime(String rp_datetime) { this.rp_datetime = rp_datetime; }
    public int getRp_status() { return rp_status; }
    public void setRp_status(int rp_status) { this.rp_status = rp_status; }
    public String getR_title() { return r_title; }
    public void setR_title(String r_title) { this.r_title = r_title; }
    public String getM_nickname() { return m_nickname; }
    public void setM_nickname(String m_nickname) { this.m_nickname = m_nickname; }
}