package com.recook.vo;

public class Recipe {
    private int r_no;           // 글번호
    private String r_title;     // 글제목
    private String r_id;        // 작성자id
    private String r_datetime;  // 작성시간
    private int r_hit;          // 조회수
    private String r_text;      // 글내용
    
    // 기본 생성자
    public Recipe() {}
    
    // 전체 생성자
    public Recipe(int r_no, String r_title, String r_id, String r_datetime, int r_hit, String r_text) {
        this.r_no = r_no;
        this.r_title = r_title;
        this.r_id = r_id;
        this.r_datetime = r_datetime;
        this.r_hit = r_hit;
        this.r_text = r_text;
    }
    
    // Getter, Setter
    public int getR_no() {
        return r_no;
    }
    
    public void setR_no(int r_no) {
        this.r_no = r_no;
    }
    
    public String getR_title() {
        return r_title;
    }
    
    public void setR_title(String r_title) {
        this.r_title = r_title;
    }
    
    public String getR_id() {
        return r_id;
    }
    
    public void setR_id(String r_id) {
        this.r_id = r_id;
    }
    
    public String getR_datetime() {
        return r_datetime;
    }
    
    public void setR_datetime(String r_datetime) {
        this.r_datetime = r_datetime;
    }
    
    public int getR_hit() {
        return r_hit;
    }
    
    public void setR_hit(int r_hit) {
        this.r_hit = r_hit;
    }
    
    public String getR_text() {
        return r_text;
    }
    
    public void setR_text(String r_text) {
        this.r_text = r_text;
    }
    
    @Override
    public String toString() {
        return "Recipe [r_no=" + r_no + ", r_title=" + r_title + ", r_id=" + r_id
                + ", r_datetime=" + r_datetime + ", r_hit=" + r_hit + ", r_text=" + r_text + "]";
    }
}