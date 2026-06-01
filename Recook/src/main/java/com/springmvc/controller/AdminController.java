package com.springmvc.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.dao.InquiryDAO;
import com.springmvc.dao.MemberDAO;
import com.springmvc.dao.NoticeDAO;
import com.springmvc.domain.Inquiry;
import com.springmvc.domain.Member;
import com.springmvc.domain.Notice;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

	// 관리자 메인 페이지
	@GetMapping("/admin")
	public String adminPage() {
		return "admin";
	}

	@GetMapping("/admin/user")
	public String userManage(@RequestParam(name = "search", required = false) String search, Model model) {
	    MemberDAO memberDAO = new MemberDAO();
	    List<Member> memberList;
	    
	    if (search != null && !search.isEmpty()) {
	        memberList = memberDAO.searchMemberById(search);
	        model.addAttribute("search", search);
	    } else {
	        memberList = memberDAO.selectAllMembers();
	    }
	    
	    model.addAttribute("memberList", memberList);
	    return "admin/admin_user";
	}

	// 회원 수정
	@PostMapping("/admin/user/update")
	public String updateMember(Member member) {
	    MemberDAO memberDAO = new MemberDAO();
	    memberDAO.updateMember(member);
	    return "redirect:/admin/user";
	}

	// 회원 삭제
	@GetMapping("/admin/user/delete")
	public String deleteMember(@RequestParam(name="m_no") int m_no) {
	    MemberDAO memberDAO = new MemberDAO();
	    memberDAO.deleteMember(m_no);
	    return "redirect:/admin/user";
	}

	// 레시피 관리
	@GetMapping("/admin/recipe")
	public String recipeManage() {
		return "admin_recipe";
	}

	// 문의 관리 목록
	@GetMapping("/admin/inquiry")
	public String inquiryManage(Model model) {
		InquiryDAO inquiryDAO = new InquiryDAO();
		List<Inquiry> inquiryList = inquiryDAO.selectAll();
		model.addAttribute("inquiryList", inquiryList);
		return "admin/admin_inquiry";
	}

	// 문의 상세 조회
	@GetMapping("/admin/inquiry/detail")
	public String inquiryDetail(@RequestParam(name = "i_no") int i_no, Model model) {
		InquiryDAO inquiryDAO = new InquiryDAO();
		Inquiry inquiry = inquiryDAO.selectOne(i_no);
		model.addAttribute("inquiry", inquiry);
		return "admin/admin_inquiry_detail";
	}

	// 공지사항 관리
	@GetMapping("/admin/admin_notice")
	public String noticeManage(Model model) {
		NoticeDAO noticeDAO = new NoticeDAO();
		List<Notice> noticeList = noticeDAO.selectAll();
		model.addAttribute("noticeList", noticeList);
		return "admin/admin_notice";
	}

	// 공지사항 작성 페이지
	@GetMapping("/admin/notice/write")
	public String noticeWritePage(HttpSession session) {
		String m_role = (String) session.getAttribute("m_role");
		if (m_role == null || !m_role.equals("admin")) {
			return "redirect:/admin/admin_notice";
		}
		return "admin/admin_notice_write";
	}

	// 공지사항 작성 처리
	@PostMapping("/admin/notice/write")
	public String noticeWrite(Notice notice, HttpSession session) {
		String m_role = (String) session.getAttribute("m_role");
		if (m_role == null || !m_role.equals("admin")) {
			return "redirect:/admin/admin_notice";
		}

		NoticeDAO noticeDAO = new NoticeDAO();
		noticeDAO.insert(notice);
		return "redirect:/admin/admin_notice";
	}

	// 공지사항 수정 페이지
	@GetMapping("/admin/notice/update")
	public String noticeUpdatePage(@RequestParam(name = "n_no") int n_no, HttpSession session, Model model) {
		String m_role = (String) session.getAttribute("m_role");
		if (m_role == null || !m_role.equals("admin")) {
			return "redirect:/admin/admin_notice";
		}

		NoticeDAO noticeDAO = new NoticeDAO();
		Notice notice = noticeDAO.selectOne(n_no);
		model.addAttribute("notice", notice);
		return "admin/admin_notice_update";
	}

	// 공지사항 수정 처리
	@PostMapping("/admin/notice/update")
	public String noticeUpdate(Notice notice, HttpSession session) {
		String m_role = (String) session.getAttribute("m_role");
		if (m_role == null || !m_role.equals("admin")) {
			return "redirect:/admin/admin_notice";
		}

		NoticeDAO noticeDAO = new NoticeDAO();
		noticeDAO.update(notice);
		return "redirect:/admin/admin_notice";
	}

	// 공지사항 삭제
	@GetMapping("/admin/notice/delete")
	public String noticeDelete(@RequestParam(name = "n_no") int n_no, HttpSession session) {
		String m_role = (String) session.getAttribute("m_role");
		if (m_role == null || !m_role.equals("admin")) {
			return "redirect:/admin/admin_notice";
		}

		NoticeDAO noticeDAO = new NoticeDAO();
		noticeDAO.delete(n_no);
		return "redirect:/admin/admin_notice";
	}

	// 답변 저장
	@PostMapping("/admin/inquiry/reply")
	public String submitReply(@RequestParam(name = "i_no") int i_no, @RequestParam(name = "i_reply") String i_reply,
			HttpSession session) {
		String m_role = (String) session.getAttribute("m_role");
		if (m_role == null || !m_role.equals("admin")) {
			return "redirect:/admin/inquiry";
		}

		InquiryDAO inquiryDAO = new InquiryDAO();
		inquiryDAO.updateReply(i_no, i_reply);
		return "redirect:/admin/inquiry";
	}

}