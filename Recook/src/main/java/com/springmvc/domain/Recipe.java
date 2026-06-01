package com.springmvc.domain;

import org.springframework.web.multipart.MultipartFile;

public class Recipe {
    private int r_no;
    private String r_title;
    private String r_image;
    private int r_hit;
    private String r_content;
    private String r_datetime;
    private int m_no;
    private String m_nickname;
    private String r_type;
    private String r_situation;
    private String r_method;
    private int r_servings;
    private int r_cooking_time;
    private String r_difficulty;
    private MultipartFile r_imageFile;
    private double avg_rating;
    private int review_count;

    public Recipe() {}

    public double getAvg_rating() { return avg_rating; }
    public void setAvg_rating(double avg_rating) { this.avg_rating = avg_rating; }

    public int getReview_count() { return review_count; }
    public void setReview_count(int review_count) { this.review_count = review_count; }

    public int getR_no() { return r_no; }
    public void setR_no(int r_no) { this.r_no = r_no; }

    public String getR_title() { return r_title; }
    public void setR_title(String r_title) { this.r_title = r_title; }

    public String getR_image() { return r_image; }
    public void setR_image(String r_image) { this.r_image = r_image; }

    public int getR_hit() { return r_hit; }
    public void setR_hit(int r_hit) { this.r_hit = r_hit; }

    public String getR_content() { return r_content; }
    public void setR_content(String r_content) { this.r_content = r_content; }

    public String getR_datetime() { return r_datetime; }
    public void setR_datetime(String r_datetime) { this.r_datetime = r_datetime; }

    public int getM_no() { return m_no; }
    public void setM_no(int m_no) { this.m_no = m_no; }

    public String getM_nickname() { return m_nickname; }
    public void setM_nickname(String m_nickname) { this.m_nickname = m_nickname; }

    public String getR_type() { return r_type; }
    public void setR_type(String r_type) { this.r_type = r_type; }

    public String getR_situation() { return r_situation; }
    public void setR_situation(String r_situation) { this.r_situation = r_situation; }

    public String getR_method() { return r_method; }
    public void setR_method(String r_method) { this.r_method = r_method; }

    public int getR_servings() { return r_servings; }
    public void setR_servings(int r_servings) { this.r_servings = r_servings; }

    public int getR_cooking_time() { return r_cooking_time; }
    public void setR_cooking_time(int r_cooking_time) { this.r_cooking_time = r_cooking_time; }

    public String getR_difficulty() { return r_difficulty; }
    public void setR_difficulty(String r_difficulty) { this.r_difficulty = r_difficulty; }

    public MultipartFile getR_imageFile() { return r_imageFile; }
    public void setR_imageFile(MultipartFile r_imageFile) { this.r_imageFile = r_imageFile; }
}