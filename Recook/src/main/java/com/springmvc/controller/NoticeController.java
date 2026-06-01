package com.springmvc.controller;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.springmvc.dao.NoticeDAO;
import com.springmvc.domain.Notice;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/notice")
public class NoticeController {
    
    private NoticeDAO noticeDAO = new NoticeDAO();
    
    @GetMapping("/notice")
    public String notice(Model model) {
        List<Notice> noticeList = noticeDAO.selectAll();
        model.addAttribute("noticeList", noticeList);
        return "notice/notice";
    }
    
    // 공지사항 상세보기
    @GetMapping("/detail")
    public String detail(@RequestParam(name="n_no") int n_no, Model model) {
        Notice notice = noticeDAO.selectOne(n_no);
        model.addAttribute("notice", notice);
        return "notice/notice_detail";
    }
    
    // 공지사항 작성 페이지
    @GetMapping("/write")
    public String writePage(HttpSession session) {
        String m_role = (String) session.getAttribute("m_role");
        if (m_role == null || !m_role.equals("admin")) {
            return "redirect:/notice/list";
        }
        return "notice/notice_write";
    }
    
    // 공지사항 작성 처리
    @PostMapping("/write")
    public String write(Notice notice, HttpSession session) {
        String m_role = (String) session.getAttribute("m_role");
        if (m_role == null || !m_role.equals("admin")) {
            return "redirect:/notice/notice";
        }
        NoticeDAO noticeDAO = new NoticeDAO();  // ← 이 줄 추가!
        noticeDAO.insert(notice);
        return "redirect:/admin/admin_notice";
    }
    
 // 공지사항 수정 페이지
    @GetMapping("/update")
    public String updatePage(@RequestParam(name="n_no") int n_no, HttpSession session, Model model) {
        String m_role = (String) session.getAttribute("m_role");
        if (m_role == null || !m_role.equals("admin")) {
            return "redirect:/notice/notice";
        }
        
        Notice notice = noticeDAO.selectOne(n_no);
        model.addAttribute("notice", notice);
        return "redirect:/admin/admin_notice"; 
    }

    // 공지사항 수정 처리
    @PostMapping("/update")
    public String update(Notice notice, HttpSession session) {
        String m_role = (String) session.getAttribute("m_role");
        if (m_role == null || !m_role.equals("admin")) {
            return "redirect:/notice/notice";
        }
        
        noticeDAO.update(notice);
        return "redirect:/admin/admin_notice";
    }
    
 // 공지사항 삭제
    @GetMapping("/delete")
    public String delete(@RequestParam(name="n_no") int n_no, HttpSession session) {
        String m_role = (String) session.getAttribute("m_role");
        if (m_role == null || !m_role.equals("admin")) {
            return "redirect:/notice/notice";
        }
        
        noticeDAO.delete(n_no);
        return "redirect:/admin/admin_notice";
    }
}