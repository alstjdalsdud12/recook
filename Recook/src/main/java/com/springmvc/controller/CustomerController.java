package com.springmvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CustomerController {

    @GetMapping("/customer")
    public String customerPage() {
        return "customer";
    }

    @GetMapping("/qna")
    public String qnaPage() {
        return "qna";
    }

    // 🔥 1:1 문의 페이지
    @GetMapping("/inquiry")
    public String inquiryPage() {
        return "inquiry";
    }
}