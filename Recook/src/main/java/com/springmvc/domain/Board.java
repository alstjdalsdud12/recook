package com.springmvc.domain;

import java.util.ArrayList;
import java.util.List;

public class Board {

    private int id;

    private String title;

    private String writer;

    private String content;

    private int hit;

    private int likeCount;

    private String regDate;

    // 대표 이미지
    private String image;

    // 여러 이미지
    private List<String> imageList =
            new ArrayList<>();

    // 댓글
    private List<Comment> comments =
            new ArrayList<>();

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getHit() {
        return hit;
    }

    public void setHit(int hit) {
        this.hit = hit;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }

    public String getRegDate() {
        return regDate;
    }

    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public List<String> getImageList() {
        return imageList;
    }

    public void setImageList(
            List<String> imageList) {

        this.imageList = imageList;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(
            List<Comment> comments) {

        this.comments = comments;
    }
}