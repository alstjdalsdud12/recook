package com.springmvc.domain;

public class RecipeReview {
    private int rr_no;
    private int r_no;
    private int m_no;
    private String m_nickname;
    private int rr_rating;
    private String rr_content;
    private String rr_image;
    private String rr_datetime;

    public int getRr_no() { return rr_no; }
    public void setRr_no(int rr_no) { this.rr_no = rr_no; }
    public int getR_no() { return r_no; }
    public void setR_no(int r_no) { this.r_no = r_no; }
    public int getM_no() { return m_no; }
    public void setM_no(int m_no) { this.m_no = m_no; }
    public String getM_nickname() { return m_nickname; }
    public void setM_nickname(String m_nickname) { this.m_nickname = m_nickname; }
    public int getRr_rating() { return rr_rating; }
    public void setRr_rating(int rr_rating) { this.rr_rating = rr_rating; }
    public String getRr_content() { return rr_content; }
    public void setRr_content(String rr_content) { this.rr_content = rr_content; }
    public String getRr_image() { return rr_image; }
    public void setRr_image(String rr_image) { this.rr_image = rr_image; }
    public String getRr_datetime() { return rr_datetime; }
    public void setRr_datetime(String rr_datetime) { this.rr_datetime = rr_datetime; }
}