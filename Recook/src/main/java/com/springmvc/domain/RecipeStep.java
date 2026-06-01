package com.springmvc.domain;

public class RecipeStep {
    private int rs_no;
    private int r_no;
    private int rs_order;
    private String rs_content;
    private String rs_image;

    public int getRs_no() { return rs_no; }
    public void setRs_no(int rs_no) { this.rs_no = rs_no; }
    public int getR_no() { return r_no; }
    public void setR_no(int r_no) { this.r_no = r_no; }
    public int getRs_order() { return rs_order; }
    public void setRs_order(int rs_order) { this.rs_order = rs_order; }
    public String getRs_content() { return rs_content; }
    public void setRs_content(String rs_content) { this.rs_content = rs_content; }
    public String getRs_image() { return rs_image; }
    public void setRs_image(String rs_image) { this.rs_image = rs_image; }
}