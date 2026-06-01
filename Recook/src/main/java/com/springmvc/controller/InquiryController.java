package com.springmvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import com.springmvc.dao.InquiryDAO;
import com.springmvc.domain.Inquiry;

@Controller
public class InquiryController {
    
    private InquiryDAO inquiryDAO = new InquiryDAO();
    
    // 문의 작성 처리만 (GET은 CustomerController에서 처리)
    @PostMapping("/inquiry")
    public String submitInquiry(Inquiry inquiry) {
        inquiryDAO.insert(inquiry);
        return "inquiry_success";
    }
}