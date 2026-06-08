package com.springmvc.domain;

public class Coupon {
    private int c_no;
    private int m_no;
    private String c_brand;
    private String c_name;
    private String c_expire_date;
    private String c_type;
    private int c_used;
    private String c_datetime;

    public int getC_no() { return c_no; }
    public void setC_no(int c_no) { this.c_no = c_no; }
    public int getM_no() { return m_no; }
    public void setM_no(int m_no) { this.m_no = m_no; }
    public String getC_brand() { return c_brand; }
    public void setC_brand(String c_brand) { this.c_brand = c_brand; }
    public String getC_name() { return c_name; }
    public void setC_name(String c_name) { this.c_name = c_name; }
    public String getC_expire_date() { return c_expire_date; }
    public void setC_expire_date(String c_expire_date) { this.c_expire_date = c_expire_date; }
    public String getC_type() { return c_type; }
    public void setC_type(String c_type) { this.c_type = c_type; }
    public int getC_used() { return c_used; }
    public void setC_used(int c_used) { this.c_used = c_used; }
    public String getC_datetime() { return c_datetime; }
    public void setC_datetime(String c_datetime) { this.c_datetime = c_datetime; }
}