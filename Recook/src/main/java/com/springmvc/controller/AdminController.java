package com.springmvc.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.dao.BoardDAO;
import com.springmvc.dao.EventDAO;
import com.springmvc.dao.InquiryDAO;
import com.springmvc.dao.MemberDAO;
import com.springmvc.dao.NoticeDAO;
import com.springmvc.dao.NotificationDAO;
import com.springmvc.dao.RecipeDAO;
import com.springmvc.dao.SolutionDAO;
import com.springmvc.domain.Board;
import com.springmvc.domain.Event;
import com.springmvc.domain.Inquiry;
import com.springmvc.domain.Member;
import com.springmvc.domain.Notice;
import com.springmvc.domain.Recipe;
import com.springmvc.domain.RecipeReport;
import com.springmvc.domain.Solution;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

	private RecipeDAO recipeDAO = new RecipeDAO();
	private SolutionDAO solutionDAO = new SolutionDAO();
	private EventDAO eventDAO = new EventDAO();
	private BoardDAO boardDAO = new BoardDAO();
	
	@GetMapping("/admin")
	public String adminPage(Model model) {
		// 회원 수
		MemberDAO memberDAO = new MemberDAO();
		int memberCount = memberDAO.selectAllMembers().size();

		// 레시피 수
		int recipeCount = recipeDAO.selectAll("").size();

		// 문의 수
		InquiryDAO inquiryDAO = new InquiryDAO();
		int inquiryCount = inquiryDAO.selectAll().size();

		// 최근 문의 5개
		List<Inquiry> recentInquiryList = inquiryDAO.selectAll().stream().limit(5)
				.collect(java.util.stream.Collectors.toList());

		model.addAttribute("memberCount", memberCount);
		model.addAttribute("recipeCount", recipeCount);
		model.addAttribute("inquiryCount", inquiryCount);
		model.addAttribute("recentInquiryList", recentInquiryList);

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

	@PostMapping("/admin/user/update")
	public String updateMember(Member member) {
		MemberDAO memberDAO = new MemberDAO();
		memberDAO.updateMember(member);
		return "redirect:/admin/user";
	}

	@GetMapping("/admin/user/delete")
	public String deleteMember(@RequestParam(name = "m_no") int m_no) {
		MemberDAO memberDAO = new MemberDAO();
		memberDAO.deleteMember(m_no);
		return "redirect:/admin/user";
	}

	// 레시피 관리
	@GetMapping("/admin/recipe")
	public String recipeList(@RequestParam(value = "keyword", defaultValue = "") String keyword, Model model) {
		List<Recipe> recipeList = recipeDAO.selectAll(keyword);
		model.addAttribute("recipeList", recipeList);
		model.addAttribute("keyword", keyword);
		return "admin/admin_recipe";
	}

	@GetMapping("/admin/recipe/delete")
	public String recipeDelete(@RequestParam("r_no") int r_no) {
		recipeDAO.delete(r_no);
		return "redirect:/admin/recipe";
	}

	@GetMapping("/admin/solution")
	public String solutionManage(@RequestParam(value = "keyword", defaultValue = "") String keyword, Model model) {
	    List<Solution> solutionList = solutionDAO.selectAll();
	    model.addAttribute("solutionList", solutionList);
	    model.addAttribute("keyword", keyword);
	    return "admin/admin_solution";
	}

	@GetMapping("/admin/solution/delete")
	public String solutionDelete(@RequestParam("s_no") int s_no) {
	    solutionDAO.delete(s_no);
	    return "redirect:/admin/solution";
	}

	@GetMapping("/admin/inquiry")
	public String inquiryManage(Model model) {
		InquiryDAO inquiryDAO = new InquiryDAO();
		List<Inquiry> inquiryList = inquiryDAO.selectAll();
		model.addAttribute("inquiryList", inquiryList);
		return "admin/admin_inquiry";
	}

	@GetMapping("/admin/inquiry/detail")
	public String inquiryDetail(@RequestParam(name = "i_no") int i_no, Model model) {
		InquiryDAO inquiryDAO = new InquiryDAO();
		Inquiry inquiry = inquiryDAO.selectOne(i_no);
		model.addAttribute("inquiry", inquiry);
		return "admin/admin_inquiry_detail";
	}

	@GetMapping("/admin/admin_notice")
	public String noticeManage(Model model) {
		NoticeDAO noticeDAO = new NoticeDAO();
		List<Notice> noticeList = noticeDAO.selectAll();
		model.addAttribute("noticeList", noticeList);
		return "admin/admin_notice";
	}

	@GetMapping("/admin/notice/write")
	public String noticeWritePage(HttpSession session) {
		String m_role = (String) session.getAttribute("m_role");
		if (m_role == null || !m_role.equals("admin")) {
			return "redirect:/admin/admin_notice";
		}
		return "admin/admin_notice_write";
	}

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

	@GetMapping("/admin/report")
	public String reportManage(Model model) {
		List<RecipeReport> reportList = recipeDAO.selectReports();
		model.addAttribute("reportList", reportList);
		return "admin/admin_report";
	}

	@GetMapping("/admin/report/done")
	public String reportDone(@RequestParam("rp_no") int rp_no) {
		recipeDAO.updateReportStatus(rp_no);
		return "redirect:/admin/report";
	}

	// 레시피 삭제 + 알림 전송
	@GetMapping("/admin/recipe/delete/notify")
	public String recipeDeleteWithNotify(@RequestParam("r_no") int r_no, @RequestParam("reason") String reason,
			Model model) {

		// 레시피 작성자 m_no 가져오기
		Recipe recipe = recipeDAO.selectOne(r_no);
		int m_no = recipe.getM_no();

		// 알림 전송
		NotificationDAO notificationDAO = new NotificationDAO();
		notificationDAO.insert(m_no, "작성하신 레시피 '" + recipe.getR_title() + "'이(가) 관리자에 의해 삭제되었습니다. 사유: " + reason);

		// 레시피 삭제
		recipeDAO.delete(r_no);

		return "redirect:/admin/report";
	}
	
	// 자유게시판 관리
	@GetMapping("/admin/board")
	public String boardManage(Model model) {
	    List<Board> boardList = boardDAO.selectAll("", "latest");
	    model.addAttribute("boardList", boardList);
	    return "admin/admin_board";
	}

	@GetMapping("/admin/board/delete")
	public String boardDelete(@RequestParam("b_id") int b_id) {
	    boardDAO.delete(b_id);
	    return "redirect:/admin/board";
	}

	// 이벤트 관리
	@GetMapping("/admin/event")
	public String eventManage(Model model) {
	    List<Event> eventList = eventDAO.getEventList();
	    model.addAttribute("eventList", eventList);
	    return "admin/admin_event";
	}

	@GetMapping("/admin/event/write")
	public String eventWritePage() {
	    return "admin/admin_event_write";
	}

	@PostMapping("/admin/event/write")
	public String eventWrite(Event event) {
	    eventDAO.insert(event);
	    return "redirect:/admin/event";
	}

	@GetMapping("/admin/event/update")
	public String eventUpdatePage(@RequestParam("e_no") int e_no, Model model) {
	    Event event = eventDAO.getEventDetail(e_no);
	    model.addAttribute("event", event);
	    return "admin/admin_event_update";
	}

	@PostMapping("/admin/event/update")
	public String eventUpdate(Event event) {
	    eventDAO.update(event);
	    return "redirect:/admin/event";
	}

	@GetMapping("/admin/event/delete")
	public String eventDelete(@RequestParam("e_no") int e_no) {
	    eventDAO.delete(e_no);
	    return "redirect:/admin/event";
	}
}