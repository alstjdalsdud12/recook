package com.springmvc.domain;

import java.util.ArrayList;
import java.util.List;

public class Board {
    private int b_id;
    private String b_title;
    private String b_writer;
    private String b_content;
    private int b_hit;
    private int b_like_count;
    private String b_reg_date;
    private int m_no;
    private String b_image;
    private List<String> imageList = new ArrayList<>();
    private List<Comment> comments = new ArrayList<>();

    public int getB_id() { return b_id; }
    public void setB_id(int b_id) { this.b_id = b_id; }
    public String getB_title() { return b_title; }
    public void setB_title(String b_title) { this.b_title = b_title; }
    public String getB_writer() { return b_writer; }
    public void setB_writer(String b_writer) { this.b_writer = b_writer; }
    public String getB_content() { return b_content; }
    public void setB_content(String b_content) { this.b_content = b_content; }
    public int getB_hit() { return b_hit; }
    public void setB_hit(int b_hit) { this.b_hit = b_hit; }
    public int getB_like_count() { return b_like_count; }
    public void setB_like_count(int b_like_count) { this.b_like_count = b_like_count; }
    public String getB_reg_date() { return b_reg_date; }
    public void setB_reg_date(String b_reg_date) { this.b_reg_date = b_reg_date; }
    public int getM_no() { return m_no; }
    public void setM_no(int m_no) { this.m_no = m_no; }
    public String getB_image() { return b_image; }
    public void setB_image(String b_image) { this.b_image = b_image; }
    public List<String> getImageList() { return imageList; }
    public void setImageList(List<String> imageList) { this.imageList = imageList; }
    public List<Comment> getComments() { return comments; }
    public void setComments(List<Comment> comments) { this.comments = comments; }
}