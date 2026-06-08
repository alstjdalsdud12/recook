package com.springmvc.domain;

import java.util.ArrayList;
import java.util.List;

public class Comment {
    private int bc_id;
    private int b_id;
    private int m_no;
    private String bc_writer;
    private String bc_content;
    private String bc_reg_date;
    private Integer parent_id;
    private int bc_depth;
    private List<Comment> replies = new ArrayList<>();
    private int bc_deleted;

    public int getBc_deleted() { return bc_deleted; }
    public void setBc_deleted(int bc_deleted) { this.bc_deleted = bc_deleted; }
    public int getBc_id() { return bc_id; }
    public void setBc_id(int bc_id) { this.bc_id = bc_id; }
    public int getB_id() { return b_id; }
    public void setB_id(int b_id) { this.b_id = b_id; }
    public int getM_no() { return m_no; }
    public void setM_no(int m_no) { this.m_no = m_no; }
    public String getBc_writer() { return bc_writer; }
    public void setBc_writer(String bc_writer) { this.bc_writer = bc_writer; }
    public String getBc_content() { return bc_content; }
    public void setBc_content(String bc_content) { this.bc_content = bc_content; }
    public String getBc_reg_date() { return bc_reg_date; }
    public void setBc_reg_date(String bc_reg_date) { this.bc_reg_date = bc_reg_date; }
    public Integer getParent_id() { return parent_id; }
    public void setParent_id(Integer parent_id) { this.parent_id = parent_id; }
    public int getBc_depth() { return bc_depth; }
    public void setBc_depth(int bc_depth) { this.bc_depth = bc_depth; }
    public List<Comment> getReplies() { return replies; }
    public void setReplies(List<Comment> replies) { this.replies = replies; }
}